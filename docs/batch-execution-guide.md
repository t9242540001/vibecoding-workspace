# Batch Execution Guide — Onboarding A New Product

<!--
  @file:        docs/batch-execution-guide.md
  @description: Step-by-step guide for connecting a product repository to batch execution
  @owner:       Claude (Anthropic)
  @updated:     2026-05-08
  @version:     1.0.1
-->

This guide is for Vasily. It explains how to connect a product repository to the batch execution system so that prompt series can run automatically without manual intervention between prompts.

## What This System Does

Instead of executing prompts one at a time and waiting for each deploy manually, you compose a series of prompts (a "batch") and trigger a Routine in Claude.ai that:

1. Reads the batch manifest from the product repository.
2. Executes each prompt in order, committing to a branch.
3. Waits for auto-merge and deploy between prompts (default 10 minutes).
4. Verifies the site is alive after each prompt via health check.
5. Sends Telegram notifications on start, after each prompt, and at the end.
6. Stops automatically if any prompt fails health check.

You compose the batch in Claude.ai planning chat, push it to the product repo, trigger the Routine via API, and walk away. The Routine works through the queue while you do other things.

---

## One-Time Setup Per Product

These steps are done once for each product (jckauto, whatscan, deepvest, yurassistent, productcenter-moderator). Subsequent batches reuse the same setup.

### Step 1 — Add Queue Folder To Product Repository

Create the folder `prompts/queue/` at the **git root** of the product repository. This is where individual batches will live.

The routine reads `prompts/queue/{batch_id}/manifest.json` from git root after `git clone`. This is a fixed behavior of the routine — the folder must be at git root regardless of how the rest of the repository is organized (single Next.js app, monorepo, multi-folder layout, etc.).

Examples:
- `JCK-AUTO/` (git root) → `JCK-AUTO/prompts/queue/{batch_id}/`
- Code lives in subfolder `JCK-AUTO/jck-auto/`? Still `JCK-AUTO/prompts/queue/`, not `JCK-AUTO/jck-auto/prompts/queue/`.
- Monorepo with multiple apps? Still single `prompts/queue/` at git root, batch_id distinguishes between targets.

Add a `.gitkeep` file inside `prompts/queue/` so the empty folder commits to git. Or add a `README.md` inside explaining what this folder is for (recommended).

### Step 2 — Create A Telegram Bot For Notifications (One Bot For All Products)

If you don't yet have a notification bot:

1. Open BotFather in Telegram.
2. Send `/newbot`. Follow prompts to name it (e.g. `vibecoder_alerts_bot` or similar).
3. Save the bot token.
4. Get your `chat_id` from `@userinfobot`.

Use this same bot for all products — no need for separate bots per product.

### Step 3 — Create The Routine In Claude.ai

1. Open https://claude.ai/code/routines.
2. Click "Create Routine".
3. **Prompt:** copy the entire content from `templates/batch-execution/routine-prompt.md` (between the `--- BEGIN ROUTINE PROMPT ---` and `--- END ROUTINE PROMPT ---` markers in this workspace repository) and paste into the Routine prompt field.
4. **Connected repositories:** select the product repository (e.g. `t9242540001/JCK-AUTO`).
5. **Trigger:** select "API" trigger. Generate and save the API token shown.
6. **Cloud Environment:** add these environment variables:
   - `TG_BOT_TOKEN` — your notification bot token
   - `TG_CHAT_ID` — your chat ID
   - `HEALTH_URL` — full URL to verify after each prompt (for jckauto: `https://jckauto.ru/`)
   - `INTER_PROMPT_WAIT_MINUTES` — `10` (default; increase if deploy is consistently slower)
7. **Connectors:** disable any connectors not needed by the routine. The routine needs only repository access and bash. Disable JCK AUTO Files MCP, VDS Files MCP, Yandex Metrika MCP — they leak permissions.
8. **Push permissions:** keep default (`claude/*` branches only).
9. Save the Routine. Note its name and the API trigger URL.

### Step 4 — Document The Setup In Product Repository

Add a one-liner to the product's `knowledge/infrastructure.md` (or equivalent):

```
- Batch execution: Routine "Batch Executor" in claude.ai/code/routines
  triggers via API on prompts/queue/{batch_id}/manifest.json.
  See workspace docs/batch-execution-guide.md for details.
```

