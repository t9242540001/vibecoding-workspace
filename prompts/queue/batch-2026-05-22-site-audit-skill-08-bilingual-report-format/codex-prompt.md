# Prompt 08 - Site Audit Bilingual Report Format

## CONTEXT

Repository: `t9242540001/vibecoding-workspace`

The `site-audit` system is ready for product pilots, but the user clarified a required report format before continuing with fixes:

After every site audit, the output must be a full `.md` report that contains:

1. A Russian section for the decision-maker: complete list of all findings, short, simple wording.
2. A separate English technical section for Code Agent / developer execution: precise technical details, file paths, evidence, and suggested fix direction.

This batch updates the universal site-audit system so future audits consistently produce that report shape.

This is a documentation/template/prompt-format update only. Do not run a product audit.

## REQUIRED READS

Read before editing:

1. `AGENTS.md`
2. `workspace-index.md`
3. `skills/site-audit/SKILL.md`
4. `templates/site-audit/report-template.md`
5. `templates/site-audit/finding-taxonomy.md`
6. `templates/site-audit/codex-live-audit-prompt-template.md`
7. `docs/site-audit/validation-gates.md`
8. `docs/site-audit/agentic-audit-pipeline.md`
9. `prompts/series/site-audit-skill/pilot-public-site-audit-prompt.md`
10. `examples/site-audit/sanitized-audit-report-example.md`
11. `docs/site-audit/system-consistency-review.md`

Use `rg "Summary|Findings|Technical|Russian|English|site-audit|report" skills templates docs prompts examples workspace-index.md` to inspect existing report format language before editing.

## TASK

Update the universal site-audit reporting contract to require bilingual reports.

Update:

1. `templates/site-audit/report-template.md`
2. `templates/site-audit/codex-live-audit-prompt-template.md`
3. `docs/site-audit/validation-gates.md`
4. `prompts/series/site-audit-skill/pilot-public-site-audit-prompt.md`
5. `examples/site-audit/sanitized-audit-report-example.md`
6. `skills/site-audit/SKILL.md` only if needed to make the rule discoverable at skill level
7. `workspace-index.md` only if needed

Create if useful:

8. `docs/site-audit/report-language-standard.md`

## REPORT FORMAT REQUIREMENTS

The standard report must be a `.md` file and must contain these top-level sections:

1. `# [Project] Site Audit Report`
2. `## 1. Краткий отчёт для руководителя`
   - Russian language.
   - Short, simple wording.
   - Must include audit result, highest risk, what was checked, what was not checked, and top priorities.
3. `## 2. Все найденные замечания`
   - Russian language.
   - Complete list of all findings, not only top five.
   - Each finding must include:
     - ID
     - severity in Russian or with English label in parentheses
     - short problem description
     - where found
     - why it matters
     - what to do next
   - Keep wording simple enough for Vasily as non-developer.
4. `## 3. Метод и ограничения проверки`
   - Russian language.
   - Must state audit mode, checked pages/files, skipped scope, unavailable evidence, and stop conditions.
5. `## 4. English Technical Section`
   - English language.
   - Detailed technical section for Code Agent/developers.
   - Must include evidence inventory, technical finding table, file paths/lines/routes, observed evidence, inferred risks, recommended fix direction, acceptance criteria, and follow-up prompt suggestions.
6. `## 5. Safety / Boundary Notes`
   - Can be English or bilingual, but must be explicit.
   - Must state forbidden actions were not performed.
7. `## 6. Next Fix Batches`
   - Must list recommended next fix batches in priority order.

## CONSISTENCY REQUIREMENTS

- Do not remove existing evidence requirements: location, evidence, impact, severity, recommendation, status.
- Do not weaken safety boundaries.
- Do not allow product-code edits during audit.
- Preserve severity taxonomy: Critical, High, Medium, Low, Observation.
- Preserve distinction between observed facts, inferred risks, and unknowns.
- Ensure validation gates require both Russian decision-maker sections and English technical section.
- Ensure prompt templates instruct Code Agent to produce the bilingual format.
- Ensure example report is synthetic only.

## REGRESSION SHIELD - DO NOT TOUCH

- Do not run a real audit.
- Do not modify product repositories.
- Do not modify application code.
- Do not modify deploy/server/secrets.
- Do not install dependencies.
- Do not run browser automation.
- Do not touch `_local/`.
- Do not use Claude Routines.
- Do not create YurAssistent-specific report content.
- Do not rewrite unrelated documentation.
- Keep edits limited to listed files and any new report-language standard file.

## CHECKS

Run:

- `python3 -m json.tool configs/site-audit-default-scope.json >/dev/null`
- `python3 -m json.tool configs/site-audit-severity-taxonomy.json >/dev/null`
- `rg "Краткий отчёт для руководителя|Все найденные замечания|English Technical Section|Next Fix Batches" templates docs skills prompts examples`
- `rg "Critical|High|Medium|Low|Observation" templates/site-audit docs/site-audit skills/site-audit prompts/series/site-audit-skill examples/site-audit`
- `git diff --check`

## ACCEPTANCE CRITERIA

- [ ] Report template requires Russian decision-maker sections and English technical section.
- [ ] Validation gates check for the bilingual report structure.
- [ ] Code Agent prompt templates require the bilingual structure.
- [ ] Example report follows the new structure and remains synthetic.
- [ ] Site-audit skill makes the report language rule discoverable if needed.
- [ ] No safety boundaries were weakened.
- [ ] No unrelated files changed.
- [ ] JSON configs remain valid.
- [ ] `git diff --check` passes.

## FINAL OUTPUT

Print:

- changed files
- files inspected
- checks run
- whether future site audits now require bilingual report format
- whether product pilot report conversion can proceed
