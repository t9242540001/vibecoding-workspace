# Codex Live Site Audit Prompt Template
<!--
  @file:        templates/site-audit/codex-live-audit-prompt-template.md
  @description: Reusable Code Agent prompt template for scoped full website audits
  @updated:     2026-05-24
  @version:     1.1
-->

# Live Site Audit: [PROJECT]

Run a scoped full website audit according to `skills/site-audit/SKILL.md`.

## CONTEXT

Project: `[PROJECT]`

Repository: `[REPO]`

URL or route labels: `[URL_OR_ROUTE_LABELS]`

Audit mode/layers: `[AUDIT_MODE_AND_ENABLED_LAYERS]`

Report path: `[REPORT_PATH]`

Scope source: `[AUDIT_SCOPE_FILE_OR_INLINE_SCOPE]`

Test data/accounts source: `[TEST_DATA_AND_ACCOUNTS_SOURCE_OR_NOT_PROVIDED]`

Relevant references:

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
- `[PROJECT_KNOWLEDGE_OR_AUDIT_REFERENCE]`

## TASK

Create or update `[REPORT_PATH]` with a complete bilingual site audit report in Markdown.

The report must use this top-level structure:

1. `# [Project] Site Audit Report`
2. `## 1. Краткий отчёт для руководителя` in Russian
3. `## 2. Все найденные замечания` in Russian, with the complete finding list
4. `## 3. Метод и ограничения проверки` in Russian
5. `## 4. Marketing, Sales, Target Audience And AI/Agentic Readiness`
6. `## 5. English Technical Section` in English
7. `## 6. Safety / Boundary Notes`
8. `## 7. Next Fix Batches`

Run the full audit layers listed in the approved scope. For every full-audit layer, either collect approved evidence or mark the layer unavailable with the exact reason and next prerequisite.

Audit these pages/routes:

- `[PAGE_OR_ROUTE_1]`
- `[PAGE_OR_ROUTE_2]`

Audit these tools/forms/flows when approved:

- `[TOOL_FORM_OR_FLOW_1]`
- `[TOOL_FORM_OR_FLOW_2]`

Cover these dimensions where relevant to scope:

- technical frontend health
- UX/usability
- accessibility
- responsive/mobile
- forms/tools
- interactive user flows
- auth/account
- payment path
- admin/access boundary
- API/server-route/SSE
- marketing/sales effectiveness
- target-audience usefulness
- SEO
- AEO/GEO/AI-friendly content
- AI/agentic-commerce readiness
- copy/grammar/trust/legal-risk wording
- design/visual consistency
- analytics/conversion
- public UI security/privacy

For every finding, include location, evidence, impact, severity, recommendation, and status. Separate observed facts from inferred risk and unknowns. The Russian sections must be simple enough for a non-developer decision-maker. The English technical section must include precise evidence, file paths/routes/selectors/artifacts, inferred risks, recommended fix direction, acceptance criteria, and follow-up prompt suggestions.

## ALLOWED ACTIONS

- `[ALLOWED_ACTION_1]`
- `[ALLOWED_ACTION_2]`
- Read approved repository files and project knowledge listed in scope.
- Inspect approved public pages/routes and public metadata.
- Use synthetic data and approved test accounts when the scope provides them.
- Collect approved live HTTP, browser, visual, interactive, auth, payment, admin, API/server-route/SSE, and sanitized artifact evidence only when explicitly scoped.
- Review supplied sanitized browser summaries and approved high-level console/network summaries.
- Run only the checks listed in the CHECKS section.

## FORBIDDEN ACTIONS

