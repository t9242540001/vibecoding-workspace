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
 * @lastModified 2026-05-21
 */

const express = require('express');
const { createProxyMiddleware } = require('http-proxy-middleware');
const { rateLimit } = require('express-rate-limit');
const crypto = require('crypto');

const PORT = parseInt(process.env.PORT, 10) || 8788;
const PROXY_SECRET = process.env.PROXY_SECRET;

if (!PROXY_SECRET) {
  process.stderr.write('FATAL: PROXY_SECRET env var is required\n');
  process.exit(1);
}

const SECRET_BUF = Buffer.from(PROXY_SECRET);

const app = express();
app.set('trust proxy', 1);

app.get('/health', (req, res) =>
  res.status(200).json({ ok: true, ts: new Date().toISOString() })
);

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
