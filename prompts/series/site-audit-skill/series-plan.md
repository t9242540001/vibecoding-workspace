# Site Audit Skill Series Plan

<!--
  @file:        prompts/series/site-audit-skill/series-plan.md
  @description: Multi-batch plan for creating the universal site-audit skill and reusable audit system
  @updated:     2026-05-22
-->

## Goal

Create a universal, reusable `site-audit` skill and supporting audit system for web projects in the Vibe Coding workspace.

This is not YurAssistent-specific. YurAssistent will only be used later as the first real application target after the universal system is created.

## Complexity

T3 — strategic, multi-prompt, long-term reusable methodology.

## Source Basis

The series must synthesize current best practices from:

- WCAG 2.2 Quick Reference for accessibility principles, criteria, forms, focus, reflow, labels, input assistance, and robustness.
- Nielsen Norman Group 10 usability heuristics for UX/usability review.
- Google Lighthouse documentation for automated performance/accessibility/SEO quality signals.
- Google Search Central SEO Starter Guide, Helpful Content, structured data guidelines, and generative AI optimization guidance.
- Schema.org documentation for structured semantic markup.
- Existing Vibe Coding skills and standards:
  - `prompt-writing-standard`
  - `research-protocol`
  - `skill-writing-standard`
  - `series-design-discipline`
  - `knowledge-structure`
  - `code-markup-standard`
  - `universality-discipline`
  - `anti-hedging-language`
  - `real-path-verification`
  - `forward-thinking-discipline`

## Series Charter

### Batch 01 — Research + Series Charter

Create the research basis and internal series charter.

Expected outputs:

- `docs/site-audit/research-basis.md`
- `docs/site-audit/series-charter.md`

No skill file yet.

### Batch 02 — Skill + Templates

Create the universal `site-audit` skill and reusable templates.

Expected outputs:

- `skills/site-audit/SKILL.md`
- `templates/site-audit/report-template.md`
- `templates/site-audit/audit-scope-template.md`
- `templates/site-audit/finding-taxonomy.md`
- `templates/site-audit/codex-live-audit-prompt-template.md`
- updated `workspace-index.md`

### Batch 03 — Agentic Audit Handoff Design

Create the reusable agentic execution design for live audits.

Expected outputs:

- `docs/site-audit/agentic-audit-pipeline.md`
- `configs/site-audit-default-scope.json`
- `configs/site-audit-severity-taxonomy.json`
- optional non-destructive scripts only if justified and safe

### Batch 04 — Validation Against Existing Browser/E2E Infrastructure

Cross-check `site-audit` against existing browser handoff docs/configs and remove contradictions.

Expected outputs:

- `docs/site-audit/integration-with-browser-e2e.md`
- updates to `docs/browser-automation-handoff-contract.md` only if strictly required
- updates to relevant indexes only if strictly required

### Batch 05 — Pilot Prompt Preparation

Prepare, but do not execute, the first safe public no-auth product audit prompt package using the universal skill.

Expected outputs:

- `prompts/series/site-audit-skill/README.md`
- `prompts/series/site-audit-skill/pilot-public-site-audit-prompt.md`
- `prompts/series/site-audit-skill/pilot-scope-example.md`
- no product code changes

### Batch 06 — System Consistency Review

Review the completed site-audit system before the first real product pilot.

Expected outputs:

- `docs/site-audit/system-consistency-review.md`
- small in-scope documentation fixes only when needed to resolve concrete contradictions
- no real audit, browser automation, product repository changes, deploy, server, or secrets actions

## Invariants

- Universal first. No YurAssistent-specific assumptions inside the skill.
- No destructive actions.
- No secrets, `.env`, credentials, production access, deploy, server, database, nginx, PM2, or payment actions.
- Live audits are read-only unless explicitly approved.
- Form submit, auth, payments, admin, and production-changing actions require separate approval.
- Every output must be repeatable across different web projects.
