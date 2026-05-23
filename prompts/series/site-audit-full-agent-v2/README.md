# Site Audit Full Agent V2 Series
<!--
  @file:        prompts/series/site-audit-full-agent-v2/README.md
  @description: Orchestrator note for running the full-agent v2 site-audit batch series
  @updated:     2026-05-24
  @version:     1.0
-->

## Goal

This series upgrades the universal `site-audit` system into a full website audit agent protocol.

The target system can prepare and run scoped audits across static repository review, live HTTP checks, browser visual evidence, interactive user flows, auth/account paths, payment paths, admin/access boundaries, API/server-route/SSE checks, marketing/sales effectiveness, target-audience usefulness, SEO/AEO/GEO, AI/agentic-commerce readiness, sensitive-data exposure, and post-fix regression.

The hard boundary is unchanged: audit execution observes and reports. Product modification, deploy/server/database/secrets actions, real payments, destructive admin actions, irreversible account changes, and sensitive-data disclosure require separate explicit approval or are forbidden.

## Batch Sequence

| Batch | Purpose | Main outputs |
|---|---|---|
| 01 | Research basis and v2 charter | `docs/site-audit/full-agent-v2-research-basis.md`, `docs/site-audit/full-agent-v2-charter.md` |
| 02 | Skill safety model and audit modes | `skills/site-audit/SKILL.md`, `docs/site-audit/agentic-audit-pipeline.md`, `configs/site-audit-default-scope.json` |
| 03 | Browser, interactive, auth, payment, admin evidence contract | `docs/site-audit/live-browser-interactive-audit-contract.md`, full audit scope and test-data/access templates |
| 04 | Marketing, target-audience, AI, and agentic-commerce readiness | Marketing/AI standard, checklist, taxonomy, severity config |
| 05 | Report, validation, and prompt package | Report template, live audit prompt template, pilot prompt, validation gates, sanitized example |
| 06 | Consistency review and orchestrator | `docs/site-audit/full-agent-v2-consistency-review.md`, this README |

## How To Run With `vcw`

Run from the shared workspace on the intended branch.

```powershell
vcw pull
vcw batch batch-2026-05-22-site-audit-full-agent-v2-01-research-charter
vcw batch batch-2026-05-22-site-audit-full-agent-v2-02-skill-modes
vcw batch batch-2026-05-22-site-audit-full-agent-v2-03-interactive-contract
vcw batch batch-2026-05-22-site-audit-full-agent-v2-04-marketing-ai-agentic
vcw batch batch-2026-05-22-site-audit-full-agent-v2-05-report-validation
vcw batch batch-2026-05-22-site-audit-full-agent-v2-06-consistency
vcw status
```

Do not use Claude Routines for this Codex batch series unless a future prompt explicitly changes the executor model.

## Final Expected Outcome

After Batch 06, the reusable system should have:

- full audit capability layers documented in the skill, pipeline, contracts, templates, configs, and prompts;
- no-product-modification and no-sensitive-data-disclosure rules preserved;
- browser, interactive, auth, payment, admin, API/server-route/SSE, artifact, and stop-condition contracts;
- marketing/sales, target-audience usefulness, SEO/AEO/GEO, and AI/agentic-commerce readiness as first-class dimensions;
- bilingual Markdown report requirements with Russian decision-maker sections and an English technical section;
- validation gates and taxonomy aligned with the report and prompt package;
- a consistency review marking the system ready or not ready for a product pilot.

## Next Product-Pilot Batch Recommendation

Recommended next batch id:

`batch-2026-05-24-site-audit-full-agent-v2-product-pilot-01`

The pilot should audit one product with an explicit scope, approved routes, report path, artifact policy, and any required test accounts or sandbox boundaries. It should produce a product-specific audit report only. Product fixes, deploy/server/database/secrets actions, and production-changing actions stay out of scope unless separately approved.
