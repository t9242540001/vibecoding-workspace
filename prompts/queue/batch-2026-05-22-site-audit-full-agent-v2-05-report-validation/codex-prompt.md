# Prompt 05 - Site Audit Full Agent V2 Report, Validation And Prompt Package

## CONTEXT

Repository: `t9242540001/vibecoding-workspace`

This is Batch 05 of the `site-audit-full-agent-v2` series.

Batches 01-04 should already define the full audit target, skill modes, live/browser/interactive evidence contract, and marketing/AI/agentic readiness standard.

This batch updates the report template, validation gates, prompt package, and synthetic example so a full audit produces a complete bilingual `.md` report and validates all full-audit dimensions.

This batch updates methodology only. Do not run a product audit.

## REQUIRED READS

Read before editing:

1. `AGENTS.md`
2. `workspace-index.md`
3. `docs/site-audit/full-agent-v2-research-basis.md`
4. `docs/site-audit/full-agent-v2-charter.md`
5. `skills/site-audit/SKILL.md`
6. `docs/site-audit/agentic-audit-pipeline.md`
7. `docs/site-audit/live-browser-interactive-audit-contract.md`
8. `docs/site-audit/marketing-ai-agentic-readiness-standard.md`
9. `templates/site-audit/marketing-ai-agentic-checklist.md`
10. `templates/site-audit/report-template.md`
11. `templates/site-audit/codex-live-audit-prompt-template.md`
12. `prompts/series/site-audit-skill/pilot-public-site-audit-prompt.md`
13. `docs/site-audit/validation-gates.md`
14. `examples/site-audit/sanitized-audit-report-example.md`
15. `templates/site-audit/finding-taxonomy.md`
16. `configs/site-audit-default-scope.json`
17. `configs/site-audit-severity-taxonomy.json`

Use `rg "Краткий отчёт|Все найденные замечания|English Technical Section|marketing|agentic|browser|interactive|validation|report" docs skills templates configs prompts examples workspace-index.md` before editing.

## TASK

Update:

1. `templates/site-audit/report-template.md`
2. `templates/site-audit/codex-live-audit-prompt-template.md`
3. `prompts/series/site-audit-skill/pilot-public-site-audit-prompt.md`
4. `docs/site-audit/validation-gates.md`
5. `examples/site-audit/sanitized-audit-report-example.md`
6. `workspace-index.md` only if needed

## REPORT TEMPLATE REQUIREMENTS

The standard site audit report must remain a `.md` file and must include these top-level sections:

1. `# [Project] Site Audit Report`
2. `## 1. Краткий отчёт для руководителя`
   - Russian.
   - Short, simple wording.
   - Must include what was checked, what was not checked, main result, highest risks, evidence limitations, and top next actions.
3. `## 2. Все найденные замечания`
   - Russian.
   - Complete list of every finding, not only top findings.
   - Each item must include ID, severity, short problem, where found, why it matters, what to do next, and status.
4. `## 3. Метод и ограничения проверки`
   - Russian.
   - Must include audit layers enabled, audit layers unavailable, test data/accounts used or missing, live/browser/interactive evidence limitations, stop conditions.
5. `## 4. Marketing, Sales, Target Audience And AI/Agentic Readiness`
   - Russian short interpretation plus English technical details if useful.
   - Must include target-audience usefulness, marketing/sales effectiveness, SEO/AEO/GEO, AI-friendliness, and agentic-commerce readiness findings or explicit not-tested reasons.
6. `## 5. English Technical Section`
   - English.
   - Detailed Code Agent/developer section.
   - Must include evidence inventory, technical findings table, file paths/routes/selectors/artifacts, observed evidence, inferred risks, unknowns, recommended fix direction, acceptance criteria, and suggested next batches.
7. `## 6. Safety / Boundary Notes`
   - Must explicitly state product code was not changed, sensitive data was not disclosed, and any sensitive data encountered is anonymized.
8. `## 7. Next Fix Batches`
   - Recommended next batches in priority order.

## VALIDATION REQUIREMENTS

`docs/site-audit/validation-gates.md` must validate:

- all required bilingual report sections exist;
- all findings are included;
- Russian decision-maker sections are short and simple;
- English technical section is detailed enough for Code Agent execution;
- full audit layers are either executed or explicitly marked unavailable with reason;
- marketing/sales/target-audience and AI/agentic-commerce readiness are covered or explicitly marked not tested;
- no product modifications were performed during audit;
- sensitive data is not disclosed and any exposure is anonymized;
- screenshots/artifacts are either approved and safe or absent with reason.

## PROMPT PACKAGE REQUIREMENTS

The live audit prompt templates must instruct Code Agent to:

- run full audit layers listed in the scope;
- use synthetic data and test accounts when provided;
- collect approved browser/interactive evidence;
- not modify product code or production configuration;
- anonymize sensitive material;
- produce the full bilingual `.md` report;
- include marketing/sales/target-audience and AI/agentic-commerce findings.

## EXAMPLE REQUIREMENTS

`examples/site-audit/sanitized-audit-report-example.md` must remain synthetic and must demonstrate:

- Russian decision-maker summary;
- all findings list;
- method and limitations;
- marketing/sales/target-audience/AI-agentic section;
- English technical section;
- safety notes;
- next fix batches;
- anonymized sensitive-data example if appropriate, without real values.

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
- Do not weaken no-product-modification or sensitive-data anonymization rules.
- Keep edits limited to listed files and batch queue files.

## CHECKS

Run:

- `python3 -m json.tool configs/site-audit-default-scope.json >/dev/null`
- `python3 -m json.tool configs/site-audit-severity-taxonomy.json >/dev/null`
- `git diff --check`
- `rg "Краткий отчёт для руководителя|Все найденные замечания|English Technical Section|AI/Agentic|agentic-commerce|sensitive data|Next Fix Batches" templates docs prompts examples skills configs workspace-index.md`

## ACCEPTANCE CRITERIA

- [ ] Report template enforces full bilingual `.md` report.
- [ ] Validation gates check full-audit and bilingual report structure.
- [ ] Prompt templates instruct full audit and no product modification.
- [ ] Example report follows the new structure and remains synthetic.
- [ ] Marketing/sales/target-audience and AI/agentic-commerce sections are mandatory or explicitly not-tested.
- [ ] JSON configs remain valid.
- [ ] No product repo/audit/code changes occurred.
- [ ] `git diff --check` passes.

## FINAL OUTPUT

Print:

- changed files
- files inspected
- checks run
- whether Batch 06 can proceed
- blockers or contradictions
