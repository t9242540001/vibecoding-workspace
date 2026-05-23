# Pilot Public Site Audit Prompt

<!--
  @file:        prompts/series/site-audit-skill/pilot-public-site-audit-prompt.md
  @description: Reusable Code Agent prompt template for safe public no-auth site audit pilots
  @updated:     2026-05-24
-->

# Public Site Audit Pilot: [PROJECT_NAME]

Run a scoped, safe public no-auth website audit. Do not fix product code during this audit.

## Context

- Project name: `[PROJECT_NAME]`
- Repository: `[REPOSITORY]`
- Public URL or route labels: `[PUBLIC_URL_OR_ROUTE_LABELS]`
- Allowed pages/routes: `[ALLOWED_PAGES_OR_ROUTES]`
- Audit layers: `[PUBLIC_NO_AUTH_FULL_AUDIT_LAYERS]`
- Report path: `[REPORT_PATH]`
- Scope source: `[SCOPE_FILE_OR_INLINE_SCOPE]`
- Test data/accounts: `[SYNTHETIC_TEST_DATA_OR_NOT_PROVIDED]`
- Source/context files:
  - `[PROJECT_INSTRUCTIONS_OR_EQUIVALENT]`
  - `[PROJECT_KNOWLEDGE_OR_PRIOR_AUDIT_CONTEXT]`
  - `skills/site-audit/SKILL.md`
  - `docs/site-audit/agentic-audit-pipeline.md`
  - `docs/site-audit/live-browser-interactive-audit-contract.md`
  - `docs/site-audit/marketing-ai-agentic-readiness-standard.md`
  - `docs/site-audit/validation-gates.md`
  - `templates/site-audit/report-template.md`
  - `templates/site-audit/finding-taxonomy.md`
  - `templates/site-audit/marketing-ai-agentic-checklist.md`
  - `configs/site-audit-default-scope.json`
  - `configs/site-audit-severity-taxonomy.json`

## Required Reads

Read before collecting evidence or writing the report:

1. Repository instructions for `[REPOSITORY]`.
2. `[PROJECT_INSTRUCTIONS_OR_EQUIVALENT]`.
3. `[PROJECT_KNOWLEDGE_OR_PRIOR_AUDIT_CONTEXT]`.
4. `skills/site-audit/SKILL.md`.
5. `docs/site-audit/agentic-audit-pipeline.md`.
6. `docs/site-audit/live-browser-interactive-audit-contract.md`.
7. `docs/site-audit/marketing-ai-agentic-readiness-standard.md`.
8. `docs/site-audit/validation-gates.md`.
9. `templates/site-audit/report-template.md`.
10. `templates/site-audit/finding-taxonomy.md`.
11. `templates/site-audit/marketing-ai-agentic-checklist.md`.
12. `configs/site-audit-default-scope.json`.
13. `configs/site-audit-severity-taxonomy.json`.

## Task

Create `[REPORT_PATH]` using `templates/site-audit/report-template.md`. The report must be a complete bilingual Markdown report: Russian decision-maker sections first, then a separate English technical section for Code Agent/developer execution.

Run only the public no-auth audit layers listed in scope. For every full-audit layer, either collect approved evidence or mark it unavailable with a clear reason and next prerequisite. Public no-auth pilots usually cannot execute auth/account, payment, admin, production submit, or private-account layers; report those as unavailable instead of fabricating evidence.

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
- live HTTP signals;
- browser/visual evidence only when supplied or explicitly approved;
- marketing/sales effectiveness;
- target-audience usefulness;
- SEO;
- AEO/GEO/AI-friendly content;
- AI/agentic-commerce readiness;
- copy/grammar/trust/legal-risk wording;
- design/visual consistency;
- analytics/conversion;
- public UI security/privacy.

State skipped dimensions as out of scope, unavailable, or unknown. Do not fabricate browser, visual, network, console, Lighthouse, screenshot, interaction, auth, payment, admin, or API evidence.

## Allowed Actions

- `[ALLOWED_ACTION_1]`
- `[ALLOWED_ACTION_2]`
- Read approved repository files and project knowledge listed in this prompt.
- Observe only approved public no-auth pages/routes listed above.
- Inspect visible text, public metadata, headings, links, public page source where in scope, and supplied sanitized browser summaries.
- Use synthetic test data only for approved non-submit form/tool inspection.
- Inspect high-level console or network summaries only when approved and sanitized.
- Collect approved browser/interactive evidence only when this prompt names the route labels, interaction profiles, viewports, and artifact policy.
- Run only checks listed in the Checks section.

## Forms And Tools

| Form/Tool | Route | Allowed interaction | Submit allowed? | Test data policy | Stop-before point |
|---|---|---|---:|---|---|
| `[FORM_OR_TOOL]` | `[ROUTE]` | `[READ_ONLY_OR_NON_SUBMIT_ONLY]` | No | Synthetic only | `[STOP_POINT]` |

