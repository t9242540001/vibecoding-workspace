# Vibecoding Workspace Roadmap

This roadmap tracks the medium-term capability milestones for the Vibecoding Workspace as a shared development operating system.

It is not a product roadmap for any one product repository. Product-specific facts, decisions, infrastructure values, and roadmaps stay in the relevant product repository.

## Final Goal

The final goal is an end-to-end AI-assisted product factory.

Vasily can start from either:

- a new project idea;
- an improvement to an existing product repository.

The AI orchestrator conducts iterative research and planning before serious implementation. Research may happen in rounds:

1. initial questions;
2. investigation;
3. follow-up questions;
4. deeper investigation;
5. final synthesis.

Before serious implementation, the system produces a clear product specification. When needed, it prepares the product repository and required infrastructure. AI agents then handle technical execution autonomously inside agreed boundaries.

Vasily stays responsible for strategy, product meaning, business logic, budget, legal and business tradeoffs, and major dilemmas. The AI system handles routine technical planning, implementation choices, verification, and documentation updates within the approved scope.

## Mandatory Research And Specification Blocks

Every serious project discovery or specification cycle should cover at minimum:

- target audience need and user pain;
- product value proposition;
- user scenarios and MVP scope;
- technical plan using current best practices;
- technical security;
- legal, privacy, and compliance risks;
- usability and accessibility;
- SEO and discoverability for web projects;
- financial model, costs, and monetization assumptions;
- operational and deployment plan;
- data, integrations, and external dependencies;
- testing and acceptance criteria;
- risks, open questions, and decision points.

The research output should separate known facts, assumptions, open questions, and decisions that require Vasily.

## Secure Development Access Layer

The workspace needs a controlled local-only development access layer for secrets and operational credentials.

Purpose: enable automation during setup without turning temporary convenience into permanent exposure.

Rules:

- temporary development secrets may be made conveniently available to AI-driven setup only through an explicitly controlled local-only mechanism;
- secrets must not be committed to GitHub;
- secrets must not be placed in tracked documentation;
- secrets must not be read by Code Agent unless the task explicitly names the relevant local file or value;
- local-only material remains outside GitHub source of truth.

After launch or infrastructure stabilization, every product must have a mandatory credential rotation task:

1. replace temporary credentials;
2. remove exposed development access;
3. verify Git history for accidental secret exposure;
4. update production secrets securely;
5. record the stable production access pattern in the product repository knowledge without storing secret values.

## Current Reality

The `yurassistent` product cycle has partially validated the operating model. It produced useful lessons around knowledge structure, roadmap restoration, deployment notes, and repair after a bad knowledge migration.

This is a partial validation source, not proof that the full factory loop is complete. The workspace still needs stronger research, specification, access, agent workflow, and review layers before the system can be treated as a repeatable end-to-end factory.

## Stage 0 - Bootstrap And Repository Hygiene

Goal: establish the workspace repository as a reliable source of shared operating rules.

Why it matters: the workspace cannot guide product work safely if its own structure, Git workflow, and boundaries are unclear.

Key deliverables:

- repository role documented;
- root agent instructions present;
- Git workflow documented;
- local-only ignored folders defined;
- branch protection plan documented;
- onboarding and work-track boundaries documented.

Definition of done:

- the workspace has clear navigation and ownership boundaries;
- direct bootstrap work is documented as temporary;
- local-only material is ignored and excluded from normal Codex inspection;
- no product-specific facts are stored as workspace rules.

Current status: In progress.

## Stage 1 - Workspace Operating System

Goal: define the reusable standards, skills, templates, prompts, and workflow rules that product repositories can rely on.

Why it matters: product work should not depend on memory or improvised manual steps.

Key deliverables:

- shared standards;
- reusable skills;
- product repository template;
- prompt templates for audit and repair;
- onboarding rules for existing and new repositories;
- visible prompt readiness gate for serious Code Agent prompts.

Definition of done:

