# Batch Execution Standard

<!--
  @file:        standards/batch-execution-standard.md
  @description: Standard for running prompt batches via Claude Code Routines
  @owner:       Claude (Anthropic)
  @updated:     2026-05-10
  @version:     1.1
-->

This standard supplements `standards/VIBECODER_STANDARDS.md`. It defines rules for composing and running batches of prompts via Claude Code Routines.

This standard does not modify the existing `VIBECODER_STANDARDS.md`. The two documents coexist — `VIBECODER_STANDARDS.md` covers single-prompt workflows, this standard covers multi-prompt batch workflows.

---

## 1. What Is A Batch

A **batch** is a sequence of prompts that execute in a single Routine run, with automatic deploy and health verification between each prompt. The batch is described by a manifest file in the product repository under `prompts/queue/{batch_id}/manifest.json`.

A batch is not a different kind of work — it is a different delivery mechanism for the same prompts. Each prompt inside a batch follows the same `prompt-writing-standard-universal.md` rules as a standalone prompt.

The point of batches is to remove human waiting time between prompts (typically 10-15 minutes per prompt for auto-merge and deploy). For a series of 8 prompts this saves 1-2 hours of Vasily sitting at the computer.

---

## 2. When To Use A Batch Vs Single Prompts

Use a batch when:
- The work is naturally a series of related, atomic prompts (3 or more).
- Each prompt's success criteria is verifiable independently.
- Each prompt produces a working state that can be deployed.
- The cost of a failed prompt mid-batch is recoverable (rollback or fix-forward).

Use single prompts (current workflow) when:
- The task is a single change, one or two files.
- Prompts have ambiguous boundaries that need clarification mid-flight.
- Vasily wants to inspect each result before the next prompt.
- The work is exploratory — composition of prompts emerges as work progresses.

There is no zone of work that is "off-limits to batches." Critical zones (calculator, lead form, tariffs, user-facing copy in jckauto) require **higher quality of each individual prompt**, not avoidance of batches. A well-prepared batch in a critical zone is safer than a poorly-prepared single prompt in the same zone.

---

## 3. Preparation Quality = Result Quality

A batch executes without manual intervention. There is no opportunity to course-correct mid-flight. This means **all the careful thinking happens before the batch starts**, not during.

Time saved by automation must be reinvested in preparation:

- Deeper prototyping of complex tasks before any prompt is written.
- More thorough analysis of affected files via GitHub MCP.
- Stronger Step 9 reviews from `prompt-writing-standard-universal.md`.
- More explicit regression shields per prompt.
- Wider scope mapping ("what else could break if this prompt does its work?").

For batches that touch high-stakes zones (calculator logic, payment flows, lead capture, legal text, tariff calculations), this preparation quality must be **explicitly verified** — not assumed:

- Every prompt in the batch passes the full Step 9 review (three perspectives, scope integrity check) — no shortcuts.
- The Stakeholder review explicitly considers the user-facing impact of regression.
- The Domain expert review is performed by the most appropriate domain (financial analyst for calculator, lawyer for legal text, etc.).
- The Technical review explicitly checks for bypass vectors of the regression shield.

---

## 4. Parade Of Prompts — Mandatory Pre-Flight Review

Before any batch is committed and triggered, Claude presents to Vasily a **parade of prompts** — a compact summary of the entire batch:

```
Batch: {batch_id}
Total prompts: N
Telegram notify: yes/no
Stop on failure: yes/no
Inter-prompt wait: 10 minutes

01. [Title] — what it does (1 line) — what it does NOT touch (1 line)
02. [Title] — what it does — what it does not touch
...
NN. [Title] — what it does — what it does not touch
```

Vasily reviews the parade in 2-5 minutes. He can:
- Approve as-is.
- Reject specific prompts ("remove 05, it's not safe yet").
- Reorder ("swap 03 and 04, dependencies are wrong").
- Request rewrites ("07 needs to be split into two").

