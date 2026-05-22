# Site Audit System Consistency Review
<!--
  @file:        docs/site-audit/system-consistency-review.md
  @description: Final consistency review for the reusable Vibe Coding site-audit system
  @updated:     2026-05-22
  @version:     1.0
-->

## Scope Of Review

This review checks consistency across the reusable site-audit skill, templates, configs, validation gates, browser/E2E integration docs, examples, and pilot prompt package.

This review did not run a real audit, browser automation, dependency installation, product repository change, deploy, server, database, secrets, auth, payment, admin, submit, or production action.

## Files Inspected

- `AGENTS.md`
- `workspace-index.md`
- `standards/codex-batch-execution-standard.md`
- `standards/VIBECODER_STANDARDS.md`
- `docs/site-audit/research-basis.md`
- `docs/site-audit/series-charter.md`
- `docs/site-audit/agentic-audit-pipeline.md`
- `docs/site-audit/validation-gates.md`
- `docs/site-audit/integration-with-browser-e2e.md`
- `skills/site-audit/SKILL.md`
- `templates/site-audit/audit-scope-template.md`
- `templates/site-audit/report-template.md`
- `templates/site-audit/finding-taxonomy.md`
- `templates/site-audit/codex-live-audit-prompt-template.md`
- `configs/site-audit-default-scope.json`
- `configs/site-audit-severity-taxonomy.json`
- `examples/site-audit/sanitized-audit-report-example.md`
- `prompts/series/site-audit-skill/README.md`
- `prompts/series/site-audit-skill/series-plan.md`
- `prompts/series/site-audit-skill/pilot-public-site-audit-prompt.md`
- `prompts/series/site-audit-skill/pilot-scope-example.md`
- `docs/real-public-browser-summary-mvp.md`
- `docs/browser-automation-handoff-contract.md`
- `docs/e2e-staging-summary-contract.md`
- `configs/real-staging-approved-routes.json`
- `configs/real-staging-interaction-profiles.json`

## Consistency Matrix

| Area | Consistency Result | Notes |
|---|---|---|
| Audit modes | Mostly aligned, with label/id representation split. | Human-facing docs use `Static repository audit`, `Read-only live public audit`, `Non-submit form/tool audit`, `Approved submit/auth/payment/admin audit`, and `Post-fix regression audit`. JSON config uses equivalent snake_case IDs. |
| Allowed/forbidden actions | Aligned. | Skill, pipeline, validation gates, templates, default scope config, pilot prompt, and browser/E2E docs consistently separate read-only work, non-submit inspection, and approved submit/auth/payment/admin flows. |
| Artifact policy | Aligned. | Raw HAR, screenshots, videos, traces, cookies, storage, auth headers, request/response bodies, private URLs, server IPs, local paths, secrets, and private data are forbidden by default across operational artifacts. |
| Evidence fields | Aligned. | Operational report and validation artifacts require location, evidence, impact, severity, recommendation, and status. Finding IDs and category are also required by the report/taxonomy/config contract. |
| Severity levels | Aligned. | Operational artifacts and the research basis now use `Critical`, `High`, `Medium`, `Low`, and `Observation`. |
| Finding categories | Aligned. | Skill dimensions, finding taxonomy labels, and JSON category labels match. JSON also provides stable snake_case IDs for machine-readable validation. |
| Validation gates | Aligned. | Gates cover scope completeness, safety boundaries, evidence quality, severity quality, SEO/AEO/GEO quality, accessibility quality, report completeness, and regression quality. |
| Browser/E2E handoff language | Aligned. | Site-audit consumes approved route/profile sanitized summaries and does not expand browser actions, artifacts, route scope, or model inputs. |
| Pilot prompt requirements | Aligned. | Pilot prompt forbids product-code fixes, dependency installation, raw artifacts, arbitrary URLs, broad crawling, submit/auth/payment/admin actions, deploy/server/database/secrets actions, and real personal data use. |

## Contradictions Found

| ID | Files involved | Problem | Fix applied or reason no fix was applied |
|---|---|---|---|
| C-001 | `docs/site-audit/research-basis.md`; `skills/site-audit/SKILL.md`; `templates/site-audit/report-template.md`; `templates/site-audit/finding-taxonomy.md`; `configs/site-audit-severity-taxonomy.json`; `docs/site-audit/validation-gates.md` | Severity level names were not the same everywhere. The research basis used a different fifth label, while the operational skill, templates, config, and validation gates use `Observation`. | Resolved by `batch-2026-05-22-site-audit-skill-07-taxonomy-cleanup`: `docs/site-audit/research-basis.md` now uses `Observation`. |
| C-002 | `prompts/series/site-audit-skill/series-plan.md`; `prompts/series/site-audit-skill/README.md`; `prompts/series/site-audit-skill/pilot-public-site-audit-prompt.md`; current batch manifest | The series plan described Batch 05 as a YurAssistent-specific pilot prompt and did not record the Batch 06 consistency gate, while the actual prompt package is universal and this batch is the consistency review. | Fixed in `prompts/series/site-audit-skill/series-plan.md` by replacing the product-specific Batch 05 output with the actual universal prompt package and adding Batch 06. |

## Missing Links Or Index Gaps

| ID | File | Gap | Fix |
|---|---|---|---|
| L-001 | `workspace-index.md` | The active site-audit docs list did not include this consistency review. | Added `docs/site-audit/system-consistency-review.md` to the active site-audit docs list. |

## JSON Validation Results

| File | Result |
|---|---|
| `configs/site-audit-default-scope.json` | Valid JSON. |
| `configs/site-audit-severity-taxonomy.json` | Valid JSON. |

## Final Readiness Decision

Decision: ready for product pilot.

Resolved blocker:

- `C-001` is resolved. The severity taxonomy is consistent everywhere required by the batch: `Critical`, `High`, `Medium`, `Low`, and `Observation`.

Recommended next batch:

- `batch-2026-05-22-site-audit-skill-08-product-pilot`
