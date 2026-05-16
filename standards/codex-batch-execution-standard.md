# Codex Batch Execution Standard

<!--
  @file:        standards/codex-batch-execution-standard.md
  @description: Standard for running prompt batches manually through Codex or inside an isolated Codex runner
  @owner:       Vibe Coding
  @updated:     2026-05-15
  @version:     1.0
-->

This standard supplements `standards/VIBECODER_STANDARDS.md`. It defines the Codex-native batch execution model: a Codex session reads a manifest and ordered prompt queue, executes prompts sequentially, makes repo-local file changes, stops on critical failure, and reports the result. Git add/commit/push may be performed by a trusted wrapper or human after verification.

It does not replace or modify `standards/batch-execution-standard.md`, which remains the Claude Code Routine-specific batch standard.

---

## 1. Purpose And Relationship

Codex batches are for multi-prompt work where the prompt sequence is already prepared and reviewed, but the execution happens through Codex instead of Claude Code Routines.

The purpose is to remove manual waiting between prompts while preserving verification, regression shields, explicit git checkpoints, and stop conditions.

---

## 2. Codex Batch Architecture

Default flow:

Vasily -> AI orchestrator -> Codex -> prompt queue -> verified file changes -> trusted wrapper or human git add/commit/push -> GitHub verification/report.

Codex owns scoped repo-local file execution inside the current repository. A trusted wrapper or human owns git metadata and push when the active Codex sandbox does not safely support commit/push. GitHub remains the source of truth after commits are pushed.

---

## 3. What A Codex Batch Is

A Codex batch is:

- A `manifest.json` file.
- Ordered prompt files.
- A shared directory under `prompts/queue/{batch_id}/`.

The manifest declares prompt order and batch metadata. Each prompt file declares its own task, affected files, regression shield, acceptance criteria, and stop conditions.

---

## 4. Execution Modes

### 4.1 Interactive Manual Codex Batch

Runs on the main developer machine in a normal Codex session.

Use this when:
- Human-visible approval prompts are acceptable.
- The machine has personal files, credentials, or broad system access.
- The work may need judgment between prompts.

Recommended mode:

```
codex --sandbox workspace-write --ask-for-approval on-request
```

### 4.2 Isolated Runner Mode

Runs inside a repo-scoped container, VM, WSL instance, or dedicated runner where the outer environment limits access to the intended repository.

Use this when:
- Prompts should run without approval prompts.
- The runner has no access to unrelated personal files, secrets, SSH keys, or production systems.
- All required credentials are minimal, explicit, and scoped to the task.

Allowed mode inside that isolation boundary:

```
codex --sandbox workspace-write --ask-for-approval never
```

A hardened WSL process-local runner that hides host mounts such as `/mnt/c` and `/mnt/d` for the runner process is acceptable as a temporary isolated runner level for repo-local batch work.

---

## 5. Approval Policy

Default safe sandbox for Codex repository work is `--sandbox workspace-write`.

Do not use `danger-full-access` on the main Windows environment.

Do not use `--dangerously-bypass-approvals-and-sandbox` on the main Windows environment.

`--ask-for-approval never` is acceptable only inside an isolated repo-scoped runner/container/VM. It is not a substitute for isolation.

Inside a hardened WSL process-local runner, `--ask-for-approval never` is allowed only for repo-local tasks without secrets, deploy actions, production access, auth, payments, PII, or other high-risk systems.

Do not claim or assume that Codex has a repo-scoped allowlist unless the current Codex runtime explicitly provides one.

---

## 6. Safe Corridor

Allowed inside the declared prompt scope:

- Repo-local file reads and edits.
- Repo-local tests, build, lint, and validation commands.
- `git status` and `git diff`.
- Handoff to a trusted wrapper or human for `git add`, `git commit`, and normal `git push` after scope and verification checks.
- Documentation and knowledge updates explicitly listed by the prompt.

Not allowed without explicit approval:

- Secrets, tokens, passwords, `.env` values, or credential changes.
- Writes outside the repository.
- Destructive operations outside the repository.
- `rm -rf` or destructive reset operations.
- `git push --force`.
- `ssh`, `scp`, production deploys, or server changes.
- Auth, payments, PII, or production config changes not explicitly approved.

---

## 7. Stop Conditions

Stop the batch and report when any of these occur:

- Scope drift from the current prompt.
- Required edit outside the prompt's affected files or declared sections.
- Secret exposure or suspected credential access.
- Destructive command requirement.
- Network access not required by the task.
- Write outside the repository.
- Auth, payments, PII, deploy, or production config change without explicit approval.
- Verification failure whose fix is outside the current prompt scope.
- Ambiguous prompt meaning with material risk of semantic drift.

Safe errors inside the current prompt scope may be fixed before committing.

---

## 8. Per-Prompt Loop

For each prompt in manifest order:

1. Read `manifest.json`.
2. Read the prompt file.
3. Read affected files fully before editing.
4. Apply the prompt's regression shield.
5. Edit only the declared files and sections.
6. Run relevant local verification.
7. Review `git diff`.
8. Report changed files, checks, and any stop conditions.
9. Hand off git add/commit/push to a trusted wrapper or human, or continue to the next prompt when the wrapper controls the checkpoint.

Do not update Routine state fields unless the prompt explicitly says to do so.

Codex sandbox commit/push support is not required for a valid batch run. The normal architecture is that Codex produces verified repo-local changes and an external trusted layer records those changes in Git.

---

## 9. Reporting Requirements

Final reports must include:

- Changed files.
- Commits created by the trusted wrapper or human, in order, when git checkpoints were completed.
- Verification checks run.
- Stop conditions encountered, or confirmation that none occurred.
- Final `git status`.
- Push result when push was requested.

---

## 10. Relationship To Claude Routine Files

These files are Claude Routine-specific unless explicitly generalized later:

- `standards/batch-execution-standard.md`
- `docs/batch-execution-guide.md`
- `docs/routine-launcher-setup.md`
- `scripts/routine.sh`
- `scripts/trigger-batch.sh`

Codex batch execution may reference them for historical context, but it must not depend on Claude Routine credentials, Routine URLs, or Routine state.

---

## Changelog

- 2026-05-15 - v1.0. Initial Codex-specific batch execution standard. Defines interactive manual execution, isolated runner autonomy, approval policy, safe corridor, stop conditions, per-prompt loop, reporting requirements, and separation from Claude Routine infrastructure.