The parade is not optional — it is the last point where a human looks at the entire shape of the batch before automation takes over. A batch without an approved parade does not get triggered.

---

## 5. Manifest Schema Compliance

Every batch manifest follows the structure defined in `templates/batch-execution/manifest-template.json`. Deviations from the schema cause the routine to fail validation and abort the batch.

When the schema needs to change (new fields, removed fields, semantic changes):
1. Update the template in `templates/batch-execution/manifest-template.json`.
2. Update the routine prompt in `templates/batch-execution/routine-prompt.md` to handle the new schema.
3. Update this standard.
4. Update existing Routines (paste the new routine-prompt into each one).
5. Bump version of all three files.

Manifests in product repositories use the latest schema at the time the batch is composed. Older completed batches keep their original schema (immutable historical record).

---

## 6. Branch Naming Conventions

Three branch namespaces exist for batches:

| Branch pattern | Owner | Purpose |
|---|---|---|
| `prep/{batch_id}` | Claude planning chat | Holds the batch manifest and prompt files. Merged to main manually or via auto-merge configured for `prep/*`. |
| `claude/{batch_id}` | Routine | Working branch where the routine commits each prompt's output. Auto-merges to main per existing repo configuration. |
| `claude/*` (general) | Single-prompt Code Agent sessions | Existing pattern for non-batch work. Unchanged by this standard. |

Why two namespaces (`prep/` and `claude/`):
- The batch description (manifest + prompt files) is itself a code change to the repo. It should be reviewable as a unit before the batch starts.
- The batch execution branch (`claude/{batch_id}`) starts from main after `prep/{batch_id}` is merged. This way the routine works on a clean main with the batch already declared, not on a moving target.

**Default branch requirement.** The product repository's default branch on GitHub **must** be `main` (or whatever branch the deploy pipeline targets). Routines and the GitHub API both default to reading from the repo's configured default branch when no explicit `ref` is given. If the default branch points elsewhere — for example a stale `claude/init-*` branch left over from initial scaffolding — the Routine reads a stale tree and reports recently-created batches as "manifest not found." Before onboarding a new product, verify on the GitHub repo settings page that the default branch is set to the working branch.

---

## 7. Gate Mechanism Evolution

Health verification between prompts is a gate. The gate's strictness should evolve with project maturity:

### Level 1 — HTTP 200 On Main Page

Current default. Suitable for:
- CSS/styling changes (DS series).
- Non-critical UI tweaks.
- Any change that, if broken, surfaces as immediate visual regression Vasily would notice in seconds.

What it catches: server crashes, build failures, total page failures (5xx).
What it misses: visual regressions, broken interactivity, logic errors.

### Level 2 — Basic `/api/health` Endpoint

Recommended for:
- Logic changes (calculator updates, form validation, API changes).
- Database schema changes.
- Any change where breakage might not be visually obvious.

The endpoint checks: server alive, key data files readable, basic API endpoints respond. Implementation is one prompt (10-30 minutes of Code Agent work). Add as the first prompt of a batch that needs this level.

### Level 3 — Full Liveness Monitoring With Dashboard

Recommended for:
- Critical user flows (payment, lead capture, calculator with financial impact).
- Any change to systems where silent breakage costs money or trust.

Full implementation includes:
- `/api/health` checking multiple subsystems.
- Synthetic user-flow tests (calculator computes correct value for known input, lead form accepts test submission).
- Dashboard panel showing per-system status with history.
- Telegram alerts on degraded health independent of batches.
- Auto-run every 15 minutes regardless of batch activity.

This is a separate workstream, not a batch prerequisite. Tracked as `NEW-MONITOR-1` in product roadmaps.

### Choosing The Right Level

Default: Level 1 for any new product or first batches.

Upgrade to Level 2 when:
- A batch is planned for logic changes and the cost of silent breakage is non-trivial.
- After a Level 1 batch had a near-miss (build passed, site loaded, but something logical broke).

