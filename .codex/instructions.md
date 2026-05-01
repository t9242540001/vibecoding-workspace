# Codex Instructions

## Before Work

- Run `git status --short`.
- If git is unavailable, report it and stop.

## Before Edits

- Inspect relevant files before changing them.

## During Work

- Edit only affected files.
- Keep changes inside the explicit task scope.
- `_local/` is local-only. Ignore it by default. Use it only when the prompt explicitly names a file inside `_local/`.

## After Work

- Run `git status --short`.
- Report changed files.

## Commit And Push

- Follow `docs/git-workflow.md`.
- Treat an explicit user prompt as pre-approval for low-risk repository actions required by that prompt when changed files match expected scope.
- For low-risk workspace tasks, commit and push if changed files match expected scope.
- For standards, skills, or architecture changes, do not push unless explicitly instructed.
