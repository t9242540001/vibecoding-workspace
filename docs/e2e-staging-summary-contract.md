# E2E Staging Summary Contract

## Purpose

This contract is the bridge from synthetic Browser/E2E text fixtures to future real staging analysis.

## Why This Exists

Models should analyze sanitized summaries, not raw staging sessions, secrets, cookies, screenshots, request dumps, or user data.

## Current Status

- contract added;
- sanitized summary example added;
- validator workflow added;
- validator passed on fake sanitized summary;
- manual staging-summary analysis workflow added;
- not connected to real staging;
- no browser automation yet;
- no real staging URL required.

## Allowed Input

- sanitized page title;
- route label or stable route name;
- visible text snippets;
- interaction summary;
- sanitized console and network error summaries;
- accessibility notes;
- acceptance criteria;
- test metadata without secrets.

## Forbidden Input

- secrets;
- cookies;
- tokens;
- session dumps;
- raw HAR;
- real personal data;
- private client data;
- billing/payment data;
- screenshots by default;
- private endpoints unless explicitly approved.

## Required Summary Fields

- `summary_id`
- `source`
- `environment_label`
- `route_label`
- `page_title`
- `visible_text`
- `interactions`
- `acceptance_criteria`
- `console_errors`
- `network_errors`
- `sanitization_notes`

## Model Report Contract

- `passed`
- `score`
- `summary`
- `matched_criteria`
- `missing_criteria`
- `issues`
- `recommendation`

## Default Model Policy

Qwen `qwen-plus`, DeepSeek `deepseek-v4-flash`, and DeepSeek `deepseek-v4-pro` passed the required synthetic fixture matrix.

Gemini `gemini-2.5-flash` remains experimental for this workflow.

## References

- `examples/e2e/sanitized-staging-summary-example.json`
- `.github/workflows/e2e-staging-summary-validator.yml`
- `.github/workflows/e2e-staging-summary-analysis.yml`
- `docs/e2e-staging-summary-validator.md`
- `docs/e2e-staging-summary-analysis.md`

## Next Steps

1. Create sanitized staging summary example using fake data. Done.
2. Add summary contract validator. Done.
3. Add manual staging-summary analysis workflow. Done.
4. Run analysis on fake sanitized summary with Qwen and DeepSeek.
5. Connect real browser automation only after staging access and sanitization rules are approved.
