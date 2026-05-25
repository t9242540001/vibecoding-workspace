# Prompt 13 — YurAssistent Pilot Prompt

## CONTEXT
Project: Vibe Coding workspace infrastructure
Repository: t9242540001/vibecoding-workspace
Series: prompts/queue/batch-2026-05-25-site-audit-v3-multi-agent/00-series-context.md
Series Charter: knowledge/series-charters/2026-05-25-site-audit-v3-multi-agent.md
V3 architecture: docs/site-audit/v3-architecture-contract.md
Outcome statuses: configs/site-audit-v3-outcome-statuses.json
Evidence registry: configs/site-audit-v3-evidence-registry.json
Agent registry: configs/site-audit-v3-agent-registry.json
Agent packs: skills/site-audit-v3-*/SKILL.md
Aggregator/report templates: templates/site-audit/v3-agent-handoff-template.md and templates/site-audit/v3-final-report-template.md
Obsidian output contract: docs/site-audit/v3-obsidian-output-contract.md
Validation gates: docs/site-audit/v3-validation-gates.md
Affected files:
- prompts/series/site-audit-v3/yurassistent-v3-pilot-prompt.md

Current state:
The V3 infrastructure prompts create the reusable multi-agent audit pipeline. After the infrastructure exists, the next practical use case is a new YurAssistent audit. This prompt must prepare a product-pilot prompt template only. It must not run the audit and must not modify the YurAssistent product repository.

Relevant series invariants:
- Product-specific logic is allowed only because this file is explicitly a YurAssistent pilot prompt.
- The pilot must respect V3 preflight and outcome status rules.
- The pilot must not claim full live/browser completion without browser/live/flow evidence.
- The pilot must write results to project-specific report/Obsidian output paths, not universal workspace docs.
- No real payments, real user data, production-changing actions, or sensitive artifacts are allowed.

## TASK
Create `prompts/series/site-audit-v3/yurassistent-v3-pilot-prompt.md` as a ready-to-adapt Code Agent prompt for running a YurAssistent Site Audit V3 product pilot after this infrastructure batch is complete.

The pilot prompt must be written in English and follow the four-block prompt structure:

1. CONTEXT
2. TASK
3. REGRESSION SHIELD — DO NOT TOUCH
4. ACCEPTANCE CRITERIA

The pilot prompt must instruct the Code Agent to:
- work in the `t9242540001/yurassistent` product repository, not in `vibecoding-workspace`;
- read the product repository's main context file, knowledge index, relevant knowledge files, and previous audit report if present;
- use Site Audit V3 workspace artifacts as methodology references;
- run preflight first;
- set audit outcome status according to V3 status registry;
- perform only layers that pass preflight and have approved prerequisites;
- generate agent handoffs using the V3 handoff template;
- aggregate findings using the V3 final report template;
- write the final product report to a product-repository report path under `reports/site-audit/`;
- prepare Obsidian output handoff according to the V3 Obsidian contract;
- stop before real payments, real user data, destructive admin actions, or production-changing changes.

The pilot prompt must include explicit placeholders for:
- live URL;
- approved routes;
- approved browser profiles/viewports;
- test accounts availability;
- sandbox payment or stop-before-charge status;
- allowed artifacts;
- report path;
- Obsidian project output path.

The pilot prompt must state that if DNS/browser/tooling/test accounts/sandbox prerequisites are missing, the result must be `blocked_at_preflight` or a partial status, never full live/browser audit.

Update the Series Charter step status for Prompt 13 if the charter exists.

## REGRESSION SHIELD — DO NOT TOUCH
Files not to modify:
- t9242540001/yurassistent repository files
- any product repository files
- skills/site-audit/SKILL.md
- skills/site-audit-v3-*/*
- docs/site-audit/*
- templates/site-audit/* except the new pilot prompt path listed above
- README.md
- workspace-index.md

Functions/components not to modify:
- Not applicable; this is a prompt-template creation task.

Within modified file(s): create only the YurAssistent V3 pilot prompt template and update only the relevant Series Charter status if available. Do not run the audit, do not edit the YurAssistent repository, and do not create a real audit report in this prompt.

Critical rules for this project:
- Product repository changes are out of scope for this workspace batch.
- Full live/browser status requires successful preflight and matching evidence.
- No secrets, credentials, `.env` values, cookies, raw HAR, raw request bodies, raw response bodies, personal data, or payment data may be included.
- Real payments, real user data, destructive admin actions, and production-changing actions are forbidden.

## ACCEPTANCE CRITERIA
[ ] `prompts/series/site-audit-v3/yurassistent-v3-pilot-prompt.md` exists.
[ ] The pilot prompt uses the four-block prompt structure.
[ ] The pilot prompt targets `t9242540001/yurassistent`, not `vibecoding-workspace`.
[ ] The pilot prompt requires preflight before any audit layer.
[ ] The pilot prompt uses V3 outcome statuses and forbids false full live/browser status.
[ ] The pilot prompt includes placeholders for URL, routes, viewports, test accounts, payment boundary, artifacts, report path, and Obsidian output path.
[ ] The pilot prompt requires agent handoffs and final aggregation using V3 templates.
[ ] The pilot prompt writes only a product report/handoff when later executed, not in this workspace batch.
[ ] The Series Charter status for Prompt 13 is updated if the charter exists.
[ ] No YurAssistent repository files are modified.

Code Agent must report against each criterion after completion.
