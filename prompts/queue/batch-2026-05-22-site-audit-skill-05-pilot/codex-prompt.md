# Prompt 05 - Prepare Universal Site Audit Pilot Prompt

## CONTEXT

Repository: `t9242540001/vibecoding-workspace`

This is Batch 05 of the universal `site-audit` skill series.

Batches 01-04 should already exist and be committed before this batch runs:

- `docs/site-audit/research-basis.md`
- `docs/site-audit/series-charter.md`
- `skills/site-audit/SKILL.md`
- `templates/site-audit/*`
- `docs/site-audit/agentic-audit-pipeline.md`
- `docs/site-audit/validation-gates.md`
- `docs/site-audit/integration-with-browser-e2e.md`
- `configs/site-audit-default-scope.json`
- `configs/site-audit-severity-taxonomy.json`
- `examples/site-audit/sanitized-audit-report-example.md`

This batch must prepare the reusable pilot prompt for the first safe public no-auth website audit. It must not run the audit.

## REQUIRED READS

Read before editing:

1. `AGENTS.md`
2. `workspace-index.md`
3. `skills/site-audit/SKILL.md`
4. `docs/site-audit/research-basis.md`
5. `docs/site-audit/series-charter.md`
6. `docs/site-audit/agentic-audit-pipeline.md`
7. `docs/site-audit/validation-gates.md`
8. `docs/site-audit/integration-with-browser-e2e.md`
9. `templates/site-audit/audit-scope-template.md`
10. `templates/site-audit/report-template.md`
11. `templates/site-audit/finding-taxonomy.md`
12. `templates/site-audit/codex-live-audit-prompt-template.md`
13. `configs/site-audit-default-scope.json`
14. `configs/site-audit-severity-taxonomy.json`
15. `standards/codex-batch-execution-standard.md`
16. `skills/prompt-writing-standard/SKILL.md`

Use `rg "site-audit|public site audit|pilot" docs skills templates configs prompts workspace-index.md` before editing.

## TASK

Create the reusable pilot prompt package for safe public no-auth website audits.

Create:

1. `prompts/series/site-audit-skill/pilot-public-site-audit-prompt.md`
2. `prompts/series/site-audit-skill/pilot-scope-example.md`
3. `prompts/series/site-audit-skill/README.md`

Update only if strictly needed:

4. `workspace-index.md`

## DOCUMENT REQUIREMENTS

### `prompts/series/site-audit-skill/pilot-public-site-audit-prompt.md`

Must be a reusable Code Agent prompt template, not YurAssistent-specific.

It must include placeholders for:

- project name
- repository
- public URL
- allowed pages/routes
- audit mode
- allowed actions
- forbidden actions
- viewports
- tools/forms
- artifact policy
- report path
- source/context files
- checks
- final output

It must require use of:

- `skills/site-audit/SKILL.md`
- `docs/site-audit/agentic-audit-pipeline.md`
- `docs/site-audit/validation-gates.md`
- `templates/site-audit/report-template.md`
- `templates/site-audit/finding-taxonomy.md`
- `configs/site-audit-default-scope.json`
- `configs/site-audit-severity-taxonomy.json`

It must explicitly forbid unless separately approved in the prompt:

- production form submit
- auth/admin/payment/account/billing/upload/destructive actions
- real personal data
- secrets/tokens/env/cookies/storage/auth headers
- deploy/server/database/SSH/SCP/process actions
- raw HAR/videos/traces/screenshots unless artifact policy approves them
- dependency installation
- product code changes during audit
- arbitrary URLs or broad crawling

It must include acceptance criteria:

- report created
- all findings have location/evidence/impact/severity/recommendation
- stop conditions reported
- validation gates pass or failures listed
- no forbidden actions performed

### `prompts/series/site-audit-skill/pilot-scope-example.md`

Must be a synthetic example only.

Use a fake project and fake URL like `https://example.invalid`.

Show how to fill:

- target
- mode
- routes
- viewports
- tools/forms
- allowed actions
- forbidden actions
- artifact policy
- report path

### `prompts/series/site-audit-skill/README.md`

Must explain:

- what this prompt package is for
- when to use it
- when not to use it
- how it connects to `site-audit` skill
- safe launch procedure
- required user approval gates
- how to adapt it for a product repo

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
- Do not add real URLs except official references already present in docs.
- Keep edits limited to listed files and batch queue files.

## CHECKS

Run:

- `python3 -m json.tool configs/site-audit-default-scope.json >/dev/null`
- `python3 -m json.tool configs/site-audit-severity-taxonomy.json >/dev/null`
- `git diff --check`
- `rg "site-audit" prompts/series/site-audit-skill docs/site-audit skills/site-audit templates/site-audit configs/site-audit* workspace-index.md`

## ACCEPTANCE CRITERIA

- [ ] Pilot prompt package exists and is universal.
- [ ] Prompt package references the completed skill, pipeline, validation gates, templates, and configs.
- [ ] Prompt separates read-only audit, non-submit form inspection, and submit/auth/payment/admin approval-gated actions.
- [ ] Synthetic scope example contains no real project assumptions.
- [ ] No real audit, browser run, dependency install, product repo change, or code change occurred.
- [ ] `git diff --check` passes.

## FINAL OUTPUT

Print:

- changed files
- files inspected
- checks run
- whether the universal site-audit system is ready for a product pilot
- any blockers
