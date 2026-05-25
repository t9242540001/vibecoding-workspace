# Prompt 04 — Evidence Registry

## CONTEXT
Project: Vibe Coding workspace infrastructure
Repository: t9242540001/vibecoding-workspace
Series: prompts/queue/batch-2026-05-25-site-audit-v3-multi-agent/00-series-context.md
Series Charter: knowledge/series-charters/2026-05-25-site-audit-v3-multi-agent.md
Architecture contract: docs/site-audit/v3-architecture-contract.md
Outcome statuses: configs/site-audit-v3-outcome-statuses.json and docs/site-audit/v3-outcome-statuses.md
Affected files:
- configs/site-audit-v3-evidence-registry.json
- docs/site-audit/v3-evidence-registry.md

Current state:
V3 needs a single evidence vocabulary used by all agents and by the aggregator. Without it, expert passes can mix facts, opinions, screenshots, source-code evidence, inferred risks, and unavailable layers in inconsistent ways.

Relevant series invariants:
- Findings must separate observed fact, evidence, inferred risk, impact, recommendation, confidence, and status.
- Browser/live claims require actual browser/live evidence.
- Sensitive data must never be stored or quoted in audit artifacts.
- The registry must be universal and product-neutral.

## TASK
Create the Site Audit V3 evidence registry in machine-readable and human-readable forms.

Create `configs/site-audit-v3-evidence-registry.json` with evidence classes:

1. `static_source`
2. `repository_config`
3. `http_public`
4. `browser_rendered`
5. `screenshot_sanitized`
6. `console_summary`
7. `network_summary`
8. `flow_transcript_synthetic`
9. `auth_test_account`
10. `payment_sandbox_or_stop_before_charge`
11. `admin_boundary_non_destructive`
12. `api_response_shape_summary`
13. `accessibility_manual_check`
14. `performance_measurement`
15. `analytics_signal`
16. `expert_assessment`
17. `unavailable_layer`
18. `sensitive_exposure_class_only`

For each class include:
- id;
- label;
- allowed_sources;
- allowed_artifacts;
- forbidden_artifacts;
- supports_full_live_claim_boolean;
- sanitization_required_boolean;
- can_contain_sensitive_data_boolean;
- required_location_fields;
- notes.

Create `docs/site-audit/v3-evidence-registry.md` explaining:
- why evidence classes exist;
- which classes can support full live/browser status;
- how unavailable layers are recorded;
- how sensitive exposure is reported safely;
- how agents must cite evidence in handoff;
- how the aggregator must reject unsupported findings.

Update the Series Charter step status for Prompt 04 if the charter exists.

## REGRESSION SHIELD — DO NOT TOUCH
Files not to modify:
- skills/site-audit/SKILL.md
- configs/site-audit-v3-outcome-statuses.json
- docs/site-audit/v3-outcome-statuses.md
- existing configs/site-audit-default-scope.json
- existing configs/site-audit-severity-taxonomy.json
- templates/site-audit/*
- README.md
- workspace-index.md

Functions/components not to modify:
- Not applicable; this is a config/documentation prompt.

Within modified file(s): create only the new V3 evidence registry config and documentation, plus the relevant Series Charter status update if available. Do not rewrite existing status registry, V2 configs, or existing templates.

Critical rules for this project:
- Evidence must never include secrets, credentials, `.env` values, tokens, cookies, raw HAR, raw request bodies, raw response bodies, or personal data.
- Sensitive exposures are reported by class, safe location, impact, and remediation path only.
- No existing safety boundary may be weakened.

## ACCEPTANCE CRITERIA
[ ] `configs/site-audit-v3-evidence-registry.json` exists and is valid JSON.
[ ] The JSON contains all required evidence classes.
[ ] Each evidence class contains all required fields.
[ ] The registry identifies which evidence classes can support a full live/browser claim.
[ ] The registry includes `unavailable_layer` and `sensitive_exposure_class_only`.
[ ] `docs/site-audit/v3-evidence-registry.md` exists and explains the registry for humans.
[ ] The human doc explains unsupported finding rejection by aggregator.
[ ] The Series Charter status for Prompt 04 is updated if the charter exists.
[ ] Existing status registry, V2 configs/templates/skills are not edited.
[ ] No secrets, credentials, personal data, or private artifacts are added.

Code Agent must report against each criterion after completion.
