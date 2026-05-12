# Batch Execution Guide — Onboarding A New Product

<!--
  @file:        docs/batch-execution-guide.md
  @description: Step-by-step guide for connecting a product repository to batch execution
  @owner:       Claude (Anthropic)
  @updated:     2026-05-12
  @version:     1.2.0
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

You compose the batch in Claude.ai planning chat, push it to the product repo, fire the Routine via the `routine` launcher, and walk away. The Routine works through the queue while you do other things.

---

## Per-Machine One-Time Setup (Launcher)

Before onboarding the first product, the local launcher must exist on the developer machine. This is set up **once per machine**, not per product. Adding a second, third, or tenth product later only requires Step 4 of that setup (creating a new `.env` file).

See `docs/routine-launcher-setup.md` for full step-by-step instructions. In short:

- Wrapper script `~/bin/routine` (copied from `scripts/routine.sh` in this workspace).
- Per-project config files at `~/.config/routines/<project>.env` with `ROUTINE_API_URL` and `ROUTINE_API_TOKEN`.
- `trigger-batch` installed as `~/bin/trigger-batch` (copied from `scripts/trigger-batch.sh`).

If the launcher is already set up from a previous product, skip ahead to the per-product onboarding below.

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

### Step 2 — Verify Default Branch Is Set Correctly

Open the product repository's GitHub settings page (Settings → Branches). Confirm the **default branch** is the branch the deploy pipeline targets — typically `main`.

This sounds trivial but has caused multi-hour debugging sessions. Routines and the GitHub API both default to reading from the configured default branch when no explicit `ref` is given. If the default branch points at a stale branch left over from initial scaffolding (for example, a `claude/init-nextjs-project-*` branch that Claude created during project setup), the Routine reads a stale tree and reports recently-committed batches as "manifest not found."

Symptoms of a wrong default branch:
- Recently created batches do not appear when the Routine lists `prompts/queue/`.
- Only older, pre-scaffolding batches are visible.
- The branch shown at the top of the GitHub repo page is not `main`.

Fix: Settings → Branches → swap the default branch to `main` and confirm.

### Step 3 — Create A Telegram Bot For Notifications (One Bot For All Products)

If you don't yet have a notification bot:

1. Open BotFather in Telegram.
2. Send `/newbot`. Follow prompts to name it (e.g. `vibecoder_alerts_bot` or similar).
3. Save the bot token.
4. Get your `chat_id` from `@userinfobot`.

Use this same bot for all products — no need for separate bots per product.

### Step 4 — Create The Routine In Claude.ai

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
7. **Connectors:** disable any connectors not needed by the routine. The routine needs only repository access and bash. Disable project-specific MCPs (JCK AUTO Files, VDS Files, Yandex Metrika) — they leak permissions across products.
8. **Push permissions:** keep default (`claude/*` branches only).
9. Save the Routine. Note its name and the API trigger URL.

### Step 5 — Register The Project In The Launcher

On the developer machine, add a config file for this project so the `routine` launcher knows where to fire its batches.

Pick a short project shortname (3–5 lowercase letters, unique within `~/.config/routines/`). Examples: `jck` for JCK AUTO, `aks` for ai-knowledge-system.

```bash
cat > ~/.config/routines/<shortname>.env << 'EOF'
ROUTINE_API_URL="https://api.anthropic.com/v1/claude_code/routines/<trig_id>/fire"
ROUTINE_API_TOKEN="<bearer-token-from-step-4>"
EOF
chmod 600 ~/.config/routines/<shortname>.env
```

Verify with a dry-run:

```bash
ROUTINE_DRY_RUN=1 routine <shortname> batch-test
```

Expected: a `[dry-run] Would POST to: ...` block from `trigger-batch` showing the URL of this product's Routine. If the URL points elsewhere, the config file has the wrong URL — re-check the values from Step 4.

For the full setup walkthrough including troubleshooting, see `docs/routine-launcher-setup.md`.

### Step 6 — Document The Setup In Product Repository

Add a one-liner to the product's `knowledge/infrastructure.md` (or equivalent):

```
- Batch execution: Routine "<product> Batch Executor" in claude.ai/code/routines.
  Fire batches via `routine <shortname> <batch_id>` on the dev machine.
  See workspace docs/batch-execution-guide.md for details.
```

This is so future sessions of any AI agent know batch execution exists for this product and which shortname to use.

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

### Step C — Fire The Routine

On the developer machine, run:

```bash
routine <shortname> <batch_id>
```

Examples:

```bash
routine jck batch-2026-05-10-rate-limit-gate-fix
routine aks batch-2026-05-10-knowledge-init
```