Upgrade to Level 3 when:
- The product matures enough that monitoring becomes a product feature, not just a batch gate.
- After any incident where Level 1 or Level 2 missed a regression that hurt users.

---

## 8. Failure Recovery

When a prompt fails health check:

1. The routine sets `prompts[i].status = "failed"`, records `failure_reason`, commits manifest.
2. If `stop_on_failure: true` (default and recommended) — the routine stops, sends Telegram alert.
3. Vasily decides:
   - **Roll back the failed prompt's commit and rerun.** If the failure was transient (deploy timing, flaky external service): `git revert {failed_commit}` on `claude/{batch_id}` branch, push, manually retrigger the routine with the same batch_id (the routine resumes from the next pending prompt, skipping done ones).
   - **Fix the failed prompt and continue.** Edit the prompt file, reset its status to `pending`, retrigger.
   - **Abandon the batch.** Mark all remaining prompts `skipped`, accept partial completion. Document in `knowledge/roadmap.md` what completed and what didn't.

Never:
- Continue a failed batch by pretending the failure didn't happen.
- Change `stop_on_failure` to `false` mid-batch to "skip past" a problem.
- Modify the manifest's `prompts[i].status` to `done` when the prompt actually failed.

---

## 9. Concurrent Batches Across Products

Each product has its own Routine. Batches in different products can run concurrently — they don't share state.

Within one product, only one batch runs at a time. The routine is single-tenant per product.

If a batch is running on jckauto and Vasily wants to push a manual commit to jckauto main during the run — wait for the batch to complete. Manual commits during a batch can cause merge conflicts on the routine's working branch.

---

## 10. Daily Run Cap (Max Plan)

Anthropic Max plan: 15 Routine runs per day. Each batch counts as one run, regardless of how many prompts are inside.

15 batches per day across all products is far more than typical work. The cap is not a practical constraint for normal workflows.

If hit (e.g. multiple parallel pilots in one day): use one-off scheduled runs (do not count against daily cap) for the next batch as an escape hatch.

---

## 11. Reference Files

- Single-prompt writing standard: `skills/prompt-writing-standard-universal.md`
- Knowledge structure: `skills/knowledge-structure-universal.md`
- Bug hunting (when batches fail repeatedly): `skills/bug-hunting-universal.md`
- Onboarding guide: `docs/batch-execution-guide.md`
- Per-project launcher setup: `docs/routine-launcher-setup.md`
- Routine prompt template: `templates/batch-execution/routine-prompt.md`
- Manifest template: `templates/batch-execution/manifest-template.json`
- Single-prompt template: `templates/batch-execution/prompt-template.md`
- Wrapper script (per-project launcher): `scripts/routine.sh`
- Underlying API primitive: `scripts/trigger-batch.sh`

---

## 12. Per-Project Launcher

Section 1–11 cover *what* a batch is and *what* the Routine does with it. This section covers *how* batches are fired from the developer's machine when multiple products coexist.

### 12.1 Problem

Each product has its own Routine in `claude.ai/code/routines`, each with its own API URL and bearer token. The original launcher (`scripts/trigger-batch.sh`) reads these from two environment variables: `ROUTINE_API_URL` and `ROUTINE_API_TOKEN`. A single global pair of credentials worked for a single-product setup. It does not work for multi-product setups for two reasons:

1. **Cross-project routing failures.** A token belonging to product A can silently route a trigger meant for product B into product A's Routine. The Anthropic API authenticates and dispatches based on the bearer token; URL is informational. If URL says "B's endpoint" but the token belongs to A, the API routes to A's Routine, which reports "manifest not found" because the batch_id was prepared in B's repo.

2. **Stale shell state.** Even with the "correct" values in `.bashrc`, an earlier `export` in the live shell session shadows them. `env | grep ROUTINE` shows the stale values; `.bashrc` shows the fresh ones. The mismatch is invisible without explicit inspection.

Both failures share a root cause: one global namespace for credentials of multiple distinct services.

