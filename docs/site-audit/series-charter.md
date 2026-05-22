# Site Audit Skill Series Charter

<!--
  @file:        docs/site-audit/series-charter.md
  @description: Series charter for creating the universal Vibe Coding site audit skill system
  @updated:     2026-05-22
  @version:     1.0
-->

## Series Goal

Create a universal, reusable Vibe Coding website audit system that lets a Code Agent or AI orchestrator prepare and run safe, scoped site audits across product repositories.

The final system must produce evidence-based findings for technical frontend health, UX, accessibility, responsive behavior, forms/tools, SEO, AEO/GEO, copy/trust, design consistency, analytics/conversion, and public UI security/privacy while preserving Vibe Coding safety boundaries.

The series output is not a one-off audit of YurAssistent. It is a shared skill, standards/templates, and pilot prompt framework that future product repositories can apply with project-specific scope.

## T3 Classification

This series is T3 because:

- it creates a new reusable skill and supporting methodology;
- it requires 3+ prompts with shared invariants;
- it touches long-lived standards/templates used across future projects;
- mistakes could authorize unsafe browser automation, data handling, or misleading audit conclusions;
- it requires research, skill design, validation, and pilot execution design.

## Batch Sequence

### Batch 01 - Research Basis And Series Charter

Status: in progress.

Produces:

- `docs/site-audit/research-basis.md`
- `docs/site-audit/series-charter.md`

Does not produce:

- `skills/site-audit/SKILL.md`
- templates;
- browser automation;
- pilot audit changes;
- product repository changes.

Acceptance criteria:

- research basis cites verified source categories and existing Vibe Coding browser-safety documents;
- all required audit dimensions are covered;
- automated checks are separated from human/browser judgment;
- safe live-audit boundaries are explicit;
- read-only audit, non-submit form inspection, and submit/auth/payment/admin actions are clearly separated;
- the Charter defines the rest of the multi-batch series.

### Batch 02 - Skill Template And Draft Skill

Status: pending.

Produces:

- `skills/site-audit/SKILL.md`
- optional skill-local references only if needed and explicitly scoped.

Acceptance criteria:

- skill follows `skills/skill-writing-standard/SKILL.md`;
- YAML description triggers on website/site audits, landing-page audits, public UI audits, and browser-summary audit review;
- skill excludes deploy/server/secrets work, unrestricted browser automation, product-code changes, and unapproved submissions/auth/payments/admin actions;
- skill maps audit workflow to the dimensions in `docs/site-audit/research-basis.md`;
- skill contains anti-patterns for Lighthouse-only audits, SEO-only audits, visual taste-only audits, unsafe browser actions, and unsupported claims;
- skill does not contradict existing browser/E2E safety docs.

### Batch 03 - Audit Standards And Report Templates

Status: pending.

Produces one or more scoped template/standard artifacts, with final paths chosen before the batch starts.

Candidate artifacts:

- `templates/site-audit/audit-report-template.md`
- `templates/site-audit/audit-plan-template.md`
- `templates/site-audit/finding-template.md`
- `docs/site-audit/reporting-standard.md`

Acceptance criteria:

- templates encode severity, evidence, affected path, user impact, source basis, safe-boundary notes, and recommended follow-up;
- templates include sections for all audit dimensions without forcing irrelevant findings;
- templates distinguish automated evidence from human/browser judgment;
- templates include stop-condition reporting;
- templates do not require screenshots, raw HAR, credentials, real personal data, or form submissions by default.

### Batch 04 - Agentic Audit Design

Status: pending.

Produces:

- design documentation for how a Code Agent or AI orchestrator uses the `site-audit` skill with existing browser-summary workflows;
- approval gates for route/profile selection, artifacts, model analysis, and higher-risk actions;
- validation handoff rules for future real browser profiles.

Candidate artifact:

- `docs/site-audit/agentic-audit-design.md`

Acceptance criteria:

- design reuses approved route/profile/sanitized-summary concepts from existing browser docs;
- no arbitrary browser commands or arbitrary URLs are introduced;
- no deploy/server/secrets actions are introduced;
- model analysis receives only sanitized summaries, acceptance criteria, and report schema unless separately approved;
- form, dialogue, auth, payment, admin, upload, and document-result flows remain approval-gated;
- stop conditions are concrete and aligned with `standards/codex-batch-execution-standard.md`.

### Batch 05 - Validation And Quality Gates

Status: pending.

Produces:

- a validation checklist or lightweight validator design for site-audit outputs;
- optional examples using synthetic or sanitized data only.

Candidate artifacts:

- `docs/site-audit/validation-gates.md`
- `examples/site-audit/sanitized-audit-report-example.md`

Acceptance criteria:

- validates that reports include scope, evidence, severity, affected paths, safe-boundary status, and stop conditions;
- checks that every finding has an evidence basis or is explicitly labeled as human judgment;
- checks that forbidden actions and artifacts are not required by the report;
- includes a contradiction check against existing Vibe Coding browser/E2E docs;
- uses only synthetic or sanitized examples.

### Batch 06 - Pilot Prompt

Status: pending.

Produces:

- a reusable prompt for a first safe public site audit pilot;
- optional response/report template binding for the pilot.

Candidate artifact:

- `prompts/series/site-audit-skill/pilot-public-site-audit-prompt.md`

Acceptance criteria:

- pilot prompt is universal and can target any approved public no-auth site scope;
- prompt cites `skills/site-audit/SKILL.md`, `docs/site-audit/research-basis.md`, and relevant templates;
- prompt explicitly forbids deploy/server/secrets actions, product-code changes, dependency installation, and unapproved browser actions;
- prompt separates read-only audit, non-submit form inspection, and submit/auth/payment/admin actions requiring explicit approval;
- prompt includes checks and final report requirements compatible with Codex batch execution.

