# Browser Automation Handoff Contract

## Purpose

This contract defines how future browser automation hands off safe text summaries to validator and model analysis.

## Current Status

- contract added;
- synthetic browser observations added;
- synthetic browser summary generator workflow added;
- no real browser automation yet;
- no real staging URL;
- no credentials;
- no screenshots/raw HAR/videos/traces.

## Why This Exists

Browser automation can see sensitive session data. Models should receive sanitized summaries only, and the validator must pass before model analysis.

## Allowed Browser Output

- page title;
- route label;
- visible text snippets;
- interaction labels;
- high-level console error summaries after redaction;
- high-level network error summaries after redaction;
- accessibility notes;
- performance notes;
- browser/viewport labels;
- acceptance criteria outcome evidence.

## Forbidden Browser Artifacts

- cookies;
- auth headers;
- bearer tokens;
- API keys;
- passwords;
- session dumps;
- raw HAR;
- raw request/response bodies by default;
- screenshots/videos/traces by default;
- real personal data;
- private client data;
- billing/payment data;
- full private URLs by default;
- server IPs/private endpoints unless explicitly approved;
- local paths.

## Required Handoff Flow

1. Approved browser route/interactions.
2. Sanitized summary JSON.
3. Validator.
4. Staging-summary analysis with Qwen/DeepSeek.
5. Review model report.

## Stop Conditions

- login/auth required and not explicitly approved;
- payment/billing flow encountered;
- real personal data encountered;
- private client data encountered;
- secrets/cookies/tokens detected;
- screenshots/video/traces required but not approved;
- raw HAR needed;
- route/interaction scope unclear;
- staging URL or credentials missing/unclear.

## Current Working Chain

- synthetic fixtures passed required matrix;
- sanitized example passed validator;
- fake sanitized summary analysis passed with Qwen and DeepSeek.

## Next Steps

References:

- `configs/synthetic-browser-observations.json`
- `.github/workflows/synthetic-browser-summary-generator.yml`
- `docs/synthetic-browser-summary-generator.md`

1. Create synthetic browser runner summary generator. Done.
2. Run `landing-success` with Qwen.
3. Run `landing-missing-cta` with Qwen.
4. Run both with DeepSeek.
5. Then design real staging browser workflow.
