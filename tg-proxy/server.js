/**
 * @file        server.js
 * @description Transparent reverse proxy for Telegram Bot API. Stands between
 *              RU-IP clients (blocked from api.telegram.org) and Telegram.
 *              Replaces Cloudflare Worker tg-proxy which cannot pass multipart.
 * @runs        EU VDS (157.22.178.181) via PM2; nginx proxy_pass on 127.0.0.1:8788
 * @rule        Transparent reverse only — never parse, modify, or interpret Telegram API.
 * @rule        Mandatory X-Proxy-Secret on every non-/health request. Timing-safe comparison.
 * @rule        No PII in logs. Method/status/ms/auth-result/IP only — never path/body/headers/secret.
 * @rule        Bind 127.0.0.1 only. Nginx is the public face.
 * @rule        Bidirectional: outbound transparent proxy (above) is untouched; inbound webhook
 *              tract POST /tg-in/:botId receives Telegram webhooks and forwards them to per-bot
 *              backends from a registry. Inbound auth = X-Telegram-Bot-Api-Secret-Token, timing-safe.
 * @lastModified 2026-06-02
 */

const express = require('express');
const { createProxyMiddleware } = require('http-proxy-middleware');
const { rateLimit } = require('express-rate-limit');
const crypto = require('crypto');
const path = require('path');
const fs = require('fs');

const PORT = parseInt(process.env.PORT, 10) || 8788;
const PROXY_SECRET = process.env.PROXY_SECRET;

if (!PROXY_SECRET) {
  process.stderr.write('FATAL: PROXY_SECRET env var is required\n');
  process.exit(1);
}

const SECRET_BUF = Buffer.from(PROXY_SECRET);

// --- Inbound tract: bot registry ------------------------------------------
// Registry maps botId -> { secret_token, target_url }. Read once at startup.
// Missing/invalid file => empty registry: inbound tract is simply inert,
// outbound proxy keeps working (graceful degradation).
const BOTS_REGISTRY_PATH = process.env.BOTS_REGISTRY_PATH || path.join(__dirname, 'bots.json');

function loadBotsRegistry() {
  try {
    const raw = fs.readFileSync(BOTS_REGISTRY_PATH, 'utf8');
    const parsed = JSON.parse(raw);
    if (parsed && typeof parsed === 'object' && !Array.isArray(parsed)) {
      return parsed;
    }
    process.stderr.write(`WARN: bots registry at ${BOTS_REGISTRY_PATH} is not an object — inbound tract disabled\n`);
    return {};
  } catch (err) {
    process.stderr.write(`WARN: bots registry not loaded (${err.code || 'parse error'}) — inbound tract disabled\n`);
    return {};
  }
}

const BOTS_REGISTRY = loadBotsRegistry();

function logInbound(req, status, startTime, botId) {
  process.stdout.write(JSON.stringify({
    ts: new Date().toISOString(),
    method: req.method,
    status,
    ms: Date.now() - startTime,
    kind: 'inbound',
    botId,
    ip: req.ip,
  }) + '\n');
}

const app = express();
app.set('trust proxy', 1);

app.get('/health', (req, res) =>
  res.status(200).json({ ok: true, ts: new Date().toISOString() })
);

// --- Inbound webhook tract ------------------------------------------------
// Registered BEFORE the rate limiter and the X-Proxy-Secret gate: Telegram
// does not know X-Proxy-Secret. Auth is per-bot X-Telegram-Bot-Api-Secret-Token.
// express.json is scoped to THIS route only — the outbound proxy must keep
// receiving raw (incl. multipart) bodies, so no global body parser is added.
app.post('/tg-in/:botId', express.json({ limit: '5mb' }), async (req, res) => {
  const startTime = Date.now();
  const botId = req.params.botId;
  const entry = BOTS_REGISTRY[botId];

  if (!entry) {
    logInbound(req, 404, startTime, botId);
    return res.status(404).json({ ok: false, error_code: 404, description: 'Not Found: unknown botId' });
  }

  const expected = entry.secret_token;
  const received = req.header('X-Telegram-Bot-Api-Secret-Token');
  let authed = false;
  if (expected && received) {
    const expBuf = Buffer.from(String(expected));
    const recvBuf = Buffer.from(received);
    if (recvBuf.length === expBuf.length) {
      try { authed = crypto.timingSafeEqual(recvBuf, expBuf); } catch { authed = false; }
    }
  }
  if (!authed) {
    logInbound(req, 401, startTime, botId);
    return res.status(401).json({ ok: false, error_code: 401, description: 'Unauthorized: invalid secret token' });
  }

  const controller = new AbortController();
  const timer = setTimeout(() => controller.abort(), 15_000);
  try {
    await fetch(entry.target_url, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(req.body),
      signal: controller.signal,
    });
    clearTimeout(timer);
    // Telegram only needs a 2xx to stop retrying; backend's own status is moot.
    logInbound(req, 200, startTime, botId);
    return res.status(200).json({ ok: true });
  } catch (err) {
    clearTimeout(timer);
    // Forward failed/timed out: 502 lets Telegram retry the update later.
    logInbound(req, 502, startTime, botId);
    if (!res.headersSent) {
      return res.status(502).json({ ok: false, error_code: 502, description: 'Bad Gateway: backend forward failed' });
    }
  }
});

const limiter = rateLimit({
  windowMs: 60_000,
  max: 60,
  standardHeaders: true,
  legacyHeaders: false,
  message: { ok: false, error_code: 429, description: 'Too Many Requests: proxy rate limit' },
  skip: (req) => req.path === '/health',
  handler: (req, res, next, options) => {
    process.stdout.write(JSON.stringify({
      ts: new Date().toISOString(),
      method: req.method,
      status: 429,
      ms: 0,
      auth: 'n/a',
      ip: req.ip,
    }) + '\n');
    res.status(429).json(options.message);
  },
});
app.use(limiter);

app.use((req, res, next) => {
  req._startTime = Date.now();
  const received = req.header('X-Proxy-Secret');
  let ok = false;
  if (received) {
    const recvBuf = Buffer.from(received);
    if (recvBuf.length === SECRET_BUF.length) {
      try { ok = crypto.timingSafeEqual(recvBuf, SECRET_BUF); } catch { ok = false; }
    }
  }
  if (!ok) {
    process.stdout.write(JSON.stringify({
      ts: new Date().toISOString(),
      method: req.method,
      status: 403,
      ms: Date.now() - req._startTime,
      auth: 'fail',
      ip: req.ip,
    }) + '\n');
    return res.status(403).json({
      ok: false,
      error_code: 403,
      description: 'Forbidden: missing or invalid X-Proxy-Secret',
    });
  }
  res.on('finish', () => {
    process.stdout.write(JSON.stringify({
      ts: new Date().toISOString(),
      method: req.method,
      status: res.statusCode,
      ms: Date.now() - req._startTime,
      auth: 'ok',
      ip: req.ip,
    }) + '\n');
  });
  next();
});

app.use(createProxyMiddleware({
  target: 'https://api.telegram.org',
  changeOrigin: true,
  on: {
    error: (err, req, res) => {
      if (res && !res.headersSent) {
        res.status(502).json({
          ok: false,
          error_code: 502,
          description: 'Bad Gateway: upstream telegram failure',
        });
      }
    },
  },
}));

app.listen(PORT, '127.0.0.1', () => {
  console.log(`tg-proxy listening on 127.0.0.1:${PORT}, PROXY_SECRET length: ${PROXY_SECRET.length}`);
});
