# Pilot Public Site Audit Prompt

<!--
  @file:        prompts/series/site-audit-skill/pilot-public-site-audit-prompt.md
  @description: Reusable Code Agent prompt template for safe public no-auth site audit pilots
  @updated:     2026-05-22
-->

# Public Site Audit Pilot: [PROJECT_NAME]

Run a scoped, safe public no-auth website audit. Do not fix product code during this audit.

## Context

- Project name: `[PROJECT_NAME]`
- Repository: `[REPOSITORY]`
- Public URL: `[PUBLIC_URL]`
- Allowed pages/routes: `[ALLOWED_PAGES_OR_ROUTES]`
- Audit mode: `[READ_ONLY_LIVE_PUBLIC_AUDIT_OR_NON_SUBMIT_FORM_TOOL_AUDIT]`
- Report path: `[REPORT_PATH]`
- Scope source: `[SCOPE_FILE_OR_INLINE_SCOPE]`
- Source/context files:
  - `[PROJECT_INSTRUCTIONS_OR_EQUIVALENT]`
  - `[PROJECT_KNOWLEDGE_OR_PRIOR_AUDIT_CONTEXT]`
  - `skills/site-audit/SKILL.md`
  - `docs/site-audit/agentic-audit-pipeline.md`
  - `docs/site-audit/validation-gates.md`
  - `templates/site-audit/report-template.md`
  - `templates/site-audit/finding-taxonomy.md`
  - `configs/site-audit-default-scope.json`
  - `configs/site-audit-severity-taxonomy.json`

## Required Reads

Read before collecting evidence or writing the report:

1. Repository instructions for `[REPOSITORY]`.
2. `[PROJECT_INSTRUCTIONS_OR_EQUIVALENT]`.
3. `[PROJECT_KNOWLEDGE_OR_PRIOR_AUDIT_CONTEXT]`.
4. `skills/site-audit/SKILL.md`.
5. `docs/site-audit/agentic-audit-pipeline.md`.
6. `docs/site-audit/validation-gates.md`.
7. `templates/site-audit/report-template.md`.
8. `templates/site-audit/finding-taxonomy.md`.
9. `configs/site-audit-default-scope.json`.
10. `configs/site-audit-severity-taxonomy.json`.

## Task

Create `[REPORT_PATH]` using `templates/site-audit/report-template.md`.

Audit only the approved public no-auth pages/routes:

| Route/Page | URL or path | Purpose | Required checks |
|---|---|---|---|
| `[ROUTE_LABEL]` | `[ROUTE_URL_OR_PATH]` | `[PURPOSE]` | `[REQUIRED_CHECKS]` |

Cover these dimensions where supported by approved evidence:

- technical frontend health;
- UX/usability;
- accessibility;
- responsive/mobile;
- forms/tools;
- SEO;
- AEO/GEO/AI-friendly content;
- copy/grammar/trust/legal-risk wording;
- design/visual consistency;
- analytics/conversion;
- public UI security/privacy.

State skipped dimensions as out of scope or unknown. Do not fabricate browser, visual, network, console, Lighthouse, screenshot, or interaction evidence.

## Allowed Actions

- `[ALLOWED_ACTION_1]`
- `[ALLOWED_ACTION_2]`
- Read approved repository files and project knowledge listed in this prompt.
- Observe only approved public no-auth pages/routes listed above.
- Inspect visible text, public metadata, headings, links, public page source where in scope, and supplied sanitized browser summaries.
- Inspect high-level console or network summaries only when approved and sanitized.
- Run only checks listed in the Checks section.

## Forms And Tools

| Form/Tool | Route | Allowed interaction | Submit allowed? | Test data policy |
|---|---|---|---:|---|
| `[FORM_OR_TOOL]` | `[ROUTE]` | `[READ_ONLY_OR_NON_SUBMIT_ONLY]` | No | Synthetic only |

Non-submit form/tool inspection may include labels, hints, required markers, disabled/loading/error states, and client-side validation that does not send data. Any submit, upload, contact-message, auth, payment, admin, account, billing, settings, logout, or destructive action requires separate explicit approval in a new prompt.

## Viewports

Use only approved viewport checks:

| Viewport | Required? | Evidence allowed |
|---|---:|---|
| `[DESKTOP_VIEWPORT]` | `[YES_OR_NO]` | `[TEXT_SUMMARY_OR_APPROVED_BROWSER_OBSERVATION]` |
| `[MOBILE_VIEWPORT]` | `[YES_OR_NO]` | `[TEXT_SUMMARY_OR_APPROVED_BROWSER_OBSERVATION]` |
| `[TABLET_VIEWPORT]` | `[YES_OR_NO]` | `[TEXT_SUMMARY_OR_APPROVED_BROWSER_OBSERVATION]` |

