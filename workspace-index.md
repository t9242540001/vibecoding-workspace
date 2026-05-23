# Vibecoding Workspace Index

<!--
  @file:        workspace-index.md
  @description: Root navigation file for the Vibe Coding workspace infrastructure
  @updated:     2026-05-22
  @version:     0.4.7
-->

## Purpose

This repository is the infrastructure center for Vibe Coding.

It stores the shared working system: standards, skills, templates, rules, tools, scripts, documentation, and the registry of product repositories.

Product repositories remain separate. Each product repository stores only its own project-specific context, code, infrastructure notes, and knowledge files.

`_local/` is the standard ignored local-only folder for temporary project materials and is not part of GitHub source of truth.

## Architecture

Vasily
→ ChatGPT project / AI orchestrator
→ Code Agent
→ GitHub repositories
→ local Obsidian vault
→ VDS / production server
→ project knowledge
→ shared skills
→ external tools / MCP
→ future multi-agent development system

## Repository Roles

### This repository: `vibecoding-workspace`

Role: shared infrastructure and operating system for Vibe Coding.

Planned contents:

| Path | Role | Status |
|---|---|---|
| `standards/` | Shared development standards | Active: core standards present |
| `skills/` | Reusable working procedures | Active: twelve universal skills migrated |
| `skills/external/` | Third-party skills surveyed/adopted from the ecosystem | Active: REGISTRY.md catalogs surveyed skills |
| `templates/` | Starter templates for product repositories and reusable workflows | Active: product and site-audit templates present |
| `examples/` | Sample artifacts for validating workspace templates | Active: sample product repository template test present |
| `rules/` | Shared rules that are not product-specific | Active: root rules note present |
| `tools/` | External tools and MCP-related notes | Active: plugin registry present |
| `configs/` | Shared machine-readable configuration for runners and model profiles | Active: model profiles present |
| `prompts/` | Reusable prompt templates for workspace and product workflows | Active: project audit, knowledge repair, and site-audit pilot prompts present |
| `scripts/` | Utility scripts for workspace operations | Active: batch-trigger primitive and per-project launcher present |
| `docs/` | Supporting documentation | Active: repository and Codex workflow docs present |
| `.codex/` | Codex-specific repository instructions | Active |
| `AGENTS.md` | Root Code Agent instructions | Active |
| `workspace-index.md` | Root navigation file | Active |

Active standards files:

- `standards/VIBECODER_STANDARDS.md`
- `standards/VIBECODER_SYSTEM_INSTRUCTION.md`
- `standards/batch-execution-standard.md`
- `standards/codex-batch-execution-standard.md`

Active templates:

