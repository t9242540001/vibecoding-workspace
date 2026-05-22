# tg-proxy

Self-hosted Telegram Bot API reverse proxy for RU-IP clients.

## Why this exists

`api.telegram.org` is blocked from Russian IPs. A Cloudflare Worker proxy was
used as a workaround; it relays text-only Telegram Bot API calls reliably but
fails on multipart uploads (e.g. `sendPhoto` with a real JPEG body), tearing
the connection with `ECONNRESET` after ~45 seconds. This service is a thin
Node reverse proxy without that limitation, deployed on a European VDS and
fronted by nginx with TLS.

## Contract

- `GET /health` → `200`, no auth required, returns `{ok:true, ts:<ISO>}`.
- `* /<any-other-path>` with valid `X-Proxy-Secret` header → transparent
  forward to `https://api.telegram.org<same-path>`; response returned as-is
  (status, headers, body unchanged).
- `* /<any-other-path>` without valid `X-Proxy-Secret` → `403` with
  `{ok:false, error_code:403, description:'Forbidden: ...'}`.
- Rate limit: 60 req/min per IP; over → `429` with Telegram-compatible JSON
  `{ok:false, error_code:429, description:'Too Many Requests: ...'}`.
- Body size limit: 50 MB (enforced in the nginx layer, not in this service).

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

## Troubleshooting

- **403 on legitimate JCK AUTO call** → secret mismatch; verify `.env` on
  both sides is identical (no trailing whitespace, no quotes around the
  value).
- **502 from proxy** → upstream `api.telegram.org` unreachable; verify with
  `curl https://api.telegram.org/bot<TOKEN>/getMe` from the EU VDS directly.
- **ECONNRESET in JCK AUTO logs** → Telegram bot itself rate-limited
  (separate from proxy rate limit); check bot status.

## Monitoring

`pm2 logs tg-proxy` shows JSON-line output, one line per request.
`grep '"auth":"fail"' /root/.pm2/logs/tg-proxy-out.log` shows unauthorized
attempts (near-zero in normal operation).

## Universal registration

This service is a CREATES NEW universal in vibecoding-workspace. Future
products on RU-IP VDS that need Telegram API access can reuse this service
unchanged — just add another `X-Proxy-Secret`-bearing client.
