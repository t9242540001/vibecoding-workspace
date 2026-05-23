# Site Audit Full Agent V2 Charter

<!--
  @file:        docs/site-audit/full-agent-v2-charter.md
  @description: Multi-batch charter for upgrading site-audit into a full universal website audit agent
  @updated:     2026-05-23
  @version:     1.0
-->

## Goal

Upgrade `site-audit` into a full universal website audit agent protocol for Vibe Coding product repositories.

The upgraded system must support static, live, browser, visual, interactive, auth/account, payment, admin/access-boundary, API/server-route/SSE, marketing/sales, target-audience usefulness, SEO/AEO/GEO, AI/agentic-commerce readiness, sensitive-data exposure, and post-fix regression audits.

The output of the series is reusable methodology, skill behavior, contracts, templates, validation gates, examples, and prompt package updates. It is not a one-off audit of YurAssistent.

## T3 Classification

This series is T3 because it changes a long-lived cross-project skill and supporting audit system, spans 3+ dependent batches, affects security/privacy and payment/auth/admin boundaries, and sets the methodology future product repositories will use for website audits.

## Safety Model

The v2 safety model is capability-positive and modification-negative:

- Allowed to audit: the agent may collect evidence through approved static, live, browser, interactive, auth, payment, admin, API, marketing, SEO/AEO/GEO, AI-readiness, and regression layers when scope and test conditions allow.
- Forbidden to modify product during audit: the audit must not change product code, product content, application data, production settings, infrastructure, deployment, secrets, accounts, payments, database state, or server configuration.
- Forbidden to disclose sensitive data: reports must not include personal data, credentials, passwords, API keys, tokens, cookies, auth headers, raw private data, raw sensitive artifacts, payment data, or private client data.
- Sensitive findings are reported anonymized: name the exposure class, safe location, impact, and remediation path without reproducing the sensitive value.

Fixes are separate. The audit report may recommend fix prompts or next batches, but code/config/data changes require separate explicit scope and verification.

## Audit Capability Layers

| Layer | Capability | Boundary |
|---|---|---|
| Static repository audit | Inspect approved source, metadata, routes, content, tests, docs, and public config. | No product-code edits during audit. |
| Live HTTP audit | Check public status, redirects, headers, assets, route availability, robots/sitemap, and public links. | No broad crawling, rate-heavy checks, private URLs, or server config changes. |
| Browser visual audit | Inspect rendered pages, viewports, layout, console/network summaries, visual states, media, and screenshots when approved. | No raw session artifacts or sensitive screenshots by default. |
| Interactive user-flow audit | Exercise approved flows with synthetic data, including form states and reversible submissions. | Stop before unapproved state change, real data use, or sensitive exposure. |
| Auth/account audit | Test login, registration, profile, recovery, role, and account states with approved test accounts. | No credential disclosure, real account mutation, or private data reporting. |
| Payment path audit | Test pricing, checkout, payment states, errors, receipts, and cancellation in sandbox/test mode or stop-before-charge mode. | No real charge, refund, saved payment mutation, or billing change without separate approval. |
| Admin/access-boundary audit | Check permissions, blocked states, role boundaries, and sensitive UI/API exposure non-destructively. | No create/delete/export/refund/settings mutation in production. |
| API/server-route/SSE audit | Verify route connectivity, safe response shape summaries, stream behavior, errors, timeouts, and client integration evidence. | No env, deployment, server, or secrets changes. |
| Marketing/sales/target-audience usefulness audit | Evaluate value proposition, audience fit, offer clarity, objections, trust, CTA path, and usefulness of information/tools. | Findings must be evidence-based and route/section-specific. |
| SEO/AEO/GEO audit | Evaluate crawlability, metadata, structured data, answerability, entity clarity, and people-first content. | No manipulative ranking or AI-search tactics. |
| AI/agentic-commerce readiness audit | Evaluate assistant recommendation accuracy, service/action clarity, stable deep links, structured offers, pricing, limitations, and agentic selection/shopping readiness. | Emerging-practice findings must be labeled and not overstated as platform requirements. |
| Security/privacy/sensitive-data exposure audit | Detect exposed secrets, PII, private endpoints, unsafe errors, and artifact leakage. | Stop and anonymize when sensitive data appears. |
| Post-fix regression audit | Retest finding IDs after approved fixes. | Do not broaden scope or artifact policy during retest. |

## Batch Sequence And Dependencies

The sequence matches `prompts/series/site-audit-full-agent-v2/series-plan.md`.

### Batch 01 - Research Basis And V2 Charter

Status: this batch.

Creates:

- `docs/site-audit/full-agent-v2-research-basis.md`
- `docs/site-audit/full-agent-v2-charter.md`

Purpose:

- record the clarified full-audit target model;
- distinguish audit action from product modification;
- define source categories, safety model, invariants, dependencies, and report requirements.

Does not update the operational skill, templates, configs, browser automation, or product repositories.

### Batch 02 - Skill Safety Model And Audit Modes V2

Depends on Batch 01.

Updates:

