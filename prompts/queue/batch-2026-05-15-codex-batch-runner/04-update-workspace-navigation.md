# Prompt 04 — Update workspace navigation

## CONTEXT
Project: vibecoding-workspace
Repository: github.com/t9242540001/vibecoding-workspace
Affected files:
- workspace-index.md

Current state:
`workspace-index.md` lists active standards, docs, scripts, templates, and trigger logic. It currently identifies `standards/batch-execution-standard.md` and the Routine launcher as active batch infrastructure, but does not yet list the new Codex-specific batch standard or isolated runner setup guide.

## TASK
Update only `workspace-index.md` so navigation reflects the new Codex batch execution layer.

Required changes:
1. Add `standards/codex-batch-execution-standard.md` to Active standards files.
2. Add `docs/codex-isolated-runner-setup.md` to Active tools, rules, and docs.
3. Clarify in the Active templates or Active batch execution sections that `templates/batch-execution/`, `scripts/routine.sh`, `scripts/trigger-batch.sh`, `docs/batch-execution-guide.md`, and `docs/routine-launcher-setup.md` are Claude Routine-specific unless explicitly generalized later.
4. Add a Skill Triggering Logic row for composing/running Codex prompt batches via Codex: use `standards/codex-batch-execution-standard.md` and `docs/codex-isolated-runner-setup.md`.
5. Preserve existing Claude Routine trigger rows; do not delete them.

## REGRESSION SHIELD — DO NOT TOUCH
Files not to modify:
- standards/**
- docs/**
- scripts/**
- templates/**
- skills/**
- README.md

Within workspace-index.md:
- Do not rewrite the whole file.
- Do not change unrelated project status, browser/E2E status, skills migration status, or open decisions.
- Do not delete existing Claude Routine references; clarify them only where directly relevant.
- Do not update unrelated dates or sections.

Critical rules for this project:
- RULE: Navigation must separate Codex batch execution from Claude Routine execution.
- RULE: Existing navigation content is preserved unless directly in scope.

## ACCEPTANCE CRITERIA
[ ] `standards/codex-batch-execution-standard.md` listed under active standards.
[ ] `docs/codex-isolated-runner-setup.md` listed under active docs.
[ ] Claude Routine-specific infrastructure is clearly labeled as such.
[ ] Codex batch trigger logic row added.
[ ] Existing Claude Routine trigger rows preserved.
[ ] No other files were modified.
[ ] Code Agent reports changed sections and confirms scope was respected.
