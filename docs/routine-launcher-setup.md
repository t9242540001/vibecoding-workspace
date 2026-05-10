# Routine Launcher Setup — Per-Project Configuration

<!--
  @file:        docs/routine-launcher-setup.md
  @description: One-time setup steps for the `routine` per-project launcher
  @owner:       Claude (Anthropic)
  @updated:     2026-05-10
  @version:     1.0
-->

This guide explains how to set up the local launcher that triggers batches in any product Routine without manually swapping environment variables between projects. It supplements `docs/batch-execution-guide.md` — which covers what a batch is and how to compose one — and focuses purely on the local-machine ergonomics of firing batches across multiple products.

This document is for **Vasily** (the human running batches). For the underlying design rationale see Section 12 of `standards/batch-execution-standard.md`.

---

## What This Solves

Multiple products mean multiple Routines. Each Routine has its own API URL and bearer token. The original approach was a single pair of environment variables (`ROUTINE_API_URL`, `ROUTINE_API_TOKEN`) in `~/.bashrc`, swapped manually before firing each batch.

That approach failed in practice. The two failure modes that occurred during setup:

1. **Cross-project routing.** A token from project A leaked into the shell session while the developer thought he was working on project B. The next `trigger-batch` fired into project A's Routine, which then could not find the batch_id (because it was created in project B's repo) and reported a misleading "manifest not found" error. The actual cause — token mismatch — took several hours to identify.

2. **Stale environment.** The token in `.bashrc` was correct, but a previous `export` in the live shell session shadowed it with a different value. The shell looked fine on inspection (`.bashrc` had the right value) but `env | grep ROUTINE` showed the stale one. Same misleading errors followed.

Both failures share a single root cause: a single global namespace for credentials of multiple distinct services. The fix is per-project configs loaded explicitly by an explicit project argument.

---

## What You Get After Setup

After the steps below:

- One command per batch: `routine <project> <batch_id>`.
- No environment swapping. No risk of cross-project misrouting.
- Audit log of every trigger at `~/.local/state/routines/trigger.log` — useful when investigating "did I actually fire it, and where did it go?"
- Adding a new product is a one-file change (`~/.config/routines/<new>.env`). The launcher needs no modifications.

Examples after setup:

```
routine jck batch-2026-05-10-rate-limit-gate-fix
routine aks batch-2026-05-10-knowledge-init
```

The project shortname is part of the command. Routing is explicit. Tokens stay scoped to the project they belong to.

---

## Setup Steps

These steps are run **once** on the developer machine. Adding a new product later only requires Step 4 (create a new `.env` file).

### Step 1 — Back Up `.bashrc`

```bash
cp ~/.bashrc ~/.bashrc.backup-$(date +%s)
```

This is insurance. The next steps modify `.bashrc` via `sed`. If anything in your `.bashrc` wraps the routine env vars in an `if` block or unusual structure, `sed` may leave partial logic. The backup lets you restore in one command.

### Step 2 — Create The Config Directory

```bash
mkdir -p ~/.config/routines
chmod 700 ~/.config/routines
```

`0700` ensures only your user can list or read files inside. Other users on the machine — if any — cannot see the project configs.

### Step 3 — Verify `trigger-batch` Is Installed

```bash
which trigger-batch
```

Expected: `/home/<user>/bin/trigger-batch` or similar. The wrapper `routine` invokes `trigger-batch` under the hood — if `trigger-batch` is not on PATH, the wrapper will fail.

If `trigger-batch` is not installed, install it from `scripts/trigger-batch.sh` of vibecoding-workspace:

```bash
# Adjust source path to wherever you cloned vibecoding-workspace
cp ~/vibecoding-workspace/scripts/trigger-batch.sh ~/bin/trigger-batch
chmod +x ~/bin/trigger-batch
```

### Step 4 — Create A Config File Per Project

For each product, create one config file at `~/.config/routines/<project>.env`.

Pick a short project shortname (3–5 lowercase letters, no dashes, no spaces). It becomes the first argument to `routine`. Examples used in practice: `jck` for JCK AUTO, `aks` for ai-knowledge-system.

```bash
cat > ~/.config/routines/<shortname>.env << 'EOF'
ROUTINE_API_URL="https://api.anthropic.com/v1/claude_code/routines/<trig_id>/fire"
ROUTINE_API_TOKEN="<bearer-token>"
EOF
chmod 600 ~/.config/routines/<shortname>.env
```

