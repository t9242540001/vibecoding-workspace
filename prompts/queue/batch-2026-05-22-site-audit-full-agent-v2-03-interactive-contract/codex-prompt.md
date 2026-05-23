# Prompt 03 - Site Audit Full Agent V2 Interactive Evidence Contract

## CONTEXT

Repository: `t9242540001/vibecoding-workspace`

This is Batch 03 of the `site-audit-full-agent-v2` series.

Batch 01 defines the research basis and charter. Batch 02 updates the core skill, pipeline, and default scope. This batch creates the concrete contract for browser, interactive, auth/account, payment-path, admin/access-boundary, and technical route evidence.

The goal is not to forbid these checks. The goal is to make them executable, controlled, evidence-based, and non-modifying except for explicitly scoped reversible test actions.

## REQUIRED READS

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

Use `rg "browser|interactive|auth|payment|admin|screenshot|HAR|cookie|storage|test data|redact|route|profile" docs configs templates skills workspace-index.md` before editing.

## TASK

Create:

1. `docs/site-audit/live-browser-interactive-audit-contract.md`
2. `templates/site-audit/full-audit-scope-template.md`
3. `templates/site-audit/test-data-and-credentials-template.md`

Update only if strictly needed:

4. `workspace-index.md`

## CONTRACT REQUIREMENTS

`docs/site-audit/live-browser-interactive-audit-contract.md` must define how a full website audit can safely use:

- live HTTP checks;
- browser visual checks;
- desktop/mobile screenshots when allowed;
- console and network evidence;
- form filling with synthetic data;
- generation/tool submission with synthetic data;
- auth/account testing with test accounts;
- payment-path testing in sandbox/test mode or stop-before-charge mode;
- admin/access-boundary testing with non-destructive checks;
- API/server-route/SSE verification as observation, not config modification.

It must define:

1. Required scope contract before execution.
2. Test data rules.
3. Test account rules.
4. Payment-path boundaries.
5. Admin/access-boundary boundaries.
6. Screenshot/artifact rules.
7. Redaction/anonymization rules.
8. Stop conditions.
9. Evidence IDs and artifact naming.
10. What to report when a needed credential/tooling/account is missing.

## FULL AUDIT SCOPE TEMPLATE REQUIREMENTS

`templates/site-audit/full-audit-scope-template.md` must be a fillable template for complete audits.

Include sections for:

- project/site target;
- enabled audit layers;
- routes/pages;
- user flows;
- forms/tools;
- test data;
- test accounts;
- payment path policy;
- admin/access policy;
- API/server-route checks;
- browser/viewports;
- artifacts and screenshots;
- sensitive data redaction;
- stop conditions;
- report path;
- approvals and unavailable prerequisites.

## TEST DATA AND CREDENTIALS TEMPLATE REQUIREMENTS

`templates/site-audit/test-data-and-credentials-template.md` must define a safe way to describe test data/accounts without storing secrets.

Include:

- account role labels, not passwords;
- credential source reference, not credential value;
- synthetic data examples;
- forbidden real data;
- payment sandbox/stop-before-charge policy;
- admin non-destructive action list;
- redaction rules;
- missing prerequisite reporting.

## REGRESSION SHIELD - DO NOT TOUCH

- Do not run a real audit.
- Do not modify product repositories.
- Do not modify application code.
- Do not deploy or change server/database/secrets/config.
- Do not install dependencies.
- Do not run browser automation.
- Do not touch `_local/`.
- Do not use Claude Routines.
- Do not create YurAssistent-specific content.
- Do not store secrets or credentials in templates.
- Keep edits limited to listed files and batch queue files.

## CHECKS

Run:

- `git diff --check`
- `rg "test account|synthetic|stop-before-charge|redact|anonymized|browser visual|payment-path|admin/access" docs/site-audit templates/site-audit workspace-index.md`

## ACCEPTANCE CRITERIA

- [ ] Live/browser/interactive audit contract exists.
- [ ] Full audit scope template exists.
- [ ] Test data and credentials template exists and stores no secrets.
- [ ] Contract enables full audit checks without authorizing product modification.
- [ ] Missing prerequisites are report limitations, not permanent capability blocks.
- [ ] `git diff --check` passes.

## FINAL OUTPUT

Print:

- changed files
- files inspected
- checks run
- whether Batch 04 can proceed
- blockers or contradictions
