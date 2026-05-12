# Batch Execution Standard

<!--
  @file:        standards/batch-execution-standard.md
  @description: Standard for running prompt batches via Claude Code Routines
  @owner:       Claude (Anthropic)
  @updated:     2026-05-12
  @version:     1.2
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

## 13. Pre-commit Verification

Every prompt — whether inside a batch or standalone — instructs the Code Agent to run the project's automated quality checks **locally in its own environment, before `git commit`**. The instruction lives in the prompt's `## ACCEPTANCE CRITERIA` block (the exact wording is in `templates/batch-execution/prompt-template.md`).

### 13.1 Why

In Batch A (ai-knowledge-system, 2026-05-11), the Code Agent ran `pytest` locally, saw all tests green, and reported success. It did not run `ruff check`, `ruff format --check`, or `mypy`. Those checks were enforced by CI on the auto-merged branch — which discovered the violations only after the prompt was committed and the batch had moved on. Several commits accumulated failures before this surfaced.

The lesson: **what CI catches after the fact, the Code Agent must catch before the commit.** A green CI is a poor first signal — it is the last signal, expensive to discover problems through. Catching failures in the Code Agent's own environment closes a multi-minute feedback loop into a sub-second one.

### 13.2 Required checks

The default set, applicable to any Python project using the standard `uv` toolchain:

- `uv run ruff check .` — lint.
- `uv run ruff format --check .` — format conformance (does not modify files).
- `uv run mypy src/ --ignore-missing-imports` — type check, when `src/` exists.
- `uv run pytest -q` — test suite, when `tests/` exists (mock LLM only; no real API calls).

For non-Python projects, the equivalent checks are project-defined (e.g. `npm run lint`, `npm run typecheck`, `npm test` for Node/TS). The principle is the same: every check that CI runs, the Code Agent runs first.

### 13.3 Toolchain availability caveat

If a required check's toolchain is **not available** in the Code Agent's environment (e.g. `uv` not installed on first foundation prompt, `mypy` missing from `[tool.uv.dev-dependencies]` because the prompt that adds it has not yet run), the Code Agent **skips that specific check** and records the skip explicitly in the commit message:

```
[skipped: ruff check — uv not yet installed in this prompt's scope]
```

Skipping is not failure. The next prompt that introduces the missing toolchain restores the check. Skipping is also not bypass — the standard requires that the **next foundation prompt in sequence** install the missing toolchain so subsequent prompts can run the full set. Indefinite skipping accumulates blind spots.

### 13.4 On failure

If a check fails, the Code Agent fixes the cause **within the prompt's declared scope** before committing. If the cause is outside scope (would violate the `REGRESSION SHIELD` block) — **STOP and report to Vasily**, do not commit a known-failing state.

This rule applies identically in Routine batch execution and in interactive single-prompt chats.

---

## 14. Foundation As Separate Bootstrap PR

The project's **foundation** — the minimum machinery that lets any batch reach `main` safely — must be on `main` **before** the first content batch starts. Foundation changes do not travel inside a content batch; they go through a separate **bootstrap PR** with manual merge.

### 14.1 Why

In Batch A, the Promot 03 task was to upgrade `auto-merge.yml` from v1 (push-trigger, no CI gating) to v2 (workflow_run gating). The v2 file was committed to the batch's working branch, but v1 was still active on `main`. When v1 tried to auto-merge the branch carrying the v2 replacement, the change broke the workflow under its own feet — a classic bootstrap chicken-and-egg. The fix could not pass through the gate it was installing.

The lesson: **foundation must be in place before any content batch runs.** A batch must never need to upgrade the rules it operates under, mid-flight. Foundation upgrades are pre-flight work, executed once, with human review, in a separate PR.

### 14.2 Foundation components

A foundation comprises **four components**. Any project running batches must have all four on `main` before the first content batch:

1. **Toolchain config.** `pyproject.toml` (or equivalent) with lint, format, and type-check tool configuration — including any `per-file-ignores`, line length, target version. Lockfile committed (`uv.lock` for Python projects, `package-lock.json` / `pnpm-lock.yaml` for Node).
2. **CI workflow with required-check gating.** `.github/workflows/ci.yml` runs lint, format-check, type-check, and tests on every push and PR to `main`. Workflow's job name is referenced by required-status-checks in branch protection.
3. **Auto-merge with `workflow_run` gating.** `.github/workflows/auto-merge.yml` triggered on `workflow_run` completion of the CI workflow, merges only when `conclusion == 'success'`. Does NOT trigger on raw `push` events.
4. **`.env.example`.** Documents all required environment variables (names only — no values). Sets the contract that subsequent prompts can refer to.

### 14.3 Procedure — greenfield bootstrap (new project)

For a new project repository:

