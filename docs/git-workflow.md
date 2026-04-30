# Git Workflow

## Current Bootstrap Mode

- Direct push to `main` is allowed only for low-risk workspace setup tasks.
- Codex may commit and push only when changed files match the explicit task scope.
- An explicit user prompt is pre-approval for low-risk repository actions required by that prompt, including `git add`, `git commit`, and `git push`, when changed files match the expected scope.
- Standards, skills, architecture, production, and secrets-related changes require explicit approval before push.
- Separate confirmation is still required for destructive actions, sensitive data transmission, secrets or credentials, production-impacting actions, out-of-scope changes, or actions blocked by the runtime safety policy.

## Target Mode

- `main` is protected.
- Changes go through branches and pull requests.
- Required checks pass before merge.
- No force push to `main`.
- Deployment happens only from `main`.

## Transition Trigger

Enable branch protection after the first successful product-repo test cycle.
