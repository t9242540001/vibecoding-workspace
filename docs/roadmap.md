# Vibecoding Workspace Roadmap

This roadmap tracks the medium-term capability milestones for the Vibecoding Workspace as a shared development operating system.

It is not a product roadmap for any one product repository. Product-specific facts, decisions, infrastructure values, and roadmaps stay in the relevant product repository.

## Final Goal

See `docs/product-factory.md`.

## Mandatory Research And Specification Blocks

See `docs/research-and-specification-pipeline.md`.

## Secure Development Access Layer

See `docs/secure-development-access.md`.

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

See `docs/research-and-specification-pipeline.md`.

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

See `docs/secure-development-access.md`.

## Stage 5 - Baseline Code Agent Development Loop

See `docs/agent-development-loop.md`.

## Stage 6 - Autonomous Agent Development Loop

See `docs/agent-development-loop.md`.

## Stage 7 - Multi-Agent / Subagent System

See `docs/agent-development-loop.md`.

## Stage 8 - End-To-End Product Factory

See `docs/product-factory.md`.

## Stage 8a - Agent Execution Environment

See `docs/agent-execution-environment.md`.

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
