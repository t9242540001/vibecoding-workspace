# Agentic Site Audit Pipeline
<!--
  @file:        docs/site-audit/agentic-audit-pipeline.md
  @description: Reusable safe execution pipeline for agentic website audits
  @updated:     2026-05-22
  @version:     1.0
-->

## Purpose

This document defines how an AI orchestrator and Code Agent run a safe, evidence-based website audit from request intake to report and follow-up fix prompts.

The pipeline applies to public websites, landing pages, frontend UIs, public no-auth flows, scoped repository audits, non-submit form/tool inspection, approved higher-risk flows, and post-fix regression audits.

## Non-Purpose

This pipeline does not authorize:

- real website audits without an approved scope;
- arbitrary URLs, arbitrary browser commands, or broad crawling;
- browser automation implementation;
- screenshots, videos, traces, raw HAR, cookies, storage, auth headers, raw request bodies, or raw response bodies by default;
- deploy, server, database, secrets, SSH, SCP, production config, auth, payment, admin, upload, or state-changing actions without separate explicit approval;
- product-code changes during the audit itself.

## Actor Model

| Actor | Responsibility |
|---|---|
| User/decision layer | Approves scope, mode, routes, artifact policy, higher-risk actions, and follow-up fixes. |
| AI orchestrator | Converts the request into a scoped audit plan, selects the audit mode, checks safety gates, and prepares Code Agent prompts. |
| Code Agent | Reads approved context, collects only approved evidence, writes the report, validates outputs, and stops on safety conditions. |
| Optional browser/e2e evidence producer | Produces sanitized summaries from approved route/profile pairs. It does not send raw session artifacts to model analysis. |
| Repository/GitHub source of truth | Stores reusable skills, configs, reports, prompts, and any approved product changes after review and checks. |

## Pipeline Phases

### 1. Intake And Scope Gate

The orchestrator records the target project/site, audit mode, routes/pages, devices/viewports, forms/tools, allowed actions, forbidden actions, artifact policy, report path, approval gates, and stop conditions.

Use `templates/site-audit/audit-scope-template.md` when the scope is not already explicit. Use `configs/site-audit-default-scope.json` as the reusable default policy. Product-specific routes and report paths belong in the product repository or the prompt, not in the shared default config.

Stop before execution when the request requires unapproved submit/auth/payment/admin/account/upload/destructive actions, real personal/client/payment data, private URLs, credentials, screenshots/videos/traces/raw HAR, deploy/server/database/secrets work, or artifact types outside policy.

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

- selected audit mode;
- included and skipped dimensions;
- approved routes/profiles or source paths;
- automated checks;
- manual or human-judgment checks;
- artifact policy;
- report path;
- stop conditions;
- what is out of scope.

### 4. Safe Evidence Collection

The Code Agent collects only approved evidence:

- source files inside scope;
- public page observations inside approved routes;
- sanitized browser summaries from approved route/profile pairs;
- high-level console and network summaries after redaction;
- Lighthouse or similar signals when the run is approved and does not collect forbidden artifacts;
- human visual judgment only when visual inspection is approved and evidence limits are stated.

Do not fabricate browser evidence. If a page, viewport, screenshot, trace, Lighthouse run, console log, or network summary was not actually captured or supplied as an approved sanitized artifact, the report marks it as unknown or out of scope.

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

Higher-risk items remain gated. A finding that requires deploy/server/database/secrets/auth/payment/admin/account/upload/destructive action becomes an approval request or follow-up decision, not an automatic fix prompt.

### 8. Post-Fix Regression Audit

After fixes, run a post-fix regression audit against original finding IDs and acceptance criteria. Mark each finding as fixed, partially fixed, not fixed, new regression, or not retested, with evidence.

## Audit Mode Routing

| Mode | Route When | Default Allowed Evidence | Approval Gate |
|---|---|---|---|
| Static repository audit | The user asks to inspect source, content, metadata, or UI implementation without live browser evidence. | Repo-local files, configs, tests, build outputs, static metadata. | Product-code edits require separate fix approval. |
| Read-only live public audit | The user approves public no-auth pages or supplied sanitized summaries. | Visible text, public metadata, safe page observations, high-level console/network summaries, public link status. | Approved URLs/routes and artifact policy required. |
| Non-submit form/tool audit | The user approves inspection of fields and client-side behavior without sending data. | Labels, hints, validation states, disabled/loading/error states, synthetic non-submit interactions. | Explicit non-submit approval and synthetic data policy required. |
| Approved submit/auth/payment/admin audit | The requested evidence requires submission, login, payment, admin, account, upload, or state change. | Only the artifacts and data approved for that exact route and action. | Separate explicit approval naming route, data, artifact policy, and stop conditions. |
| Post-fix regression audit | Previous findings have fixes to retest. | Prior report, finding IDs, changed files, approved route/profile summaries, relevant checks. | Must cite previous finding IDs and allowed retest checks. |

## Evidence Model

| Evidence Type | Use | Constraint |
|---|---|---|
| Source files | Static repository audit, implementation evidence, metadata and content checks. | Read only approved files; no product-code edits during audit. |
| Public page observations | Read-only public no-auth audit. | Approved routes only; no arbitrary URLs or broad crawling. |
| Sanitized browser summaries | Browser/e2e handoff and model-readable page evidence. | Must pass the summary contract and forbidden-pattern scan before model analysis. |
| Console/network summaries | Technical frontend health, failed public requests, mixed content, blocked assets. | High-level redacted summaries only; no raw request/response bodies, headers, cookies, or tokens. |
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

No audit may broaden route/profile scope during execution. No audit may collect raw cookies, storage, auth headers, raw HAR, raw request bodies, raw response bodies, private URLs, server IPs, screenshots, videos, or traces unless the scope explicitly approves that artifact policy.

The browser/e2e evidence producer is optional. If it is not available or approved, the audit uses static evidence and supplied sanitized summaries, and reports browser-only questions as unknowns.

## Safety Stop Conditions

Stop and report when any condition appears:

- secret, credential, token, cookie, auth header, or session material exposure;
- real personal, client, payment, billing, medical, legal-case, or private user data;
- unapproved submit, auth, payment, admin, account, upload, logout, destructive, settings-change, or contact-message action required;
- private URL, private endpoint, account boundary, or credentialed environment outside approval;
- server, deploy, database, secrets, SSH, SCP, process-management, or production config action needed;
- evidence source outside the approved artifact policy;
- broad crawling, scraping, rate-heavy checks, or anti-abuse boundary risk;
- validation failure whose fix is outside the current scope;
- ambiguous scope with material risk of semantic or safety drift.

Stop reports must be minimal and sanitized. Do not quote secret values or private data.

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

`configs/site-audit-default-scope.json` defines universal defaults for audit modes, allowed read-only actions, forbidden actions, audit dimensions, viewports, stop conditions, artifact policy, and report sections. Use it as the starting policy, then narrow it with a product-specific scope.

`configs/site-audit-severity-taxonomy.json` defines severity levels, evidence requirements, escalation factors, and allowed categories. Use it to validate report findings and align fix prompt priority.

## Open Decisions And Future Extensions

- Whether product repositories may override severity labels while preserving the same impact logic.
- Whether a lightweight report validator should enforce required sections and finding fields.
- Whether approved screenshot artifacts need a separate visual-evidence policy.
- Whether additional default viewport sets are needed for product categories with unusual device usage.
- Whether browser/e2e route and profile configs should gain a generic shared schema for all product repositories.
