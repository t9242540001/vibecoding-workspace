# Agentic Site Audit Pipeline
<!--
  @file:        docs/site-audit/agentic-audit-pipeline.md
  @description: Reusable safe execution pipeline for full agentic website audits
  @updated:     2026-05-23
  @version:     1.1
-->

## Purpose

This document defines how an AI orchestrator and Code Agent run a safe, evidence-based full website audit from request intake to report and follow-up fix prompts.

The pipeline applies to public websites, landing pages, frontend UIs, scoped repository audits, live HTTP checks, browser visual checks, interactive user flows, auth/account checks, payment-path checks, admin/access-boundary checks, API/server-route/SSE checks, marketing/sales and target-audience usefulness checks, SEO/AEO/GEO checks, AI/agentic-commerce readiness checks, security/privacy/sensitive-data exposure checks, and post-fix regression audits.

## Non-Purpose

This pipeline does not authorize:

- real website audits without an approved scope;
- arbitrary URLs, arbitrary browser commands, or broad crawling;
- browser automation implementation;
- screenshots, videos, traces, raw HAR, cookies, storage, auth headers, raw request bodies, or raw response bodies by default;
- deploy, server, database, secrets, SSH, SCP, production config, product modification, real payment, destructive admin, irreversible account, upload, or state-changing actions outside the approved audit scope;
- product-code changes during the audit itself.

## Actor Model

| Actor | Responsibility |
|---|---|
| User/decision layer | Approves scope, enabled layers, routes, artifact policy, test data/accounts, payment/admin boundaries, stop conditions, and follow-up fixes. |
| AI orchestrator | Converts the request into a scoped audit plan, selects capability layers, checks safety gates, and prepares Code Agent prompts. |
| Code Agent | Reads approved context, collects only approved evidence, writes the report, validates outputs, and stops on safety conditions. |
| Optional browser/e2e evidence producer | Produces sanitized summaries from approved route/profile pairs. It does not send raw session artifacts to model analysis. |
| Repository/GitHub source of truth | Stores reusable skills, configs, reports, prompts, and any approved product changes after review and checks. |

## Pipeline Phases

### 1. Intake And Scope Gate

The orchestrator records the target project/site, enabled audit layers, routes/pages, devices/viewports, forms/tools, allowed actions, forbidden actions, test data/accounts, sandbox or stop-before-charge payment boundary, admin/access-boundary limits, artifact policy, report path, approval gates, and stop conditions.

Use `templates/site-audit/audit-scope-template.md` when the scope is not already explicit. Use `configs/site-audit-default-scope.json` as the reusable default policy. Product-specific routes and report paths belong in the product repository or the prompt, not in the shared default config.

Stop before execution when a requested layer lacks the required route, test data/account, sandbox/stop-before-charge boundary, non-destructive admin boundary, artifact policy, or stop condition. Interactive, auth, payment-path, admin, browser, and server-route checks are not blocked by default; they become unavailable limitations only when the approved scope cannot support them safely.

### 2. Read Order

For shared audit-system work, read:

1. repository instructions;
2. `workspace-index.md`;
3. relevant standards;
4. `skills/site-audit/SKILL.md`;
5. `docs/site-audit/research-basis.md`;
6. relevant templates and configs;
7. affected files.

For product audits, read the product repository instructions, equivalent main context file, knowledge files, approved audit scope, prior audit reports, and the source files or sanitized browser summaries needed for the approved evidence model.

### 3. Audit Plan

The plan maps the approved scope to audit dimensions and evidence sources. It states:

- enabled audit layers;
- included and skipped dimensions;
- approved routes/profiles or source paths;
- approved test data/accounts and payment/admin boundaries;
- automated checks;
- manual or human-judgment checks;
- artifact policy;
- report path;
- stop conditions;
- what is out of scope.

### 4. Safe Evidence Collection

The Code Agent collects only approved evidence. Allowed audit action may include browsing, clicking, typing, synthetic submissions, test-account login, sandbox/test payment-path checks, stop-before-charge checkout inspection, non-destructive admin/access-boundary checks, and API/server-route/SSE behavior checks when the scope enables them.

Evidence sources include:

- source files inside scope;
- public page observations inside approved routes;
- sanitized browser summaries from approved route/profile pairs;
- high-level console and network summaries after redaction;
- approved interactive flow notes using synthetic data;
- auth/account observations using approved test accounts;
- payment-path observations from sandbox/test mode or explicit stop-before-charge boundaries;
- admin/access-boundary observations from non-destructive role checks;
- API/server-route/SSE observations summarized without raw sensitive payloads;
- Lighthouse or similar signals when the run is approved and does not collect forbidden artifacts;
- human visual judgment only when visual inspection is approved and evidence limits are stated.

Do not fabricate browser evidence. If a page, viewport, screenshot, trace, Lighthouse run, console log, or network summary was not actually captured or supplied as an approved sanitized artifact, the report marks it as unknown or out of scope.

