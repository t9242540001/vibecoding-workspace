# Prompt 02 - Create Universal Site Audit Skill And Templates

## CONTEXT

Repository: `t9242540001/vibecoding-workspace`

This is Batch 02 of the universal `site-audit` skill series.

Batch 01 must already have created:

- `docs/site-audit/research-basis.md`
- `docs/site-audit/series-charter.md`

This batch must create the reusable skill and templates that future website audits will use. It must stay universal and not become YurAssistent-specific.

## REQUIRED READS

Read before editing:

1. `AGENTS.md`
2. `workspace-index.md`
3. `docs/site-audit/research-basis.md`
4. `docs/site-audit/series-charter.md`
5. `skills/skill-writing-standard/SKILL.md`
6. `skills/prompt-writing-standard/SKILL.md`
7. `skills/research-protocol/SKILL.md`
8. `skills/series-design-discipline/SKILL.md`
9. `skills/knowledge-structure/SKILL.md`
10. Existing skill files enough to match house style:
    - `skills/bug-hunting/SKILL.md`
    - `skills/real-path-verification/SKILL.md`
    - `skills/forward-thinking-discipline/SKILL.md`
    - `skills/universality-discipline/SKILL.md`

Use `rg "site-audit|website audit|browser"` to check for naming conflicts before creating files.

## TASK

Create a universal website audit skill and reusable templates.

Create:

1. `skills/site-audit/SKILL.md`
2. `templates/site-audit/audit-scope-template.md`
3. `templates/site-audit/report-template.md`
4. `templates/site-audit/finding-taxonomy.md`
5. `templates/site-audit/codex-live-audit-prompt-template.md`

Update:

6. `workspace-index.md`

Only update `workspace-index.md` in the minimal places needed:
- active skills list/table
- trigger map
- active templates list if applicable

## SKILL REQUIREMENTS

`skills/site-audit/SKILL.md` must follow `skill-writing-standard`.

The skill must include:

1. YAML frontmatter:
   - `name: site-audit`
   - description with accurate activation triggers

2. File header:
   - `@file`
   - `@description`
   - `@version: 1.0`
   - `@updated: 2026-05-22`

3. Philosophy:
   - website audit is a repeatable evidence-based process, not casual opinion
   - universal first, product-specific later
   - safe audit corridor before live submit/auth/payment/admin actions

4. Activation triggers:
   - requests to audit, review, inspect, test, or improve a website/front-end/UI
   - requests for SEO/AEO/GEO/readability/accessibility/performance/form audit
   - requests to prepare live browser audit prompts
   - requests to create website audit reports

5. Non-triggers:
   - pure backend architecture audits
   - generic marketing strategy without website review
   - one-off copy rewrite unless framed as website audit
   - production deployment/debugging unless the issue is public UI audit evidence

6. Audit modes:
   - static repository audit
   - read-only live public audit
   - non-submit form/tool audit
   - approved submit/auth/payment/admin audit
   - post-fix regression audit

7. Audit dimensions:
   - technical frontend health
   - UX/usability
   - accessibility
   - responsive/mobile
   - forms/tools
   - SEO
   - AEO/GEO/AI-friendly content
   - copy/grammar/trust/legal-risk wording
   - design/visual consistency
   - analytics/conversion
   - public UI security/privacy

8. Evidence rules:
   - every finding must have location, evidence, impact, severity, recommendation
   - separate observed facts from inferred risk
   - no fabricated browser evidence
   - screenshots/logs only when actually captured

9. Severity taxonomy:
   - Critical
   - High
   - Medium
   - Low
   - Observation
   with clear definitions.

10. Safety boundaries:
   - no production-changing actions without explicit approval
   - no real personal data
   - no payments
   - no auth/admin unless approved
   - no secrets/deploy/server/database actions
   - no hidden destructive actions

11. Workflow:
   - scope gate
   - source/context read
   - audit plan
   - execution
   - report
   - fix prompt planning
   - regression check

12. Connections to other skills:
   - `research-protocol`
   - `prompt-writing-standard`
   - `series-design-discipline`
   - `knowledge-structure`
   - `code-markup-standard`
   - `real-path-verification`
   - `forward-thinking-discipline`
   - `anti-hedging-language`

13. Anti-patterns:
   - generic checklist without evidence
   - mixing read-only audit with submit/payment/admin actions
   - treating Lighthouse as complete UX/accessibility audit
   - SEO spam / manipulative AI-search tactics
   - product-specific assumptions in universal skill
   - changing code during audit without a separate fix task

14. Quick reference.

## TEMPLATE REQUIREMENTS

### `templates/site-audit/audit-scope-template.md`

Must help define:

- target site/project
- audit mode
- allowed actions
- forbidden actions
- routes/pages
- devices/viewports
- forms/tools
- required outputs
- approval gates

### `templates/site-audit/report-template.md`

Must include a structured audit report format:

- summary
- scope
- method
- evidence
- findings table
- severity definitions
- prioritized recommendations
- out-of-scope items
- next fix prompts

### `templates/site-audit/finding-taxonomy.md`

Must define:

- finding categories
- severity levels
- evidence requirements
- common examples
- how to avoid duplicates
- when to escalate to separate specialist review

### `templates/site-audit/codex-live-audit-prompt-template.md`

Must be a reusable Code Agent prompt template for future live website audit batches.

It must include placeholders for:

- project
- URL
- repo
- audit mode
- allowed actions
- forbidden actions
- pages/routes
- tools/forms
- report path
- checks
- final output

It must explicitly forbid:
- production form submit unless approved
- auth/admin/payment unless approved
- real personal data
- secrets/deploy/server/database actions

## REGRESSION SHIELD - DO NOT TOUCH

- Do not modify product repositories.
- Do not modify application code.
- Do not modify deploy/server/secrets.
- Do not install dependencies.
- Do not run browser automation.
- Do not touch `_local/`.
- Do not use Claude Routines.
- Do not create a YurAssistent-specific audit.
- Do not rewrite unrelated parts of `workspace-index.md`.
- Keep changes limited to the listed files and batch queue files.

## CHECKS

Run:

- `git status --short --branch`
- `git diff --check`
- `rg "site-audit" workspace-index.md skills templates docs` after edits

## ACCEPTANCE CRITERIA

- [ ] `skills/site-audit/SKILL.md` exists and follows `skill-writing-standard`.
- [ ] The skill is universal, not YurAssistent-specific.
- [ ] The skill covers all required audit dimensions.
- [ ] The skill defines safe audit modes and approval gates.
- [ ] Templates exist and are reusable.
- [ ] `workspace-index.md` references the new skill and templates with minimal edits only.
- [ ] No unrelated files changed.
- [ ] `git diff --check` passes.

## FINAL OUTPUT

Print:

- changed files
- files inspected
- checks run
- whether Batch 03 can proceed
- any decisions or blockers
