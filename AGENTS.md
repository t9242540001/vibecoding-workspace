# Repository Agent Instructions

## Repository Role

This repository is the shared infrastructure workspace for Vibe Coding. It is not a product repository.

## Read Order

1. `workspace-index.md`
2. Relevant files in `standards/`
3. Relevant files in `skills/`
4. Affected files for the task

## Change Discipline

- Inspect before editing.
- Use `rg` where useful for search.
- Make the smallest correct change.
- Do not touch unrelated files.

## Scope Rule

- No style cleanup.
- No opportunistic refactors.
- No semantic changes outside the explicit task scope.

## Commit And Push Rule

Commit and push only when changed files match the explicit task scope.

## Prompt Approval Rule

For this repository, an explicit user prompt is pre-approval for low-risk repository actions that are required by that prompt and stay inside its declared scope, including `git add`, `git commit`, and `git push`.

Ask again only when an action is destructive, transmits sensitive data, changes secrets or credentials, touches production, exceeds the prompt scope, or is otherwise blocked by the runtime safety policy.

## Secrets Rule

Never commit secrets, `.env` files, tokens, credentials, or passwords.

## Source Of Truth

- Shared skills live in `skills/`.
- Shared standards live in `standards/`.
- Product-specific knowledge lives in product repositories.
