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

## Current Status

Pending.