## Dependencies Between Batches

| Batch | Depends On | Produces For Later Batches |
|---|---|---|
| 01 | Existing standards, skills, browser/E2E docs, verified external sources | Research basis and Charter used by all later batches |
| 02 | Batch 01 research basis and Charter; `skill-writing-standard` | The `site-audit` skill consumed by templates, design, validation, and pilot prompt |
| 03 | Batch 02 skill and Batch 01 research basis | Report and planning templates consumed by agentic design, validation, and pilot prompt |
| 04 | Batches 01-03; existing browser/E2E docs | Agentic workflow design and approval gates consumed by validation and pilot prompt |
| 05 | Batches 01-04 | Quality gates and examples consumed by pilot prompt and future audits |
| 06 | Batches 01-05 | First reusable pilot prompt for safe public no-auth audits |

Sequential dependencies:

- Batch 02 must not start until Batch 01 files exist.
- Batch 03 must not define templates before the skill workflow exists.
- Batch 04 must not expand browser actions beyond existing approval gates.
- Batch 05 must validate against the actual skill/templates, not this Charter alone.
- Batch 06 must consume the completed skill, templates, design, and validation gates.

Parallelizable work after Batch 02:

- Template drafting and agentic design can be prepared in parallel only if they do not write the same files and both cite the same Batch 02 skill version.
- Validation examples can be drafted from synthetic data while templates are being finalized, but final validation gates must reconcile with the final template paths.

## Invariants Across The Series

- Universal scope: artifacts must apply across Vibe Coding product repositories and must not encode YurAssistent-specific methodology.
- Safety first: no deploy, server, SSH, SCP, secrets, production config, database, auth, payment, or PII action is authorized by this series.
- Scope discipline: each batch edits only its declared files and sections.
- Browser discipline: no arbitrary URLs, arbitrary browser commands, unrestricted crawling, screenshots, videos, traces, raw HAR, cookies, auth headers, raw request/response bodies, or private URLs by default.
- Submission boundary: read-only audit, non-submit form inspection, and submit/action flows are separate categories. Submit/auth/payment/admin/account/destructive/upload actions require separate explicit approval.
- Evidence discipline: findings require evidence, a named judgment basis, or an explicit unknown with a next step. No unsupported claims.
- Severity discipline: severity is based on user impact, safety risk, conversion impact, accessibility impact, and reversibility, not personal taste.
- People-first content: SEO and AEO/GEO recommendations must improve user clarity and trust. Manipulative search optimization is forbidden.
- Existing-system alignment: new artifacts must reuse existing browser-summary, sanitized-summary, approval-gate, and stop-condition concepts.
- No Claude Routines: this series is executed through Codex batch execution unless a future prompt explicitly says otherwise and receives approval.

## Handoff Rules

### Research To Skill

Batch 02 consumes `docs/site-audit/research-basis.md` and this Charter. It must translate the research into activation triggers, workflow phases, safety boundaries, anti-patterns, and output requirements.

The skill must not duplicate every paragraph of the research basis. It must encode the operational behavior that a model applies when the trigger fires.

### Skill To Templates

Templates in Batch 03 must reflect the skill's workflow and required outputs. If the skill defines severity fields, evidence fields, or stop-condition fields, the templates must use the same names.

If Batch 03 discovers a missing required output in the skill, it must stop or update the skill in scope only if the batch explicitly allows it. Silent divergence between skill and templates is a stop condition.

### Templates To Agentic Audit Design

Batch 04 uses the templates as the report contract. The agentic design must explain how approved browser summaries, manual observations, model analysis, and human review populate those template fields.

The design must not create new report fields that bypass the templates unless it records the change and updates the template in the same scoped batch.

### Agentic Audit Design To Validation

Batch 05 validates the actual workflow shape from Batch 04. Validation gates must check both content quality and safety compliance:

- scope stated;
- approved route/profile stated where browser evidence is used;
- sanitized artifact policy stated;
- forbidden actions absent;
- evidence and severity present;
- stop conditions reported.

### Validation To Pilot Prompt

Batch 06 writes the pilot prompt only after validation gates exist. The pilot prompt must require the final report to pass those gates.

If the pilot needs browser automation beyond safe public no-auth observation, Batch 06 must stop and ask for separate approval instead of expanding scope.

## Expected Final Repository Artifacts

Expected final artifacts after the full series:

- `docs/site-audit/research-basis.md`
- `docs/site-audit/series-charter.md`
- `skills/site-audit/SKILL.md`
- `docs/site-audit/reporting-standard.md` or equivalent scoped standard
- `docs/site-audit/agentic-audit-design.md`
- `docs/site-audit/validation-gates.md`
- `templates/site-audit/audit-plan-template.md`
- `templates/site-audit/audit-report-template.md`
- `templates/site-audit/finding-template.md`
- `examples/site-audit/sanitized-audit-report-example.md` if synthetic examples are approved in Batch 05
- `prompts/series/site-audit-skill/pilot-public-site-audit-prompt.md`

The final artifact list may be narrowed by later batches if a candidate file is unnecessary. It must not be expanded into browser automation, product repository changes, deployment, server, or secrets work without a new explicit prompt and approval.

## Series-Level Definition Of Done

The series is complete when:

- the `site-audit` skill exists and passes skill-writing review;
- templates and validation gates exist and align with the skill;
- agentic audit design aligns with existing Vibe Coding browser/E2E safety docs;
- the pilot prompt can run a safe public no-auth site audit without relying on Claude Routines, deploy/server/secrets actions, unapproved browser actions, or product-specific methodology;
- all final artifacts are universal, internally consistent, and checked with `git diff --check`.
