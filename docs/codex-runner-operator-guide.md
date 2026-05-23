# Codex Runner Operator Guide

<!--
  @file:        docs/codex-runner-operator-guide.md
  @description: Operator commands for running Codex work through project runners
  @updated:     2026-05-24
  @version:     1.0
-->

Use this guide when a Codex task should run through the project runner instead of an interactive Codex Desktop sandbox.

The policy behind this guide is `docs/codex-autonomous-runner-policy.md`.

## Default Pattern

For long-running work:

1. Confirm the target project.
2. Confirm the branch/status is understood.
3. Run the project router command.
4. Let the runner execute inside the repo-scoped environment.
5. Review the final status and commit/push result.

Do not split a batch into many ad hoc Desktop commands when a project runner exists.

## Vibe Coding Workspace

Use `vcw` for this repository.

```text
vcw status
vcw pull
vcw batch <batch_id>
vcw status
```

The `vcw batch` path should run the hardened WSL Codex runner and hand off checkpointing to the trusted wrapper.

## YurAssistent

Use `yura` for the YurAssistent product repository.

```text
yura status
yura pull
yura batch <batch_id>
yura status
```

The `yura batch` path should run the project-scoped hardened runner and the project trusted checkpoint wrapper.

## When To Ask Vasily

Ask before continuing if the task requires:

- deleting files;
- destructive Git operations;
- access outside the target repository;
- secrets, credentials, `.env`, SSH keys, or credential stores;
- deploy, server, production, database, auth, payment, or PII actions;
- force push or branch history rewrite.

## Expected Codex Desktop Behavior

When Codex Desktop receives a runner-suitable task, it should answer with the specific router action it is taking or the exact command Vasily should run through the panel.

Examples:

```text
vcw batch batch-2026-05-22-site-audit-full-agent-v2-06-consistency
```

```text
yura batch batch-2026-05-22-yurassistent-frontend-audit-preflight
```

If the command fails because the router is missing, not authenticated, or outside policy, stop and report the blocker instead of falling back to broad host execution.

## New Router Checklist

For a new project router, support at least:

- `status`;
- `pull`;
- `batch <batch_id>`;
- `checkpoint <batch_id> "<commit message>"`.

Reject:

- unknown commands;
- arbitrary shell passthrough;
- arbitrary filesystem paths;
- delete/destructive modes unless separately approved;
- deploy/server/secrets modes unless separately approved.

## Changelog

- 2026-05-24 - v1.0. Initial operator guide for `vcw`, `yura`, and future project runners.
