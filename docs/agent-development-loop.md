# Agent Development Loop

## Stage 5 - Baseline Code Agent Development Loop

Goal: establish a repeatable single-agent loop for scoped implementation, verification, commit, push, and review.

Why it matters: the system needs one reliable execution loop before more autonomy or multi-agent work is safe.

Key deliverables:

- one task equals one scoped prompt;
- regression shield in every implementation prompt;
- verification commands included in acceptance criteria;
- commit and push rules;
- ChatGPT/GitHub verification after execution;
- knowledge update assessment for durable product facts.

Definition of done:

- a real product task can move from prompt to verified GitHub result;
- changed files stay within scope;
- the Code Agent reports acceptance criteria and final Git status;
- failures produce repair prompts or backlog items instead of silent drift.

Current status: In progress.

## Stage 6 - Autonomous Agent Development Loop

Goal: allow AI agents to execute larger technical tasks autonomously within approved boundaries.

Why it matters: Vasily should not need to approve routine technical micro-decisions once scope, risk, and acceptance criteria are clear.

Key deliverables:

- autonomy boundaries by task type and risk level;
- branch and PR workflow;
- required checks and review gates;
- escalation rules for ambiguity, cost, legal, security, production, or business logic;
- rollback and repair workflow.

Definition of done:

- agents can complete routine implementation paths without repeated human approvals;
- Vasily is pulled in for strategy, meaning, budget, legal/business tradeoffs, and major dilemmas;
- risky tasks stop at clear gates instead of guessing.

Current status: Pending.

## Stage 7 - Multi-Agent / Subagent System

Goal: coordinate specialized agents for research, implementation, review, testing, documentation, and repair.

Why it matters: larger product work needs parallel expertise without losing ownership, scope control, or source of truth.

Key deliverables:

- role definitions for subagents;
- delegation rules;
- parallel work boundaries;
- review and integration protocol;
- conflict resolution workflow.

Definition of done:

- multi-agent work can split tasks safely;
- each agent has a bounded responsibility;
- integration preserves product knowledge, tests, and Git history.

Current status: Future.
