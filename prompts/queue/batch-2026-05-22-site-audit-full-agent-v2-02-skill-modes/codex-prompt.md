# Prompt 02 - Site Audit Full Agent V2 Skill Modes And Safety Model

## CONTEXT

Repository: `t9242540001/vibecoding-workspace`

This is Batch 02 of the `site-audit-full-agent-v2` series.

Batch 01 should create:

- `docs/site-audit/full-agent-v2-research-basis.md`
- `docs/site-audit/full-agent-v2-charter.md`

This batch updates the operational skill and pipeline to reflect the clarified target model:

- The site-audit agent must be capable of full website audits, including live, browser, interactive, auth/account, payment-path, admin-access, technical route, marketing/sales, target-audience usefulness, SEO/AEO/GEO, and AI/agentic-commerce readiness checks.
- The audit should not be blocked by default from testing these areas.
- The hard prohibition is on product modification during audit and on disclosing sensitive data.
- Any sensitive data encountered must be reported only in anonymized form.

## REQUIRED READS

Read before editing:

1. `AGENTS.md`
2. `workspace-index.md`
3. `docs/site-audit/full-agent-v2-research-basis.md`
4. `docs/site-audit/full-agent-v2-charter.md`
5. `skills/site-audit/SKILL.md`
6. `docs/site-audit/agentic-audit-pipeline.md`
7. `configs/site-audit-default-scope.json`
8. `templates/site-audit/audit-scope-template.md`
9. `docs/site-audit/validation-gates.md`
10. `docs/site-audit/integration-with-browser-e2e.md`

Use `rg "Audit Modes|Safety Boundaries|Scope Gate|forbidden|approval|browser|interactive|auth|payment|admin|marketing|agentic" skills docs templates configs workspace-index.md` before editing.

## TASK

Update:

1. `skills/site-audit/SKILL.md`
2. `docs/site-audit/agentic-audit-pipeline.md`
3. `configs/site-audit-default-scope.json`
4. `templates/site-audit/audit-scope-template.md` only if needed for mode list alignment
5. `workspace-index.md` only if needed

## REQUIRED SEMANTIC CHANGE

Replace the old read-only-first safety framing with a full-audit capability framing.

The new rule:

- The audit may inspect, browse, click, submit test data, authenticate with test accounts, inspect payment paths in safe/test/stop-before-charge mode, check admin access boundaries, verify API/server route behavior, and collect permitted evidence when this is inside the audit scope.
- The audit must not modify product code, deploy, change server config, change database data except reversible/synthetic test data created for the audit, perform real payments, perform destructive admin actions, or expose sensitive data in reports.
- If secrets, credentials, personal data, payment data, cookies, tokens, or auth/session material are encountered, the report must anonymize them and describe only the exposure type, location class, and risk.

## REQUIRED AUDIT MODES V2

Define clear modes or capability layers:

1. Static repository audit.
2. Live HTTP audit.
3. Browser visual audit.
4. Interactive user-flow audit.
5. Auth/account audit.
6. Payment-path audit.
7. Admin/access-boundary audit.
8. API/server-route/SSE audit.
9. Marketing/sales/target-audience usefulness audit.
10. SEO/AEO/GEO audit.
11. AI/agentic-commerce readiness audit.
12. Security/privacy/sensitive-data exposure audit.
13. Post-fix regression audit.

Do not require choosing exactly one mode if a full audit legitimately combines multiple layers. Instead, require a scope contract that lists enabled layers, test data/accounts, artifact policy, and stop conditions.

## REQUIRED SKILL UPDATES

`skills/site-audit/SKILL.md` must:

- change description if needed to include full audit, marketing/sales, target audience, AI/agentic-commerce readiness, interactive flows, auth/payment/admin access-boundary checks;
- update philosophy;
- update audit modes/layers;
- update audit dimensions;
- update workflow;
- update safety boundaries;
- update anti-patterns to include over-restricting audits without reason and confusing audit execution with product modification;
- preserve bilingual `.md` report requirement;
- preserve evidence/severity rules.

## REQUIRED PIPELINE UPDATES

`docs/site-audit/agentic-audit-pipeline.md` must:

- explain the full audit lifecycle;
- make browser/interactive/auth/payment/admin/server-route checks first-class when scoped;
- define role of test data, test accounts, stop-before-charge boundary, non-destructive admin checks, and anonymized sensitive-data reporting;
- keep product modification forbidden during audit.

## REQUIRED CONFIG UPDATES

`configs/site-audit-default-scope.json` must remain valid JSON and include:

- enabled audit layers;
- default forbidden product modifications;
- default sensitive data redaction rules;
- artifact policy categories;
- test data/account placeholders;
- stop conditions;
- marketing/sales/target-audience and AI/agentic-commerce readiness dimensions.

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
- Do not weaken the no-product-modification and no-sensitive-data-disclosure rules.
- Keep edits limited to listed files and batch queue files.

## CHECKS

Run:

- `python3 -m json.tool configs/site-audit-default-scope.json >/dev/null`
- `python3 -m json.tool configs/site-audit-severity-taxonomy.json >/dev/null`
- `git diff --check`
- `rg "agentic-commerce|target-audience|Payment-path|Admin/access-boundary|sensitive data|product modification|bilingual" skills/site-audit docs/site-audit configs templates/site-audit workspace-index.md`

## ACCEPTANCE CRITERIA

- [ ] Skill describes full audit capability model.
- [ ] Pipeline describes full audit lifecycle.
- [ ] Default scope config is valid JSON and reflects V2 capability layers.
- [ ] Audit actions are no longer blocked by default solely because they are interactive/auth/payment/admin/browser/server-route checks.
- [ ] Product modification during audit remains forbidden.
- [ ] Sensitive data disclosure remains forbidden and anonymized risk reporting is required.
- [ ] No real audit or product repo change occurred.
- [ ] `git diff --check` passes.

## FINAL OUTPUT

Print:

- changed files
- files inspected
- checks run
- contradictions resolved
- whether Batch 03 can proceed
