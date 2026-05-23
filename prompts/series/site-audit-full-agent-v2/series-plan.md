# Site Audit Full Agent V2 Series Plan

<!--
  @file:        prompts/series/site-audit-full-agent-v2/series-plan.md
  @description: Multi-batch plan for upgrading site-audit into a full universal website audit agent
  @updated:     2026-05-22
  @version:     1.0
-->

## Goal

Upgrade the universal `site-audit` system from a read-only-first website audit protocol into a full universal website audit agent protocol.

The target agent must be able to audit different websites through live browsing, visual review, interactive user flows, forms, auth/account paths, payment paths, admin access boundaries, technical routes, marketing/sales effectiveness, target-audience usefulness, SEO/AEO/GEO, and AI/agentic-commerce readiness.

The hard prohibition is not on audit actions. The hard prohibition is:

- do not change product code, data, configuration, infrastructure, payments, accounts, or production state except where an audit scenario explicitly uses reversible test actions;
- do not disclose personal data, credentials, secrets, passwords, API keys, tokens, cookies, auth headers, raw private data, or sensitive artifacts in reports;
- if sensitive data is encountered, report it only in anonymized form.

## T3 Classification

This is T3 because it changes a reusable cross-project skill, audit methodology, templates, validation gates, evidence model, report standard, and product-pilot behavior.

## Batch Sequence

### Batch 01 — Research Basis And V2 Charter

Create:

- `docs/site-audit/full-agent-v2-research-basis.md`
- `docs/site-audit/full-agent-v2-charter.md`

Purpose:

- record the clarified target model;
- add research-backed best practices;
- define the series invariants and dependencies;
- separate audit execution from product modification.

### Batch 02 — Skill Safety Model And Audit Modes V2

Update:

- `skills/site-audit/SKILL.md`
- `docs/site-audit/agentic-audit-pipeline.md`
- `configs/site-audit-default-scope.json`

Purpose:

- replace read-only-first mindset with full-audit capability model;
- define audit modes for live, browser, interactive, auth, payment, admin, server/API route checks, marketing/sales, AI/agentic readiness;
- preserve no-code-change and no-sensitive-data-disclosure rules.

### Batch 03 — Browser, Interactive, Auth, Payment, Admin Evidence Contract

Create/update:

- `docs/site-audit/live-browser-interactive-audit-contract.md`
- `templates/site-audit/full-audit-scope-template.md`
- `templates/site-audit/test-data-and-credentials-template.md`

Purpose:

- define how to run full audits safely with test data/accounts;
- define screenshots, console, network, flow recording, stop conditions, and anonymization;
- make unavailable test credentials a report limitation, not a permanent capability block.

### Batch 04 — Marketing, Sales, Target Audience, AI And Agentic Commerce Readiness

Create/update:

- `docs/site-audit/marketing-ai-agentic-readiness-standard.md`
- `templates/site-audit/marketing-ai-agentic-checklist.md`
- `templates/site-audit/finding-taxonomy.md`
- `configs/site-audit-severity-taxonomy.json`

Purpose:

- add target-audience usefulness, content usefulness, offer clarity, sales path, objection handling, trust, AI-friendliness, machine readability, structured data, service/tool actionability, and agentic-commerce readiness.

### Batch 05 — Report, Validation, Prompt Package V2

Update:

- `templates/site-audit/report-template.md`
- `templates/site-audit/codex-live-audit-prompt-template.md`
- `prompts/series/site-audit-skill/pilot-public-site-audit-prompt.md`
- `docs/site-audit/validation-gates.md`
- `examples/site-audit/sanitized-audit-report-example.md`

Purpose:

- require full bilingual `.md` reports;
- require all findings, Russian decision-maker sections, English technical section;
- validate that full-audit modes were executed or explicitly marked blocked with reason;
- include marketing/sales/AI-agentic sections.

### Batch 06 — Consistency Review And Orchestrator

Create/update:

- `docs/site-audit/full-agent-v2-consistency-review.md`
- `prompts/series/site-audit-full-agent-v2/README.md`

Purpose:

- check consistency across skill, docs, templates, configs, validation gates, examples, and prompts;
- mark the system ready/not ready for a full product pilot;
- recommend the next product pilot batch.

## Invariants

- Universal first. Do not encode YurAssistent-specific methodology.
- Audit capabilities should not be blocked by default. Missing accounts, credentials, test payment mode, or browser tooling are limitations to report and solve, not reasons to remove the capability.
- Product changes are forbidden during audit.
- Sensitive data must not be disclosed in reports.
- Screenshots and artifacts may be used as evidence when they do not expose sensitive data; sensitive content must be redacted or summarized.
- Tests may use synthetic data and test accounts when available.
- Real payments, destructive admin actions, irreversible account changes, and production data mutations require safe test mode or explicit reversible scenario definition.
- Findings must separate observed facts, inferred risks, and unknowns.
- Reports must be complete bilingual `.md` documents.

## External Research Basis To Use

Use authoritative and current sources when writing Batch 01, including:

- Google Search Central structured data guidelines.
- Google Search Central helpful people-first content guidance.
- Schema.org documentation.
- Nielsen Norman Group usability/content guidance.
- Recent agentic commerce and AI-agent commerce sources, clearly labeled when they are industry/news/academic rather than platform standards.

## Series Definition Of Done

The series is complete when:

- `site-audit` skill describes a full universal audit agent, not a read-only-only reviewer;
- full audit modes are documented;
- marketing/sales/target-audience usefulness is a first-class audit dimension;
- AI/agentic-commerce readiness is a first-class audit dimension;
- browser/interactive/auth/payment/admin/server-route audit contracts exist;
- report templates and validation gates enforce bilingual complete reports;
- consistency review marks the system ready for a full product pilot.