### 12.2 Design

A wrapper script — `scripts/routine.sh`, installed as `~/bin/routine` on the developer machine — loads per-project credentials from `~/.config/routines/<project>.env` files in an isolated subshell, then invokes `trigger-batch`. The project name is the first argument to the wrapper, so routing is always explicit at the call site.

Calling convention:

```
routine <project> <batch_id>
```

Examples:

```
routine jck batch-2026-05-10-rate-limit-gate-fix
routine aks batch-2026-05-10-knowledge-init
```

Properties this design guarantees:

- **No global env vars.** `~/.bashrc` does not declare `ROUTINE_API_URL` or `ROUTINE_API_TOKEN` at all. The wrapper handles all loading.
- **No leakage between projects.** Credentials are loaded inside `( ... )` subshell; they exist only between `(` and `)`. After the subshell exits, no env state remains.
- **Misrouting structurally impossible.** The project name is part of every command. There is no implicit default and no shell-state to forget.
- **Audit trail.** Every fire is logged at `~/.local/state/routines/trigger.log` with timestamp, project, batch_id, HTTP status, and session_id.
- **Adding a new project is one file.** Drop `~/.config/routines/<new>.env` containing `ROUTINE_API_URL` and `ROUTINE_API_TOKEN`. No wrapper changes.

### 12.3 Rejected Alternatives

Four approaches were considered. Three were rejected:

- **Shell aliases per project** — `alias trigger-jck='ROUTINE_API_URL=... trigger-batch'`. Stores tokens in plaintext in `.bashrc`, which is often dotfile-managed and synced across machines. Editing tokens requires text-editor mode, which is incompatible with "setup via commands only."
- **Shell functions per project** — `jck_env && trigger-batch <id>`. Two-step invocation. State leaks between commands in the same shell session. Forgetting the project-setting step or typing the wrong one routes to whatever was set previously — same failure mode as the original bug, just slightly delayed.
- **Auto-detection by current working directory** — `trigger-batch <id>` infers project from `pwd`. Implicit magic. The developer often fires batches from `~`, not from project directories. Surprising failure modes when run from the wrong path.

The wrapper-plus-per-project-config approach is the only one where misrouting cannot happen by construction — there is no shared mutable state and the project name is explicit in every command.

### 12.4 Setup Steps

Setup is one-time per developer machine. See `docs/routine-launcher-setup.md` for step-by-step instructions including:

- Creating the config directory with correct permissions
- Writing per-project `.env` files
- Installing the wrapper script
- Removing legacy global env vars from `.bashrc`
- Smoke testing
- Adding new projects later

The setup guide also documents the failure modes that motivated the design and lists known troubleshooting steps for each error class.

### 12.5 Integration With Section 6 (Branch Conventions)

A common error class during initial launcher setup was "Routine reports manifest not found even though the batch was committed." Often this was a launcher issue (wrong credentials), but in one case it was a **default branch issue**: the product repository's default branch on GitHub was pointing at a stale `claude/init-*` branch instead of `main`. The Routine read the stale tree and saw none of the recent batches.

Section 6 was updated in v1.1 to make the default branch requirement explicit. The launcher and the default branch are orthogonal — both need to be correct. When `routine <project> <batch_id>` returns "manifest not found", check both: the trigger log for which Routine actually received the fire, and the GitHub repo settings for the current default branch.

---

## Changelog

- 2026-05-08 — v1.0 initial version. Defines parade-of-prompts rule, gate evolution levels, failure recovery, branch naming.
- 2026-05-10 — v1.1. Added Section 12 (Per-Project Launcher) documenting the multi-product credential design. Updated Section 6 with explicit default branch requirement. Updated Section 11 reference list with `routine.sh` and `routine-launcher-setup.md`. Motivated by a multi-hour cross-project routing incident that traced to shared global ROUTINE_API_* environment variables in the original single-product launcher.

When updating this standard, increment the version, add an entry above with date and summary of changes.
