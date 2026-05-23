# Prompt 03b - Site Audit Full Agent V2 Interactive Evidence Contract Safe Path

## Context

Repository: `t9242540001/vibecoding-workspace`.

This replaces Batch 03. The previous local result was not committed because one generated filename was rejected by the trusted checkpoint. Use only the safe filenames listed below.

Goal: create the contract and templates for live browser, interactive flow, account, payment-path, admin boundary, and API route evidence.

Audit checks should be possible when scoped. Product modification during audit remains forbidden.

## Required reads

Read before editing:

1. `AGENTS.md`
2. `workspace-index.md`
3. `docs/site-audit/full-agent-v2-research-basis.md`
4. `docs/site-audit/full-agent-v2-charter.md`
5. `skills/site-audit/SKILL.md`
6. `docs/site-audit/agentic-audit-pipeline.md`
7. `configs/site-audit-default-scope.json`
8. `docs/site-audit/integration-with-browser-e2e.md`
9. `docs/browser-automation-handoff-contract.md`
10. `docs/real-public-browser-summary-mvp.md`
11. `docs/real-staging-browser-workflow-design.md`
12. `docs/e2e-staging-summary-contract.md`
13. `configs/browser-automation-handoff-contract.json`
14. `configs/real-staging-approved-routes.json`
15. `configs/real-staging-interaction-profiles.json`
16. `templates/site-audit/audit-scope-template.md`
17. `templates/site-audit/codex-live-audit-prompt-template.md`

## Task

Create exactly these files:

1. `docs/site-audit/live-browser-interactive-audit-contract.md`
2. `templates/site-audit/full-audit-scope-template.md`
3. `templates/site-audit/test-data-and-access-template.md`

Update only if needed:

4. `workspace-index.md`

Do not create extra files.

## Content requirements

### `docs/site-audit/live-browser-interactive-audit-contract.md`

Define how a full site audit safely uses:

- live HTTP checks;
- browser visual checks;
- desktop and mobile screenshots when allowed;
- console and network evidence;
- form filling with synthetic data;
- tool or generation submission with synthetic data;
- account testing with test accounts;
- payment-path testing in sandbox/test mode or stop-before-charge mode;
- admin boundary testing with non-destructive checks;
- API route and SSE verification as observation, not config modification.

Include:

1. Required scope contract.
2. Synthetic test data rules.
3. Test account rules.
4. Payment-path boundaries.
5. Admin boundary limits.
6. Screenshot and artifact rules.
7. Redaction and anonymization rules.
8. Stop conditions.
9. Evidence IDs and artifact naming.
10. What to report when a needed tool, test account, or access reference is missing.

### `templates/site-audit/full-audit-scope-template.md`

Create a fillable template for complete audits.

Include sections for:

- project/site target;
- enabled audit layers;
- routes/pages;
- user flows;
- forms/tools;
- synthetic test data;
- test accounts;
- payment path policy;
- admin boundary policy;
- API/server-route checks;
- browser/viewports;
- artifacts and screenshots;
- sensitive data redaction;
- stop conditions;
- report path;
- approvals and unavailable prerequisites.

### `templates/site-audit/test-data-and-access-template.md`

Create a safe template for synthetic test data, test account roles, and out-of-band access references.

Include:

- account role labels;
- access source reference, not secret value;
- synthetic data examples;
- forbidden real data;
- payment sandbox/stop-before-charge policy;
- admin non-destructive action list;
- redaction rules;
- missing prerequisite reporting.

## Regression shield

Do not:

- run a real audit;
- modify product repositories;
- modify application code;
- deploy or change server/database/config;
- install dependencies;
- run browser automation;
- touch `_local/`;
- use Claude Routines;
- create YurAssistent-specific content;
- store any secret values in templates.

## Checks

Run:

- `git diff --check`
- `rg "test account|synthetic|stop-before-charge|redact|anonymized|browser visual|payment-path|admin boundary" docs/site-audit templates/site-audit workspace-index.md`

## Acceptance criteria

- [ ] Live/browser/interactive audit contract exists.
- [ ] Full audit scope template exists.
- [ ] Test data and access template exists.
- [ ] Contract enables full audit checks without authorizing product modification.
- [ ] Missing prerequisites are report limitations, not permanent capability blocks.
- [ ] `git diff --check` passes.

## Final output

Print:

- changed files
- files inspected
- checks run
- whether Batch 04 can proceed
- blockers or contradictions
