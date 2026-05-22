# Prompt 04 - Site Audit Validation Gates And Browser Integration Review

## CONTEXT

Repository: `t9242540001/vibecoding-workspace`

This is Batch 04 of the universal `site-audit` skill series.

Batches 01-03 should already exist:

- `docs/site-audit/research-basis.md`
- `docs/site-audit/series-charter.md`
- `skills/site-audit/SKILL.md`
- `templates/site-audit/*`
- `docs/site-audit/agentic-audit-pipeline.md`
- `configs/site-audit-default-scope.json`
- `configs/site-audit-severity-taxonomy.json`

This batch must validate the new site-audit system against the existing browser/e2e infrastructure and create reusable validation gates. It must not run a real audit.

## REQUIRED READS

Read before editing:

1. `AGENTS.md`
2. `workspace-index.md`
3. `docs/site-audit/research-basis.md`
4. `docs/site-audit/series-charter.md`
5. `skills/site-audit/SKILL.md`
6. `docs/site-audit/agentic-audit-pipeline.md`
7. `templates/site-audit/report-template.md`
8. `templates/site-audit/finding-taxonomy.md`
9. `templates/site-audit/codex-live-audit-prompt-template.md`
10. `configs/site-audit-default-scope.json`
11. `configs/site-audit-severity-taxonomy.json`
12. Existing browser/e2e docs and configs:
    - `docs/browser-automation-handoff-contract.md`
    - `docs/real-public-browser-summary-mvp.md`
    - `docs/real-staging-browser-workflow-design.md`
    - `docs/e2e-staging-summary-contract.md`
    - `docs/e2e-staging-summary-analysis.md`
    - `docs/e2e-staging-summary-validator.md`
    - `configs/browser-automation-handoff-contract.json`
    - `configs/real-staging-approved-routes.json`
    - `configs/real-staging-interaction-profiles.json`
    - `configs/e2e-staging-summary-contract.json`
    - `configs/e2e-staging-summary-summary-contract.json` if it exists

Use `rg "site-audit|browser|staging|summary|approved route|interaction profile|validation|artifact" docs configs skills templates` to inspect terminology and possible contradictions.

## TASK

Create validation and integration documentation for the site-audit system.

Create:

1. `docs/site-audit/validation-gates.md`
2. `docs/site-audit/integration-with-browser-e2e.md`
3. `examples/site-audit/sanitized-audit-report-example.md`

Update only if strictly needed:

4. `workspace-index.md`

## DOCUMENT REQUIREMENTS

### `docs/site-audit/validation-gates.md`

Must define reusable gates that every site-audit report or prompt can be checked against.

Include gates for:

1. Scope completeness:
   - target
   - audit mode
   - allowed actions
   - forbidden actions
   - routes/pages
   - forms/tools
   - artifact policy
   - report path
2. Safety boundary compliance:
   - no unapproved submit/auth/payment/admin/account/upload/destructive actions
   - no real personal data
   - no secrets/credentials/env/cookies/storage/auth headers
   - no deploy/server/database/SSH/SCP/process actions
   - no raw HAR/videos/traces/screenshots unless explicitly approved
3. Evidence quality:
   - every finding has location, evidence, impact, severity, recommendation
   - observed facts separated from inferred risks and unknowns
   - browser/visual claims require actual approved browser or visual evidence
   - automated signals are labeled as signals, not complete proof
4. Severity quality:
   - severity uses taxonomy
   - escalation factors applied
   - duplicates grouped
5. SEO/AEO/GEO quality:
   - recommendations improve user clarity/trust
   - no manipulative ranking tactics
   - structured data does not contradict visible content
6. Accessibility quality:
   - automated checks do not replace manual judgment
   - WCAG-related claims cite evidence or are framed as follow-up
7. Report completeness:
   - required sections from template present
   - stop conditions reported
   - next fix prompts scoped
8. Regression quality:
   - post-fix audits map to original finding IDs
   - statuses: fixed, partially fixed, not fixed, new regression, not retested

### `docs/site-audit/integration-with-browser-e2e.md`

Must compare the new site-audit system with existing browser/e2e docs and configs.

Include:

- current existing browser/e2e concepts found in the repo
- how site-audit reuses them
- where site-audit is higher-level than browser/e2e
- where browser/e2e evidence feeds the site-audit report
- contradiction review table
- final integration decision
- rules for future browser profiles/routes

Must explicitly preserve:

- approved route/profile discipline
- sanitized summaries before model analysis
- no arbitrary URLs by default
- no unapproved high-risk actions
- no raw private artifacts by default

### `examples/site-audit/sanitized-audit-report-example.md`

Must be synthetic only.

Include:

- fake project name
- fake public URL
- fake routes
- fake evidence IDs
- fake findings across several categories
- safe-boundary notes
- stop conditions
- next fix prompts examples

Must not include real secrets, real client data, real URLs needing access, or YurAssistent-specific content.

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
- Do not rewrite existing browser/e2e docs unless a contradiction requires a minimal cross-reference update and you explain it.
- Keep edits limited to the listed files and batch queue files.

## CHECKS

Run:

- `python3 -m json.tool configs/site-audit-default-scope.json >/dev/null`
- `python3 -m json.tool configs/site-audit-severity-taxonomy.json >/dev/null`
- `git diff --check`
- `rg "site-audit" docs/site-audit examples/site-audit workspace-index.md`

## ACCEPTANCE CRITERIA

- [ ] `docs/site-audit/validation-gates.md` exists and is reusable.
- [ ] `docs/site-audit/integration-with-browser-e2e.md` exists and contains a contradiction review.
- [ ] `examples/site-audit/sanitized-audit-report-example.md` exists and is synthetic only.
- [ ] Site-audit does not conflict with existing browser/e2e safety rules.
- [ ] No real audit, browser run, dependency install, product repo change, or code change occurred.
- [ ] `git diff --check` passes.

## FINAL OUTPUT

Print:

- changed files
- files inspected
- checks run
- contradictions found and resolved
- whether Batch 05 can proceed