- Do not modify product code, product content, product data, production configuration, infrastructure, database state, accounts, payments, billing, DNS, CI/CD, or secrets during this audit.
- Do not submit production forms unless this prompt includes separate explicit approval naming the route, data, stop conditions, and artifact policy.
- Do not use auth, admin, payment, billing, account, upload, logout, destructive, or settings-change flows unless explicitly approved in this prompt.
- Do not use real personal data, real client data, payment data, credentials, or private user data.
- Do not read, print, store, screenshot, summarize, or commit secrets, tokens, passwords, `.env` values, cookies, local storage, session storage, auth headers, raw request bodies, or raw response bodies.
- Do not disclose sensitive material in the report. If sensitive material appears, stop that evidence path and report only anonymized exposure class, safe location, impact, and remediation path.
- Do not run deploy, server, SSH, SCP, database, secrets, production config, or process-management actions.
- Do not install dependencies.
- Do not run broad crawling, scraping, rate-heavy checks, arbitrary browser commands, or arbitrary URLs outside scope.
- Do not collect screenshots, videos, traces, raw HAR, cookies, storage state, or private URLs unless separately approved in this prompt and sanitized before use.

## PAGES / ROUTES

| Route | URL or label | Purpose | Required checks |
|---|---|---|---|
| `[ROUTE_LABEL]` | `[ROUTE_URL_OR_LABEL]` | `[PURPOSE]` | `[CHECKS]` |

## TOOLS / FORMS / FLOWS

| Tool/Form/Flow | Route | Allowed interaction | Submit allowed? | Data/account policy | Stop-before point |
|---|---|---|---:|---|---|
| `[TOOL_OR_FORM]` | `[ROUTE]` | `[NON_SUBMIT_ONLY_OR_APPROVED_ACTION]` | No | Synthetic only | `[STOP_POINT]` |

## EVIDENCE AND ARTIFACT POLICY

Approved evidence:

- `[APPROVED_EVIDENCE_1]`
- `[APPROVED_EVIDENCE_2]`
- Markdown report at `[REPORT_PATH]`
- Sanitized summaries already approved for Code Agent review
- Command output excerpts that contain no secrets or private data

Forbidden unless separately approved and sanitized:

- screenshots
- videos
- traces
- raw HAR
- cookies/storage/auth headers
- raw request/response bodies
- private URLs
- server IPs
- raw sensitive values

Do not fabricate browser, visual, network, console, Lighthouse, screenshot, interaction, auth, payment, admin, or API evidence. If evidence was not captured or supplied under the approved policy, mark the layer or question as unknown or unavailable.

## CHECKS

Run only checks that fit the allowed actions:

- `git status --short --branch`
- `[STATIC_REPO_CHECK]`
- `[PUBLIC_PAGE_OR_SANITIZED_SUMMARY_CHECK]`
- `[REPORT_VALIDATION_CHECK]`
- `git diff --check`

Do not run browser automation unless this prompt explicitly approves the runner, route labels, interactions, viewports, and artifact policy.

## ACCEPTANCE CRITERIA

- [ ] `[REPORT_PATH]` exists or is updated.
- [ ] Report is a Markdown file with Russian decision-maker sections and a separate English technical section.
- [ ] Report includes all required top-level sections from `templates/site-audit/report-template.md`.
- [ ] `## 2. Все найденные замечания` includes every finding, not only top findings.
- [ ] `## 3. Метод и ограничения проверки` lists enabled and unavailable audit layers, test data/accounts used or missing, evidence limitations, and stop conditions.
- [ ] `## 4. Marketing, Sales, Target Audience And AI/Agentic Readiness` covers target-audience usefulness, marketing/sales effectiveness, SEO/AEO/GEO, AI-friendliness, and agentic-commerce readiness, or explicitly marks each missing area as not tested with a reason.
- [ ] `## 5. English Technical Section` includes evidence inventory, technical findings, file paths/routes/selectors/artifacts, observed evidence, inferred risks, unknowns, recommended fix direction, acceptance criteria, and suggested next batches.
- [ ] Every finding has ID, severity, category, location, evidence, impact, recommendation, and status.
- [ ] Observed facts are separated from inferred risks and unknowns.
- [ ] No fabricated browser evidence is included.
- [ ] No forbidden actions were performed.
- [ ] No product code or production configuration was modified.
- [ ] No secrets, sensitive data, real personal data, auth/admin/payment actions, deploy/server/database actions, or production-changing actions were used or disclosed.

## FINAL OUTPUT

Print:

- changed files
- files inspected
- checks run
- stop conditions encountered, or confirmation that none occurred
- whether validation gates passed
- whether follow-up fix prompts can proceed and which approvals they need
