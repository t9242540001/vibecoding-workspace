# Prompt 03 - Site Audit Pipeline And Default Configs

## CONTEXT

Repository: `t9242540001/vibecoding-workspace`

This is Batch 03 of the universal `site-audit` skill series.

Batch 01 created the research basis and series charter. Batch 02 created the `site-audit` skill and templates.

This batch must design the reusable agentic execution pipeline for safe website audits. It must not run a real website audit and must not add browser automation code unless the need is documented and explicitly scoped as a non-destructive design artifact.

## REQUIRED READS

Read before editing:

1. `AGENTS.md`
2. `workspace-index.md`
3. `docs/site-audit/research-basis.md`
4. `docs/site-audit/series-charter.md`
5. `skills/site-audit/SKILL.md`
6. `templates/site-audit/audit-scope-template.md`
7. `templates/site-audit/report-template.md`
8. `templates/site-audit/finding-taxonomy.md`
9. `templates/site-audit/codex-live-audit-prompt-template.md`
10. `standards/codex-batch-execution-standard.md`
11. Existing browser/e2e docs and configs:
    - `docs/browser-automation-handoff-contract.md`
    - `docs/real-public-browser-summary-mvp.md`
    - `docs/real-staging-browser-workflow-design.md`
    - `docs/e2e-staging-summary-contract.md`
    - `docs/e2e-staging-summary-analysis.md`
    - `configs/browser-automation-handoff-contract.json`
    - `configs/real-staging-approved-routes.json`
    - `configs/real-staging-interaction-profiles.json`
    - `configs/e2e-staging-summary-contract.json`

Use `rg "browser|staging|summary|approved route|interaction profile|site-audit" docs configs skills templates` to inspect existing terminology before writing.

## TASK

Create the reusable site-audit execution design and default machine-readable configs.

Create:

1. `docs/site-audit/agentic-audit-pipeline.md`
2. `configs/site-audit-default-scope.json`
3. `configs/site-audit-severity-taxonomy.json`

Update only if strictly needed:

4. `workspace-index.md`

## DOCUMENT REQUIREMENTS

### `docs/site-audit/agentic-audit-pipeline.md`

Must explain how an AI orchestrator and Code Agent run a safe website audit from request to report.

Include:

1. Purpose and non-purpose.
2. Actor model:
   - user/decision layer
   - AI orchestrator
   - Code Agent
   - optional browser/e2e evidence producer
   - repository/GitHub source of truth
3. Pipeline phases:
   - intake and scope gate
   - read order
   - audit plan
   - safe evidence collection
   - report generation
   - validation gates
   - fix prompt planning
   - post-fix regression audit
4. Audit mode routing:
   - static repository audit
   - read-only live public audit
   - non-submit form/tool audit
   - approved submit/auth/payment/admin audit
   - post-fix regression audit
5. Evidence model:
   - source files
   - public page observations
   - sanitized browser summaries
   - console/network summaries
   - Lighthouse or similar signals if available
   - human visual judgment
   - unknowns
6. Browser/e2e integration rules:
   - reuse approved route/profile concepts
   - no arbitrary URLs by default
   - no broad crawling by default
   - no raw cookies/storage/auth headers/raw HAR by default
   - screenshots/videos/traces require explicit artifact policy
7. Safety stop conditions:
   - secret/credential exposure
   - real personal/client/payment data
   - unapproved submit/auth/payment/admin action required
   - private URL or account boundary
   - server/deploy/database/secrets action needed
   - evidence source outside approved artifact policy
8. Output contracts:
   - report path
   - finding IDs
   - evidence IDs
   - severity taxonomy
   - next fix prompts
9. How to use configs:
   - `configs/site-audit-default-scope.json`
   - `configs/site-audit-severity-taxonomy.json`
10. Open decisions and future extensions.

### `configs/site-audit-default-scope.json`

Must be valid JSON.

Include reusable defaults for:

- audit modes
- default forbidden actions
- default allowed read-only actions
- default audit dimensions
- default viewports
- default stop conditions
- default artifact policy
- report required sections

Keep this config universal. Do not include YurAssistent-specific URLs.

### `configs/site-audit-severity-taxonomy.json`

Must be valid JSON.

Include:

- severity levels
- definitions
- escalation factors
- evidence requirements
- category list aligned with `templates/site-audit/finding-taxonomy.md`

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
- `rg "site-audit" docs/site-audit configs workspace-index.md`

## ACCEPTANCE CRITERIA

- [ ] `docs/site-audit/agentic-audit-pipeline.md` exists and is universal.
- [ ] Pipeline aligns with `skills/site-audit/SKILL.md` and existing browser/e2e safety concepts.
- [ ] Config JSON files are valid.
- [ ] Safety boundaries remain approval-gated.
- [ ] No real audit, browser run, dependency install, product repo change, or code change occurred.
- [ ] `git diff --check` passes.

## FINAL OUTPUT

Print:

- changed files
- files inspected
- checks run
- whether Batch 04 can proceed
- any contradictions found and how resolved
