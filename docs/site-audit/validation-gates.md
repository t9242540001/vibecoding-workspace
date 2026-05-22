# Site Audit Validation Gates
<!--
  @file:        docs/site-audit/validation-gates.md
  @description: Reusable validation gates for Vibe Coding site-audit prompts and reports
  @updated:     2026-05-22
  @version:     1.0
-->

## Purpose

These gates validate site-audit prompts, reports, post-fix audits, and browser-summary audit reviews before they are treated as complete.

The gates apply after the approved scope is known and before any report is accepted, sent for model analysis, or converted into fix prompts. They validate evidence quality, safety boundaries, report completeness, and regression discipline. They do not authorize a live audit, browser automation, screenshots, form submission, auth, payment, deploy, server, database, or secrets work.

## Gate 1 - Scope Completeness

A site-audit prompt or report passes only when it states:

| Required scope field | Pass condition |
|---|---|
| Target | Project/site/repository and public URL or approved route label are named. |
| Audit mode | One mode from `skills/site-audit/SKILL.md` is selected. Mixed modes are split or separately approved. |
| Allowed actions | Read, browser, validation, and artifact actions are listed explicitly. |
| Forbidden actions | Submit/auth/payment/admin/account/upload/destructive/deploy/server/database/secrets actions are explicitly forbidden unless separately approved. |
| Routes/pages | Routes use approved labels where browser evidence is used; arbitrary URLs are not introduced by default. |
| Forms/tools | Each form or tool lists allowed interaction, submit status, and data policy. |
| Artifact policy | Allowed and forbidden artifacts are listed, including screenshot/video/trace/raw HAR/cookie/storage/header handling. |
| Report path | Output path is declared and stays inside the approved repository scope. |

Fail the gate when the prompt or report relies on browser evidence without route/profile scope, artifact policy, or stop conditions.

## Gate 2 - Safety Boundary Compliance

The audit passes only when it preserves the default Vibe Coding safety envelope:

- no unapproved submit, auth, payment, admin, account, upload, logout, settings-change, contact-message, or destructive action;
- no real personal data, client data, payment data, credentials, or private user data;
- no secrets, tokens, `.env` values, passwords, cookies, local storage, session storage, auth headers, bearer tokens, raw request bodies, or raw response bodies;
- no deploy, server, database, SSH, SCP, process-management, production config, or secrets-management action;
- no raw HAR, screenshots, videos, traces, storage state, full private URLs, private endpoints, server IPs, or local paths unless separately approved in the scope;
- no broad crawling, scraping, rate-heavy checks, arbitrary browser commands, or arbitrary URLs by default.

If a forbidden item appears in evidence, stop the audit, do not quote the value, and report the exposure at a high level.

## Gate 3 - Evidence Quality

Every finding must include:

- location: route, source file, selector, section, viewport, or artifact;
- evidence: observed fact, source line, command output, sanitized browser summary, approved screenshot reference, approved Lighthouse-style signal, human judgment, or explicit unknown;
- impact: user, accessibility, SEO, conversion, trust, safety, privacy, or maintenance consequence;
- severity: one of the allowed taxonomy values;
- recommendation: a concrete fix direction or approved next step.

Observed facts, inferred risks, and unknowns must be separated. Use `Observed:`, `Inferred risk:`, and `Unknown:` wording where a finding combines them.

Browser, visual, responsive, console, network, Lighthouse, and link claims require actual approved evidence or a supplied sanitized summary. Automated signals are labeled as signals, not complete proof. If the evidence was not captured or supplied, the report marks the question as unknown or out of scope.

## Gate 4 - Severity Quality

Severity passes when:

- values match `configs/site-audit-severity-taxonomy.json`: `Critical`, `High`, `Medium`, `Low`, or `Observation`;
- escalation factors are considered for vulnerable users, mobile users, new users, legal/financial/medical decisions, data submission, primary CTAs, primary tasks, privacy risk, auth/payment/admin/account boundaries, misleading structured data, and repeated primary-route issues;
- duplicates are grouped when the root cause and recommendation are the same;
- related findings are linked rather than copied into multiple categories;
- `Observation` is not used to downgrade a defect with real user impact.

## Gate 5 - SEO, AEO, And GEO Quality

SEO/AEO/GEO recommendations pass only when they improve user clarity, trust, findability, or answerability.

Reject recommendations that rely on manipulative ranking tactics, keyword stuffing, hidden content, fake freshness, fake reviews, fabricated authority, doorway pages, or structured data that contradicts visible content.

Structured data findings must distinguish syntax, completeness, eligibility, and visible-content alignment. A schema opportunity without evidence of user impact should be `Observation` unless escalation factors apply.

## Gate 6 - Accessibility Quality

Accessibility findings pass when:

- automated checks are treated as signals and do not replace manual judgment;
- WCAG-related claims cite concrete evidence, a source location, an approved browser observation, or are framed as a follow-up check;
- keyboard, focus, contrast, reflow, labels, alt text, error messages, and name/role/value claims state the inspected route, viewport, or artifact;
- missing evidence is recorded as `Unknown` with a next approved step, not as a reproduced defect.

Escalate when the issue blocks keyboard users, screen-reader users, mobile users, form completion, or a primary user path.

## Gate 7 - Report Completeness

A completed report must include the required sections from `templates/site-audit/report-template.md`:

- `# [Project] Site Audit Report`;
- `## 1. Краткий отчёт для руководителя` in Russian, with audit result, highest risk, what was checked, what was not checked, and top priorities;
- `## 2. Все найденные замечания` in Russian, with the complete finding list and each finding's ID, severity, short problem, location, impact, and next action;
- `## 3. Метод и ограничения проверки` in Russian, with audit mode, checked pages/files, skipped scope, unavailable evidence, and stop conditions;
- `## 4. English Technical Section` in English, with evidence inventory, technical finding table, file paths/lines/routes, observed evidence, inferred risks, recommended fix direction, acceptance criteria, and follow-up prompt suggestions;
- `## 5. Safety / Boundary Notes`, with explicit confirmation that forbidden actions were not performed;
- `## 6. Next Fix Batches`, with recommended next fix batches in priority order.

Stop conditions must be reported even when none occurred. Next fix batches must be scoped to finding IDs, affected files or routes, regression shield, checks, and approval needs.

## Gate 8 - Regression Quality

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
- [ ] SEO/AEO/GEO quality gate passed where relevant.
- [ ] Accessibility quality gate passed where relevant.
- [ ] Report completeness gate passed.
- [ ] Report includes Russian decision-maker sections and the English technical section.
- [ ] Regression quality gate passed for post-fix audits.
- [ ] JSON configs referenced by the audit validate if changed.
- [ ] `git diff --check` passes for repository changes.
