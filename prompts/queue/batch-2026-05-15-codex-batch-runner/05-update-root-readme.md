# Prompt 05 — Update root README

## CONTEXT
Project: vibecoding-workspace
Repository: github.com/t9242540001/vibecoding-workspace
Affected files:
- README.md

Current state:
The root README lists current standards, docs, templates, scripts, and batch infrastructure. It does not yet list the Codex-specific batch execution standard or isolated runner setup guide, and it still describes batch execution templates/scripts without clearly separating Codex from Claude Routine infrastructure.

## TASK
Update only `README.md` so the root overview reflects the new Codex batch execution layer.

Required changes:
1. Add `standards/codex-batch-execution-standard.md` under Core standards.
2. Add `docs/codex-isolated-runner-setup.md` under Tools, rules, and docs.
3. Clarify that `templates/batch-execution/`, `scripts/trigger-batch.sh`, and `scripts/routine.sh` are Claude Routine-specific unless explicitly generalized later.
4. Do not remove the existing Claude Routine references.
5. Do not change unrelated README content.

## REGRESSION SHIELD — DO NOT TOUCH
Files not to modify:
- standards/**
- docs/**
- scripts/**
- templates/**
- skills/**
- workspace-index.md

Within README.md:
- Do not rewrite the whole file.
- Do not change Purpose, Operating rule, migrated skills list, or unrelated docs list except for the single new Codex runner guide line.
- Do not rephrase existing paragraphs for style.

Critical rules for this project:
- RULE: Root README is navigation, not a full standard.
- RULE: Codex and Claude Routine batch paths must be visibly separated.

## ACCEPTANCE CRITERIA
[ ] `standards/codex-batch-execution-standard.md` listed under Core standards.
[ ] `docs/codex-isolated-runner-setup.md` listed under Tools, rules, and docs.
[ ] Claude Routine-specific scripts/templates are labeled as such.
[ ] Existing Claude Routine references preserved.
[ ] No other files were modified.
[ ] Code Agent reports changed sections and confirms scope was respected.
