# Prompt 02 — V3 Architecture Contract

## CONTEXT
Project: Vibe Coding workspace infrastructure
Repository: t9242540001/vibecoding-workspace
Series: prompts/queue/batch-2026-05-25-site-audit-v3-multi-agent/00-series-context.md
Series Charter: knowledge/series-charters/2026-05-25-site-audit-v3-multi-agent.md
Affected files:
- docs/site-audit/v3-architecture-contract.md

Current state:
The workspace has V2 site-audit documents, templates, configs, and a universal `site-audit` skill. Prompt 01 creates the Series Charter. The next step must define the V3 architecture contract before outcome statuses, evidence registry, agent registry, skills, templates, and validation gates are created.

Relevant series invariants:
- V3 is additive/connecting first; do not delete or rename V2 files.
- No false full-audit status is allowed.
- V3 artifacts must be universal and product-neutral.
- Findings must separate fact, evidence, risk, opinion, impact, recommendation, confidence, and status.
- Agent roles must be future-tunable without rewriting the whole pipeline.

## TASK
Create `docs/site-audit/v3-architecture-contract.md` as the controlling architecture document for Site Audit V3.

The document must define the pipeline in this exact logical order:

1. Scope & Orchestration
2. Preflight Gate
3. Discovery
4. Independent Expert Passes
5. Risk Board
6. Report Aggregator
7. Fix-Batch Queue
8. Obsidian Project Output
9. Post-fix Regression Audit

For each stage, define:

- purpose;
- inputs;
- outputs;
- allowed decisions;
- forbidden decisions;
- handoff to the next stage.

The architecture must state that V3 does not replace V2 files immediately. It wraps and upgrades the existing V2 audit assets through a stricter, multi-agent, evidence-based pipeline.

The document must define the core contracts that later prompts will implement:

- audit outcome status contract;
- evidence registry contract;
- agent registry contract;
- agent output/handoff contract;
- aggregator/risk-board contract;
- Obsidian output contract;
- validation-gate contract.

The document must explicitly explain why static fallback is allowed only as a downgraded audit outcome and never as `full live/browser audit completed`.

After creating the architecture document, update the Series Charter step status for Prompt 02 if the charter exists. If the charter is not present, state that in the completion report and do not invent its status.

## REGRESSION SHIELD — DO NOT TOUCH
Files not to modify:
- skills/site-audit/SKILL.md
- docs/site-audit/agentic-audit-pipeline.md
- docs/site-audit/validation-gates.md
- docs/site-audit/system-consistency-review.md
- templates/site-audit/*
- configs/site-audit-*.json
- README.md
- workspace-index.md

Functions/components not to modify:
- Not applicable; this is a documentation prompt.

Within modified file(s): create only the V3 architecture contract and update only the relevant Series Charter status if available. Do not rewrite existing V2 documents, do not merge V2 and V3 into one file, do not change existing safety policy, and do not introduce product-specific YurAssistent requirements.

Critical rules for this project:
- Shared methodology belongs in this workspace; product-specific audit data belongs in product repositories and Obsidian outputs.
- No existing site-audit safety boundary may be weakened.
- No secrets, credentials, `.env` values, tokens, cookies, raw HAR, raw request bodies, or personal data may be committed.
- Existing skills, standards, templates, and knowledge files are edited only inside explicitly approved scope.

## ACCEPTANCE CRITERIA
[ ] `docs/site-audit/v3-architecture-contract.md` exists.
[ ] The document defines all nine pipeline stages in the required order.
[ ] Each stage includes purpose, inputs, outputs, allowed decisions, forbidden decisions, and handoff.
[ ] The document states that V3 wraps/upgrades existing V2 assets instead of deleting them.
[ ] The document defines all required V3 contracts.
[ ] The document explicitly forbids static fallback from being labelled as full live/browser audit.
[ ] The Series Charter status for Prompt 02 is updated if the charter exists.
[ ] No existing V2 site-audit documents, templates, configs, or skills are changed.
[ ] No product-specific YurAssistent logic is added.
[ ] No secrets, credentials, personal data, or private artifacts are added.

Code Agent must report against each criterion after completion.
