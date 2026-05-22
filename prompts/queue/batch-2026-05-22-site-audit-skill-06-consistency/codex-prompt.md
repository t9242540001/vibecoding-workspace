# Prompt 06 - Site Audit System Consistency Review

## CONTEXT

Repository: `t9242540001/vibecoding-workspace`

This is Batch 06 of the universal `site-audit` skill series.

Batches 01-05 created the universal methodology, skill, templates, configs, validation docs, integration docs, examples, and pilot prompt package. This batch is a final quality gate before using the system on a real product site.

This batch must review consistency only. It may fix documentation contradictions only when the fix is small, local, and clearly within this batch scope. It must not run a real audit.

## REQUIRED READS

Read before editing:

1. `AGENTS.md`
2. `workspace-index.md`
3. `docs/site-audit/research-basis.md`
4. `docs/site-audit/series-charter.md`
5. `skills/site-audit/SKILL.md`
6. `docs/site-audit/agentic-audit-pipeline.md`
7. `docs/site-audit/validation-gates.md`
8. `docs/site-audit/integration-with-browser-e2e.md`
9. `templates/site-audit/audit-scope-template.md`
10. `templates/site-audit/report-template.md`
11. `templates/site-audit/finding-taxonomy.md`
12. `templates/site-audit/codex-live-audit-prompt-template.md`
13. `configs/site-audit-default-scope.json`
14. `configs/site-audit-severity-taxonomy.json`
15. `examples/site-audit/sanitized-audit-report-example.md`
16. `prompts/series/site-audit-skill/README.md`
17. `prompts/series/site-audit-skill/pilot-public-site-audit-prompt.md`
18. `prompts/series/site-audit-skill/pilot-scope-example.md`
19. `standards/codex-batch-execution-standard.md`
20. Relevant existing browser/e2e docs/configs referenced by the site-audit system.

Use `rg "site-audit|Site Audit|approved|forbidden|artifact|severity|evidence|browser|summary|validation|pilot" docs skills templates configs prompts workspace-index.md` to inspect consistency.

## TASK

Create a final consistency review report and apply only small in-scope documentation fixes if contradictions are found.

Create:

1. `docs/site-audit/system-consistency-review.md`

Update only if needed and only to resolve concrete contradictions:

2. `skills/site-audit/SKILL.md`
3. `docs/site-audit/agentic-audit-pipeline.md`
4. `docs/site-audit/validation-gates.md`
5. `docs/site-audit/integration-with-browser-e2e.md`
6. `templates/site-audit/*`
7. `configs/site-audit-*.json`
8. `prompts/series/site-audit-skill/*`
9. `workspace-index.md`

## REVIEW REQUIREMENTS

`docs/site-audit/system-consistency-review.md` must include:

1. Scope of review.
2. Files inspected.
3. Consistency matrix:
   - audit modes
   - allowed/forbidden actions
   - artifact policy
   - evidence fields
   - severity levels
   - finding categories
   - validation gates
   - browser/e2e handoff language
   - pilot prompt requirements
4. Contradictions found:
   - ID
   - files involved
   - problem
   - fix applied or reason no fix was applied
5. Missing links or index gaps.
6. JSON validation results.
7. Final readiness decision:
   - ready for product pilot / not ready
   - blockers if any
   - recommended next batch if ready

## CONSISTENCY RULES

Check that:

- Audit modes use the same names across skill, templates, configs, pipeline, validation, and pilot prompt.
- Severity levels are the same everywhere: Critical, High, Medium, Low, Observation.
- Finding categories align across `skills/site-audit/SKILL.md`, `templates/site-audit/finding-taxonomy.md`, and `configs/site-audit-severity-taxonomy.json`.
- Every report/prompt template requires location, evidence, impact, severity, and recommendation.
- Read-only audit, non-submit form/tool audit, and approved submit/auth/payment/admin audit stay separated.
- Browser/e2e integration preserves approved routes/profiles and sanitized summaries.
- Forbidden artifacts and actions do not conflict across files.
- Pilot prompt does not accidentally authorize product code changes, dependency installation, raw browser/session artifacts, arbitrary URLs, broad crawling, or submit/auth/payment/admin actions.
- `workspace-index.md` references the new system accurately.

## REGRESSION SHIELD - DO NOT TOUCH

- Do not run a real audit.
- Do not modify product repositories.
- Do not modify application code.
- Do not modify deploy/server/secrets.
- Do not install dependencies.
- Do not run browser automation.
- Do not touch `_local/`.
- Do not use Claude Routines.
- Do not create YurAssistent-specific routes or reports.
- Do not rewrite unrelated documentation.
- Keep edits limited to the listed files and batch queue files.

## CHECKS

Run:

- `python3 -m json.tool configs/site-audit-default-scope.json >/dev/null`
- `python3 -m json.tool configs/site-audit-severity-taxonomy.json >/dev/null`
- `git diff --check`
- `rg "Critical|High|Medium|Low|Observation" skills/site-audit docs/site-audit templates/site-audit configs prompts/series/site-audit-skill`
- `rg "submit|auth|payment|admin|screenshots|raw HAR|cookies|storage|deploy|server|database" skills/site-audit docs/site-audit templates/site-audit configs prompts/series/site-audit-skill`

## ACCEPTANCE CRITERIA

- [ ] `docs/site-audit/system-consistency-review.md` exists.
- [ ] Consistency matrix covers all required areas.
- [ ] Any contradictions are either fixed or explicitly recorded as blockers.
- [ ] JSON config files are valid.
- [ ] Site-audit system is either marked ready for product pilot or blockers are listed.
- [ ] No real audit, browser run, dependency install, product repo change, code change, or production action occurred.
- [ ] `git diff --check` passes.

## FINAL OUTPUT

Print:

- changed files
- files inspected
- checks run
- contradictions fixed
- readiness decision
- exact next recommended batch id if ready
