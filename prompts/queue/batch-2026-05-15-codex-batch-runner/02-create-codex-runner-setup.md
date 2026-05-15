# Prompt 02 — Create Codex runner setup

## CONTEXT
Project: vibecoding-workspace
Repository: github.com/t9242540001/vibecoding-workspace
Affected files:
- docs/codex-isolated-runner-setup.md

Current state:
Codex can run batches manually in the main Windows environment, but approval prompts interrupt execution. Local investigation found no safe repo-scoped allowlist; available mechanisms are global prefix rules or global approval bypass. The safe long-term solution is an isolated runner/container/VM where Codex can use `--ask-for-approval never` because the outer environment limits writes and access to the intended repository.

## TASK
Create `docs/codex-isolated-runner-setup.md` as a practical setup guide for running Codex batches with fewer or no approval prompts safely.

The guide must cover:

1. Purpose: why isolated runner exists.
2. Recommended options:
   - WSL dedicated workspace.
   - Dev container / Docker container.
   - VM or dedicated local runner.
3. Minimal safety requirements:
   - one repo mounted/writable;
   - no SSH keys or unrelated secrets mounted;
   - network restricted when possible;
   - no access to unrelated local folders;
   - clean git identity and token handling;
   - no `danger-full-access` on the host OS.
4. Suggested Codex launch patterns:
   - main machine safe interactive mode: `--sandbox workspace-write --ask-for-approval on-request`.
   - isolated runner autonomous mode: `--sandbox workspace-write --ask-for-approval never`.
5. What not to do:
   - do not run bypass approvals on main Windows with broad filesystem access;
   - do not store secrets in repo;
   - do not create global allow-rules for broad commands such as `git`, `python`, `npm`, `uv` if they are not repo-scoped.
6. Operational checklist before batch run.
7. Rollback / cleanup guidance.
8. Link back to `standards/codex-batch-execution-standard.md`.
9. Changelog.

Keep it concise and practical. Do not include real local secrets or tokens. Use placeholders only.

## REGRESSION SHIELD — DO NOT TOUCH
Files not to modify:
- standards/**
- scripts/**
- templates/**
- skills/**
- README.md
- workspace-index.md
- docs/codex-workflow.md
- docs/routine-launcher-setup.md
- docs/batch-execution-guide.md

Within the new file:
- Do not claim a tested container image exists unless you create it in a later prompt.
- Do not prescribe destructive cleanup commands.
- Do not add private machine-specific absolute paths except as generic examples.
- Do not recommend exposing SSH keys or production secrets to the runner.

Critical rules for this project:
- RULE: Full autonomy is allowed only when the environment boundary is safe.
- RULE: Secrets are never committed and should not be mounted into broad agent environments.
- RULE: This guide is for Codex, not Claude Routines.

## ACCEPTANCE CRITERIA
[ ] `docs/codex-isolated-runner-setup.md` created.
[ ] It explains why the isolated runner is needed.
[ ] It gives safe interactive and isolated autonomous Codex launch patterns.
[ ] It explicitly forbids approval bypass on the main Windows host.
[ ] It includes pre-run checklist and rollback/cleanup guidance.
[ ] It links to `standards/codex-batch-execution-standard.md`.
[ ] No existing files were modified.
[ ] Code Agent reports the created file path and confirms scope was respected.