1. **Single PR** — title `bootstrap: foundation (toolchain + CI + auto-merge + env)`. All four components are introduced in this one PR. Multiple commits within the PR are fine; the unit of merge is the PR itself.
2. **Manual merge by Vasily.** Auto-merge is not yet on `main`, so it cannot self-merge this PR. Vasily reviews the PR (10–15 minutes), merges manually via GitHub UI, deletes the source branch.
3. **Verify CI passes on `main`** after the merge. The first CI run on `main` from the freshly-merged foundation is the smoke test that the bootstrap landed correctly.
4. **Only after step 3 — open the first content batch.** Content batches assume foundation is stable. They are not the place to discover that the foundation is wrong.

### 14.4 Procedure — foundation upgrade (existing project)

For an existing project where foundation already exists but is incomplete or out of date (e.g. `ci.yml` exists but does not gate auto-merge; `pyproject.toml` exists but `ruff` config is missing `per-file-ignores`):

1. **Audit foundation against §14.2** — which of the four components is present and current, which is missing or outdated.
2. **Single PR** — title `foundation upgrade: {summary of what's changing}`. Scope is foundation only — no content changes ride along.
3. **Manual merge by Vasily.** Even if auto-merge is configured, **bypass it for foundation upgrades** — the upgrade itself may temporarily destabilize the gate; manual merge avoids the chicken-and-egg.
4. **Verify CI passes on `main`** after the merge.
5. **Only after step 4 — schedule subsequent content batches.**

### 14.5 What goes inside a content batch, what does not

**Inside a batch (allowed):** content changes — features, fixes, refactors, knowledge updates, agent implementations, pipeline implementations. Anything that depends on the foundation being stable.

**Outside a batch (foundation PR only):** changes to `pyproject.toml` tool configs, lockfile-only changes that change the toolchain, `.github/workflows/ci.yml` rules, `.github/workflows/auto-merge.yml`, the project's `.env.example` contract, branch protection rules.

If a content batch needs a foundation change to succeed — that is the signal to stop, do the foundation upgrade as a separate PR, then resume the batch.

---

## 15. Branch Discipline

Code Agent (Claude Code, Codex, others) operates under its own system instruction that fixes its working branch to `claude/<auto-slug>` (or equivalent provider-specific pattern). This is a **safeguard**, not a bug. The standard treats it as a fixed constraint, not something prompts try to override.

### 15.1 Why

In Batch A, after the bootstrap stall, a fix-prompt was written instructing the Code Agent to work on the existing batch branch `claude/batch-2026-05-11-repo-foundation`. The Code Agent ignored that instruction (per its system safeguard) and created an orphan branch `claude/fix-ruff-lint-tests-jObuK`. The fix landed there, divorced from the batch, and required manual reconciliation.

The lesson: **prompts do not direct the Code Agent's branch. They never have. Pretending otherwise creates orphan branches and lost work.**

### 15.2 Rule

Prompts written for the Code Agent **must not** specify a target branch in their `## TASK`, `## CONTEXT`, or anywhere else in the prompt body. The Code Agent picks its own branch under its safeguard; the routine (for batches) or the auto-merge workflow (for single prompts) reconciles the result back to `main`.

If a prompt template field looks like it asks for a branch — that field is misnamed or vestigial. Ignore it; the standard takes precedence.

### 15.3 How to make targeted edits to an existing feature branch

When a planning chat needs to make a small edit on top of an existing feature branch (e.g. correct a typo on `claude/batch-2026-05-11-repo-foundation` before it reaches main) — do it through **GitHub MCP from the planning chat**, not through a Code Agent prompt. The planning chat:

1. Reads the file from the target branch via GitHub MCP (`get_file_contents` with `ref=refs/heads/<branch>`).
2. Writes the corrected version via GitHub MCP (`create_or_update_file` with the same `branch`).

This path is direct, single-commit, and respects that the feature branch is owned by whichever entity created it. The Code Agent is not invoked.

---

## Changelog

- 2026-05-08 — v1.0 initial version. Defines parade-of-prompts rule, gate evolution levels, failure recovery, branch naming.
- 2026-05-10 — v1.1. Added Section 12 (Per-Project Launcher) documenting the multi-product credential design. Updated Section 6 with explicit default branch requirement. Updated Section 11 reference list with `routine.sh` and `routine-launcher-setup.md`. Motivated by a multi-hour cross-project routing incident that traced to shared global ROUTINE_API_* environment variables in the original single-product launcher.
- 2026-05-12 — v1.2. Discipline reinforcement after Batch A (ai-knowledge-system, 2026-05-11) retrospective. Added Section 13 (Pre-commit Verification), Section 14 (Foundation As Separate Bootstrap PR), Section 15 (Branch Discipline). No changes to Sections 1–12. Motivated by three failure modes observed in Batch A: Code Agent reporting green pytest while ruff/mypy were failing (§13); v2 auto-merge upgrade stuck inside the batch it was meant to gate, classic bootstrap chicken-and-egg (§14); fix-prompt directing the Code Agent to a specific branch, creating an orphan branch (§15).

When updating this standard, increment the version, add an entry above with date and summary of changes.
