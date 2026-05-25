# Prompt 10 — Aggregator Risk Board

## CONTEXT
Project: Vibe Coding workspace infrastructure
Repository: t9242540001/vibecoding-workspace
Series: prompts/queue/batch-2026-05-25-site-audit-v3-multi-agent/00-series-context.md
Series Charter: knowledge/series-charters/2026-05-25-site-audit-v3-multi-agent.md
Architecture contract: docs/site-audit/v3-architecture-contract.md
Outcome statuses: configs/site-audit-v3-outcome-statuses.json
Evidence registry: configs/site-audit-v3-evidence-registry.json
Agent registry: configs/site-audit-v3-agent-registry.json
Agent packs:
- skills/site-audit-v3-core-agents/SKILL.md
- skills/site-audit-v3-human-product-agents/SKILL.md
- skills/site-audit-v3-risk-agents/SKILL.md
- skills/site-audit-v3-growth-ai-agents/SKILL.md
Affected files:
- skills/site-audit-v3-aggregator-risk-board/SKILL.md
- templates/site-audit/v3-agent-handoff-template.md
- templates/site-audit/v3-final-report-template.md

Current state:
The V3 pipeline has architecture, statuses, evidence classes, agent registry, and agent packs. It now needs a Report Aggregator / Risk Board skill and shared templates for agent handoff and final reporting. This is where independent findings become a single decision-maker report and fix-batch queue.

Relevant series invariants:
- Aggregator must not accept unsupported findings as facts.
- Aggregator must not lose minority findings.
- Aggregator must deduplicate without hiding distinct impacts.
- Outcome status must match preflight result and actual evidence, not report ambition.
- Final output must produce prioritized fix-batches.

## TASK
Create the Site Audit V3 aggregator/risk-board skill and two report templates.

Create `skills/site-audit-v3-aggregator-risk-board/SKILL.md` for agent 18: Report Aggregator / Risk Board.

The skill must define:
- mission;
- required inputs from all previous agents;
- evidence acceptance rules;
- unsupported finding rejection rules;
- duplicate detection rules;
- cross-agent conflict resolution;
- priority model;
- outcome status enforcement;
- fix-batch generation rules;
- self-check;
- handoff to Obsidian output and post-fix regression.

Create `templates/site-audit/v3-agent-handoff-template.md` with a reusable handoff format for every agent:
- agent id and title;
- audit scope slice;
- unavailable inputs/layers;
- findings table;
- evidence table;
- assumptions and limitations;
- self-check result;
- handoff summary for aggregator.

Create `templates/site-audit/v3-final-report-template.md` with final report sections:
- Russian executive summary;
- audit status and completeness;
- scope and unavailable layers;
- top risks;
- full findings table;
- evidence registry summary;
- cross-agent conflicts and decisions;
- prioritized fix-batch queue;
- Obsidian output map;
- English technical appendix;
- post-fix regression plan.

Update the Series Charter step status for Prompt 10 if the charter exists.

## REGRESSION SHIELD — DO NOT TOUCH
Files not to modify:
- skills/site-audit/SKILL.md
- skills/site-audit-v3-core-agents/SKILL.md
- skills/site-audit-v3-human-product-agents/SKILL.md
- skills/site-audit-v3-risk-agents/SKILL.md
- skills/site-audit-v3-growth-ai-agents/SKILL.md
- configs/site-audit-v3-agent-registry.json
- configs/site-audit-v3-evidence-registry.json
- configs/site-audit-v3-outcome-statuses.json
- docs/site-audit/v3-architecture-contract.md
- existing templates/site-audit/report-template.md
- README.md
- workspace-index.md

Functions/components not to modify:
- Not applicable; this is a skill/template prompt.

Within modified file(s): create only the aggregator skill and the two V3 templates, plus the relevant Series Charter status update if available. Do not modify existing V2 report templates in this prompt.

Critical rules for this project:
- Final audit status must be derived from evidence and preflight, not from intent.
- Unsupported claims are downgraded or rejected, not silently accepted.
- Sensitive material must never be reproduced in reports.
- Existing V2 files remain unchanged unless explicitly scoped.

## ACCEPTANCE CRITERIA
[ ] `skills/site-audit-v3-aggregator-risk-board/SKILL.md` exists.
[ ] The aggregator skill includes evidence acceptance, unsupported finding rejection, deduplication, conflict resolution, priority model, status enforcement, fix-batch rules, self-check, and handoff.
[ ] `templates/site-audit/v3-agent-handoff-template.md` exists.
[ ] Agent handoff template includes all required sections.
[ ] `templates/site-audit/v3-final-report-template.md` exists.
[ ] Final report template includes all required sections.
[ ] The final report template makes audit completeness status prominent.
[ ] The fix-batch queue connects finding -> impact -> recommended prompt/fix batch.
[ ] The Series Charter status for Prompt 10 is updated if the charter exists.
[ ] Existing V2 templates, skills, docs, and configs are not edited.

Code Agent must report against each criterion after completion.
