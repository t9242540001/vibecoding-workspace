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
- Treat D as the working disk. Keep active Codex/Vibe Coding work in WSL under `/home/redmi/codex-runners`, backed by `D:\Vibecoding\WSL\Ubuntu`; do not create new heavy working files, clones, generated artifacts, caches, exports, or batch outputs on C.
- Existing Codex Desktop support folders and tiny launcher scripts on C are allowed to remain unless the user explicitly requests and approves a separate storage migration.
- For long-running batches or autonomous repo-local work, prefer the repo-scoped project runner per `docs/codex-autonomous-runner-policy.md` and `docs/codex-runner-operator-guide.md` instead of repeated Desktop approval prompts.
- Ask again before deletes, destructive Git operations, outside-repo access, secrets/credentials, production/deploy/server/database/auth/payment/PII actions, or force push/history rewrite.

## After Work

- Run `git status --short`.
- Report changed files.

## Commit And Push

- Follow `docs/git-workflow.md`.
- Treat an explicit user prompt as pre-approval for low-risk repository actions required by that prompt when changed files match expected scope.
- For low-risk workspace tasks, commit and push if changed files match expected scope.
- For standards, skills, or architecture changes, do not push unless explicitly instructed.
