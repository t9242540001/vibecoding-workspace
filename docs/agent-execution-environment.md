# Agent Execution Environment

## Purpose

The agent execution environment exists to let Code Agent execute technical development steps autonomously for trusted repositories while keeping Vasily's personal computer, unrelated files, and secrets protected.

It should provide a controlled place where AI-driven development can run commands, edit scoped repository files, verify work, commit, and push without gaining broad access to personal folders or unrelated local material.

## Problem

Web/manual approval mode is useful during bootstrap, careful review, and early trust-building.

It is not enough for autonomous product development. If Vasily has to approve routine technical operations one by one, the workflow stalls on decisions he cannot meaningfully evaluate as a non-developer.

The long-term system needs autonomy for ordinary technical execution while still stopping for strategy, product meaning, budget, legal and business tradeoffs, production risk, and major dilemmas.

## Target Operating Model

- The agent works inside an isolated workspace.
- Only selected repositories are available inside that workspace.
- Temporary development credentials are available only through an explicitly controlled local-only mechanism.
- Code Agent can run allowed technical commands autonomously.
- AI and GitHub review verify commits after execution.
- Vasily is involved for strategy, product meaning, budget, legal and business tradeoffs, and major dilemmas, not routine technical approvals.

## Key Deliverables

- Choose the execution environment: Codex CLI, IDE, cloud Codex, WSL, container, or another isolated runner.
- Define safe autonomy mode and approval boundaries.
- Create an isolated workspace without personal files.
- Define repository access rules.
- Define `_local/` and secrets access rules.
- Configure Git identity and push flow.
- Run a test autonomous cycle on a safe documentation task.
- Document rollback and cleanup rules.

## Security Boundaries

- No full-computer access by default.
- No personal folders in the execution workspace.
- No production secrets unless explicitly required and approved.
- Temporary development credentials must be rotated after launch or stabilization.
- `_local/` remains ignored by default.
- Secrets must not be committed or copied into tracked documentation.

## Definition Of Done

- Code Agent can complete a low-risk task from edit to commit/push without repeated user clicks.
- Changed files stay within declared scope.
- Unrelated local files remain untouched.
- GitHub commit can be reviewed after execution.
- Secrets are not exposed.
- Vasily is not asked to approve routine technical git operations.

## Setup Plan

This is a staged setup plan, not completed work.

1. Choose the execution environment.
2. Create an isolated workspace without personal files.
3. Add only selected trusted repositories.
4. Configure Git identity and push flow.
5. Define autonomy and approval boundaries.
6. Define local-only `_local/` and secrets access boundaries.
7. Run a safe documentation-only autonomous test cycle.
8. Review the GitHub commit after execution.
9. Decide whether to expand autonomy or keep restrictions.

## Safe Test Cycle

The first test should be a low-risk documentation-only task.

It should verify that Code Agent can:

- edit one allowed file;
- run validation commands;
- commit;
- push;
- report branch, commit SHA, push result, final `git status -sb`, and `git log --oneline -3`;
- stop after push.

The test must not involve production, secrets, deploy, payments, auth, personal data, or broad filesystem access.

## Local WSL Runner Test Result

A first local WSL + Codex CLI test was run as a transitional proof-of-concept.

What worked:

- Codex CLI launched inside the isolated WSL workspace.
- `approval: never` removed routine confirmation prompts.
- `read-only` sandbox could inspect repository state and run safe git read commands.
- `workspace-write` sandbox could edit the declared documentation file.
- The scoped edit stayed within the requested file.
- `git diff --check` passed.

What did not work:

- Local `git add` / commit failed inside the Codex sandbox because `.git/index.lock` could not be created.
- The sandbox allowed working-tree file edits but did not provide a complete local edit → commit → push loop.
- WSL networking required temporary DNS/GitHub/OpenAI API workarounds.
- The successful commit/push was completed manually outside the Codex sandbox.

Conclusion: local WSL runner is useful for proving no-approval execution and scoped edits, but it is a transitional mode, not the final autonomous execution environment.

## Next Architecture Options

The next planning step is to choose how autonomous commit/push should work.

Options:

1. Allow Git operations through a broader local sandbox only if the workspace is externally isolated enough.
2. Split roles: Codex CLI performs scoped edit/test work, while a separate trusted runner performs commit/push.
3. Move toward a GitHub/cloud runner where commit, push, logs, and verification are visible through GitHub.

Preferred direction: treat local WSL as a proof-of-concept and evaluate GitHub/cloud runner or a dedicated isolated runner as the long-term path.

## Stop Conditions

Autonomous execution must stop and ask for direction when any of these appear:

- scope drift;
- unexpected changed files;
- secrets detected;
- production/deploy impact;
- auth/payments/PII impact;
- failed checks that require a strategic choice;
- unclear repository or branch;
- need to access `_local/` or secrets not explicitly named.

## Open Decisions

These decisions still require Vasily or later workspace planning:

- which execution environment to use first;
- whether to use Codex web, CLI, IDE, WSL, container, or cloud runner;
- how much filesystem access is acceptable;
- how GitHub authentication should be handled;
- whether the current WSL DNS/GitHub access workaround is acceptable for the first autonomous test or must be replaced before broader use;
- whether Git operations should be allowed inside a broader local sandbox or handled by a separate runner;
- whether the long-term target should be GitHub/cloud runner rather than local WSL runner;
- whether test credentials are enough or real temporary dev credentials are needed;
- when branch protection / PR-only workflow should be enabled.

## Current Status

Pending.