Non-submit form/tool inspection may include labels, hints, required markers, disabled/loading/error states, and client-side validation that does not send data. Any submit, upload, contact-message, auth, payment, admin, account, billing, settings, logout, or destructive action requires separate explicit approval in a new prompt.

## Viewports

Use only approved viewport checks:

| Viewport | Required? | Evidence allowed |
|---|---:|---|
| `[DESKTOP_VIEWPORT]` | `[YES_OR_NO]` | `[TEXT_SUMMARY_OR_APPROVED_BROWSER_OBSERVATION]` |
| `[MOBILE_VIEWPORT]` | `[YES_OR_NO]` | `[TEXT_SUMMARY_OR_APPROVED_BROWSER_OBSERVATION]` |
| `[TABLET_VIEWPORT]` | `[YES_OR_NO]` | `[TEXT_SUMMARY_OR_APPROVED_BROWSER_OBSERVATION]` |

Screenshots, videos, traces, raw HAR, storage state, cookies, auth headers, and raw request/response bodies are forbidden unless this prompt's artifact policy separately approves the exact artifact type and redaction rule.

## Artifact Policy

Allowed artifacts:

- `[ALLOWED_ARTIFACT_1]`
- `[ALLOWED_ARTIFACT_2]`
- audit report markdown at `[REPORT_PATH]`;
- sanitized summaries already approved for model or Code Agent review;
- command output excerpts that contain no secrets, credentials, private data, cookies, headers, or tokens.

Forbidden artifacts unless separately approved in this prompt and sanitized:

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
- full local file paths from outside the repository;
- raw sensitive values.

## Forbidden Actions

- Do not submit production forms unless a separate explicit approval names the route, data, stop conditions, and artifact policy.
- Do not use auth, admin, payment, billing, account, upload, logout, destructive, settings-change, contact-message, or state-changing flows.
- Do not use real personal data, real client data, payment data, credentials, or private user data.
- Do not read, print, store, screenshot, summarize, or commit secrets, tokens, passwords, `.env` values, cookies, storage, auth headers, bearer tokens, raw request bodies, or raw response bodies.
- Do not disclose sensitive data. If sensitive material appears, stop that evidence path and report only anonymized exposure class, safe location, impact, and remediation path.
- Do not run deploy, server, database, SSH, SCP, process-management, production config, or secrets-management actions.
- Do not install dependencies.
- Do not modify product code, product content, product data, production configuration, infrastructure, accounts, payments, or server state during this audit.
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
- product-code, product-config, or product-data change required to complete the audit;
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

The report must include these top-level sections:

1. `# [Project] Site Audit Report`
2. `## 1. Краткий отчёт для руководителя` in Russian, with audit result, what was checked, what was not checked, highest risks, evidence limitations, and top next actions.
3. `## 2. Все найденные замечания` in Russian, with the complete finding list, not only top findings. Each finding must include ID, severity, short problem, where found, why it matters, what to do next, and status.
4. `## 3. Метод и ограничения проверки` in Russian, with enabled audit layers, unavailable layers and reasons, checked pages/files, skipped scope, test data/accounts used or missing, live/browser/interactive evidence limitations, and stop conditions.
5. `## 4. Marketing, Sales, Target Audience And AI/Agentic Readiness`, with Russian short interpretation plus English technical details if useful. It must cover target-audience usefulness, marketing/sales effectiveness, SEO/AEO/GEO, AI-friendliness, and agentic-commerce readiness, or explicitly mark each area as not tested with a reason.
6. `## 5. English Technical Section` in English, with evidence inventory, technical finding table, file paths/routes/selectors/artifacts, observed evidence, inferred risks, unknowns, recommended fix direction, acceptance criteria, and suggested next batches.
7. `## 6. Safety / Boundary Notes`, with explicit confirmation that product code was not changed, sensitive data was not disclosed, and any sensitive data encountered was anonymized.
8. `## 7. Next Fix Batches`, with recommended next fix batches in priority order.

Every finding must include:

- ID;
- category aligned with `templates/site-audit/finding-taxonomy.md`;
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
- [ ] The report includes Russian decision-maker sections and a separate English technical section.
- [ ] All required bilingual report sections are present.
- [ ] Every finding has ID, category, location, evidence, impact, severity, recommendation, and status.
- [ ] All findings are included, not only the top findings.
- [ ] Findings use categories aligned with `templates/site-audit/finding-taxonomy.md`.
- [ ] Severity values align with `configs/site-audit-severity-taxonomy.json`.
- [ ] Marketing/sales/target-audience and AI/agentic-commerce areas are covered or explicitly marked not tested.
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