- `skills/site-audit/SKILL.md`
- `docs/site-audit/agentic-audit-pipeline.md`
- `configs/site-audit-default-scope.json`

Purpose:

- replace the read-only-first mindset with the full audit capability model;
- add v2 audit modes and safety boundaries;
- preserve no product modification and no sensitive-data disclosure rules.

### Batch 03 - Browser, Interactive, Auth, Payment, Admin Evidence Contract

Depends on Batches 01-02.

Creates or updates:

- `docs/site-audit/live-browser-interactive-audit-contract.md`
- `templates/site-audit/full-audit-scope-template.md`
- `templates/site-audit/test-data-and-access-template.md`

Purpose:

- define safe evidence collection for browser, interactive, auth, payment, admin, screenshots, console, network, flow recording, test data, and test credentials;
- make missing accounts or sandbox mode a report limitation rather than a methodology block.

### Batch 04 - Marketing, Sales, Target Audience, AI And Agentic Commerce Readiness

Depends on Batches 01-03.

Creates or updates:

- `docs/site-audit/marketing-ai-agentic-readiness-standard.md`
- `templates/site-audit/marketing-ai-agentic-checklist.md`
- `templates/site-audit/finding-taxonomy.md`
- `configs/site-audit-severity-taxonomy.json`

Purpose:

- make target-audience usefulness, offer clarity, sales path, objection handling, trust, AI-friendliness, machine readability, service/action clarity, and agentic-commerce readiness first-class audit dimensions.

### Batch 05 - Report, Validation, Prompt Package V2

Depends on Batches 01-04.

Updates:

- `templates/site-audit/report-template.md`
- `templates/site-audit/codex-live-audit-prompt-template.md`
- `prompts/series/site-audit-skill/pilot-public-site-audit-prompt.md`
- `docs/site-audit/validation-gates.md`
- `examples/site-audit/sanitized-audit-report-example.md`

Purpose:

- require a full bilingual Markdown report;
- require all findings, Russian decision-maker sections, English technical section, evidence, limitations, stop conditions, and next batches;
- validate full-audit layers and marketing/sales/AI-agentic sections.

### Batch 06 - Consistency Review And Orchestrator

Depends on Batches 01-05.

Creates or updates:

- `docs/site-audit/full-agent-v2-consistency-review.md`
- `prompts/series/site-audit-full-agent-v2/README.md`

Purpose:

- verify consistency across skill, docs, templates, configs, validation gates, examples, and prompts;
- mark readiness for a full product pilot;
- recommend the next product pilot batch.

## Dependencies

| Batch | Depends On | Produces For Later Batches |
|---|---|---|
| 01 | Existing standards, skills, browser/E2E docs, and series plan. | Research basis and charter for every later v2 batch. |
| 02 | Batch 01. | Operational skill modes, pipeline rules, and default scope policy. |
| 03 | Batches 01-02. | Evidence contract and scope/test-data templates for full audit runs. |
| 04 | Batches 01-03. | Marketing, target-audience, AI, and agentic-commerce standards and taxonomy updates. |
| 05 | Batches 01-04. | Report template, validation gates, prompt package, and synthetic example alignment. |
| 06 | Batches 01-05. | Final consistency review, orchestrator notes, and pilot readiness decision. |

## Invariants

- Universal first: do not encode YurAssistent-specific methodology.
- YurAssistent is only a possible product pilot target, not a universal methodology source.
- Audit capabilities are not blocked by default; missing credentials, test accounts, sandbox mode, or browser tooling are limitations to report.
- Product changes are forbidden during audit.
- Sensitive data is never disclosed in reports.
- Sensitive findings are anonymized and reported by class, safe location, impact, and remediation path.
- Real payments, destructive admin actions, irreversible account changes, and production data mutation require sandbox/test mode or separately approved reversible scenario definition.
- Interactive tests use synthetic data and approved test accounts.
- Browser and live evidence must be actual approved evidence, not fabricated or inferred.
- Findings separate observed facts, inferred risks, and unknowns.
- Reports are complete bilingual Markdown documents with Russian decision-maker sections and an English technical section.
- No Claude Routines are used for this series unless a future explicit approval changes execution mode.
- No deploy, server, database, secrets, SSH, SCP, production config, or dependency-install action is part of audit execution.

## Definition Of Done

The v2 series is complete when:

- `skills/site-audit/SKILL.md` describes a full universal audit agent, not a read-only-only reviewer;
- full audit modes are documented and approval-gated by risk;
- browser, visual, interactive, auth, payment, admin, API/server-route/SSE, and post-fix regression evidence contracts exist;
- marketing/sales/target-audience usefulness is a first-class audit dimension;
- SEO/AEO/GEO and AI/agentic-commerce readiness are first-class audit dimensions;
- sensitive-data handling requires anonymized reporting and forbids disclosure;
- report templates require a full bilingual Markdown report with all findings;
- validation gates check full-audit sections, evidence quality, limitations, stop conditions, and safety boundaries;
- examples remain synthetic or sanitized;
- a consistency review marks the system ready or not ready for a full product pilot;
- no product repository, deploy/server/secrets action, real audit, or browser automation was performed by this charter batch.
