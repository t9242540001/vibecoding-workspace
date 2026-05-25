# Prompt 03 — Outcome Status Registry

## CONTEXT
Project: Vibe Coding workspace infrastructure
Repository: t9242540001/vibecoding-workspace
Series: prompts/queue/batch-2026-05-25-site-audit-v3-multi-agent/00-series-context.md
Series Charter: knowledge/series-charters/2026-05-25-site-audit-v3-multi-agent.md
Architecture contract: docs/site-audit/v3-architecture-contract.md
Affected files:
- configs/site-audit-v3-outcome-statuses.json
- docs/site-audit/v3-outcome-statuses.md

Current state:
Site Audit V3 requires a machine-readable and human-readable status contract so audit reports cannot overstate completeness. The previous pilot showed the key failure mode: a claimed full audit can silently become static-only when DNS, browser tooling, accounts, or sandbox payment access are missing. This prompt creates the status registry consumed by preflight, aggregator, validation gates, report templates, and product pilots.

Relevant series invariants:
- No false full-audit status is allowed.
- Missing live/browser/flow evidence must downgrade the audit outcome.
- The status model must be universal and product-neutral.
- Statuses must be understandable to Vasily and enforceable by Code Agent prompts.

## TASK
Create the Site Audit V3 outcome status registry in both machine-readable and human-readable forms.

Create `configs/site-audit-v3-outcome-statuses.json` with these required statuses:

1. `blocked_at_preflight`
2. `partial_static_audit`
3. `partial_audit_with_unavailable_layers`
4. `full_live_browser_audit_completed`
5. `post_fix_regression_completed`
6. `post_fix_regression_partial`

For each status include:

- id;
- label;
- meaning;
- allowed_when;
- required_evidence;
- forbidden_claims;
- report_label_ru;
- report_label_en;
- next_action;
- blocks_full_audit_boolean.

Create `docs/site-audit/v3-outcome-statuses.md` explaining the same registry for humans. It must include:

- why the registry exists;
- status table;
- transition rules from preflight to final report;
- examples of correct downgrades;
- examples of forbidden labels;
- aggregator enforcement rule.

Update the Series Charter step status for Prompt 03 if the charter exists.

## REGRESSION SHIELD — DO NOT TOUCH
Files not to modify:
- skills/site-audit/SKILL.md
- docs/site-audit/v3-architecture-contract.md
- existing configs/site-audit-default-scope.json
- existing configs/site-audit-severity-taxonomy.json
- templates/site-audit/*
- README.md
- workspace-index.md

Functions/components not to modify:
- Not applicable; this is a config/documentation prompt.

Within modified file(s): create only the new V3 outcome status config and documentation, plus the relevant Series Charter status update if available. Do not edit existing V2 configs or existing report templates in this prompt.

Critical rules for this project:
- No existing safety boundary may be weakened.
- New machine-readable contracts must be backward-compatible additions; do not mutate existing configs unless explicitly requested.
- No secrets, credentials, `.env` values, tokens, cookies, raw HAR, raw request bodies, or personal data may be committed.
- Existing files are edited only inside explicitly approved scope.

## ACCEPTANCE CRITERIA
[ ] `configs/site-audit-v3-outcome-statuses.json` exists and is valid JSON.
[ ] The JSON contains the six required statuses.
[ ] Each status contains all required fields.
[ ] `full_live_browser_audit_completed` requires successful preflight and live/browser/flow evidence for the declared full scope.
[ ] Static-only fallback is represented only by a partial or blocked status.
[ ] `docs/site-audit/v3-outcome-statuses.md` exists and explains the registry for humans.
[ ] The human doc includes transition rules, downgrade examples, forbidden labels, and aggregator enforcement.
[ ] The Series Charter status for Prompt 03 is updated if the charter exists.
[ ] Existing V2 configs/templates/skills are not edited.
[ ] No secrets, credentials, personal data, or private artifacts are added.

Code Agent must report against each criterion after completion.