- `templates/product-repo/` — includes Codex instructions and knowledge-structure-compliant starter files.
- `templates/batch-execution/` — Claude Routine-specific infrastructure for prompt batch execution via Routines unless explicitly generalized later (see folder's AGENTS.md).
- `templates/site-audit/` — reusable scope, report, taxonomy, and Codex live-audit prompt templates for safe website audits.
- `docs/site-audit/` — reusable site-audit research basis, full-agent v2 research/charter, agentic audit pipeline, validation gates, and browser/E2E integration review.
- `configs/site-audit-default-scope.json` and `configs/site-audit-severity-taxonomy.json` — universal default audit policy and severity taxonomy for site-audit reports.

Active examples:

- `examples/sample-product-repo/` — sample product repository instantiated from the template.
- `examples/e2e/sanitized-staging-summary-example.json` — fake sanitized staging summary example for validator testing.
- `examples/site-audit/sanitized-audit-report-example.md` — synthetic site-audit report example for validation-gate review.

Active root agent layer:

- `AGENTS.md`
- `.codex/instructions.md`
- `.codex/skills/README.md`

Active tools, rules, and docs:

- `tools/plugins.md`
- `tools/MCP_AND_PLUGINS_ROADMAP.md`
- `rules/README.md`
- `docs/work-tracks.md`
- `docs/new-project-onboarding.md`
- `docs/repository-structure.md`
- `docs/codex-workflow.md`
- `docs/codex-isolated-runner-setup.md`
- `docs/git-workflow.md`
- `docs/branch-protection-plan.md`
- `docs/deploy-rollback-pattern.md`
- `docs/next-steps.md`
- `docs/roadmap.md`
- `docs/product-factory.md`
- `docs/research-and-specification-pipeline.md`
- `docs/secure-development-access.md`
- `docs/agent-development-loop.md`
- `docs/agent-execution-environment.md`
- `docs/agent-runner-github-actions.md`
- `docs/agent-runner-model-providers.md`
- `docs/model-capability-matrix.md`
- `docs/batch-execution-guide.md`
- `docs/routine-launcher-setup.md`
- `configs/model-profiles.json`
- `configs/e2e-text-fixtures.json`
- `docs/browser-e2e-text-fixtures.md`
- `.github/workflows/e2e-text-fixture-matrix.yml`
- `configs/e2e-staging-summary-contract.json`
- `docs/e2e-staging-summary-contract.md`
- `.github/workflows/e2e-staging-summary-validator.yml`
- `docs/e2e-staging-summary-validator.md`
- `.github/workflows/e2e-staging-summary-analysis.yml`
- `docs/e2e-staging-summary-analysis.md`
- `configs/browser-automation-handoff-contract.json`
- `docs/browser-automation-handoff-contract.md`
- `configs/synthetic-browser-observations.json`
- `.github/workflows/synthetic-browser-summary-generator.yml`
- `docs/synthetic-browser-summary-generator.md`
- `docs/real-staging-browser-workflow-design.md`
- `configs/real-staging-approved-routes.json`
- `configs/real-staging-interaction-profiles.json`
- `.github/workflows/real-public-browser-summary.yml`
- `docs/real-public-browser-summary-mvp.md`
- `docs/site-audit/agentic-audit-pipeline.md`
- `docs/site-audit/validation-gates.md`
- `docs/site-audit/integration-with-browser-e2e.md`
- `docs/site-audit/system-consistency-review.md`
- `docs/site-audit/full-agent-v2-research-basis.md`
- `docs/site-audit/full-agent-v2-charter.md`
- `configs/site-audit-default-scope.json`
- `configs/site-audit-severity-taxonomy.json`

Active operational backlog:

- `skills/BACKLOG.md`
- `skills/external/REGISTRY.md` — survey + decision log for third-party skills considered for adoption

Active prompt templates:

- `prompts/project-inventory-audit.md`
- `prompts/knowledge-repair.md`
- `prompts/series/site-audit-skill/series-plan.md`
- `prompts/series/site-audit-skill/pilot-public-site-audit-prompt.md`
- `prompts/series/site-audit-skill/pilot-scope-example.md`
- `prompts/series/site-audit-skill/README.md`

Active batch execution infrastructure (Claude Routine-specific unless explicitly generalized later):

- `templates/batch-execution/AGENTS.md`
- `templates/batch-execution/routine-prompt.md`
- `templates/batch-execution/manifest-template.json`
- `templates/batch-execution/prompt-template.md`
- `scripts/trigger-batch.sh` — low-level API primitive: POSTs to a Routine's fire endpoint
- `scripts/routine.sh` — per-project launcher: loads per-project credentials and invokes `trigger-batch`
- `docs/batch-execution-guide.md` — onboarding a new product to the batch execution system
- `docs/routine-launcher-setup.md` — setting up the per-project launcher on a developer machine

Active skill sync infrastructure (used by all product repositories via SessionStart hook):

- `scripts/sync-skills.sh` — canonical SessionStart hook script that pulls `skills/` into a product repo's `.claude/skills/` on every session start
- `docs/new-project-onboarding.md` § 6.5 — Skill Sync Setup procedure for new product repositories

### Local Obsidian vault

Role: local long-term knowledge base for WipeCoder/Vibe Coding context.

Status:

- Active vault path: `D:\WipeCoder\Obsidian\Vibe Knowledge`.
- Obsidian sees and opens the vault.
- Starter skeleton is created.
- Git history is initialized for the vault.
- Next step: add real context packs and working routes, such as `project-audit` and `website-audit`, without breaking the existing skeleton.

### Product repositories

Role: concrete applications, bots, websites, services, and other build targets.

Each product repository should contain only its own local context:

- `AGENTS.md` — rules for the Code Agent in this repository
- `CLAUDE.md` or equivalent main context file — compact project constitution
- `knowledge/INDEX.md`
- `knowledge/infrastructure.md`
- `knowledge/architecture.md`
- `knowledge/rules.md`
- `knowledge/decisions.md`
- `knowledge/roadmap.md`
- `.env.example`
- `.gitignore`

Shared standards and skills are not duplicated inside product repositories unless a specific local copy is explicitly required.

## Current Setup Stage

Current stage: real public browser summary MVP documented and passed.

Current Obsidian status:

- Active vault path: `D:\WipeCoder\Obsidian\Vibe Knowledge`.
- Obsidian sees and opens the vault.
- Starter skeleton is created.
- Git history is initialized for the vault.
- Next step: add real context packs and working routes, such as `project-audit` and `website-audit`, without breaking the existing skeleton.

Current Browser/E2E MVP status:

- First approved route: `yurassistent-home`.
- First approved profiles: `homepage-load-only`, `homepage-primary-cta-presence`.
- First approved analysis models: `qwen/qwen-plus`, `deepseek/deepseek-v4-flash`.
- Broader routes/interactions remain approval-gated.

Skills universality migration remains recorded below.

Skills migration immediate next steps:

1. Audit existing skills for universal wording.
2. Replace platform-specific wording where needed:
   - `Claude` → `AI model` where the role is universal
   - `Claude Code` → `Code Agent` where the executor is universal
   - `CLAUDE.md` → `CLAUDE.md or equivalent main project context file` where appropriate
3. Preserve the meaning, structure, and rules of every skill.
4. Move approved universal skills into `skills/`.
5. Move the universal standard into `standards/`.
6. Create templates for product repositories.

## Skills Migration Status

| Skill | Priority | Status | Repository file |
|---|---:|---|---|
| `prompt-writing-standard` | 1 | Migrated to universal Code Agent wording | `skills/prompt-writing-standard/SKILL.md` |
| `knowledge-structure` | 2 | Migrated to universal Code Agent wording | `skills/knowledge-structure/SKILL.md` |
| `code-markup-standard` | 3 | Migrated to universal Code Agent wording | `skills/code-markup-standard/SKILL.md` |
| `bug-hunting` | 4 | Migrated to universal Code Agent wording | `skills/bug-hunting/SKILL.md` |
| `research-protocol` | 5 | Migrated to universal Code Agent wording | `skills/research-protocol/SKILL.md` |
| `skill-writing-standard` | 6 | Migrated to universal Code Agent wording | `skills/skill-writing-standard/SKILL.md` |
| `universality-discipline` | 7 | New skill, born universal (closes pain map G; partially A, B, E) | `skills/universality-discipline/SKILL.md` |
| `anti-hedging-language` | 8 | New skill, born universal (closes pain map F; partially A, C, D) | `skills/anti-hedging-language/SKILL.md` |
| `real-path-verification` | 9 | New skill, born universal (closes pain map D; partially A, B, C) | `skills/real-path-verification/SKILL.md` |
| `forward-thinking-discipline` | 10 | New skill, born universal (closes pain map C; partially A, B, D) — design-time counterpart of `real-path-verification` | `skills/forward-thinking-discipline/SKILL.md` |
| `series-design-discipline` | 11 | New skill, born universal (closes pain map E; partially A, C, G) — Series Charter as cross-prompt namespace for 3+ prompt series; wired into `prompt-writing-standard` v3.9 (§7 Checkpoint, §9 check, CONTEXT field, AC checkboxes, §4 block), `batch-execution-standard` v1.5 (parade-as-Charter-projection in §4), and `research-protocol` v1.3 (§4 Phase 4 conditional handoff, §8 connection) | `skills/series-design-discipline/SKILL.md` |
| `site-audit` | 12 | New skill, born universal — evidence-based website audit workflow, safe audit modes, severity taxonomy, and reusable audit templates | `skills/site-audit/SKILL.md` |

## Skill Triggering Logic

Skills are applied by trigger, not by manual memory.

Current trigger map:

| Trigger | Skill |
|---|---|
| Writing any prompt for a Code Agent | `prompt-writing-standard` |
| Creating or updating project knowledge files | `knowledge-structure` |
| Creating or editing code files, file headers, RULE comments, or markup | `code-markup-standard` |
| Two failed fixes, recurring bug, or production incident | `bug-hunting` |
| T3 task, strategic decision, high reversal cost, or external facts | `research-protocol` |
| Creating or editing skills | `skill-writing-standard` |
| Planning or prompting any technical or design unit (components, modules, engines, tokens, forms) | `universality-discipline` |
| Writing any plan, brief, prompt, ADR, knowledge entry, or review summary containing hedging language ("possibly", "later", "should work", "not critical") | `anti-hedging-language` |
| Writing or reviewing any prompt that creates or modifies runtime behavior (feature, fix, refactor, schema migration, API change, integration, calculation, validation, parsing) | `real-path-verification` |
| Writing any plan, brief, or prompt for a T2-tier task (or for a micro-decision inside a research-protocol T3 session) — design-time forward thinking before the TASK block is formed | `forward-thinking-discipline` |
| Decomposing a task into a series of 3+ sequential Code Agent prompts forming one project increment — composes Series Charter before the first prompt | `series-design-discipline` |
| Auditing, reviewing, inspecting, testing, improving, reporting on, or preparing live audit prompts for websites, landing pages, frontend UI, public flows, SEO/AEO/GEO, accessibility, performance, forms, conversion, or public UI security/privacy | `site-audit` |
| Composing or running multi-prompt batches via Claude Code Routines | `standards/batch-execution-standard.md` + `docs/batch-execution-guide.md` |
| Composing or running Codex prompt batches via Codex | `standards/codex-batch-execution-standard.md` + `docs/codex-isolated-runner-setup.md` |
| First-time setup of the per-project batch launcher on a developer machine | `docs/routine-launcher-setup.md` |

## Non-Negotiable Rules

- GitHub is the source of truth. VDS is an execution environment, not a source of truth.
- Product-specific knowledge lives in the product repository, not in this workspace repository.
- Shared standards and skills live in this workspace repository, not duplicated across every product.
- No secrets, tokens, passwords, `.env` files, or private credentials are committed to GitHub.
- Existing documents and skills are edited only inside explicitly approved change scope.
- No style cleanup, simplification, restructuring, or meaning changes without explicit approval.
- The local Obsidian vault already exists and must not be recreated, reorganized, or structurally rewritten without explicit approval.

## Open Decisions

- Final folder structure of this workspace repository.
- Exact universal wording for AI model / Code Agent roles inside remaining skills.
- Template structure for new product repositories.
- Branch protection and PR workflow for this workspace repository.
