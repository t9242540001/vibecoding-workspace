# Site Audit Validation Gates
<!--
  @file:        docs/site-audit/validation-gates.md
  @description: Reusable validation gates for Vibe Coding site-audit prompts and reports
  @updated:     2026-05-24
  @version:     1.1
-->

## Purpose

These gates validate site-audit prompts, reports, post-fix audits, and browser-summary audit reviews before they are treated as complete.

The gates apply after the approved scope is known and before any report is accepted, sent for model analysis, or converted into fix prompts. They validate evidence quality, safety boundaries, bilingual report completeness, full-audit layer coverage, marketing/sales/target-audience and AI/agentic-commerce coverage, and regression discipline. They do not authorize a live audit, browser automation, screenshots, form submission, auth, payment, deploy, server, database, or secrets work.

## Gate 1 - Scope Completeness

A site-audit prompt or report passes only when it states:

| Required scope field | Pass condition |
|---|---|
| Target | Project/site/repository and public URL or approved route label are named. |
| Enabled audit layers | Full audit layers are listed. Each requested layer is either executed or explicitly marked unavailable with reason. |
| Allowed actions | Read, live HTTP, browser, interactive, auth/account, payment, admin, API/server-route/SSE, validation, and artifact actions are listed when in scope. |
| Forbidden actions | Product modification, submit/auth/payment/admin/account/upload/destructive/deploy/server/database/secrets actions are explicitly forbidden unless separately approved. |
| Routes/pages | Routes use approved labels where browser evidence is used; arbitrary URLs are not introduced by default. |
| Forms/tools/flows | Each form, tool, or flow lists allowed interaction, submit status, data policy, account policy, and stop-before point. |
| Test data/accounts | Synthetic test data, approved test accounts, missing prerequisites, and credential-handling rules are stated. |
| Artifact policy | Allowed and forbidden artifacts are listed, including screenshot/video/trace/raw HAR/cookie/storage/header handling. |
| Report path | Output path is declared and stays inside the approved repository scope. |
| Stop conditions | Safety, evidence, sensitive-data, and scope stop conditions are listed. |

Fail the gate when the prompt or report relies on browser, visual, interactive, auth, payment, admin, or API evidence without route/profile scope, test data/account policy, artifact policy, and stop conditions.

## Gate 2 - Safety Boundary Compliance

The audit passes only when it preserves the default Vibe Coding safety envelope:

- no product code, product content, product data, production configuration, infrastructure, accounts, payments, billing, DNS, CI/CD, or server state was modified during the audit;
- no unapproved submit, auth, payment, admin, account, upload, logout, settings-change, contact-message, or destructive action;
- no real personal data, client data, payment data, credentials, or private user data;
- no secrets, tokens, `.env` values, passwords, cookies, local storage, session storage, auth headers, bearer tokens, raw request bodies, or raw response bodies;
- no deploy, server, database, SSH, SCP, process-management, production config, or secrets-management action;
- no raw HAR, screenshots, videos, traces, storage state, full private URLs, private endpoints, server IPs, or local paths unless separately approved in the scope and sanitized;
- no broad crawling, scraping, rate-heavy checks, arbitrary browser commands, or arbitrary URLs by default.

If a forbidden item appears in evidence, stop the affected evidence path, do not quote the value, and report the exposure only by anonymized exposure class, safe location, impact, and remediation path.

## Gate 3 - Evidence Quality

Every finding must include:

- ID: stable `F-001` style identifier;
- category: aligned with `templates/site-audit/finding-taxonomy.md`;
- location: route, source file, selector, section, viewport, or artifact;
- evidence: observed fact, source line, command output, sanitized browser summary, approved screenshot reference, approved Lighthouse-style signal, human judgment, or explicit unknown;
- impact: user, accessibility, SEO, conversion, trust, safety, privacy, marketing, AI/agentic, or maintenance consequence;
- severity: one of the allowed taxonomy values;
- recommendation: a concrete fix direction or approved next step;
- status: `open`, `fixed`, `partially fixed`, `not fixed`, `new regression`, or `not retested`.

Observed facts, inferred risks, and unknowns must be separated. Use `Observed:`, `Inferred risk:`, and `Unknown:` wording where a finding combines them.

Browser, visual, responsive, console, network, Lighthouse, interaction, auth, payment, admin, and API/server-route claims require actual approved evidence or a supplied sanitized summary. Automated signals are labeled as signals, not complete proof. If the evidence was not captured or supplied, the report marks the question as unknown, not tested, or out of scope.

## Gate 4 - Severity Quality

Severity passes when:

- values match `configs/site-audit-severity-taxonomy.json`: `Critical`, `High`, `Medium`, `Low`, or `Observation`;
- escalation factors are considered for vulnerable users, mobile users, new users, legal/financial/medical decisions, data submission, primary CTAs, primary tasks, privacy risk, auth/payment/admin/account boundaries, misleading structured data, AI/agentic recommendation safety, and repeated primary-route issues;
- duplicates are grouped when the root cause and recommendation are the same;
- related findings are linked rather than copied into multiple categories;
- `Observation` is not used to downgrade a defect with real user impact.

## Gate 5 - SEO, AEO, GEO, Marketing, And AI/Agentic Quality

SEO/AEO/GEO, marketing/sales, target-audience, and AI/agentic-commerce recommendations pass only when they improve user clarity, trust, findability, answerability, decision usefulness, or safe service/action routing.