Where to find the values:

- **ROUTINE_API_URL** — open the Routine in `claude.ai/code/routines/<trig_id>`. The full URL with `/fire` at the end is shown in the "API trigger" section of Routine settings.
- **ROUTINE_API_TOKEN** — same page. The token is shown alongside the URL. If you ever regenerate the token, update this file.

`chmod 600` ensures only your user can read the file. Bearer tokens are sensitive — treat the same way you would treat an SSH key.

Repeat Step 4 for every product. Each gets its own `.env` file.

### Step 5 — Install The Launcher

```bash
# Adjust source path to wherever you cloned vibecoding-workspace
cp ~/vibecoding-workspace/scripts/routine.sh ~/bin/routine
chmod +x ~/bin/routine
```

`routine` invokes `trigger-batch` internally. Both scripts need to be on PATH.

### Step 6 — Remove Legacy Global Env Vars From `.bashrc`

If `~/.bashrc` has lines like:

```bash
export ROUTINE_API_URL="..."
export ROUTINE_API_TOKEN="..."
```

— these were the old setup that the per-project launcher replaces. Remove them:

```bash
sed -i '/^export ROUTINE_API_URL=/d' ~/.bashrc
sed -i '/^export ROUTINE_API_TOKEN=/d' ~/.bashrc
```

If you skipped Step 1, **stop and back up `.bashrc` first**. `sed -i` is irreversible.

After running `sed`, clear the current shell's stale env so the new launcher sees clean state:

```bash
unset ROUTINE_API_URL ROUTINE_API_TOKEN
```

### Step 7 — Review What's Left In `~/bin/`

```bash
ls -la ~/bin/
```

Look for legacy per-project wrappers that may have accumulated during earlier ad-hoc attempts. Common names: `trigger-<project>`, `routine-<project>`, project-specific firing scripts. Remove the ones you recognize as obsolete:

```bash
rm ~/bin/trigger-<old-wrapper>
```

Do not remove anything you do not recognize. Better to leave an unknown script alone than to delete something useful by accident.

### Step 8 — Smoke Tests

Verify the launcher rejects unknown projects:

```bash
routine bogus batch-test
```

Expected output:

```
ERROR: no config for project 'bogus' at /home/<user>/.config/routines/bogus.env

Available projects:
  aks
  jck
```

Verify the launcher passes credentials correctly without firing (dry-run):

```bash
ROUTINE_DRY_RUN=1 routine <shortname> batch-test
```

Expected output (a `[dry-run] Would POST to: ...` block from `trigger-batch`, pointing at the right URL for that project). If the URL points to a different project, the config file has the wrong URL — re-check Step 4 for that shortname.

### Step 9 — Real Run

When ready to fire an actual batch (after the batch is prepared in the product repo):

```bash
routine <shortname> <batch_id>
```

The Routine accepts the trigger, returns HTTP 200, and the batch starts. A Telegram message arrives within a minute or two confirming the start.

---

## Audit Log

Every trigger is logged at `~/.local/state/routines/trigger.log`. Format (tab-separated):

```
<ISO timestamp UTC>\t<project>\t<batch_id>\tHTTP <code>\t<session_id>
```

Example contents:

```
2026-05-10T23:14:02Z	jck	batch-2026-05-10-rate-limit-gate-fix	HTTP 200	session_01ABC...
2026-05-10T23:30:45Z	aks	batch-2026-05-10-knowledge-init	HTTP 200	session_01DEF...
2026-05-10T23:45:11Z	jck	batch-2026-05-10-typo-fix	HTTP 401	none
```

The log is append-only and never rotated by the launcher itself. If it grows large, manual rotation is fine — just rename the file, the launcher will create a fresh one on the next fire.

Useful queries:

```bash
# Last 10 triggers across all projects
tail -10 ~/.local/state/routines/trigger.log

# All triggers for project jck today
grep "$(date -u +%Y-%m-%d).*jck" ~/.local/state/routines/trigger.log

# All failures (non-200 HTTP)
grep -v 'HTTP 2' ~/.local/state/routines/trigger.log
```

---

## Adding A New Project Later

When a new product joins the system:

