# Prompt 01 — Create trusted wrapper

## CONTEXT
Project: vibecoding-workspace
Repository: github.com/t9242540001/vibecoding-workspace
Affected files:
- scripts/codex-trusted-checkpoint.sh

Current state:
Codex batch execution works inside a hardened WSL runner, but `git add`, `git commit`, and `git push` are currently completed manually outside the Codex sandbox. The standard now allows a trusted wrapper or human to own the git checkpoint after Codex produces verified repo-local changes. To reach a fully automatic prompt-series system for low-risk repo-local batches, we need a trusted wrapper that performs conservative validation and then creates/pushes the git checkpoint.

## TASK
Create `scripts/codex-trusted-checkpoint.sh`.

The wrapper must be a Bash script for the hardened WSL runner repo. It should perform these checks before staging or committing:

1. Confirm it is run inside a Git work tree.
2. Confirm there are changes to commit.
3. Require a batch id argument and a commit message argument.
4. Run `git diff --check` and stop on failure.
5. Reject changes to high-risk paths unless explicitly allowed later by future extension. For now reject if any changed path matches:
   - `.env` or `.env.*`
   - `.ssh/`
   - `secrets/`
   - paths containing `secret`, `token`, `credential`, or `password` case-insensitively
   - production deploy scripts or server scripts if such path contains `deploy`, `server`, `ssh`, or `scp`
6. Reject deleted files by default unless an optional flag `--allow-deletes` is provided.
7. Stage only changed files reported by Git, not untracked files outside the repo.
8. Commit with message format:
   `[batch:<batch_id>] <commit message>`
9. Push to the current branch with `git push origin HEAD`.
10. Print a final report: changed files, commit sha, push status.

The script should support:

```
scripts/codex-trusted-checkpoint.sh <batch_id> <message>
scripts/codex-trusted-checkpoint.sh --allow-deletes <batch_id> <message>
```

Keep it conservative. If uncertain, stop with a clear error message.

## REGRESSION SHIELD — DO NOT TOUCH
Files not to modify:
- standards/**
- docs/**
- templates/**
- skills/**
- README.md
- workspace-index.md
- scripts/routine.sh
- scripts/trigger-batch.sh

Within the new file:
- Do not add support for force push.
- Do not add support for deploy, SSH, SCP, server commands, or secret access.
- Do not silently commit untracked files unless they appear in `git status --porcelain` inside the repo and pass the path safety checks.
- Do not bypass failed checks.

Critical rules for this project:
- RULE: The trusted wrapper exists to reduce manual friction, not to bypass safety.
- RULE: Secrets and production access must remain outside automatic low-risk batch commits.
- RULE: GitHub remains source of truth after push.

## ACCEPTANCE CRITERIA
[ ] `scripts/codex-trusted-checkpoint.sh` created and executable.
[ ] Script validates Git work tree and non-empty changes.
[ ] Script runs `git diff --check` before staging.
[ ] Script blocks high-risk paths.
[ ] Script blocks deletions unless `--allow-deletes` is provided.
[ ] Script commits with `[batch:<batch_id>]` prefix.
[ ] Script pushes with `git push origin HEAD`.
[ ] Script prints changed files, commit sha, and push status.
[ ] No existing files modified.
[ ] Code Agent reports created file and confirms scope was respected.
