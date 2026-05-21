# Multi-Agent Routing Standard

<!--
  @file:        standards/multi-agent-routing.md
  @description: Routing rules between agent executors (Claude orchestrator, Claude Code, Codex, art-pipeline workflows, DALL-E prototyping)
  @owner:       Vibe Coding
  @updated:     2026-05-21
  @version:     1.0
-->

This standard supplements `standards/VIBECODER_STANDARDS.md`. It defines the routing logic between the agents involved in product development: who picks up what kind of task, who hands off to whom, and where the contracts between agents live.

It does not modify the execution rules of any individual agent — those live in their respective standards (`batch-execution-standard.md`, `codex-batch-execution-standard.md`) and in product-repository `AGENTS.md` files.

---

## 1. Roles

The system has five distinct agent roles:

### 1.1 Claude (orchestrator)

Runs in claude.ai planning chat. Does not write code directly, does not touch git, does not run npm/cargo/pytest locally.

**Responsibilities:**
- research-protocol Phase 0–4 (premortem, virtual team, deep investigation).
- Visual Contract / ADR composition.
- Task decomposition: breaking a feature into prompt-sized units.
- Routing decisions: which executor picks up which prompt.
- Knowledge sweep: updating `knowledge/*.md` via GitHub MCP.
- PR review (architecture, alignment with project rules).
- Cross-repo orchestration (when a change in one repo affects another).

**Tools:** GitHub MCP (read/write files, branches, PRs, merges), web search, fetch_sports_data (irrelevant), DALL-E via ChatGPT (visual prototyping), conversation with Vasily.

### 1.2 Claude Code (executor A)

Runs as Routine or as direct Claude Code session. Has full local file system and shell access in the product repository checkout.

**Responsibilities:**
- Architectural refactors that span multiple files.
- Cross-domain changes requiring product judgment.
- Knowledge sweeps that require reading many files at once.
- GitHub Actions orchestration (workflow YAML, secrets management with Vasily approval).
- Migrations, dependency updates, schema changes.
- Bug fixes requiring broad context investigation.

**Standard:** `standards/batch-execution-standard.md`.

**Best at:** context-heavy work, large diffs spread across files, knowledge integration.

### 1.3 Codex (executor B)

Runs locally in Codex Desktop (or isolated runner per `codex-batch-execution-standard.md` §4.2). GitHub App access to the product repository, npm/cargo/etc. available, sandbox `workspace-write`.

**Responsibilities:**
- Phaser VFX, programmatic UI, particle systems (in game projects).
- Isolated module work (one to four files, single concern).
- Mechanical refactors with explicit scope.
- Test generation, visual prototypes.
- Asset-manifest integration when `catalog.json` and allowed files are explicit.

**Standard:** `standards/codex-batch-execution-standard.md`.

**Best at:** focused, narrow, testable work that fits comfortably in a single PR (≤300 lines diff, ≤4 files, ~30–90 min).

### 1.4 Art-pipeline workflows (GitHub Actions)

GitHub Actions workflows in product repositories (e.g. workflow `255616475` in magic-defender). Generate production sprite art via Qwen-Image-Max or other image-generation APIs.

**Responsibilities:**
- Production asset generation per `tools/art-pipeline/catalog.json`.
- Triggered manually with `single_asset` or `single_group` mode (max 5 assets per run).

**Critical:** while an art-pipeline workflow is running, no other agent commits to `main` of the same product repo. The workflow's final `git pull` will reject the push and assets generated in that run are lost. Orchestrator (Claude) checks workflow status before scheduling any main-touching work.

### 1.5 DALL-E (prototyping only)

Accessed via ChatGPT by Vasily directly, or via the orchestrator's reference loop. Generates one-off visual previews to validate art-direction decisions before committing the art-pipeline budget.

**Responsibilities:**
- Pre-flight visualization of art direction (style, palette, composition) before production assets are commissioned.
- Reference loops during Visual Contract iteration.

**Not used for production assets.** Output is reference-only; never integrated as a runtime asset.

---

## 2. Routing Rules

Routing is a decision made by the orchestrator (Claude) at task-decomposition time. Each prompt or batch is assigned to exactly one executor.

### 2.1 Default Routing Table

| Task shape | Default executor | Reasoning |
|---|---|---|
| New feature touching ≥5 files | Claude Code | Cross-file context, knowledge sweep needed. |
| Isolated VFX or particle work | Codex | Single concern, visual feedback loop. |
| Mechanical refactor (rename, extract, move) | Codex | Narrow scope, deterministic. |
| Bug fix with unclear repro | Claude Code | Investigation cost is high, context wins. |
| Bug fix with clear narrow repro | Codex | Fits comfort zone. |
| Knowledge update (`knowledge/*.md`) | Claude (orchestrator) via MCP | No code execution needed. |
| Architectural decision (ADR) | Claude (orchestrator) | Research-protocol scope. |
| Production sprite generation | Art-pipeline workflow | Only path with budget access. |
| Visual prototype before commitment | DALL-E (via Vasily) | Cheap, throwaway. |
| GitHub Actions YAML edit | Claude Code | Workflow logic is context-heavy. |
| Dependency bump in `package.json` | Claude Code | Often touches lockfile + tests. |
| Single test file authoring | Codex | Isolated, comfortable. |