1. Create the Routine in `claude.ai/code/routines` (per `docs/batch-execution-guide.md` Step 3).
2. Pick a shortname (3–5 letters, unique within `~/.config/routines/`).
3. Create the config file:

   ```bash
   cat > ~/.config/routines/<new-shortname>.env << 'EOF'
   ROUTINE_API_URL="https://api.anthropic.com/v1/claude_code/routines/<trig_id>/fire"
   ROUTINE_API_TOKEN="<bearer-token>"
   EOF
   chmod 600 ~/.config/routines/<new-shortname>.env
   ```

4. Test with `ROUTINE_DRY_RUN=1 routine <new-shortname> batch-test`.

No changes to the `routine` script. No changes to `.bashrc`. Adding the third or fifth or tenth project is one file each time.

---

## Known Failure Modes And Fixes

### "ERROR: no config for project 'X'"

The config file does not exist at `~/.config/routines/X.env`. Either you mistyped the shortname or you have not yet created the config for this project. The error message lists available projects — verify the shortname matches one of them.

### HTTP 401 from Routine

The token in the config file is wrong or has been regenerated. Open the Routine page in `claude.ai/code/routines`, copy the current token, update the config file:

```bash
# Replace just the token line
sed -i 's|^ROUTINE_API_TOKEN=.*|ROUTINE_API_TOKEN="<new-token>"|' \
  ~/.config/routines/<shortname>.env
```

### HTTP 404 from Routine

The URL in the config file is wrong, or the Routine was deleted. Verify the URL in the Routine settings page. If you regenerated the Routine, you have a new trigger ID — update the URL.

### "Routine reports manifest not found" but the file exists

This is the same class of error that originally motivated the per-project launcher. Run through these checks in order:

1. Was the batch_id typed correctly? Compare exact string with the directory name in the product repo.
2. Is the product repo's default branch on GitHub set to `main`? (Routines read from default branch by default. If it points at a stale branch, recent batches are invisible.)
3. Was the batch committed and pushed to the default branch? (`prep/<batch_id>` branch must be merged into main before the Routine sees it.)
4. Check the trigger log: does the `session_id` show a Routine that belongs to this project? If you see a session_id in the log but the Telegram message mentions a different product — the wrong config file was loaded (file naming mismatch with the shortname you typed).

### Launcher fires but no Telegram message arrives

Check the Routine's environment variables in `claude.ai/code/routines/<trig_id>` settings — `TG_BOT_TOKEN` and `TG_CHAT_ID` must be configured. Verify that the bot referenced by `TG_BOT_TOKEN` was started by the chat owner (Telegram blocks bot messages to chats that did not initiate contact).

---

## Why Not Other Approaches

The per-project launcher is one of four approaches considered. The others were rejected for the following reasons:

**Per-project shell aliases in `.bashrc`** — e.g. `alias trigger-jck='ROUTINE_API_URL=... trigger-batch'`. Tokens end up in plaintext in `.bashrc`, which is frequently version-controlled in dotfiles repos or copied across machines. Editing tokens requires opening `.bashrc` in a text editor — incompatible with the rule of running setup commands only.

**Per-project env-setting shell functions** — e.g. `jck_env && trigger-batch <id>`. Two-step invocation. State leaks between commands in the same shell. Forgetting the second step or the second step's project name routes to the previous project. Same root cause as the original bug.

**Auto-detection by current directory** — e.g. `trigger-batch <id>` infers project from `pwd`. Implicit. Vasily often fires batches from `~`, not from project directories. Magic with surprising failure modes.

The per-project launcher (Option C in the design discussion) is the only approach where misrouting is structurally impossible — there is no shared mutable global state, and the project name is explicit in every command.

---

## Reference Files

- Wrapper script: `scripts/routine.sh`
- Underlying primitive: `scripts/trigger-batch.sh`
- Batch composition: `docs/batch-execution-guide.md`
- Standard for batch execution: `standards/batch-execution-standard.md` (Section 12 covers the launcher design)
- Routine template: `templates/batch-execution/routine-prompt.md`

---

## Changelog

- 2026-05-10 — v1.0 initial version. Documents per-project launcher introduced after a cross-project routing incident traced to shared global ROUTINE_API_* env vars.

When updating this guide, increment the version, add an entry above with date and summary of changes.
