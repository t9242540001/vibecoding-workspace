# Codex Workflow

<!--
  @file:        docs/codex-workflow.md
  @description: Working loop for Codex-based repository changes and Codex batch execution
  @updated:     2026-05-24
-->

The working loop is:

Vasily -> ChatGPT orchestrator -> Codex / Code Agent -> GitHub -> ChatGPT verification.

Vasily provides the task and reviews outcomes. ChatGPT orchestrates scope and prompts. Codex or another Code Agent edits the repository. GitHub remains the source of truth. ChatGPT verifies the result against the requested scope.

Vasily should not manually edit repository files unless explicitly needed.

Git add, commit, and push may be performed by a trusted wrapper or human after Codex reports a verified scoped diff. This is the normal Codex runner architecture when the Codex sandbox keeps Git metadata or network access outside the agent.

For long-running autonomous work, Codex Desktop is the orchestration and review surface. Execution should run through a repo-scoped project runner according to `docs/codex-autonomous-runner-policy.md` and `docs/codex-runner-operator-guide.md`.

## Single-Prompt Workflow

For normal work, Codex handles one task at a time:

1. Read repository instructions and affected files.
2. Make the smallest correct scoped change.
3. Run relevant local verification.
4. Review the diff.
5. Hand off git add, commit, and push to a trusted wrapper or human only when the prompt explicitly asks for it and the changed files match scope.
6. Report changed files, checks, and final status.

## Codex Batch Execution

A Codex batch is a manifest plus ordered prompt files under `prompts/queue/{batch_id}/`.

Default batch execution should use the project router, such as:

```text
vcw batch <batch_id>
yura batch <batch_id>
```

Do not split runner-suitable batches into many ad hoc Codex Desktop commands when a project runner exists.

For batch execution, Codex:

1. Reads `manifest.json`.
2. Reads prompt files in manifest order.
3. Reads each prompt's affected files before editing.
4. Applies each prompt's regression shield.
5. Edits only the declared scope.
6. Runs relevant verification.
7. Reports the verified diff for `scripts/codex-trusted-checkpoint.sh` or a human to commit.
8. Stops on critical conditions instead of guessing.
9. Reports changed files, checks, stop conditions, and final `git status`; the trusted wrapper validates the diff, creates the git checkpoint, and pushes the current branch for low-risk batches.

Codex batch execution is documented in `standards/codex-batch-execution-standard.md`.

Example hardened WSL launcher command:

```
wsl bash -lc '\''~/codex-runners/run-vcw-codex-hardened.sh exec "Выполни Codex batch <batch_id> по standards/codex-batch-execution-standard.md. Не используй Claude Routines. Не запускай deploy/server/secrets actions без отдельного подтверждения."'\''
```

## Safety And Autonomy

On the main developer machine, Codex should keep interactive permission checks. The safe default is repo-local work with `workspace-write` style sandboxing and approval for actions that need broader access.

Unattended execution without approval prompts belongs only inside an isolated repo-scoped runner, container, WSL workspace, VM, or dedicated local runner. The isolation boundary must prevent access to unrelated folders, secrets, SSH keys, production systems, and host-level configuration.

Do not use full host access or approval bypass on the host OS.

Isolated runner setup is documented in `docs/codex-isolated-runner-setup.md`.

Autonomous runner approval boundaries and router requirements are documented in `docs/codex-autonomous-runner-policy.md`.

- 2026-05-15: hardened WSL runner smoke test completed for a documentation-only Codex batch.
- 2026-05-21: external auto-checkpoint runner smoke test completed for a documentation-only Codex batch.

## Relationship To Claude Routine Infrastructure

Codex batch execution is separate from Claude Code Routine execution.

The Claude Routine files are not the Codex batch path:

- `standards/batch-execution-standard.md`
- `docs/batch-execution-guide.md`
- `docs/routine-launcher-setup.md`
- `scripts/routine.sh`
- `scripts/trigger-batch.sh`

Do not look for Claude Routine API URLs or tokens when executing a Codex batch manually.