### 2.2 Tiebreaker Heuristics

When a task fits both Claude Code and Codex:

1. **Diff size estimate.** ≤300 lines → Codex. >300 lines → Claude Code.
2. **File count.** ≤4 files → Codex. ≥5 files → Claude Code.
3. **Knowledge sweep required?** Yes → Claude Code. No → Codex.
4. **Visual verification needed in browser?** Yes → Codex (it has dev server + screenshot skill). No → either.
5. **Time-pressure parallel work?** Use both — Claude Code on one branch, Codex on another. They merge through PRs to main independently.

### 2.3 Hard Routing Constraints

- **Production assets:** only art-pipeline workflow. Codex and Claude Code never commit binary assets directly to `public/assets/` without workflow approval.
- **Secrets / `.env`:** only Vasily, never any agent.
- **Direct main pushes:** forbidden for all agents. Only PR → review → merge.
- **Repo description / settings:** only Vasily through GitHub Settings UI (no MCP endpoint exposed for this).

---

## 3. Handoff Contracts

When work needs to flow between agents, the contract is always a committed artefact, not a chat reference.

### 3.1 Orchestrator → Executor

Orchestrator commits a manifest + prompt(s) to `prompts/queue/{batch_id}/` on a `prep/{batch_id}` branch (Claude Code lane) or directly via GitHub MCP (Codex lane). The manifest's `executor` field routes the batch.

Executor picks up the batch by its own mechanism (Routine launcher polls; Codex reads on Vasily's local trigger).

### 3.2 Executor → Orchestrator (success)

Executor opens a PR to `main`. PR description follows the Codex PR template (`.github/PULL_REQUEST_TEMPLATE/codex.md` in product repo) or routine commit-message format (Claude Code Routine).

Orchestrator reviews the PR via GitHub MCP and either merges or requests changes.

### 3.3 Executor → Orchestrator (blocked / partial)

Executor commits `prompts/queue/{batch_id}/codex-response.md` (Codex) or sets `failure_reason` in the manifest (Claude Code Routine). The branch is left open.

Orchestrator reads the response, decides next step (resume with corrected prompt, abort, escalate to Vasily).

### 3.4 Orchestrator → Vasily (questions)

Orchestrator asks in claude.ai chat. Critical: questions are explicit and numbered; Vasily's response is the canonical answer captured in `knowledge/decisions.md` or in the next prompt's CONTEXT block.

### 3.5 Vasily → System (instructions)

Vasily speaks to orchestrator in claude.ai chat. Instructions flow downward to executors via prompts. Vasily never instructs executors directly except in rare debugging cases (e.g. running a single command in Codex session for diagnostics).

---

## 4. Drift Detection

When conventions change (a new rule, a renamed file, a new executor, a deprecated workflow), the orchestrator records the change in two places:

1. **In the affected product repo:** `knowledge/agent-changelog.md` (append-only log per product).
2. **Cross-product convention changes:** in this file (Section 6 Changelog) and in the affected agent standard.

Each executor reads `knowledge/agent-changelog.md` at session start (per `AGENTS.md` Read First). Drift is detected when an entry post-dates the executor's last session.

---

## 5. Anti-Patterns

These patterns are explicitly forbidden:

- **Multi-executor batch.** Forbidden. One batch = one executor. If a sequence of prompts mixes Claude Code work and Codex work, split into two batches.
- **Orchestrator-as-executor.** The orchestrator never runs npm/cargo locally, never commits without going through the GitHub MCP. Even when the task is "trivial" — the trivial work is what builds drift.
- **Verbal handoff.** No "I'll tell Codex in chat to do X." All handoffs are committed artefacts.
- **Routing by author preference.** Codex tasks go to Codex even when the orchestrator could write the prompt faster as Claude Code work. The system optimizes for parallelism, not for individual task speed.
- **Bypass review.** Every PR from any executor gets orchestrator review before merge. Self-merges by an executor are forbidden.

---

## 6. Changelog

- 2026-05-21 — v1.0. Initial multi-agent routing standard. Defines five roles (Claude orchestrator, Claude Code, Codex, art-pipeline workflows, DALL-E), the default routing table, tiebreaker heuristics, hard constraints, handoff contracts, drift detection, and anti-patterns.
