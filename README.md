# vibecoding-workspace

Workspace infrastructure for Vibe Coding: standards, skills, templates, rules, tools, and project knowledge structure.

## Purpose

This repository is the shared infrastructure center for Vibe Coding.

It stores universal working procedures and templates. Product repositories remain separate and contain only their own project-specific code, context, infrastructure notes, and knowledge files.

`_local/` is the standard ignored local-only project folder for temporary source materials, research, exports, screenshots, and drafts.

## Current status

Initial setup is in progress.

Active navigation file:

- `workspace-index.md`

Root agent layer:

- `AGENTS.md`
- `.codex/instructions.md`
- `.codex/skills/README.md`

Core standards:

- `standards/VIBECODER_STANDARDS.md`
- `standards/VIBECODER_SYSTEM_INSTRUCTION.md`
- `standards/batch-execution-standard.md`
- `standards/codex-batch-execution-standard.md`

Templates:

- `templates/product-repo/` — product repository template with Codex instructions and knowledge-structure-compliant starter files.
- `templates/batch-execution/` — Claude Routine-specific manifest, prompt, and routine-prompt templates for batch execution unless explicitly generalized later.

Examples:

- `examples/sample-product-repo/` — sample product repository instantiated from the template.

Tools, rules, and docs:

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
- `docs/batch-execution-guide.md` — onboarding a new product to the batch execution system
- `docs/routine-launcher-setup.md` — setting up the per-project batch launcher on a developer machine

Scripts:

- `scripts/trigger-batch.sh` — Claude Routine-specific low-level API primitive: POSTs to a Routine's fire endpoint unless explicitly generalized later.
- `scripts/routine.sh` — Claude Routine-specific per-project launcher: `routine <project> <batch_id>` invokes `trigger-batch` with per-project credentials loaded from `~/.config/routines/<project>.env` unless explicitly generalized later.

Prompt templates:

- `prompts/project-inventory-audit.md`
- `prompts/knowledge-repair.md`

Operational backlog:

- `skills/BACKLOG.md`

Migrated skills:

- `skills/prompt-writing-standard-universal.md` — universal Code Agent prompt workflow, approved and uploaded.
- `skills/knowledge-structure-universal.md`
- `skills/code-markup-standard-universal.md`
- `skills/bug-hunting-universal.md`
- `skills/research-protocol-universal.md`
- `skills/skill-writing-standard-universal.md`

Skills pending universality audit:

- None.

## Operating rule

No skill, standard, template, or knowledge file is changed outside explicitly approved scope. No style cleanup, simplification, restructuring, or meaning changes without approval.