This is so future sessions of any AI agent know batch execution exists for this product.

---

## Per-Batch Workflow

For each batch you want to run:

### Step A — Compose The Batch In Claude.ai Planning Chat

1. State the goal of the batch in the planning chat with Claude.
2. Claude analyzes the project (via GitHub MCP), proposes a sequence of prompts, and presents a "parade of prompts" — a 1-2 line summary of each prompt for your review.
3. You approve the parade. Claude writes each prompt as a separate file following `templates/batch-execution/prompt-template.md`.
4. Claude composes the manifest based on `templates/batch-execution/manifest-template.json`.

### Step B — Push The Batch To The Product Repository

Claude commits the manifest and prompt files into the product repository under:

```
prompts/queue/{batch_id}/
├── manifest.json
├── 01-first-prompt.md
├── 02-second-prompt.md
└── ...
```

The commit goes to a branch named `prep/{batch_id}` (not `claude/...` — that namespace is reserved for the routine's working branch). The branch is merged to main manually or via the product's auto-merge if configured for `prep/*`.

### Step C — Trigger The Routine

Send a POST request to the Routine's API trigger URL with the `batch_id` in the request body:

```
curl -s -X POST "{routine_api_url}" \
  -H "Authorization: Bearer {routine_api_token}" \
  -H "Content-Type: application/json" \
  -d '{"text": "batch-2026-05-08-design-system-finish"}'
```

Save this curl command as a snippet — you'll reuse it for every batch in this product.

### Step D — Monitor Via Telegram

The Routine sends a start message to Telegram. Then a message after each prompt. Then a completion message.

If any prompt fails health check, the routine stops and Telegram tells you which prompt failed and why.

### Step E — Review After Completion

After the batch completes:
1. Check the final state in the product repository (manifest shows all `done` or details on failures).
2. Verify the production site looks correct visually (the routine only checks HTTP 200, not visual correctness).
3. Update `knowledge/roadmap.md` in the product repository: mark completed items.

---

## Coordinating With Codex

Codex (ChatGPT orchestrator) operates in this same workspace repository but in different folders. To avoid conflicts:

- **Codex zones in workspace repo:** `skills/`, `templates/product-repo/`, `prompts/project-inventory-audit.md`, `prompts/knowledge-repair.md`, most of `docs/`, most of `standards/`.
- **Claude zones in workspace repo:** `templates/batch-execution/`, `standards/batch-execution-standard.md`, `docs/batch-execution-guide.md` (this file).

When running a batch in a product repository: Codex should not be working on the same product repository simultaneously. Coordinate via Vasily — only one orchestrator works on a given product at a time.

When the batch routine is running: do not push manual commits to the product repository's main branch until the batch completes. The routine merges via auto-merge, manual commits during a batch can cause merge conflicts.

---

## Troubleshooting

**Routine doesn't trigger:** verify the API URL and token are correct. Check that the JSON payload contains `text` field with the batch_id.

**Routine starts but immediately fails:** check Telegram for the error message. Most common causes — manifest malformed, prompt file missing, branch name conflict.

**Health check fails for unrelated reasons:** if the production site has occasional flaky 503s, this will stop the batch. Use stable infrastructure or set `inter_prompt_wait_minutes` higher to give deploy more time to settle.

**Telegram messages don't arrive:** verify `TG_BOT_TOKEN` and `TG_CHAT_ID` in Cloud Environment. Verify the bot was started by you (sent `/start` to it at least once) — Telegram blocks messages to bots you haven't initiated.

**Batch hits Max daily run limit (15/day):** rare with the "one batch = one routine run" model. If hit, use one-off scheduled run as escape hatch (does not count against daily cap).

**Cross-product confusion:** verify you're triggering the correct Routine for the correct product. Routine names should clearly identify the product (e.g. "JCK AUTO Batch Executor", "WhatScan Batch Executor").

---

## Changelog

- 2026-05-08 — v1.0 initial version. DS-серия pilot in jckauto.
- 2026-05-08 — v1.0.1: Removed reference to legacy `app/` layout in Step 1. Clarified that `prompts/queue/` is always at git root regardless of code organization, with examples.

When updating this guide, increment the version, add an entry above with date and summary of changes.
