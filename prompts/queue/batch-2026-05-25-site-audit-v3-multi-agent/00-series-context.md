# Site Audit V3 Multi-Agent Series Context

@file: prompts/queue/batch-2026-05-25-site-audit-v3-multi-agent/00-series-context.md
@description: Shared context for all prompts in the Site Audit V3 Multi-Agent implementation batch
@updated: 2026-05-25

## Series goal

Implement Site Audit V3 as a reusable multi-agent website audit pipeline inside `vibecoding-workspace`.

The system must turn the existing site-audit V2/focused audit materials into a coherent V3 architecture with explicit preflight gating, role-specific expert passes, evidence registry, outcome statuses, validation gates, report aggregation, and Obsidian project output rules.

## Repository

Repository: `t9242540001/vibecoding-workspace`
Default branch: `main`

## Source materials

The Code Agent must use current repository files as source of truth, especially:

- `README.md`
- `workspace-index.md`
- `AGENTS.md`
- `.codex/instructions.md`
- `skills/prompt-writing-standard/SKILL.md`
- `skills/series-design-discipline/SKILL.md`
- `skills/site-audit/SKILL.md`
- `skills/knowledge-structure/SKILL.md`
- `skills/skill-writing-standard/SKILL.md`
- `docs/site-audit/*`
- `templates/site-audit/*`
- `configs/site-audit-*`

If any listed file does not exist, record that fact in the batch result and use the closest existing equivalent. Do not invent that the file was read.

## Research basis

The planning chat provided a research draft named `site_audit_v3_multi_agent_architecture.docx`. The implementation must preserve its core decisions:

- A full site audit is not one large agent pass.
- Correct pipeline: scope/orchestration -> preflight gate -> discovery -> independent expert passes -> risk board -> report aggregator -> fix-batch queue.
- If live/browser evidence is unavailable, the report must not be labelled as full live/browser audit.
- Outcome statuses must distinguish blocked, partial, and full audits.
- Each expert pass needs role logic, self-directed questions, evidence policy, boundaries, self-check, and handoff.
- Findings must separate observed facts, evidence, inferred risk, impact, recommendation, confidence, and status.
- The system must be reusable across product repositories and must not contain YurAssistent-specific logic except in the final pilot prompt template.

## Series invariants

These invariants apply to every prompt in this batch:

1. Do not weaken existing `site-audit` safety boundaries.
2. Do not rename or delete existing V2 files unless a prompt explicitly says so. V3 is additive/connecting first.
3. No false full-audit status: missing browser/live/flow evidence must downgrade the outcome.
4. Every new V3 artifact must be universal and product-neutral unless its filename explicitly says `yurassistent`.
5. Every finding/report format must preserve fact vs risk vs opinion separation.
6. Every agent profile must be future-tunable without rewriting the whole pipeline.
7. Obsidian output rules must respect the existing local vault and must not recreate or reorganize it.
8. No secrets, credentials, personal data, cookies, raw HAR, raw request bodies, or production-changing actions in audit artifacts.
9. Documentation and skills must follow existing repository markup style and keep files focused.
10. Each prompt must update the series charter status or explicitly state why the charter is not available yet.

## Desired final state

After all prompts pass, the workspace contains:

- Site Audit V3 series charter.
- V3 architecture document.
- V3 outcome status registry.
- V3 evidence registry.
- V3 agent registry.
- V3 orchestrator/preflight/discovery/core/human/product/risk/growth/aggregator skills or skill packs.
- V3 output templates for agent handoff and final aggregation.
- V3 Obsidian project output contract.
- V3 validation gates.
- A product pilot prompt template for running YurAssistent through V3 after the infrastructure is ready.

## Non-goals

- Do not run a real audit in this workspace batch.
- Do not modify the YurAssistent product repository.
- Do not install dependencies.
- Do not deploy anything.
- Do not access production servers.
- Do not collect live browser artifacts.
- Do not rewrite existing standards globally.

## Batch execution note

This batch is intentionally documentation/skill/template heavy. It prepares the reusable system. Running the actual product audit is a separate follow-up batch in the product repository after this batch is merged and reviewed.
