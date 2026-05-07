# Real Public Browser Summary MVP

## Purpose

This MVP proves the first real public no-auth browser observation loop:

approved public route/profile -> real headless browser observation -> sanitized summary -> validation/forbidden scan -> optional Qwen/DeepSeek model analysis.

It checks that an approved public homepage can be observed safely and converted into a model-readable summary without collecting raw browser/session artifacts.

This MVP does not add arbitrary browser automation, private staging access, credentials, login/auth flows, form flows, screenshots, videos, traces, raw HAR, or broad E2E journeys.

## Current Status

Status: MVP required run set passed.

Date reported: `2026-05-07`.

Workflow: `.github/workflows/real-public-browser-summary.yml`.

Current approved route: `yurassistent-home`, public no-auth route for `https://yurassistent.ru/`.

Current approved interaction profiles: `homepage-load-only`, `homepage-primary-cta-presence`, `homepage-content-audit-v1`.

Current first-flow models: `qwen/qwen-plus`, `deepseek/deepseek-v4-flash`.

Gemini is excluded from the first real public browser flow.

Known-green MVP run combinations:

| Route | Profile | Model | Result |
|---|---|---|---|
| `yurassistent-home` | `homepage-load-only` | `qwen/qwen-plus` | Passed |
| `yurassistent-home` | `homepage-primary-cta-presence` | `qwen/qwen-plus` | Passed |
| `yurassistent-home` | `homepage-load-only` | `deepseek/deepseek-v4-flash` | Passed |
| `yurassistent-home` | `homepage-primary-cta-presence` | `deepseek/deepseek-v4-flash` | Passed |

## Content Audit V1

Content Audit Profile v1 exists as `homepage-content-audit-v1` and has been run safely on `yurassistent-home`.

The first run produced a useful product signal: Qwen and DeepSeek agreed the page needs review. The primary CTA was not detected in sanitized visible text, trust signals appear weak/limited, and console/network errors need inspection.

This remains text-only sanitized analysis: no clicks, forms, login, screenshots, HAR, or raw browser artifacts.

## Link Check V1

Link Check v1 exists as `homepage-link-check-v1` for the approved `yurassistent-home` route.

It checks public links and contact-link signals using sanitized link metadata only. It does not include full URLs, raw email addresses, raw phone numbers, query strings, headers, or response bodies in reports.

It does not submit forms, login, follow private/auth/payment flows, click links in the browser, send contact messages, collect screenshots, or collect HAR.

## Test Intent Taxonomy

The browser MVP now uses a test intent taxonomy: `health_check`, `acceptance_check`, `content_audit`, and `link_check` are implemented through the current safe profiles.

Future intents such as `form_check`, `dialogue_e2e`, and `document_result_review` remain approval-gated because they may require higher-risk browser actions, data handling, or artifacts.

## How The Flow Works

1. The operator starts the manual workflow from GitHub Actions.
2. The workflow accepts only an approved `route_id`.
3. The workflow accepts only an approved `interaction_profile_id`.
4. It validates route/profile existence and compatibility before opening the browser.
5. It opens the approved public no-auth route with a real headless browser.
6. It performs only safe observation actions from the selected profile.
7. It generates sanitized summary JSON.
8. It validates the summary against `configs/e2e-staging-summary-contract.json`.
9. It runs the forbidden-pattern scan.
10. If enabled, it sends only the sanitized summary, acceptance criteria, and report schema to Qwen or DeepSeek.
11. It uploads only sanitized artifacts.

## How To Run Manually

In GitHub: open Actions -> `Real Public Browser Summary` -> `Run workflow`, then choose inputs.

Inputs:

- `route_id`: currently `yurassistent-home`.
- `interaction_profile_id`: `homepage-load-only` or `homepage-primary-cta-presence`.
- `strict_forbidden_scan`: keep `true` for MVP validation.
- `run_analysis`: keep `true` for model analysis.
- `model_id`: `qwen/qwen-plus` or `deepseek/deepseek-v4-flash`.

Known-green MVP runs:

- `yurassistent-home` + `homepage-load-only` + `qwen/qwen-plus`
- `yurassistent-home` + `homepage-primary-cta-presence` + `qwen/qwen-plus`
- `yurassistent-home` + `homepage-load-only` + `deepseek/deepseek-v4-flash`
- `yurassistent-home` + `homepage-primary-cta-presence` + `deepseek/deepseek-v4-flash`

## Artifact Policy

Allowed artifacts:

- `generated-summary.json`
- `validation-report.json`
- `model-report.json` when analysis runs
- `summary.md`

Retention: 3 days.

Forbidden artifacts and data:

- screenshots, videos, traces, and raw HAR;
- cookies, storage state, auth headers, bearer tokens, API keys, passwords, and session dumps;
- raw request bodies and raw response bodies;
- personal data, private client data, billing/payment data, private endpoints, and local paths.

## Safety Boundaries

Current boundaries:

- no arbitrary URL input;
- no arbitrary browser commands;
- no login/auth;
- no forms;
- no clicks/follow-links;
- no uploads;
- no payment/account creation/destructive actions;
- no screenshots/videos/traces/raw HAR;
- no cookies/storage state/auth headers;
- no raw request/response bodies;
- sanitized summary validation before model analysis;
- Qwen/DeepSeek only;
- Gemini excluded.

## Useful For

This MVP is useful for:

- checking that a public homepage loads;
- checking visible text availability;
- checking primary CTA presence from sanitized visible text;
- producing a model-readable pass/fail report from sanitized data.

## Not Yet

This MVP is not yet:

- a full E2E user journey;
- login/auth testing;
- form testing;
- document generation testing;
- screenshot/UI visual regression testing;
- staging/private data testing.

## Next Safe Steps

1. Document and harden the MVP results.
2. Optionally add docs navigation later.
3. Optionally add another public no-auth route only after explicit approval.
4. Optionally add additional non-clicking profiles only after explicit approval.
5. Do not expand to broader routes or interactions without separate approval.
