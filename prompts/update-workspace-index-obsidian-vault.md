# Codex Task: Update workspace-index.md with active Obsidian vault status

## Scope

Update only `workspace-index.md` in `t9242540001/vibecoding-workspace`.

## Goal

Make the root workspace navigation file reflect the already completed local Obsidian vault setup.

Known facts to add:

- Local Obsidian vault path: `D:\WipeCoder\Obsidian\Vibe Knowledge`.
- Obsidian sees and opens the vault.
- Starter skeleton is created.
- Git history is initialized for the vault.
- The vault must not be recreated or reorganized unless Vasily explicitly asks.
- Next knowledge-building step: add real context packs / working routes such as `project-audit` and `website-audit`.

## Required minimal edits

1. Increment metadata version in the header by one patch version.
2. In `## Architecture`, add `local Obsidian vault` as a layer after `GitHub repositories`.
3. Add a short subsection near Repository Roles:

```md
### Local Obsidian vault

Role: local long-term knowledge base for WipeCoder/Vibe Coding context.

Status:

- Active vault path: `D:\WipeCoder\Obsidian\Vibe Knowledge`.
- Obsidian sees and opens the vault.
- Starter skeleton is created.
- Git history is initialized for the vault.
- Next step: add real context packs and working routes, such as `project-audit` and `website-audit`, without breaking the existing skeleton.
```

4. In `## Current Setup Stage`, update only the current-stage sentence or add a small `Current Obsidian status` block with the same facts.
5. In `## Non-Negotiable Rules`, add one bullet:

```md
- The local Obsidian vault already exists and must not be recreated, reorganized, or structurally rewritten without explicit approval.
```

## Forbidden changes

- Do not rewrite the whole file stylistically.
- Do not reorder existing sections.
- Do not change skills migration content.
- Do not change browser/E2E status.
- Do not change product repository rules.
- Do not touch other files unless needed only for an explicit report.
- Do not invent new vault structure.

## Verification

After editing:

1. Show diff.
2. Confirm only `workspace-index.md` changed.
3. Confirm the meaning matches `README.md`, `AGENTS.md`, `docs/next-steps.md`, and `docs/obsidian-vault-status.md`.
4. Confirm no out-of-scope text changed.

## Commit

Commit message:

```text
docs: update workspace index with obsidian vault status
```