Where:
- `<shortname>` is the project shortname registered in `~/.config/routines/<shortname>.env` (see Step 5 above).
- `<batch_id>` is the directory name in `prompts/queue/`.

The launcher:
1. Loads the project's Routine URL and token from its config file (in an isolated subshell — no environment vars leak into the developer shell).
2. Invokes `trigger-batch` with the batch_id.
3. Captures the HTTP status and session_id.
4. Appends an audit log line at `~/.local/state/routines/trigger.log`.

A successful fire shows `HTTP 200` and a `claude_code_session_id`. Telegram message arrives within a minute or two confirming the start.

The previous approach (writing curl commands by hand or per-product wrappers) is superseded — see `standards/batch-execution-standard.md` Section 12 for why.

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
- **Claude zones in workspace repo:** `templates/batch-execution/`, `standards/batch-execution-standard.md`, `docs/batch-execution-guide.md` (this file), `docs/routine-launcher-setup.md`, `scripts/routine.sh`, `scripts/trigger-batch.sh`.

When running a batch in a product repository: Codex should not be working on the same product repository simultaneously. Coordinate via Vasily — only one orchestrator works on a given product at a time.

When the batch routine is running: do not push manual commits to the product repository's main branch until the batch completes. The routine merges via auto-merge, manual commits during a batch can cause merge conflicts.

---

## Troubleshooting

**Routine doesn't trigger:**
- Verify the launcher is invoked correctly: `routine <shortname> <batch_id>` with both arguments.
- Verify the shortname exists: `ls ~/.config/routines/` should list `<shortname>.env`.
- Check the audit log: `tail ~/.local/state/routines/trigger.log` — was the fire actually attempted?

**Routine reports "manifest not found" but the batch is committed:**
- Most common cause: the product repo's default branch is not `main` (or whatever branch the batch was pushed to). Open the repo on GitHub → Settings → Branches → verify. See Step 2 above.
- Second most common cause: the token in the project's config file belongs to a different product's Routine. Check the trigger log — does the session_id match the Routine you expected? If the URL/token were copied from the wrong Routine settings page, the fire went to the wrong product.

**HTTP 401 from API:** auth failed. The token in `~/.config/routines/<shortname>.env` is wrong or has been regenerated. Update it from the Routine settings page.

**HTTP 404 from API:** the URL in the config file is wrong, or the Routine was deleted. Verify the URL in the Routine settings page.

**Health check fails for unrelated reasons:** if the production site has occasional flaky 503s, this will stop the batch. Use stable infrastructure or set `inter_prompt_wait_minutes` higher to give deploy more time to settle.

**Telegram messages don't arrive:** verify `TG_BOT_TOKEN` and `TG_CHAT_ID` in the Routine's Cloud Environment. Verify the bot was started by you (sent `/start` to it at least once) — Telegram blocks messages to bots you haven't initiated.

**Batch hits Max daily run limit (15/day):** rare with the "one batch = one routine run" model. If hit, use one-off scheduled run as escape hatch (does not count against daily cap).

**Cross-product confusion:** verify the shortname argument matches the project you intended. Audit log shows which Routine actually received each fire — `cat ~/.local/state/routines/trigger.log`. Routine names in `claude.ai/code/routines` should clearly identify the product.

For launcher-specific troubleshooting, see `docs/routine-launcher-setup.md` → "Known Failure Modes And Fixes."

---

## Changelog

- 2026-05-08 — v1.0 initial version. DS-серия pilot in jckauto.
- 2026-05-08 — v1.0.1: Removed reference to legacy `app/` layout in Step 1. Clarified that `prompts/queue/` is always at git root regardless of code organization, with examples.
- 2026-05-10 — v1.1.0: Per-project launcher integration. Step C now uses `routine <shortname> <batch_id>` instead of inline curl. Added Step 2 (verify default branch is `main`) and Step 5 (register project in launcher). Added pointer to `docs/routine-launcher-setup.md` for full launcher setup. Updated Troubleshooting with default-branch and wrong-token symptoms (motivated by a multi-hour cross-project routing incident).
- 2026-05-12 — v1.2.0: Discipline reinforcement after Batch A (ai-knowledge-system, 2026-05-11) retrospective. No content changes in this guide; the corresponding rules live in `standards/batch-execution-standard.md` v1.3.1 — Section 14 (Pre-commit Verification), Section 15 (Foundation As Separate Bootstrap PR), Section 16 (Branch Discipline). Open the standard for the actionable details; this guide remains the onboarding entry point.

When updating this guide, increment the version, add an entry above with date and summary of changes.