- every recurring workflow has an explicit document, skill, or template;
- existing product knowledge is protected by audit-first onboarding;
- serious prompts visibly confirm research, file reads, review, and readiness before handoff.

Current status: In progress.

## Stage 2 - Discovery, Research, And Specification Pipeline

Goal: turn ideas and improvement requests into researched, decision-ready product specifications.

Why it matters: implementation quality depends on the quality of product framing, research, assumptions, and acceptance criteria.

Key deliverables:

- iterative research prompt pattern;
- specification template;
- decision-point format for Vasily;
- minimum research block checklist;
- synthesis format separating facts, assumptions, risks, and open questions.

Definition of done:

- a new idea can move from rough concept to implementation-ready specification;
- existing product improvements can be researched without overwriting product knowledge;
- Vasily sees major dilemmas and tradeoffs before implementation begins.

Current status: Pending.

## Stage 3 - New Product And Existing Product Workflows

Goal: support both product creation from zero and safe improvements to existing product repositories.

Why it matters: new projects and existing products need different entry points, but both must preserve source of truth and project knowledge.

Key deliverables:

- new product bootstrap workflow;
- existing product audit workflow;
- knowledge initialization and migration workflow;
- product repository readiness checklist;
- first safe task cycle checklist.

Definition of done:

- a new product repository can be created and initialized without manual memory;
- an existing product can be audited before any knowledge or code changes;
- gaps are proposed as migration plans before edits happen.

Current status: In progress.

## Stage 4 - Secure Development Access Layer

Goal: make temporary development access convenient enough for automation while keeping secrets out of GitHub and tracked documentation.

Why it matters: setup work often needs credentials, but accidental permanence of temporary access is a serious operational risk.

Key deliverables:

- local-only access pattern;
- rules for when Code Agent may read local secret material;
- temporary credential handling checklist;
- mandatory post-launch credential rotation checklist;
- Git history verification step.

Definition of done:

- AI-driven setup can use explicitly approved local-only access;
- no secrets are committed or copied into tracked docs;
- every launch or stabilization includes credential rotation and access cleanup.

Current status: Pending.

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

## Stage 8 - End-To-End Product Factory

Goal: connect research, specification, repository setup, infrastructure, implementation, testing, deployment, and iteration into one repeatable operating model.

Why it matters: the workspace should make product creation and improvement predictable without flattening product judgment into mechanical task execution.

Key deliverables:

- idea-to-spec pipeline;
- repository bootstrap workflow;
- infrastructure setup workflow;
- secure access and rotation workflow;
- implementation and verification loop;
- deployment and rollback loop;
- post-launch improvement loop.

Definition of done:

- a new product can move from idea to launched MVP through the documented system;
- an existing product can move from improvement request to deployed change through the same operating model;
- Vasily controls product direction while routine technical execution is handled by the AI system.

Current status: Future.

## Stage 9 - Continuous Improvement From Real Product Work

Goal: use real product work to improve the workspace without mixing product-specific facts into shared standards.

Why it matters: the system should learn from practice while preserving clean boundaries between workspace process and product knowledge.

Key deliverables:

- lesson capture workflow;
- workspace process fix workflow;
- backlog routing rules;
- criteria for turning repeated product lessons into universal rules;
- periodic review of standards, skills, prompts, and templates.

Definition of done:

- product lessons become workspace improvements only after deliberate decision;
- product-specific facts remain in product repositories;
- recurring issues generate process fixes, prompt templates, skills, or backlog items.

Current status: In progress.

## Backlog Vs Roadmap

This roadmap tracks major capability milestones: operating-system layers, workflow gates, research and specification pipelines, secure access, agent loops, and product-factory maturity.

Small technical cleanup items, candidate skills, tool ideas, MCP/plugin experiments, and implementation chores belong in backlog documents such as `skills/BACKLOG.md` and `tools/MCP_AND_PLUGINS_ROADMAP.md`.

Backlogs answer "what small or candidate work is waiting?" This roadmap answers "what capability must exist for Vibecoding to operate as a repeatable product factory?"
