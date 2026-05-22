# Prompt 07 - Site Audit Taxonomy Cleanup

## CONTEXT

Repository: `t9242540001/vibecoding-workspace`

Batch 06 found one blocker before the site-audit system can be used for a product pilot:

- `docs/site-audit/research-basis.md` uses severity level `Info`.
- The operational system uses `Observation` everywhere else.

This batch must make the smallest correct documentation fix: replace the research-basis severity label `Info` with `Observation` and rerun consistency checks. Do not change the meaning of any other text.

## REQUIRED READS

Read before editing:

1. `AGENTS.md`
2. `docs/site-audit/system-consistency-review.md`
3. `docs/site-audit/research-basis.md`
4. `skills/site-audit/SKILL.md`
5. `templates/site-audit/report-template.md`
6. `templates/site-audit/finding-taxonomy.md`
7. `configs/site-audit-severity-taxonomy.json`
8. `docs/site-audit/validation-gates.md`

## TASK

Fix the severity taxonomy inconsistency recorded as C-001.

Allowed change:

- In `docs/site-audit/research-basis.md`, change the severity label `Info` to `Observation` wherever it refers to the site-audit severity taxonomy.

Optional update:

- In `docs/site-audit/system-consistency-review.md`, update the final readiness decision from blocked to ready only if all checks pass after the cleanup. Preserve the contradiction history and state that C-001 was resolved by this batch.

Do not make style improvements or unrelated wording changes.

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
- Keep edits limited to:
  - `docs/site-audit/research-basis.md`
  - `docs/site-audit/system-consistency-review.md` only if needed to mark C-001 resolved
  - batch queue files

## CHECKS

Run:

- `python3 -m json.tool configs/site-audit-default-scope.json >/dev/null`
- `python3 -m json.tool configs/site-audit-severity-taxonomy.json >/dev/null`
- `rg "\bInfo\b" docs/site-audit skills/site-audit templates/site-audit configs prompts/series/site-audit-skill || true`
- `rg "Critical|High|Medium|Low|Observation" docs/site-audit skills/site-audit templates/site-audit configs prompts/series/site-audit-skill`
- `git diff --check`

## ACCEPTANCE CRITERIA

- [ ] No site-audit severity taxonomy reference uses `Info`.
- [ ] Severity taxonomy is consistent as `Critical`, `High`, `Medium`, `Low`, `Observation`.
- [ ] JSON configs remain valid.
- [ ] `docs/site-audit/system-consistency-review.md` records C-001 as resolved or superseded.
- [ ] Site-audit system is marked ready for product pilot if no blockers remain.
- [ ] No unrelated files changed.
- [ ] `git diff --check` passes.

## FINAL OUTPUT

Print:

- changed files
- files inspected
- checks run
- whether C-001 is resolved
- readiness decision
- next recommended batch id
