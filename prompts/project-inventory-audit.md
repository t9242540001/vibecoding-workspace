# Project Inventory Audit Prompt

## CONTEXT

Project: `<project-name>`
Repository: `<owner>/<repo>`
Branch: `<branch>`

This is a product repository. It may already contain project context, agent instructions, knowledge files, local Codex instructions, or project rules.

The goal is to audit the repository before adding or changing `AGENTS.md`, `CLAUDE.md`, `knowledge/`, or `.codex/`.

## TASK

Run an inventory/audit only.

Inspect direct paths through the local filesystem or Git, not only search results.

Check for:

- `README.md`;
- `AGENTS.md`;
- `CLAUDE.md` or equivalent main context files;
- `knowledge/`;
- `.codex/`;
- docs with project rules;
- environment examples such as `.env.example`;
- dependency files;
- GitHub workflows;
- key application entrypoints;
- deploy, rollback, or infrastructure notes.

Report:

- existing context and knowledge files;
- current project structure;
- how existing structure compares with `templates/product-repo/`;
- gaps, duplicates, or conflicting instructions;
- secrets risk or files that may contain sensitive operational values;
- recommended next step.

## REGRESSION SHIELD

- Do not modify files.
- Do not create files.
- Do not stage, commit, or push.
- Do not initialize or overwrite knowledge.
- Do not rely only on GitHub search to decide whether files exist.
- Preserve existing knowledge and instructions.
- Do not expose secrets, tokens, passwords, private keys, `.env` values, or credentials in the report.

## ACCEPTANCE CRITERIA

- Direct paths were checked for existing `AGENTS.md`, `CLAUDE.md`, `knowledge/`, `.codex/`, and project-rule docs.
- Existing docs and project structure are reported.
- Secrets risk is assessed without revealing sensitive values.
- A recommended next step is provided.
- No files were modified.
- No commit or push was created.
