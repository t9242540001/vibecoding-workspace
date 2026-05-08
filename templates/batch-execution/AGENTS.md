# Batch Execution Folder — Agent Instructions

<!--
  @file:        templates/batch-execution/AGENTS.md
  @description: Access rules for the batch execution infrastructure folder
  @owner:       Claude (Anthropic)
  @updated:     2026-05-08
  @version:     1.0
-->

## Folder Role

This folder contains the infrastructure for running prompt batches via Claude Code Routines. It is owned and maintained by Claude.

The contents of this folder are templates and standards that get copied or referenced by product repositories when they enable batch execution. Changes here propagate to every product that uses batches.

## Ownership And Boundaries

- **Owner:** Claude (Anthropic).
- **Co-existing systems:** Codex / ChatGPT orchestrator works elsewhere in this repository (`skills/`, `templates/product-repo/`, `prompts/project-inventory-audit.md`, `prompts/knowledge-repair.md`, the rest of `docs/` and `standards/`). Codex does not modify files inside this folder without explicit coordination with Vasily.
- **Other AI agents:** Any AI agent — Claude, Codex, future models — must read this file before editing anything in this folder.

## Change Discipline

Same rules as the root `AGENTS.md` of this repository, with one addition specific to this folder:

- No edits to files in this folder without explicit prior approval from Vasily.
- No "consistency cleanup", style normalization, or rewording — even if the change looks minor.
- If you (any AI agent) believe a file here is outdated, conflicting, or incorrect — do not fix it silently. Stop and ask Vasily.

The reason: these files define how prompt batches behave across all product repositories. A silent change here can affect production deployments in jckauto, whatscan, deepvest, yurassistent, productcenter-moderator and any future product without anyone noticing until something breaks.

## What Lives Here

- `routine-prompt.md` — the main prompt that gets pasted into Claude Code Routines when creating a batch executor. One template, parameterized via environment variables, used across all product repositories.
- `manifest-template.json` — schema and example of a batch manifest. Each batch in a product repository describes itself via a manifest based on this template.
- `prompt-template.md` — format reminder for individual prompts inside a batch queue. Aligns with `skills/prompt-writing-standard-universal.md`.
- `AGENTS.md` (this file) — access rules.

## What Does Not Live Here

- The standard for batch execution (rules, parade-of-prompts requirement, gate evolution) lives in `standards/batch-execution-standard.md`.
- The onboarding guide for connecting a new product to batch execution lives in `docs/batch-execution-guide.md`.
- Actual batch queues for specific products live in those products' own repositories under `prompts/queue/`, not here.

## Cross-References

- Root repository rules: `AGENTS.md` at the repository root.
- Single-prompt writing standard: `skills/prompt-writing-standard-universal.md`.
- Batch execution standard: `standards/batch-execution-standard.md` (created together with this folder).
- Onboarding guide: `docs/batch-execution-guide.md` (created together with this folder).
