# tg-proxy

Self-hosted Telegram Bot API reverse proxy for RU-IP clients.

## Why this exists

`api.telegram.org` is blocked from Russian IPs. A Cloudflare Worker proxy was
used as a workaround; it relays text-only Telegram Bot API calls reliably but
fails on multipart uploads (e.g. `sendPhoto` with a real JPEG body), tearing
the connection with `ECONNRESET` after ~45 seconds. This service is a thin
Node reverse proxy without that limitation, deployed on a European VDS and
fronted by nginx with TLS.

The proxy is **bidirectional**:

- **Outbound** — RU-IP bot backends call Telegram through it (the original
  transparent-reverse tract, gated by `X-Proxy-Secret`).
- **Inbound** — Telegram delivers webhooks to it, and it forwards each update
  to the right bot backend (the `/tg-in/:botId` tract). This is needed because
  Telegram cannot reach RU-IP backends directly (connection times out), so a
  reachable EU VDS must receive the webhook and relay it inward.

## Contract

- `GET /health` → `200`, no auth required, returns `{ok:true, ts:<ISO>}`.
- `POST /tg-in/:botId` (inbound tract) → see the dedicated section below. This
  route is matched **before** the rate limiter and the `X-Proxy-Secret` gate.
- `* /<any-other-path>` with valid `X-Proxy-Secret` header → transparent
  forward to `https://api.telegram.org<same-path>`; response returned as-is
  (status, headers, body unchanged).
- `* /<any-other-path>` without valid `X-Proxy-Secret` → `403` with
  `{ok:false, error_code:403, description:'Forbidden: ...'}`.
- Rate limit: 60 req/min per IP; over → `429` with Telegram-compatible JSON
  `{ok:false, error_code:429, description:'Too Many Requests: ...'}`.
- Body size limit: 50 MB (enforced in the nginx layer, not in this service).

## Inbound webhook tract (multibot)

Telegram pushes updates to `POST /tg-in/:botId`. The proxy authenticates the
request, looks up the backend by `:botId`, and forwards the raw update there.
One proxy can serve many bots — routing is purely by the `:botId` path segment.

### How it works

1. **Telegram → proxy.** When you call `setWebhook` for a bot, point the URL at
   `https://yurassistent.ru/tg-in/<botId>` and set a `secret_token`. Telegram
   then sends every update as `POST /tg-in/<botId>` with the header
   `X-Telegram-Bot-Api-Secret-Token: <secret_token>`.
2. **Auth.** The proxy compares that header against `secret_token` for this
   `botId` in the registry using a timing-safe comparison. No/!match → `401`.
   Telegram itself never knows `X-Proxy-Secret`, which is exactly why this route
   sits in front of the outbound secret gate.
3. **Route + forward.** The proxy looks up `target_url` for `:botId` and POSTs
   the update body to it as `application/json` (15 s timeout).
4. **Response.** If the backend responds at all, the proxy returns `200` to
   Telegram (a 2xx is all Telegram needs to stop retrying). If the forward
   fails or times out → `502`, so Telegram retries the update later.
5. **Unknown botId** → `404`.

### Registry: `bots.json`

A JSON object keyed by `botId`, read once at startup from `BOTS_REGISTRY_PATH`
(default: `./bots.json` next to `server.js`). If the file is missing or invalid,
the inbound tract is simply inert — the outbound proxy keeps working (graceful
degradation), and one warning is logged.

```json
{
  "jck": { "secret_token": "REPLACE_WITH_RANDOM_HEX_32", "target_url": "https://test.jckauto.ru/bot-webhook/" }
}
```

- `secret_token` — the exact value you pass to `setWebhook` as `secret_token`
  (generate with `openssl rand -hex 32`).
- `target_url` — the backend URL updates are POSTed to. This must be the exact
  path the bot backend expects. If the backend validates the bot token in the
  URL path (node-telegram-bot-api does: it ignores updates whose `req.url` does
  not contain the token), `target_url` must include that token segment, e.g.
  `https://test.jckauto.ru/bot-webhook/bot<TOKEN>` — not just the base path.

The real `bots.json` is **not committed** (it holds secret tokens) — it is in
`.gitignore`. Commit only `bots.json.example`. On the EU VDS, copy the example
to `bots.json` and fill in real values, then restart the proxy so it reloads
the registry.

### Adding a new bot

1. Add one entry to `bots.json` on the EU VDS:
   `"<botId>": { "secret_token": "<hex32>", "target_url": "<backend-webhook-url>" }`.
2. `pm2 restart tg-proxy` (registry is read at startup).
3. Point that bot's webhook at the proxy, with the matching secret token:

```bash
curl -s "https://api.telegram.org/bot<TOKEN>/setWebhook" \
  --data-urlencode "url=https://yurassistent.ru/tg-in/<botId>" \
  --data-urlencode "secret_token=<hex32>" \
  --data-urlencode "max_connections=40"
# (run from a host that can reach api.telegram.org, or via the outbound tract)
```

## Deploy SOP on EU VDS

