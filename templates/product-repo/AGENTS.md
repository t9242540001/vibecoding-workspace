# Product Repository Agent Instructions

## Project Role

This repository is a product repository for `<project-name>`. It contains project-specific code, context, infrastructure notes, and knowledge files.

## Read Order

1. `AGENTS.md`
2. `CLAUDE.md` or the equivalent main project context file
3. `knowledge/INDEX.md`
4. Relevant `knowledge/*.md` files
5. Affected implementation files

## Change Discipline

- Inspect relevant files before editing.
- Use `rg` where useful for search.
- Make the smallest correct change.
- Do not touch unrelated files.
- Keep project knowledge current when a change creates or changes durable facts.

## Commands

- Install: `<install command>`
- Test: `<test command>`
- Lint: `<lint command>`
- Run locally: `<run command>`
- Deploy: `<deploy command>`

## Verification

- Run relevant verification commands when they are known.
- If verification cannot run, report why.
- Check `git status --short` before finishing.

## Autonomous Runner Rule

For long-running Codex batches or autonomous repo-local work, use this product's repo-scoped project runner instead of decomposing the work into repeated Codex Desktop approval prompts.

The project should provide:

- a project command router;
- a hardened Codex runner launcher;
- a batch auto-checkpoint launcher;
- a trusted checkpoint wrapper.

Normal runner work may proceed without repeated approvals only inside the repo-scoped runner. Ask again before deletes, destructive Git operations, outside-repo access, secrets/credentials, production/deploy/server/database/auth/payment/PII actions, or force push/history rewrite.

## Risk Areas

- `<risk area 1>`
- `<risk area 2>`
- `<risk area 3>`

## Out Of Scope Unless Requested

- Style cleanup unrelated to the task.
- Opportunistic refactors.
- Dependency swaps.
- Architecture changes.
- Production or deployment changes.

## Secrets Rule

Never commit secrets, `.env` files, tokens, credentials, passwords, or private keys.