Do not modify product code, product content, deployed configuration, infrastructure, database data except reversible synthetic test data created for the audit, real accounts, real payments, or production state during evidence collection.

### 5. Report Generation

Use `templates/site-audit/report-template.md`. The report must be a `.md` file with Russian decision-maker sections and a separate English technical section. Every finding must include finding ID, severity, category, location, evidence, impact, recommendation, and status.

Evidence IDs use `E-001`, `E-002`, and so on. Finding IDs use `F-001`, `F-002`, and so on. Findings must separate observed facts from inferred risks and unknowns.

### 6. Validation Gates

Before completion, verify:

- report has the required sections;
- report includes Russian executive, complete findings, and method/limits sections plus an English technical section;
- every finding has evidence or is explicitly marked as human judgment or unknown;
- severity values match `configs/site-audit-severity-taxonomy.json`;
- categories align with `templates/site-audit/finding-taxonomy.md`;
- forbidden actions and artifacts were not used;
- stop conditions are reported;
- JSON configs, if changed, are valid;
- `git diff --check` passes for repository changes.

### 7. Fix Prompt Planning

Follow-up fixes are separate scoped prompts. Each fix prompt must cite the audit report, finding IDs, evidence, regression shield, affected files, checks, and approval gates.

Findings that require product modification, deploy/server/database/secrets work, real payment, destructive admin action, irreversible account action, or production data mutation become approval requests or follow-up decisions, not automatic fix prompts.

### 8. Post-Fix Regression Audit

After fixes, run a post-fix regression audit against original finding IDs and acceptance criteria. Mark each finding as fixed, partially fixed, not fixed, new regression, or not retested, with evidence.

## Audit Layer Routing

| Layer | Route When | Allowed Evidence | Scope Contract Requirement |
|---|---|---|---|
| Static repository audit | Source, content, metadata, routes, or UI implementation must be inspected. | Repo-local files, configs, tests, build outputs, static metadata. | Approved source paths; no product-code edits during audit. |
| Live HTTP audit | Public status, redirect, headers, robots/sitemap, assets, links, or route availability must be checked. | Public HTTP summaries and safe metadata. | Approved routes/URLs, rate limits, and artifact policy. |
| Browser visual audit | Rendered layout, responsive behavior, media, console/network, or visual states must be evaluated. | Sanitized browser summaries, approved screenshots, viewport observations, console/network summaries. | Approved route/profile pairs, devices, artifact policy, and redaction rules. |
| Interactive user-flow audit | Clicks, typing, forms, validation, reversible submission, or flow continuity must be tested. | Synthetic data flow notes, state observations, sanitized summaries. | Allowed interactions, synthetic data policy, stop-before points, and state-change boundary. |
| Auth/account audit | Login, registration, recovery, profile, account states, or roles must be checked. | Test-account observations and sanitized role/state summaries. | Approved test accounts/roles and credential-handling rules. |
| Payment-path audit | Pricing, checkout, payment states, receipts, cancellation, or billing UX must be checked. | Sandbox/test-mode observations or stop-before-charge notes. | Sandbox/test mode or explicit stop-before-charge boundary; no real charges. |
| Admin/access-boundary audit | Permissions, restricted UI/API exposure, or role boundaries must be checked. | Non-destructive blocked/allowed observations. | Approved test roles and forbidden destructive admin actions. |
| API/server-route/SSE audit | Routes, response shape, stream behavior, timeouts, or client integration must be checked. | Safe status/shape summaries, stream start/stop summaries, error surfaces. | Approved endpoints/routes and no raw sensitive payloads. |
| Marketing/sales/target-audience usefulness audit | Offer, audience fit, CTA, trust, objections, or decision usefulness must be evaluated. | Route/section evidence and observed copy/content gaps. | Target audience and pages/sections in scope. |
| SEO/AEO/GEO audit | Findability, answerability, entity clarity, structured data, or people-first content must be evaluated. | Metadata, page text, structured data summaries, crawlability signals. | Approved routes/files and no manipulative ranking tactics. |
| AI/agentic-commerce readiness audit | Assistant recommendation or agentic selection/shopping readiness must be evaluated. | Service/action clarity, stable links, structured offer, pricing, policy, availability evidence. | Relevant product/service scope and emerging-practice labeling. |
| Security/privacy/sensitive-data exposure audit | Sensitive exposure, unsafe errors, private endpoints, or auth/payment/admin risks must be checked. | Anonymized exposure class, safe location class, impact, remediation path. | Stop and redact raw sensitive values. |
| Post-fix regression audit | Previous findings have fixes to retest. | Prior report, finding IDs, changed files, approved route/profile summaries, relevant checks. | Must cite previous finding IDs and allowed retest checks. |

## Evidence Model