Screenshots, videos, traces, raw HAR, storage state, cookies, auth headers, and raw request/response bodies are forbidden unless this prompt's artifact policy separately approves the exact artifact type.

## Artifact Policy

Allowed artifacts:

- `[ALLOWED_ARTIFACT_1]`
- `[ALLOWED_ARTIFACT_2]`
- audit report markdown at `[REPORT_PATH]`;
- sanitized summaries already approved for model or Code Agent review;
- command output excerpts that contain no secrets, credentials, private data, cookies, headers, or tokens.

Forbidden artifacts unless separately approved in this prompt:

- raw HAR;
- screenshots;
- videos;
- traces;
- cookies;
- local storage;
- session storage;
- storage state;
- auth headers;
- bearer tokens;
- raw request bodies;
- raw response bodies;
- private URLs;
- server IPs;
- full local file paths from outside the repository.

## Forbidden Actions

- Do not submit production forms unless a separate explicit approval names the route, data, stop conditions, and artifact policy.
- Do not use auth, admin, payment, billing, account, upload, logout, destructive, settings-change, contact-message, or state-changing flows.
- Do not use real personal data, real client data, payment data, credentials, or private user data.
- Do not read, print, store, or commit secrets, tokens, passwords, `.env` values, cookies, storage, auth headers, bearer tokens, raw request bodies, or raw response bodies.
- Do not run deploy, server, database, SSH, SCP, process-management, production config, or secrets-management actions.
- Do not install dependencies.
- Do not modify product code during this audit.
- Do not run broad crawling, scraping, rate-heavy checks, arbitrary browser commands, or arbitrary URLs outside the approved route list.
- Do not collect raw HAR, videos, traces, screenshots, cookies, storage, auth headers, or private URLs unless separately approved in this prompt's artifact policy.

## Stop Conditions

Stop and report without quoting sensitive values if any condition appears:

- secret, token, credential, cookie, auth header, session material, `.env` value, or password exposure;
- real personal, client, payment, billing, medical, legal-case, or private user data;
- unapproved submit, upload, contact-message, auth, payment, admin, account, logout, settings-change, or destructive action required;
- deploy, server, database, SSH, SCP, process-management, production config, or secrets action required;
- arbitrary URL, broad crawl, scraping, rate-heavy check, private route, private endpoint, or anti-abuse boundary risk;
- evidence source outside the approved artifact policy;
- browser automation or dependency installation required but not approved;
- product-code change required to complete the audit;
- ambiguous scope with material safety or semantic risk.

## Checks

Run only checks that fit the approved scope:

- `git status --short`
- `[PROJECT_STATIC_CHECK_IF_APPROVED]`
- `[SANITIZED_SUMMARY_VALIDATION_CHECK_IF_APPROVED]`
- `[REPORT_VALIDATION_CHECK]`
- `git diff --check`

Do not run browser automation unless this prompt explicitly approves the runner, route labels, interaction profiles, viewports, and artifact policy.

## Report Requirements

The report must include:

- summary;
- scope;
- method;
- evidence inventory;
- findings table;
- severity definitions;
- prioritized recommendations;
- safe-boundary notes;
- stop conditions;
- next fix prompts.

Every finding must include:

- location;
- evidence;
- impact;
- severity from `configs/site-audit-severity-taxonomy.json`;
- recommendation;
- status.

Separate `Observed:`, `Inferred risk:`, and `Unknown:` when a finding combines direct evidence, judgment, and missing evidence.

## Acceptance Criteria

- [ ] `[REPORT_PATH]` is created.
- [ ] The report follows `templates/site-audit/report-template.md`.
- [ ] Every finding has location, evidence, impact, severity, recommendation, and status.
- [ ] Findings use categories aligned with `templates/site-audit/finding-taxonomy.md`.
- [ ] Severity values align with `configs/site-audit-severity-taxonomy.json`.
- [ ] Stop conditions are reported, including confirmation when none occurred.
- [ ] Validation gates from `docs/site-audit/validation-gates.md` pass, or each failure is listed with the blocked reason.
- [ ] Read-only audit, non-submit form/tool inspection, and submit/auth/payment/admin actions remain separated.
- [ ] No forbidden action was performed.
- [ ] No forbidden artifact was created or used.
- [ ] No dependency installation, deploy/server/database/secrets action, product-code change, arbitrary URL, broad crawl, or real personal data use occurred.

## Final Output

Print:

- changed files;
- files inspected;
- checks run;
- stop conditions encountered, or confirmation that none occurred;
- whether validation gates passed;
- whether follow-up fix prompts can proceed and which approvals they need.
