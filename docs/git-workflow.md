# Git Workflow

## Current Bootstrap Mode

- Direct push to `main` is allowed only for low-risk workspace setup tasks.
- Codex may commit and push only when changed files match the explicit task scope.
- Standards, skills, architecture, production, and secrets-related changes require explicit approval before push.

## Target Mode

- `main` is protected.
- Changes go through branches and pull requests.
- Required checks pass before merge.
- No force push to `main`.
- Deployment happens only from `main`.

## Transition Trigger

Enable branch protection after the first successful product-repo test cycle.
