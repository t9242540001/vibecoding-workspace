# Prompt 01 — Create Codex batch standard

## CONTEXT
Project: vibecoding-workspace
Repository: github.com/t9242540001/vibecoding-workspace
Affected files:
- standards/codex-batch-execution-standard.md

Current state:
The workspace has `standards/batch-execution-standard.md`, but that file is historically Claude Code Routine-specific. The current operational need is Codex/GPT batch execution: a Codex session reads a manifest and prompt queue, executes prompts sequentially, commits after each step, stops on critical failure, and reports. The Codex permission model discovered during the previous run has no safe repo-scoped allowlist; therefore full autonomy without approvals should happen only inside an isolated runner/container/VM where the outer environment limits access to the intended repository.

## TASK
Create a new Codex-specific standard at `standards/codex-batch-execution-standard.md`.

The new file must define the Codex-native batch execution model without modifying the Claude Routine standard. Include these sections:

1. Purpose and relationship to existing standards.
2. Codex batch architecture:
   Vasily -> AI orchestrator -> Codex -> prompt queue -> per-prompt commit -> push -> GitHub verification/report.
3. What a Codex batch is: manifest + ordered prompt files under `prompts/queue/{batch_id}/`.
4. Execution modes:
   - Interactive manual Codex batch on the main machine with approvals.
   - Isolated runner mode for autonomy without approval prompts.
5. Approval policy:
   - Do not use `danger-full-access` or bypass approvals on the main Windows environment.
   - `--ask-for-approval never` is allowed only inside isolated repo-scoped runner/container/VM.
   - `--sandbox workspace-write` is the default safe sandbox for Codex work.
6. Safe corridor:
   repo-local file edits, repo-local tests/build/lint, git status/diff/add/commit/push to normal branches, no secrets, no destructive operations outside repo.
7. Stop conditions:
   scope drift, secret exposure, destructive command, network access not required by task, writes outside repo, auth/payments/PII/production config without explicit approval, failed verification outside prompt scope.
8. Per-prompt loop:
   read manifest, read prompt, read affected files, apply regression shield, edit only declared scope, run verification, commit, continue or stop.
9. Reporting requirements:
   changed files, commits, checks, stop conditions, final status.
10. Relationship to Claude Routine-specific files:
   `standards/batch-execution-standard.md`, `docs/batch-execution-guide.md`, `docs/routine-launcher-setup.md`, `scripts/routine.sh`, and `scripts/trigger-batch.sh` are Claude Routine-specific unless explicitly generalized later.
11. Changelog.

The file must be concise and operational. Do not copy the entire Claude Routine standard. This is a separate Codex-specific layer.

## REGRESSION SHIELD — DO NOT TOUCH
Files not to modify:
- standards/batch-execution-standard.md
- standards/VIBECODER_STANDARDS.md
- docs/**
- scripts/**
- templates/**
- skills/**
- README.md
- workspace-index.md

Within the new file:
- Do not claim Codex has repo-scoped allowlist if it does not.
- Do not recommend `danger-full-access` on the main Windows environment.
- Do not include secrets, tokens, local private paths beyond generic examples.
- Do not create implementation scripts in this prompt.

Critical rules for this project:
- RULE: Codex and Claude Routine mechanisms must be clearly separated to avoid routing mistakes.
- RULE: Automation removes manual waiting, not verification.
- RULE: Full autonomy without approval prompts requires an external isolation boundary.

## ACCEPTANCE CRITERIA
[ ] `standards/codex-batch-execution-standard.md` created.
[ ] It clearly separates Codex batch execution from Claude Routine execution.
[ ] It documents interactive mode and isolated runner mode.
[ ] It states that `--ask-for-approval never` is only acceptable inside an isolated repo-scoped environment.
[ ] It explicitly discourages `danger-full-access` / bypass approvals on the main Windows environment.
[ ] It defines safe corridor and stop conditions.
[ ] It defines per-prompt execution loop and reporting requirements.
[ ] It includes a changelog entry.
[ ] No existing files were modified.
[ ] Code Agent reports the created file path and confirms scope was respected.
