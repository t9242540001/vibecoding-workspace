// Minimal dotenv loader — avoids adding `dotenv` as a runtime dep just for ecosystem boot.
const fs = require('fs');
const path = require('path');
try {
  const envPath = path.join(__dirname, '.env');
  if (fs.existsSync(envPath)) {
    const lines = fs.readFileSync(envPath, 'utf8').split('\n');
    for (const line of lines) {
      const trimmed = line.trim();
      if (!trimmed || trimmed.startsWith('#')) continue;
      const idx = trimmed.indexOf('=');
      if (idx < 0) continue;
      const key = trimmed.slice(0, idx).trim();
      const val = trimmed.slice(idx + 1).trim();
      if (!(key in process.env)) process.env[key] = val;
    }
  }
} catch (e) { /* ignore — config will fail loudly later if PROXY_SECRET is missing */ }

module.exports = {
  apps: [
    {
      name: 'tg-proxy',
      script: 'server.js',
      cwd: '/opt/tg-proxy',
      env: {
        NODE_ENV: process.env.NODE_ENV || 'production',
        PORT: process.env.PORT || '8788',
        PROXY_SECRET: process.env.PROXY_SECRET,
      },
      max_memory_restart: '128M',
      restart_delay: 3000,
      max_restarts: 10,
      error_file: '/root/.pm2/logs/tg-proxy-error.log',
      out_file: '/root/.pm2/logs/tg-proxy-out.log',
      merge_logs: true,
      time: true,
    },
  ],
};
