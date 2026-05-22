# Codex Live Site Audit Prompt Template
<!--
  @file:        templates/site-audit/codex-live-audit-prompt-template.md
  @description: Reusable Code Agent prompt template for scoped live website audits
  @updated:     2026-05-22
  @version:     1.0
-->

# Live Site Audit: [PROJECT]

Run a scoped website audit according to `skills/site-audit/SKILL.md`.

## CONTEXT

Project: `[PROJECT]`

Repository: `[REPO]`

URL: `[URL]`

Audit mode: `[AUDIT_MODE]`

Report path: `[REPORT_PATH]`

Scope source: `[AUDIT_SCOPE_FILE_OR_INLINE_SCOPE]`

Relevant references:

- `skills/site-audit/SKILL.md`
- `templates/site-audit/report-template.md`
- `templates/site-audit/finding-taxonomy.md`
- `[PROJECT_KNOWLEDGE_OR_AUDIT_REFERENCE]`

## TASK

Create or update `[REPORT_PATH]` with a structured bilingual site audit report in Markdown.

The report must use this top-level structure:

1. `# [Project] Site Audit Report`
2. `## 1. Краткий отчёт для руководителя` in Russian
3. `## 2. Все найденные замечания` in Russian, with the complete finding list
4. `## 3. Метод и ограничения проверки` in Russian
5. `## 4. English Technical Section` in English
6. `## 5. Safety / Boundary Notes`
7. `## 6. Next Fix Batches`

Audit these pages/routes:

- `[PAGE_OR_ROUTE_1]`
- `[PAGE_OR_ROUTE_2]`

Audit these tools/forms:

- `[TOOL_OR_FORM_1]`
- `[TOOL_OR_FORM_2]`

Cover these dimensions where relevant to scope:

- technical frontend health
- UX/usability
- accessibility
- responsive/mobile
- forms/tools
- SEO
- AEO/GEO/AI-friendly content
- copy/grammar/trust/legal-risk wording
- design/visual consistency
- analytics/conversion
- public UI security/privacy

For every finding, include location, evidence, impact, severity, recommendation, and status. Separate observed facts from inferred risk. The Russian findings section must be simple enough for a non-developer decision-maker; the English technical section must include precise evidence, file paths or routes, inferred risks, recommended fix direction, acceptance criteria, and follow-up prompt suggestions.

## ALLOWED ACTIONS

- `[ALLOWED_ACTION_1]`
- `[ALLOWED_ACTION_2]`
- Read public no-auth pages listed in scope.
- Inspect visible text, public metadata, public source, and approved sanitized summaries.
- Run only the checks listed in the CHECKS section.

## FORBIDDEN ACTIONS

- Do not submit production forms unless this prompt includes separate explicit approval naming the route, data, stop conditions, and artifact policy.
- Do not use auth, admin, payment, billing, account, upload, logout, destructive, or settings-change flows unless separately approved in this prompt.
- Do not use real personal data, real client data, payment data, credentials, or private user data.
- Do not read, print, store, or commit secrets, tokens, passwords, `.env` values, cookies, local storage, auth headers, raw request bodies, or raw response bodies.
- Do not run deploy, server, SSH, SCP, database, secrets, production config, or process-management actions.
- Do not install dependencies.
- Do not run broad crawling, scraping, rate-heavy checks, arbitrary browser commands, or arbitrary URLs outside scope.
- Do not collect screenshots, videos, traces, raw HAR, cookies, storage state, or private URLs unless separately approved in this prompt.
- Do not modify product code during this audit.

## PAGES / ROUTES

| Route | URL | Purpose | Required checks |
|---|---|---|---|
| `[ROUTE_LABEL]` | `[ROUTE_URL]` | `[PURPOSE]` | `[CHECKS]` |

## TOOLS / FORMS

| Tool/Form | Route | Allowed interaction | Submit allowed? | Data policy |
|---|---|---|---:|---|
| `[TOOL_OR_FORM]` | `[ROUTE]` | `[NON_SUBMIT_ONLY_OR_APPROVED_ACTION]` | No | Synthetic only |

## CHECKS

Run only checks that fit the allowed actions:

- `git status --short --branch`
- `[STATIC_REPO_CHECK]`
- `[PUBLIC_PAGE_OR_SANITIZED_SUMMARY_CHECK]`
- `[REPORT_VALIDATION_CHECK]`

Do not run browser automation unless this prompt explicitly approves it and names the allowed routes, interactions, and artifact policy.

## ACCEPTANCE CRITERIA

- [ ] `[REPORT_PATH]` exists or is updated.
- [ ] Report is a Markdown file with Russian decision-maker sections and a separate English technical section.
- [ ] Report includes `## 1. Краткий отчёт для руководителя`, `## 2. Все найденные замечания`, `## 3. Метод и ограничения проверки`, `## 4. English Technical Section`, `## 5. Safety / Boundary Notes`, and `## 6. Next Fix Batches`.
- [ ] Every finding has location, evidence, impact, severity, recommendation, and status.
- [ ] Observed facts are separated from inferred risks and unknowns.
- [ ] No fabricated browser evidence is included.
- [ ] No forbidden actions were performed.
- [ ] No secrets, real personal data, auth/admin/payment actions, deploy/server/database actions, or production-changing actions were used.

## FINAL OUTPUT

Print:

- changed files
- files inspected
- checks run
- stop conditions encountered, or confirmation that none occurred
- whether follow-up fix prompts can proceed