```bash
# 1. Clone repo (sparse-checkout — only tg-proxy folder)
cd /opt
git clone --depth=1 --filter=blob:none --sparse https://github.com/t9242540001/vibecoding-workspace.git vibecoding-workspace-temp
cd vibecoding-workspace-temp && git sparse-checkout set tg-proxy && cd ..
mv vibecoding-workspace-temp/tg-proxy /opt/tg-proxy
rm -rf vibecoding-workspace-temp

# 2. Install deps
cd /opt/tg-proxy && npm install --omit=dev

# 3. Generate secret + .env
SECRET=$(openssl rand -hex 32)
cat > .env <<EOF
PROXY_SECRET=$SECRET
PORT=8788
NODE_ENV=production
EOF
chmod 600 .env
echo "SAVE THIS SECRET (also stored in /opt/tg-proxy/.env): $SECRET"

# 3b. (Inbound tract, optional) create the bot registry from the example
cp bots.json.example bots.json
# edit bots.json: real secret_token (openssl rand -hex 32) and target_url per bot
chmod 600 bots.json

# 4. Start via PM2
pm2 start ecosystem.config.js
pm2 save

# 5. Smoke test (local loopback)
curl -s http://127.0.0.1:8788/health
# Expected: {"ok":true,"ts":"..."}

# 6. Add nginx location (see next section) and reload nginx
```

## Nginx config snippet

Add this `location` inside the existing
`server { listen 443 ssl; server_name yurassistent.ru; ... }` block:

```nginx
location /tg-proxy/ {
    access_log off;
    proxy_pass http://127.0.0.1:8788/;
    proxy_http_version 1.1;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_request_buffering off;
    client_max_body_size 50m;
    proxy_read_timeout 120s;
    proxy_send_timeout 120s;
}
```

For the inbound tract, expose `/tg-in/` too (so Telegram can reach
`https://yurassistent.ru/tg-in/<botId>`):

```nginx
location /tg-in/ {
    access_log off;
    proxy_pass http://127.0.0.1:8788/tg-in/;
    proxy_http_version 1.1;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header X-Telegram-Bot-Api-Secret-Token $http_x_telegram_bot_api_secret_token;
    client_max_body_size 5m;
    proxy_read_timeout 30s;
}
```

Then: `nginx -t && systemctl reload nginx`.

Notes: `access_log off` prevents bot-token leakage via `$request_uri` (INV-3).
`proxy_request_buffering off` is critical for multipart streaming.

## Smoke tests after deploy

- `curl -i http://127.0.0.1:8788/health` → `200` with `{"ok":true,...}`.
- `curl -i http://127.0.0.1:8788/bot<TOKEN>/getMe` (no secret) → `403`.
- `curl -i -H "X-Proxy-Secret: $SECRET" http://127.0.0.1:8788/bot<TOKEN>/getMe`
  → `200` with Telegram bot info JSON.
- `curl -i -H "X-Proxy-Secret: $SECRET" -F chat_id=<id> -F photo=@cover.jpg \
   http://127.0.0.1:8788/bot<TOKEN>/sendPhoto` → `200` with Telegram message
  JSON. **This is the critical test per INV-8.**
- Inbound, unknown bot: `curl -i -X POST http://127.0.0.1:8788/tg-in/nope` →
  `404`.
- Inbound, bad secret: `curl -i -X POST http://127.0.0.1:8788/tg-in/jck \
   -H 'Content-Type: application/json' -d '{}'` → `401`.
- Inbound, good secret: same with
  `-H 'X-Telegram-Bot-Api-Secret-Token: <secret_token>'` → `200` (forwarded to
  the bot backend) or `502` (backend unreachable).

## Secret rotation SOP

Two-step coordinated process; ~30 seconds of downtime acceptable for a
~90-day rotation cadence:

1. Generate new secret: `openssl rand -hex 32`.
2. Update `.env` on EU VDS **and** `.env.local` on the JCK AUTO VDS.
3. Restart both processes:
   - EU VDS: `pm2 restart tg-proxy`.
   - JCK AUTO VDS: `pm2 reload jckauto` and
     `pm2 delete jckauto-bot && pm2 start ...` (so polling picks up the new
     header).

If the rotation `sed` command produces no effect (no `PROXY_SECRET=` line in
the target file) — verify the file content and add the line explicitly.

The inbound `secret_token` values rotate independently per bot: update both
`bots.json` (EU VDS) and the bot's `setWebhook` `secret_token`, then
`pm2 restart tg-proxy`.

## Troubleshooting

- **403 on legitimate JCK AUTO call** → secret mismatch; verify `.env` on
  both sides is identical (no trailing whitespace, no quotes around the
  value).
- **502 from proxy** → upstream `api.telegram.org` unreachable; verify with
  `curl https://api.telegram.org/bot<TOKEN>/getMe` from the EU VDS directly.
- **ECONNRESET in JCK AUTO logs** → Telegram bot itself rate-limited
  (separate from proxy rate limit); check bot status.
- **Inbound 401 from Telegram** (`getWebhookInfo` shows auth errors) →
  `secret_token` in `bots.json` does not match the one set via `setWebhook`.
- **Inbound 404** → `:botId` in the webhook URL has no entry in `bots.json`,
  or `bots.json` failed to load (check the startup warning in logs).
- **Inbound 502** → backend `target_url` unreachable/timed out; Telegram will
  retry. Verify the backend is up and the path includes any token it expects.

## Monitoring

`pm2 logs tg-proxy` shows JSON-line output, one line per request.
`grep '"auth":"fail"' /root/.pm2/logs/tg-proxy-out.log` shows unauthorized
attempts (near-zero in normal operation).
`grep '"kind":"inbound"' /root/.pm2/logs/tg-proxy-out.log` shows inbound
webhook activity (botId, status, ms — never body or tokens).

## Universal registration

This service is a CREATES NEW universal in vibecoding-workspace. Future
products on RU-IP VDS that need Telegram API access can reuse this service
unchanged — just add another `X-Proxy-Secret`-bearing client (outbound) or a
`bots.json` entry + webhook (inbound).
