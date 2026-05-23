# Codex Autonomous Runner Policy

<!--
  @file:        docs/codex-autonomous-runner-policy.md
  @description: Policy for running Codex work with minimal approval prompts through repo-scoped runners
  @updated:     2026-05-24
  @version:     1.0
-->

This policy defines how Vibe Coding runs Codex work that should proceed without repeated approval prompts while preserving repository boundaries and delete protections.

## Purpose

Codex Desktop is a good orchestration and review surface, but it is not the default execution environment for long-running autonomous repository work. Long-running batches must run through a project-specific runner whose filesystem and commands are already scoped to the target repository.

The goal is:

- no repeated approval prompts for normal repo-local reads, edits, tests, builds, and status checks;
- explicit approval for deletes and destructive operations;
- explicit approval or hard blocking for access outside the project repository;
- no broad host-level approval bypass on the Windows desktop environment.

## Roles

### Codex Desktop

Use Codex Desktop for:

- task discussion and scope clarification;
- inspecting reports and final status;
- deciding whether a task should run through a project runner;
- reviewing what the runner produced.

Do not use Codex Desktop as the primary execution environment for long-running batches when repeated approval prompts would interrupt work.

### Project Runner

Use a project runner for:

- Codex batch execution;
- prompt queues under `prompts/queue/`;
- repo-local edits and verification;
- automated checkpoint handoff.

The runner must be scoped to one intended repository and must not expose unrelated folders, personal files, broad credential stores, production systems, or SSH keys unless a specific task has separately approved, scoped credentials.

## Required Runner Mode

Inside an isolated repo-scoped runner, Codex may run with:

```text
codex --sandbox workspace-write --ask-for-approval never
```

This mode is allowed only when the external runner boundary limits access to the target repository and required tooling. It is not allowed as a broad host-level mode on the main Windows desktop environment.

Safe interactive desktop mode remains:

```text
codex --sandbox workspace-write --ask-for-approval on-request
```

## Approval Boundary

Normal repo-local work inside the runner should not ask for approval:

- read files in the repository;
- edit files inside the declared task scope;
- run repo-local tests, lint, typecheck, build, and validation commands;
- run `git status`, `git diff`, and other read-only Git inspection;
- hand off verified changes to the trusted checkpoint wrapper.

The runner or wrapper must stop or ask for explicit approval for:

- deleting files;
- destructive reset or cleanup operations;
- writes outside the repository;
- reading unrelated local folders;
- secrets, tokens, credentials, `.env` files, private keys, or credential stores;
- deploy, server, SSH, SCP, database, production, auth, payments, or PII actions;
- force push or branch history rewrite.

## Git Checkpoint Rule

Codex may produce verified repo-local changes. Git checkpointing should be performed by a trusted wrapper after validation.

The trusted wrapper must:

- inspect changed files;
- run `git diff --check`;
- reject high-risk paths by default;
- reject deleted files unless the wrapper was explicitly invoked with a delete-allowing mode;
- stage only validated files;
- create the commit;
- push only through the normal branch policy.

For this workspace, the reference wrapper is:

```text
scripts/codex-trusted-checkpoint.sh <batch_id> "<commit message>"
```

Product repositories should provide an equivalent project-local trusted checkpoint wrapper.

## Project Command Routers

Each active product should expose a small command router instead of asking Codex Desktop to run arbitrary shell commands.

Allowed baseline commands:

```text
<project> status
<project> pull
<project> batch <batch_id>
<project> checkpoint <batch_id> "<commit message>"
```

Command routers must not expose arbitrary shell execution. They should reject unknown commands, arbitrary paths, deploy/server/secrets actions, and destructive operations unless a separate approved command mode exists for that exact purpose.

Current known routers:

- `vcw` for `vibecoding-workspace`;
- `yura` for `yurassistent`.

## Desktop-To-Runner Handoff

When a user asks Codex Desktop to run a long batch or autonomous sequence, Codex should:

1. Identify the target project and batch id.
2. Prefer the project runner command, such as `vcw batch <batch_id>` or `yura batch <batch_id>`.
3. Avoid decomposing the work into many Desktop sandbox commands.
4. Report the exact runner command and final status.
5. Ask the user only if the task requires deletes, outside-repo access, secrets, production, deploy, auth, payments, PII, or another high-risk action.

## New Project Requirement

Every new product repository connected to Vibe Coding should define:

- a project command router;
- a hardened Codex runner launcher;
- a batch auto-checkpoint launcher;
- a trusted checkpoint wrapper;
- product `AGENTS.md` instructions that refer to this policy.

These files are part of the project execution contract. They should be created during onboarding or before the first long-running Codex batch.

## What Not To Do

Do not:

- use `danger-full-access` on the main Windows desktop environment;
- use `--dangerously-bypass-approvals-and-sandbox` on the main Windows desktop environment;
- treat global prefix allow-rules as a repository security boundary;
- rely on repeated Desktop "do not ask again" approvals as the normal batch workflow;
- expose arbitrary shell execution through project routers;
- run autonomous work with host-level access to unrelated folders or credentials.

## Changelog

- 2026-05-24 - v1.0. Initial policy for Desktop orchestration, repo-scoped runner execution, approval boundaries, trusted checkpointing, and new project runner requirements.
