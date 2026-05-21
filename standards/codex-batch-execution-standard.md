# Codex Batch Execution Standard

<!--
  @file:        standards/codex-batch-execution-standard.md
  @description: Standard for running prompt batches manually through Codex or inside an isolated Codex runner
  @owner:       Vibe Coding
  @updated:     2026-05-21
  @version:     1.1
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

For low-risk repo-local batches, the default trusted checkpoint wrapper is `scripts/codex-trusted-checkpoint.sh`. It validates the diff, blocks high-risk paths and deletes by default, commits with `[batch:<batch_id>]`, and pushes the current branch. Human review remains the fallback and is required for high-risk tasks.

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

## 11. Manifest Executor Field

Codex batches use the same `prompts/queue/{batch_id}/` structure as Claude Code Routine batches per `standards/batch-execution-standard.md`. The manifest schema is shared. To disambiguate which executor a batch is intended for, the manifest declares an optional `executor` field:

```json
{
  "batch_id": "batch-2026-05-21-stub-enemy-extraction",
  "executor": "codex",
  "title": "Extract stubEnemy into src/data/enemies.ts"
}
```

Allowed values:

- `"claude-code"` — default when omitted, batch runs via Claude Code Routine per `standards/batch-execution-standard.md`.
- `"codex"` — batch runs via Codex per this standard.

When `executor: "codex"` is set, the routine launcher does not pick up the batch; only Codex reads it. When `executor: "claude-code"` (or omitted) is set, Codex does not pick it up; only the routine launcher reads it.

A batch is single-executor by design. Cross-executor batches are not supported in this version of the schema.

The `executor` field is an optional addition to the manifest schema. Manifests omitting it remain valid and default to `claude-code` behavior, preserving backward compatibility with existing batches across all product repositories.

---

## 12. Per-Prompt File Naming Within A Codex Batch

For most Codex batches one prompt file is sufficient — Codex-friendly tasks are usually single-PR by nature (per its self-stated comfort zone: 1–4 files, ≤300 lines diff, one concern per PR).

Default single-prompt naming:

```
prompts/queue/{batch_id}/codex-prompt.md
```

For multi-step Codex batches (rare — usually means the batch should be split), use sequential numbering inside a `codex/` subfolder:

```
prompts/queue/{batch_id}/codex/01-{kebab-title}.md
prompts/queue/{batch_id}/codex/02-{kebab-title}.md
prompts/queue/{batch_id}/codex/response.md
```

The manifest lists prompts in execution order. The `executor` field in the manifest disambiguates Codex batches from Claude Code Routine batches; folder layout above is descriptive, not mandatory.

---

## 13. Codex Response Files

When Codex completes a batch successfully, the PR description is the single artefact. PR template lives at `.github/PULL_REQUEST_TEMPLATE/codex.md` in the product repository.

When Codex cannot complete a batch (blocked, partial, or requires human decision), Codex writes a response file `prompts/queue/{batch_id}/codex-response.md` (or `prompts/queue/{batch_id}/codex/response.md` for multi-step batches) with the following structure:

```markdown
# Codex Response: {batch_id}

## Status
blocked | partial | needs-decision

## Where I stopped
[Exact prompt section / file / line where execution halted]

## Reason
[One paragraph explaining why I stopped]

## Evidence
[Command outputs, file diffs, missing context, conflicting state — concrete data, not interpretation]

## Question For Claude
[If applicable — what Claude must decide before resuming]

## Question For Vasily
[If applicable — what Vasily must approve or provide]

## What Would Unblock Me
[Specific actionable thing — file content, decision, command output, asset]
```

Response files are committed to the same branch Codex was working on. The branch is left open for Claude review.

Response files are not created for successful batches. PR description is the artefact in that case.

---

## 14. Codex PR Template

Every product repository that uses Codex execution must include `.github/PULL_REQUEST_TEMPLATE/codex.md`. The template:

```markdown
## Summary
[One paragraph: what changed and why, in business terms]

## Files Changed
- path/to/file1.ts (new | modified | renamed | deleted) — brief reason
- path/to/file2.ts — brief reason

## Verification
- npm run lint: [exit code, summary of warnings]
- npm run test:run: [exit code, N tests pass]
- npm run build: [exit code]
- Additional checks: [task-specific commands and results]

## Visual Notes
[For UI/VFX tasks: screenshot or description of visible result. For non-visual tasks: N/A.]

## Deviations / Questions
[Any deviation from the original prompt scope, any open questions for Claude review. If none — "None".]

## Context Confirmation
- CLAUDE.md: read
- AGENTS.md: read
- knowledge/Context.md: read
- knowledge/[task-specific files]: read
- [affected source files]: read
```

This template is product-repo-specific because each product has its own command set (`npm` vs `uv` vs `cargo`) and its own knowledge structure. Reference implementation lives in `t9242540001/magic-defender/.github/PULL_REQUEST_TEMPLATE/codex.md`.

---

## Changelog

- 2026-05-15 — v1.0. Initial Codex-specific batch execution standard. Defines interactive manual execution, isolated runner autonomy, approval policy, safe corridor, stop conditions, per-prompt loop, reporting requirements, and separation from Claude Routine infrastructure.
- 2026-05-21 — v1.1. Added Sections 11 (manifest executor field), 12 (per-prompt file naming), 13 (Codex response files for blocked/partial), 14 (Codex PR template requirement). Section 2 trusted-checkpoint paragraph (added between versions) preserved unchanged. No other changes to Sections 1-10.