| Evidence Type | Use | Constraint |
|---|---|---|
| Source files | Static repository audit, implementation evidence, metadata and content checks. | Read only approved files; no product-code edits during audit. |
| Public page observations | Read-only public no-auth audit. | Approved routes only; no arbitrary URLs or broad crawling. |
| Sanitized browser summaries | Browser/e2e handoff and model-readable page evidence. | Must pass the summary contract and forbidden-pattern scan before model analysis. |
| Console/network summaries | Technical frontend health, failed public requests, mixed content, blocked assets. | High-level redacted summaries only; no raw request/response bodies, headers, cookies, or tokens. |
| Synthetic interaction notes | Interactive user-flow audit. | Synthetic data only; stop before unapproved state changes. |
| Test-account observations | Auth/account and admin/access-boundary audits. | Approved test accounts only; no credential values in reports. |
| Sandbox or stop-before-charge payment notes | Payment-path audit. | No real charges, refunds, saved payment mutation, or billing changes. |
| Safe API/server-route/SSE summaries | API/server-route/SSE audit. | Status, response-shape, stream, timeout, and error summaries only; no raw sensitive payloads. |
| Lighthouse or similar signals | Performance, accessibility, SEO, best-practice signals. | Allowed only when the run and artifacts fit scope; scores do not replace human judgment. |
| Human visual judgment | Design, visual hierarchy, overlap, mobile layout, interaction quality. | Must state what was actually inspected and whether screenshots or visual artifacts were approved. |
| Unknowns | Missing evidence, blocked checks, out-of-scope routes, unapproved actions. | Mark explicitly with next approved step. |

## Browser/E2E Integration Rules

Site audits reuse existing Vibe Coding browser-safety concepts:

- approved route labels, not arbitrary URLs;
- approved interaction profiles, not arbitrary browser commands;
- sanitized summary JSON before model analysis;
- validator and forbidden-pattern scan before model analysis;
- short-retention sanitized artifacts only;
- model analysis receives sanitized summary, acceptance criteria, and report schema.

No audit may broaden route/profile scope during execution. No audit may collect raw cookies, storage, auth headers, raw HAR, raw request bodies, raw response bodies, private URLs, server IPs, screenshots, videos, or traces unless the scope explicitly approves that artifact policy and the material is sanitized before model analysis or reporting.

The browser/e2e evidence producer is optional. If it is not available or approved, the audit uses static evidence and supplied sanitized summaries, and reports browser-only questions as unknowns.

## Safety Stop Conditions

Stop and report when any condition appears:

- secret, credential, token, cookie, auth header, or session material exposure;
- real personal, client, payment, billing, medical, legal-case, or private user data;
- unapproved submit, auth, payment, admin, account, upload, logout, destructive, settings-change, or contact-message action required;
- real charge, refund, saved payment mutation, billing change, destructive admin action, or irreversible account mutation required;
- private URL, private endpoint, account boundary, or credentialed environment outside approval;
- server, deploy, database, secrets, SSH, SCP, process-management, or production config action needed;
- evidence source outside the approved artifact policy;
- broad crawling, scraping, rate-heavy checks, or anti-abuse boundary risk;
- validation failure whose fix is outside the current scope;
- ambiguous scope with material risk of semantic or safety drift.

Stop reports must be minimal and sanitized. Do not quote secret values, credentials, personal data, payment data, cookies, tokens, auth/session material, or private payloads. Report only exposure type, safe location class, impact, and remediation path.

## Output Contracts

| Output | Contract |
|---|---|
| Report path | Declared in the audit scope or prompt; shared examples use `templates/site-audit/report-template.md`. |
| Finding IDs | Stable `F-001` style IDs, preserved across fix prompts and regression audits. |
| Evidence IDs | Stable `E-001` style IDs with type, location, captured-by, and notes. |
| Severity taxonomy | `Critical`, `High`, `Medium`, `Low`, `Observation` from `configs/site-audit-severity-taxonomy.json`. |
| Categories | Category list aligned with `templates/site-audit/finding-taxonomy.md`. |
| Next fix prompts | Separate scoped prompts that cite finding IDs, affected files, checks, and approval gates. |

## How To Use The Configs

`configs/site-audit-default-scope.json` defines universal defaults for audit layers, allowed audit actions, forbidden product modifications, sensitive data redaction rules, test data/account placeholders, audit dimensions, viewports, stop conditions, artifact policy, and report sections. Use it as the starting policy, then narrow it with a product-specific scope.

`configs/site-audit-severity-taxonomy.json` defines severity levels, evidence requirements, escalation factors, and allowed categories. Use it to validate report findings and align fix prompt priority.

## Open Decisions And Future Extensions

- Whether product repositories may override severity labels while preserving the same impact logic.
- Whether a lightweight report validator should enforce required sections and finding fields.
- Whether approved screenshot artifacts need a separate visual-evidence policy.
- Whether additional default viewport sets are needed for product categories with unusual device usage.
- Whether browser/e2e route and profile configs should gain a generic shared schema for all product repositories.
