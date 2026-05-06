# Vibecoding Workspace Index

<!--
  @file:        workspace-index.md
  @description: Root navigation file for the Vibe Coding workspace infrastructure
  @updated:     2026-05-04
  @version:     0.2
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
| `skills/` | Reusable working procedures | Active: six universal skills migrated |
| `templates/` | Starter templates for product repositories | Active: strengthened product repository template present |
| `examples/` | Sample artifacts for validating workspace templates | Active: sample product repository template test present |
| `rules/` | Shared rules that are not product-specific | Active: root rules note present |
| `tools/` | External tools and MCP-related notes | Active: plugin registry present |
| `configs/` | Shared machine-readable configuration for runners and model profiles | Active: model profiles present |
| `prompts/` | Reusable prompt templates for workspace and product workflows | Active: project audit and knowledge repair prompts present |
| `scripts/` | Utility scripts for workspace operations | Pending setup |
| `docs/` | Supporting documentation | Active: repository and Codex workflow docs present |
| `.codex/` | Codex-specific repository instructions | Active |
| `AGENTS.md` | Root Code Agent instructions | Active |
| `workspace-index.md` | Root navigation file | Active |

Active standards files:

- `standards/VIBECODER_STANDARDS.md`
- `standards/VIBECODER_SYSTEM_INSTRUCTION.md`

Active templates:

- `templates/product-repo/` — includes Codex instructions and knowledge-structure-compliant starter files.

Active examples:

- `examples/sample-product-repo/` — sample product repository instantiated from the template.
- `examples/e2e/sanitized-staging-summary-example.json` — fake sanitized staging summary example for validator testing.

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

Active operational backlog:

- `skills/BACKLOG.md`

Active prompt templates:

- `prompts/project-inventory-audit.md`
- `prompts/knowledge-repair.md`

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

Current stage: skills universality migration.

Immediate next steps:

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
| `prompt-writing-standard` | 1 | Migrated to universal Code Agent wording | `skills/prompt-writing-standard-universal.md` |
| `knowledge-structure` | 2 | Migrated to universal Code Agent wording | `skills/knowledge-structure-universal.md` |
| `code-markup-standard` | 3 | Migrated to universal Code Agent wording | `skills/code-markup-standard-universal.md` |
| `bug-hunting` | 4 | Migrated to universal Code Agent wording | `skills/bug-hunting-universal.md` |
| `research-protocol` | 5 | Migrated to universal Code Agent wording | `skills/research-protocol-universal.md` |
| `skill-writing-standard` | 6 | Migrated to universal Code Agent wording | `skills/skill-writing-standard-universal.md` |

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

## Non-Negotiable Rules

- GitHub is the source of truth. VDS is an execution environment, not a source of truth.
- Product-specific knowledge lives in the product repository, not in this workspace repository.
- Shared standards and skills live in this workspace repository, not duplicated across every product.
- No secrets, tokens, passwords, `.env` files, or private credentials are committed to GitHub.
- Existing documents and skills are edited only inside explicitly approved change scope.
- No style cleanup, simplification, restructuring, or meaning changes without explicit approval.

## Open Decisions

- Final folder structure of this workspace repository.
- Exact universal wording for AI model / Code Agent roles inside remaining skills.
- Whether skill files are stored as flat markdown files or as `skills/<skill-name>/SKILL.md` folders.
- Template structure for new product repositories.
- Branch protection and PR workflow for this workspace repository.
