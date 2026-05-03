# GitHub Actions Agent Runner

## Purpose

This document defines the long-term runner direction after the local WSL proof-of-concept.

The goal is a GitHub-visible autonomous execution loop where work, logs, diffs, commits, PRs, and verification are visible through GitHub.

## Decision

- Local WSL runner remains a transitional proof-of-concept.
- Primary long-term path is GitHub Actions / cloud runner.
- The first practical runner version should include Browser/E2E staging validation.
- Self-hosted runner is deferred until required by private network access, heavy environments, or specific dependencies.

## Why GitHub / Cloud Runner

GitHub / cloud runner is preferred because it provides:

- visible logs;
- reproducible workflow;
- branch/PR-based review;
- reduced dependence on Vasily's local terminal;
- controlled permissions;
- easier post-run verification through GitHub.

## Initial Runner Shape

The first version should use:

- manual `workflow_dispatch`;
- GitHub-hosted Ubuntu runner;
- repository checkout;
- Codex through a controlled action or step;
- scoped diff production;
- changed-file checks against declared scope;
- commit to a branch;
- PR opening instead of direct push to `main`;
- result reporting in GitHub-visible logs and PR body.

## Immediate Browser/E2E Requirement

Browser/E2E staging validation is included from the early practical runner strategy.

The runner strategy must support:

- opening the staging site;
- using synthetic test fixtures;
- running Playwright or equivalent browser automation;
- checking upload/OCR/Q&A/generation/admin-log flows when relevant;
- comparing expected vs actual by acceptance criteria, not exact text equality;
- collecting safe screenshots/logs/reports as artifacts;
- never using real personal data by default.

## E2E Test Report Shape

The E2E report must include:

- fixture;
- scenario;
- expected checks;
- actual result;
- screenshots/logs/artifacts;
- pass/fail;
- next action.

## Security Boundaries

- Use least-privilege workflow permissions.
- Do not push directly to `main` in the first version.
- Use GitHub Secrets or environment-scoped secrets for sensitive values.
- Do not put raw personal data in fixtures or artifacts by default.
- Do not run production E2E when staging exists.
- Limit artifact retention.
- Stop the runner on unexpected changed files, secrets exposure risk, or scope drift.

## Deferred Self-Hosted Runner Triggers

Self-hosted runner is not the default starting point.

It becomes relevant later if:

- staging/admin/internal APIs are only reachable from a private VDS/internal network;
- tests require heavy environments beyond GitHub-hosted runner capacity;
- a product requires specific system dependencies that are slow or fragile to install in every GitHub-hosted run.

## Phased Rollout

1. Documentation-only PR runner.
2. Low-risk workspace task runner.
3. Browser/E2E staging smoke for one product flow.
4. Product repo runner with PR output.
5. Expanded E2E suites.
6. Selective auto-merge only for low-risk tasks after repeated successful runs.

## Definition Of Done

For this capability, done means:

- runner can execute a scoped low-risk task without local approvals;
- result is visible in GitHub logs and PR;
- changed files are scope-checked;
- E2E staging smoke can run with synthetic fixtures;
- safe artifacts are uploaded;
- no direct main push is required in the first version;
- Vasily reviews product meaning and strategic choices, not routine technical approvals.

## Open Decisions

- exact trigger interface: manual workflow input, issue command, PR comment, or future orchestrator;
- whether Codex should write commits directly or only produce patches;
- how E2E fixtures should be stored;
- staging URL and authentication pattern;
- artifact retention period;
- when to introduce self-hosted runner.