Reports must cover these areas or explicitly mark them `not tested` with reasons:

- target-audience usefulness;
- marketing/sales effectiveness;
- SEO;
- AEO/GEO;
- AI-friendliness;
- AI/agentic-commerce readiness.

Reject recommendations that rely on manipulative ranking tactics, keyword stuffing, hidden content, fake freshness, fake reviews, fabricated authority, doorway pages, AI-only filler, or structured data that contradicts visible content.

Structured data findings must distinguish syntax, completeness, eligibility, and visible-content alignment. Agentic-commerce findings must label emerging-practice risk honestly and must not present future conventions as hard requirements unless backed by a current authoritative requirement.

## Gate 6 - Accessibility Quality

Accessibility findings pass when:

- automated checks are treated as signals and do not replace manual judgment;
- WCAG-related claims cite concrete evidence, a source location, an approved browser observation, or are framed as a follow-up check;
- keyboard, focus, contrast, reflow, labels, alt text, error messages, and name/role/value claims state the inspected route, viewport, or artifact;
- missing evidence is recorded as `Unknown` with a next approved step, not as a reproduced defect.

Escalate when the issue blocks keyboard users, screen-reader users, mobile users, form completion, or a primary user path.

## Gate 7 - Bilingual Report Completeness

A completed report must be a Markdown file and include the required sections from `templates/site-audit/report-template.md`:

- `# [Project] Site Audit Report`;
- `## 1. Краткий отчёт для руководителя` in Russian, with what was checked, what was not checked, main result, highest risks, evidence limitations, and top next actions;
- `## 2. Все найденные замечания` in Russian, with the complete finding list and each finding's ID, severity, short problem, location, impact, next action, and status;
- `## 3. Метод и ограничения проверки` in Russian, with enabled audit layers, unavailable layers and reasons, test data/accounts used or missing, live/browser/interactive evidence limitations, and stop conditions;
- `## 4. Marketing, Sales, Target Audience And AI/Agentic Readiness`, with Russian short interpretation plus English technical details if useful, covering target-audience usefulness, marketing/sales effectiveness, SEO/AEO/GEO, AI-friendliness, and agentic-commerce readiness or explicit not-tested reasons;
- `## 5. English Technical Section` in English, with evidence inventory, technical findings table, file paths/routes/selectors/artifacts, observed evidence, inferred risks, unknowns, recommended fix direction, acceptance criteria, and suggested next batches;
- `## 6. Safety / Boundary Notes`, with explicit confirmation that product code was not changed, sensitive data was not disclosed, and any sensitive data encountered was anonymized;
- `## 7. Next Fix Batches`, with recommended next batches in priority order.

Russian decision-maker sections pass only when they are short, simple, and decision-oriented. The English technical section passes only when it is detailed enough for Code Agent execution without needing to infer evidence, affected files/routes/selectors, acceptance criteria, or suggested follow-up scope.

Stop conditions must be reported even when none occurred. Next fix batches must be scoped to finding IDs, affected files or routes, regression shield, checks, and approval needs.

## Gate 8 - Artifact And Sensitive-Data Safety

Screenshots and artifacts pass only when they are approved by scope and safe to reference. If screenshots, videos, traces, raw HAR, cookies, storage, auth headers, private URLs, or raw payloads are absent, the report must state the reason and avoid claims that require those artifacts.

Sensitive-data handling passes only when:

- sensitive values are not printed, quoted, screenshotted, stored, or committed;
- any exposure is reported only by anonymized class, safe location, impact, and remediation path;
- reports explicitly state whether sensitive data was disclosed;
- reports explicitly state whether sensitive material was encountered and anonymized;
- raw secrets, credentials, tokens, cookies, auth headers, payment data, personal data, private client data, and private URLs are absent from the report.

## Gate 9 - Regression Quality

Post-fix audits must map every retest to original finding IDs and acceptance criteria.

Allowed regression statuses:

| Status | Meaning |
|---|---|
| fixed | Evidence shows the original issue is resolved. |
| partially fixed | Some acceptance criteria pass, but material risk remains. |
| not fixed | Evidence shows the original issue still exists. |
| new regression | A new issue appeared during retest. |
| not retested | The check was outside approved scope or evidence was unavailable. |

Regression reports must preserve original finding IDs, add new evidence IDs, and avoid broadening browser actions, artifacts, routes, or fix scope without approval.

## Minimum Completion Checklist

- [ ] Scope completeness gate passed.
- [ ] Safety boundary compliance gate passed.
- [ ] Evidence quality gate passed.
- [ ] Severity quality gate passed.
- [ ] SEO/AEO/GEO, marketing/sales, target-audience, and AI/agentic-commerce quality gate passed where relevant or each area is marked not tested with reason.
- [ ] Accessibility quality gate passed where relevant.
- [ ] Bilingual report completeness gate passed.
- [ ] All required report sections exist.
- [ ] All findings are included.
- [ ] Russian decision-maker sections are short and simple.
- [ ] English technical section is detailed enough for Code Agent execution.
- [ ] Full audit layers are either executed or explicitly marked unavailable with reason.
- [ ] No product modifications were performed during audit.
- [ ] Sensitive data is not disclosed and any exposure is anonymized.
- [ ] Screenshots/artifacts are either approved and safe or absent with reason.
- [ ] Regression quality gate passed for post-fix audits.
- [ ] JSON configs referenced by the audit validate if changed.
- [ ] `git diff --check` passes for repository changes.
