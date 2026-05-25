# Prompt 05 — Agent Registry

## CONTEXT
Project: Vibe Coding workspace infrastructure
Repository: t9242540001/vibecoding-workspace
Series: prompts/queue/batch-2026-05-25-site-audit-v3-multi-agent/00-series-context.md
Series Charter: knowledge/series-charters/2026-05-25-site-audit-v3-multi-agent.md
Architecture contract: docs/site-audit/v3-architecture-contract.md
Outcome statuses: configs/site-audit-v3-outcome-statuses.json
Evidence registry: configs/site-audit-v3-evidence-registry.json
Affected files:
- configs/site-audit-v3-agent-registry.json
- docs/site-audit/v3-agent-registry.md

Current state:
V3 needs a role registry before individual agent packs are created. The registry is the shared namespace for agent IDs, responsibilities, inputs, outputs, dependencies, evidence classes, and tunable parameters.

Relevant series invariants:
- Each agent must be future-tunable without rewriting the whole pipeline.
- Each expert pass must have role logic, self-directed questions, evidence policy, boundaries, self-check, and handoff.
- Agent roles must be universal and product-neutral.
- Agents must not duplicate each other's responsibility silently.

## TASK
Create the Site Audit V3 agent registry in machine-readable and human-readable forms.

Create `configs/site-audit-v3-agent-registry.json` with these agents:

00. `lead_orchestrator`
01. `preflight_readiness`
02. `discovery_site_map`
03. `static_technical_audit`
04. `live_browser_qa`
05. `scenario_flow`
06. `ux_target_audience`
07. `visual_design_system`
08. `product_conversion`
09. `content_editorial_trust`
10. `legal_compliance`
11. `privacy_data_protection`
12. `security_boundary`
13. `accessibility`
14. `seo_aeo_geo`
15. `ai_agentic_commerce`
16. `performance_reliability`
17. `analytics_measurement`
18. `report_aggregator_risk_board`

For each agent include:
- id;
- title;
- mission;
- primary_questions;
- required_inputs;
- allowed_evidence_classes;
- forbidden_claims;
- handoff_outputs;
- depends_on_agents;
- consumed_by_agents;
- tunable_parameters;
- default_enabled_boolean;
- requires_live_evidence_boolean;
- safety_boundary_summary.

Create `docs/site-audit/v3-agent-registry.md` explaining:
- role taxonomy;
- dependency order;
- parallelizable expert packs after discovery;
- how future tuning works;
- how agent overlap is resolved;
- how disabled/unavailable agents affect outcome status.

Update the Series Charter step status for Prompt 05 if the charter exists.

## REGRESSION SHIELD — DO NOT TOUCH
Files not to modify:
- skills/site-audit/SKILL.md
- configs/site-audit-v3-outcome-statuses.json
- configs/site-audit-v3-evidence-registry.json
- docs/site-audit/v3-architecture-contract.md
- templates/site-audit/*
- README.md
- workspace-index.md

Functions/components not to modify:
- Not applicable; this is a config/documentation prompt.

Within modified file(s): create only the V3 agent registry config and documentation, plus the relevant Series Charter status update if available. Do not create agent skills in this prompt; later prompts create agent packs using this registry.

Critical rules for this project:
- Agent roles must be universal and product-neutral.
- No existing safety boundary may be weakened.
- No secrets, credentials, personal data, or private artifacts may be committed.
- Existing files are edited only inside explicitly approved scope.

## ACCEPTANCE CRITERIA
[ ] `configs/site-audit-v3-agent-registry.json` exists and is valid JSON.
[ ] The JSON contains all agents 00-18.
[ ] Each agent contains all required fields.
[ ] The registry marks which agents require live evidence.
[ ] The registry includes tunable parameters for every agent.
[ ] `docs/site-audit/v3-agent-registry.md` exists and explains role taxonomy, dependencies, tuning, overlap, and unavailable agents.
[ ] The Series Charter status for Prompt 05 is updated if the charter exists.
[ ] No agent skills are created in this prompt.
[ ] Existing V2 site-audit assets are not edited.
[ ] No secrets, credentials, personal data, or private artifacts are added.

Code Agent must report against each criterion after completion.
