# Prompt 12 — Validation Gates

## CONTEXT
Project: Vibe Coding workspace infrastructure
Repository: t9242540001/vibecoding-workspace
Series: prompts/queue/batch-2026-05-25-site-audit-v3-multi-agent/00-series-context.md
Series Charter: knowledge/series-charters/2026-05-25-site-audit-v3-multi-agent.md
Architecture contract: docs/site-audit/v3-architecture-contract.md
Outcome statuses: configs/site-audit-v3-outcome-statuses.json
Evidence registry: configs/site-audit-v3-evidence-registry.json
Agent registry: configs/site-audit-v3-agent-registry.json
Aggregator skill: skills/site-audit-v3-aggregator-risk-board/SKILL.md
Obsidian output contract: docs/site-audit/v3-obsidian-output-contract.md
Affected files:
- docs/site-audit/v3-validation-gates.md
- templates/site-audit/v3-validation-checklist.md

Current state:
V3 has architecture, statuses, evidence classes, agent registry, agent packs, aggregator, report templates, and Obsidian output contract. It now needs validation gates that prevent incomplete or contradictory outputs from being accepted as ready.

Relevant series invariants:
- Unsupported findings must not become final facts.
- Missing live/browser/flow evidence must downgrade outcome status.
- Each agent must provide self-check and handoff.
- Final report must connect finding -> evidence -> impact -> fix-batch.
- Obsidian output must not store sensitive material.

## TASK
Create the Site Audit V3 validation gates document and reusable checklist template.

Create `docs/site-audit/v3-validation-gates.md` defining validation gates for:

1. Series/architecture readiness
2. Scope readiness
3. Preflight readiness
4. Discovery completeness
5. Agent handoff completeness
6. Evidence sufficiency
7. Outcome status correctness
8. Aggregator consistency
9. Report completeness
10. Obsidian output safety
11. Fix-batch queue quality
12. Post-fix regression readiness

For each gate define:
- purpose;
- required inputs;
- pass criteria;
- fail criteria;
- downgrade behavior;
- who consumes the gate result.

Create `templates/site-audit/v3-validation-checklist.md` as a checklist that a Code Agent or AI orchestrator can use before marking a V3 audit system or V3 audit report ready. The checklist must have explicit checkboxes and short pass/fail notes for each gate.

The validation system must explicitly reject these states:
- report says full live/browser audit but preflight/browser/live evidence is missing;
- finding has recommendation but no observed fact or evidence;
- legal/security/privacy finding quotes sensitive data;
- aggregator removes a minority finding without recording why;
- Obsidian output includes secrets, personal data, raw cookies, raw HAR, or raw request/response bodies.

Update the Series Charter step status for Prompt 12 if the charter exists.

## REGRESSION SHIELD — DO NOT TOUCH
Files not to modify:
- existing docs/site-audit/validation-gates.md
- skills/site-audit/SKILL.md
- skills/site-audit-v3-*/* except the Series Charter status if applicable
- configs/site-audit-v3-*.json
- templates/site-audit/v3-final-report-template.md
- templates/site-audit/v3-agent-handoff-template.md
- templates/site-audit/v3-obsidian-project-audit-template.md
- README.md
- workspace-index.md

Functions/components not to modify:
- Not applicable; this is a documentation/template prompt.

Within modified file(s): create only the V3 validation gates document and checklist template, plus the relevant Series Charter status update if available. Do not modify the existing V2 validation gates document in this prompt.

Critical rules for this project:
- No false full-audit status may pass validation.
- Sensitive material must never be accepted in final reports or Obsidian outputs.
- Existing V2 files remain unchanged unless explicitly scoped.
- No secrets, credentials, personal data, raw browser/session artifacts, or private data may be added.

## ACCEPTANCE CRITERIA
[ ] `docs/site-audit/v3-validation-gates.md` exists.
[ ] The document defines all twelve required gates.
[ ] Each gate includes purpose, required inputs, pass criteria, fail criteria, downgrade behavior, and consumer.
[ ] The document explicitly rejects false full live/browser status.
[ ] The document explicitly rejects findings without observed fact/evidence.
[ ] The document explicitly rejects sensitive data in legal/security/privacy reports and Obsidian outputs.
[ ] `templates/site-audit/v3-validation-checklist.md` exists.
[ ] The checklist has explicit checkboxes and pass/fail notes for each gate.
[ ] The Series Charter status for Prompt 12 is updated if the charter exists.
[ ] Existing V2 validation docs, skills, templates, and configs are not edited.

Code Agent must report against each criterion after completion.
