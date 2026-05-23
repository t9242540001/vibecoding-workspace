# Codex Isolated Runner Setup

<!--
  @file:        docs/codex-isolated-runner-setup.md
  @description: Practical setup guide for running Codex batches in an isolated repo-scoped environment
  @updated:     2026-05-24
  @version:     1.1
-->

This guide explains how to run Codex batches with fewer or no approval prompts without giving Codex broad access to the host machine.

For the operating standard, see `standards/codex-batch-execution-standard.md`.

For the approval boundary and Desktop-to-runner handoff policy, see `docs/codex-autonomous-runner-policy.md`.

---

## 1. Purpose

Codex can execute prompt batches manually on the main developer machine, but approval prompts may interrupt long runs. Removing those prompts on a broad host environment is not safe: the host may contain personal files, SSH keys, credentials, shell profiles, production access, and unrelated projects.

The isolated runner exists to move the safety boundary outside Codex. Inside a repo-scoped runner, Codex can run with fewer prompts because the runner itself limits what files, credentials, and systems are reachable.

---

## 2. Recommended Options

### WSL Dedicated Workspace

Use a dedicated WSL workspace that contains only the target repository and minimal tooling. Do not mount personal folders, SSH keys, or unrelated projects into the runner.

### Dev Container Or Docker Container

Use a container with the repository mounted as the only writable project directory. Prefer explicit package/tool installation over sharing broad host directories.

### VM Or Dedicated Local Runner

Use a small VM or dedicated machine profile for batch execution. Keep it separate from daily personal work and production administration.

---

## 3. Minimal Safety Requirements

Before using autonomous mode, verify that the runner has:

- One intended repository mounted and writable.
- No unrelated local folders mounted.
- No SSH keys mounted unless the batch explicitly requires them and the key is scoped.
- No unrelated secrets, `.env` files, credential stores, browser profiles, or shell history.
- Network restricted when possible.
- A clean Git identity.
- Token handling through explicit, minimal, revocable credentials.
- No `danger-full-access` on the host OS.

Secrets must not be committed to the repository.

---

## 4. Codex Launch Patterns

Safe interactive mode on the main machine:

```
codex --sandbox workspace-write --ask-for-approval on-request
```

Autonomous mode inside an isolated repo-scoped runner:

```
codex --sandbox workspace-write --ask-for-approval never
```

`--ask-for-approval never` is safe only when the external environment boundary is safe. It does not make the host safe by itself.

The runner does not need to perform Git commits or pushes from inside the Codex sandbox. The working model is:

1. Codex runs the prompt queue and changes only repo-local files inside the prompt scope.
2. Codex runs verification and reports the changed files and final status.
3. A trusted wrapper or human checks scope, secrets risk, and `git diff --check`.
4. The trusted wrapper or human performs `git add`, `git commit`, and normal `git push`.

This split is intentional. It keeps file-changing autonomy inside the hardened runner while leaving Git metadata and network push in a smaller trusted layer.

Low-risk checkpoint wrapper example after Codex completes a prompt or batch:

```
scripts/codex-trusted-checkpoint.sh <batch_id> "<commit message>"
```

For normal operator use, prefer the project router commands documented in `docs/codex-runner-operator-guide.md`, such as `vcw batch <batch_id>` or `yura batch <batch_id>`.

---

## 5. Process-Local WSL Mount Namespace Hardening

Process-local WSL mount namespace hardening is an intermediate option between ordinary WSL usage and a separate WSL distro, container, or VM.

In this pattern, a hardened launcher starts the runner process in its own mount namespace and hides host mounts such as `/mnt/c` and `/mnt/d` only inside that runner process. Normal WSL usage outside the runner is not changed or broken.

This option is suitable for repo-local Codex batches that do not need secrets, deploy access, production systems, or unrelated host files. It is not suitable for production, secrets, deploy, auth, payments, PII, or other high-risk batch work.

For strict isolation, prefer a separate WSL distro, container, VM, or dedicated runner environment.

---

## 6. What Not To Do

Do not:

- Run approval bypass on the main Windows host with broad filesystem access.
- Use `--dangerously-bypass-approvals-and-sandbox` on the main host.
- Use `--sandbox danger-full-access` on the main host.
- Store secrets, tokens, passwords, or `.env` values in the repository.
- Mount SSH keys or production secrets into a broad agent environment.
- Create global allow-rules for broad commands such as `git`, `python`, `npm`, `pnpm`, or `uv` unless the runtime can prove they are repo-scoped.
- Treat global prefix allow-rules as a repo-scoped security boundary.

---

## 7. Pre-Run Checklist

Before starting a Codex batch:

- Confirm the repository is the intended target.
- Confirm `git status --short --branch` is understood.
- Read `prompts/queue/{batch_id}/manifest.json`.
- Confirm all prompt files exist and are ordered.
- Confirm each prompt has affected files, regression shield, and acceptance criteria.
- Confirm required local checks are available or document why they are skipped.
- Confirm no secrets are present in the working tree.
- Confirm the trusted wrapper or human commit/push step, push target, and branch policy are understood.
- Confirm stop conditions from `standards/codex-batch-execution-standard.md`.

---

## 8. Rollback And Cleanup

For normal repository rollback, use Git history:

- Revert a bad commit with a normal revert commit.
- Reset only inside a disposable runner workspace when the workspace can be safely recreated.
- Prefer deleting and recreating the isolated runner over trying to clean an unknown state.

For credentials:

- Revoke temporary tokens after the run if they were created for the runner.
- Rotate any credential that may have been exposed to a broader environment than intended.
- Do not preserve runner images or snapshots that contain secrets.

For files:

- Remove temporary local-only files from the runner before reuse.
- Keep generated logs out of Git unless the prompt explicitly asks for committed artifacts.

---

## Changelog

- 2026-05-24 - v1.1. Linked the autonomous runner policy and operator guide so long-running batch work uses project routers instead of repeated Desktop approvals.
- 2026-05-15 - v1.0. Initial setup guide for safe Codex isolated runner usage, launch patterns, safety requirements, pre-run checklist, and rollback/cleanup guidance.
