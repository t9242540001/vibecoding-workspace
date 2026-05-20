---
name: real-path-verification
description: Discipline that rewires the default from "code written = task closed" to "real-path verified = task closed". Use this skill whenever writing or reviewing a Claude Code prompt that creates or modifies a feature, fix, or any logic with runtime behavior. The skill covers mental simulation before delivery, forward-thinking about 1-2 step consequences before any decision, real-path verification inside the prompt where access allows, explicit verification handoff to Vasily for production-side checks, and a forward-compatible interface for the future AI test agent. Mandatory in these situations — not optional. Do NOT use for pure documentation edits (knowledge/*.md without behavior change), one-off mechanical fixes (typo, formatting) with no logic change, or infrastructure operations (deploy, restart, config) that have their own verification paths.
---

# Real-Path Verification
<!--
  @file:        skills/real-path-verification/SKILL.md
  @description: Verify features on real paths, simulate before delivery, think 1-2 steps ahead, hand off prod-side checks explicitly
  @version:     1.1
  @updated:     2026-05-19
-->

---

## 1. Philosophy

"Code written" is not "task done". Between the moment a function compiles and the moment a feature reliably works for a real user on real data, there is a gap — and that gap is where the bugs live. Unit tests pass on mock inputs. TypeScript compiles. CI is green. The deploy succeeds. Then a week later production breaks because no one ran the actual scenario the feature is supposed to handle.

This skill closes that gap by rewiring three defaults at once.

**Default 1 — Mental simulation before delivery.** Before saying "done", run the code in your head against a real scenario. Recompute the math on two or three real inputs. Trace the if/else branches on realistic values. Walk through the obvious edge cases. The cheapest verification layer is the one in your head, and it catches a meaningful share of bugs before they ever leave the workstation.

**Default 2 — Forward thinking on every decision.** When you choose option A over option B, hold in mind at least one or two steps of downstream consequences: what does this do to neighbouring systems, to the database, to the end user one click later, to a future migration. The point is not to prevent every consequence — it is to see them and decide consciously, not to be surprised by them three weeks later.

**Default 3 — Real-path verification, not mock verification.** When the work is reasonably testable on real or close-to-real data — test it on that data, not on mocks. When access doesn't allow it (production data, paid APIs, real users), hand off a precise scenario to Vasily, in a format that a future AI test agent will be able to read and execute automatically.

**The core overriding principle.** A task closes when its real path has been verified — not when its code has been written. Code-written without verification is an intermediate state. State it as such, don't pretend it's done.

---

## 2. Scope — What This Skill Covers

The skill applies to every prompt that creates or modifies runtime behavior — features, bug fixes, refactors with logical changes, schema migrations, API contract changes, integration with external services, any code where wrong output is possible.

### In scope

Examples (illustrative, not exhaustive):

- Adding a feature: new endpoint, new bot command, new UI flow
- Fixing a bug with stated symptoms
- Refactoring with logical reorganization (function split, control flow change)
- Schema migrations (add column, change type, rename, drop)
- API contract changes (request shape, response shape, status codes)
- External service integrations (new vendor API, change of provider)
- Calculation logic (pricing, tax, conversion, currency, time zones)
- Authentication, authorization, permission checks
- Data parsing, validation, transformation
- Background jobs, schedulers, retries

### Out of scope

The skill does not activate for:

1. **Pure documentation edits** — `knowledge/*.md` files, README, ADRs themselves (the ADR documents a decision; the verification of the decision happens through the code change that implements it).
2. **One-off mechanical fixes** — typo, formatting, dead-code removal, comment rephrasing — where there is genuinely no runtime behavior to verify.
3. **Infrastructure operations** — deploy, restart, config rotation, certificate renewal — these have their own verification paths (process status, health endpoint, log tail) covered elsewhere.

When in doubt whether the skill activates — activate it. The cost of running mental simulation on a simple change is small; the cost of skipping it on a change that turns out non-trivial is large.

---

## 3. Activation Triggers

This skill activates **automatically** when any of these observable signals appear:

### Trigger 1 — A prompt creates or modifies runtime behavior

Any prompt whose code change can produce different output depending on input. The Section 2 in-scope list (illustrative) gives the shape.

### Trigger 2 — A decision is being made between options

Any moment where Claude or Claude Code picks one approach over another — architectural choice, library choice, algorithm choice, schema choice, copy choice that affects user behavior. Forward thinking (Section 5) applies here regardless of whether code is being written immediately.

### Trigger 3 — Acceptance criteria are being drafted

When the AC block of a prompt is being written. Real-path verification block (Section 6) is mandatory at this point.

### Trigger 4 — Vasily flags it explicitly

Phrases like *"проверь сценарий"*, *"что будет с системой"*, *"real-path"*, *"подумай на шаг вперёд"*, or equivalent.

### Not a trigger

Pure analytical discussions about strategy or research where no code change is imminent — Section 2 out-of-scope category 1 applies. Casual chat unrelated to a task.

---

## 4. Principle One — Mental Simulation Before Delivery

When Claude Code finishes writing code, or Claude finishes writing a prompt, the question to ask before saying "done":

> *"Did I run this in my head on a real scenario — not just verify the syntax?"*

Mental simulation is the cheapest verification layer. It costs minutes; it catches a meaningful share of bugs that unit tests miss because unit tests test what the author thought to test, while mental simulation forces you to think what the system will actually receive.

### What mental simulation looks like

The shape, on three categories. Each list is **examples (not an exhaustive checklist)**:

**Calculations.** Pick two or three real or realistic inputs. Compute the expected output manually. Compare to what the code will produce. If they match — record it briefly. If they don't — fix the code.

Example targets for manual recomputation:
- A pricing formula with margins, taxes, conversion
- A date arithmetic across time zones
- A sum over filtered rows
- A statistical aggregation
- A regex extraction on a known real string

**Control flow.** Trace the if/else and switch branches on realistic inputs. The questions that surface bugs:
- What happens when this argument is undefined / null / empty string / zero?
- What happens on the first call after a cold start?
- What happens if the retry logic fires three times in a row?
- What happens if two concurrent callers hit the same code path?

**Obvious edge cases.** Walk through the boundary conditions that any developer would call out if asked. Examples (not exhaustive):
- Empty input
- Single-element input
- Maximum-size input
- Unicode characters, emoji, multi-byte sequences
- Network or database failures mid-operation
- Inputs in unexpected but parseable forms

The list is meant as a starting point for thinking, not as a checklist to tick off. The principle is: **before delivery, walk through what the system will actually receive, not what the test fixture politely provided.**

### The output of mental simulation

A short note in the commit message or in the Step 10 review summary, **maximally compact**. Format:

> *Mental simulation: [briefly what was simulated and result]. [If anything material was found and fixed — one line. If nothing — "OK".]*

Examples:
- *Mental simulation: pricing formula on inputs (1500 USD, 15% margin, 20% VAT) → expected 2070, got 2070 — OK.*
- *Mental simulation: date parser on inputs including "2026-02-29" (non-leap year) — found NaN propagation, added explicit invalid-date branch.*
- *Mental simulation: cart total with empty cart → returned NaN, fixed with early return 0.*

The note is **not optional** when the prompt's task includes calculations, parsing, or control flow with multiple branches. It is optional for pure I/O glue code with no logical branching, but recommended even there.

### What mental simulation is not

It is not a replacement for unit tests. It runs *before* unit tests, as a first pass; unit tests then formalize what was found and prevent regression. It is not a replacement for real-path verification (Principle Three) — it is the layer before that.

### Self-directing question — exact form

> *"What real input will hit this code first in production? Have I run the code in my head against that input, and against the obvious edge cases around it?"*

---

## 5. Principle Two — Forward Thinking on 1-2 Steps of Consequences

When a decision is made — about architecture, schema, library, copy, anything that has consequences — the question to ask:

> *"What harmful consequences could this decision cause one or two steps downstream — for neighbouring systems, for the user, for a future migration? If I find harm, how do I redesign the decision so the harm is gone, using established best practices?"*

The point is not just to see consequences and not be surprised later. The point is to **actively search for harmful consequences before they happen, and — when harm is found — redesign the decision so the harm is prevented or minimized**, building the solution into the current work using best practices from the industry, the technology, or the domain. Most preventable production incidents are not failures of foresight — they are failures of looking, plus failures of redesigning once something was seen.

A concrete shape this often takes: you are rewriting module A, and the new logic disables an integration that module B depends on. The wrong default is *"B is not my concern, I'll do what was asked"*. The right default is *"stop, find a way to do what was asked **without breaking B**"* — look up how the industry handles this kind of conflict (feature flag, parallel run, graceful degradation, dependency injection through an adapter, deprecation path, backward-compatible API change, and so on), pick the pattern that fits, and **build the solution into the current change**. The harm is not left for "later, in another task" — it is solved now, with established practice, because that is when the choice is being made.

### The three layers of consequence

Each layer comes with examples (illustrative, not exhaustive).

**System layer.** What does this change do to the system the code lives in?

Examples of questions worth asking:
- A new column on `users` — how does the migration apply in prod (downtime, table lock)? Do existing `SELECT *` queries handle it?
- A new index — what's the write cost? Does it conflict with bulk inserts?
- A schema change — is the backup strategy still valid? Are foreign keys still intact?
- A new background job — does it compete with existing jobs for connection pool slots?
- A change to a hot code path — what's the latency profile, will p99 shift?

**Neighbour-system layer.** What does this change do to systems that depend on this one, or that this one depends on?

Examples:
- An API response shape change — who consumes this endpoint? Is the consumer code hardcoded to the old shape?
- A new required field on form submission — does the existing client still send it? Mobile app version compatibility?
- A change to a webhook payload — downstream subscribers fail silently or loudly?
- A new external API call inside an existing flow — what happens when the external service is slow or down?
- A schema change in shared infrastructure — which other services read this table?

**User layer.** What does this change do to the person who uses the product?

Examples:
- A new validation rule — do existing users now hit it on their next action?
- A removed feature — where's the migration path for users who relied on it?
- A pricing change — when do existing customers see it? Is there grandfathering?
- A new authentication step — does it lock anyone out?
- A copy change in an error message — does it now misrepresent what failed?

### How to fold forward thinking into the workflow

Forward thinking is not a separate phase — it is folded into:

**In the plan (Step 7 of `prompt-writing-standard`).** Every decision in the plan is accompanied by a one-line *1-2 step consequences* note. The note states what was seen, not what was decided about it.

Example plan entry:
> *Add `currency` field to `prices` table. 1-2 step consequences: migration is column-add (no lock); existing `SELECT *` queries pick it up automatically; pricing display in bot needs handling for null on legacy rows; reports SQL hardcodes column order — needs check.*

**In the ADR (when one is created).** New mandatory section *"Forward-thinking impact"* alongside the existing Consequences section. The Consequences section already covers immediate effects of the decision; "Forward-thinking impact" covers the 1-2 step downstream effects that may not be immediate but are foreseeable.

This is **mandatory for every ADR**, not just T3 strategic ones. A small ADR still has 1-2 step consequences worth recording — even if the recording is brief.

### When a consequence is found — three responses, depending on what kind

Not every consequence demands action. The discrimination is between **harmful**, **neutral**, and **out-of-scope-but-large** consequences. Each gets a different response.

1. **Harmful consequence found** → **redesign the current decision so the harm is prevented or minimized.** This is **always part of the current prompt** — not deferred to a future task. The redesign uses an established best practice from the relevant industry, technology, or domain (feature flag, graceful degradation, backward-compatible change, adapter pattern, deprecation period, parallel run, API versioning, dependency injection, retry-with-backoff, circuit breaker, and so on — the right pattern depends on context). The principle: when you choose option A that breaks B, you don't continue and shrug — you find option A' that does the job of A without breaking B. The fix is built into the current change, with a one-line note explaining which best practice was applied.

2. **Neutral consequence found** (visible but no harm) → **record in the plan, do not act.** It is enough that it is seen and noted. Future sessions reading the plan will know it was considered. No special action required.

3. **Large consequence requiring its own task** → **open an artefact task in `knowledge/roadmap/tasks/`** (per `anti-hedging-language` Section 5 — deferral becomes artefact, never silent "later"). **And** — reshape the current decision so that the current change does not deepen the problem before the future task gets to it. The artefact tracks the big fix; the current redesign prevents the current change from making the situation worse.

What is **not** legitimate in any of the three cases: see the consequence and silently ignore it. If you saw it, you owe the system a recorded response — and if it was harmful, you owe the system a redesign, now.

### Searching for the best practice

When a harmful consequence requires redesign, the search for the right pattern is part of the work, not optional. Don't invent the solution from scratch — the conflict you found has almost certainly been encountered before in the industry, the technology stack, or the domain. Examples of established patterns by problem family (illustrative, not exhaustive):

- **Breaking a downstream consumer of an API** → API versioning, backward-compatible field addition, deprecation period with both versions supported, content negotiation.
- **Disabling an integration another module depends on** → feature flag with gradual rollout, adapter layer that lets B run against either old or new A, graceful degradation when A is unavailable.
- **Schema change that breaks reads** → additive migration first (add new column nullable), then dual-write, then read switchover, then drop old column.
- **Removing a feature users rely on** → deprecation period with in-app notice, opt-in migration path, redirect for old URLs.
- **Changing a hot code path** → benchmark before, benchmark after, canary deploy, rollback plan.

If the right pattern is not obvious — say so explicitly in the plan, and either research it (via `research-protocol` for T3 decisions) or escalate to Vasily for input. Hedging here ("we'll figure it out as we go") is the failure mode this principle exists to prevent.

### Self-directing question — exact form

> *"What harm could this decision cause one or two steps downstream — to a neighbouring system, to the user, to a future migration? If I find harm, what established best practice lets me redesign the decision now so the harm is prevented? If I don't see any harm — that is a sign I haven't looked enough, not a sign there is nothing."*

---

## 6. Principle Three — Real-Path Verification Inside the Prompt Where Access Allows

When access permits, Claude Code verifies on real or realistic data inside the prompt — does not defer everything to Vasily. The question:

> *"What can I verify here, before this leaves my hands?"*

### Three access tiers

Each prompt's verification work splits across these tiers. Examples are illustrative, not exhaustive.

**Tier 1 — Full access (Claude Code verifies in this prompt).** Local computations, regex on sample strings, parsing utilities, formatters, calculations, migrations on dev/staging databases, anything that can run with no production-side credentials.

Examples:
- A pricing formula — run it against three known real-world price inputs from prod data, compare to known correct outputs
- A regex parser — apply it to a sample of real strings (e.g. ten product titles from the actual catalog), confirm the matches
- A migration on dev DB — apply, query the result, roll back, apply again
- A formatter for currency / dates — produce outputs for a known set of inputs, compare visually to spec

**Tier 2 — Partial access (verify what's reachable).** API with a sandbox/test key, a staging endpoint, a test database with realistic data. Claude Code runs what it can, records what it ran, identifies what remains for Vasily.

Examples:
- A new endpoint that hits a third-party API — call it against the sandbox key, confirm the contract, leave the real-key call for Vasily
- A new bot command — run it against the local bot instance with a test chat, leave the prod-chat smoke test for Vasily
- A schema migration with backfill — apply on staging with a copy of prod-shaped data, confirm count and a spot-check

**Tier 3 — No access (handoff to Vasily, structured).** Production data, real payments, real user accounts, live customers. Claude Code prepares a precise scenario for Vasily and queues it; can also queue it for the future AI test agent (Section 8).

Examples:
- A change to live payment flow — test on dev, hand off the full payment cycle to Vasily on a small test transaction
- A change to email-sending logic — confirm template renders locally, hand off the actual send to Vasily
- A change to a feature used by paying customers — Vasily verifies on his own test account

### The Real-Path Verification block

For prompts in scope (Section 2), a new block is added between **REGRESSION SHIELD** and **ACCEPTANCE CRITERIA**. Format:

```
## REAL-PATH VERIFICATION

### What Claude Code verifies in this prompt:
- [specific action 1]: run with input X, expect output Y
- [specific action 2]: ...
- [If nothing — state "No tier-1 verification applicable, all verification is mental simulation + handoff."]

### What Claude Code verifies via mental simulation (no run):
- [calculation/logic 1]: trace through values A, B, C — each should yield ...
- [edge case 1]: empty payload → expected behaviour ...
- [If covered by Section 4 mental simulation already — state "see commit message mental-simulation note."]

### What is handed off to Vasily for prod-side verification:
- Scenario 1:
  - Trigger: [how to invoke]
  - Input: [specific data]
  - Expected: [what should happen]
  - Verify at: [where to look for the result]
- Scenario 2: ...

### What is queued for the future AI test agent:
- (Currently duplicates the Vasily-handoff section above — this is intentional. When the AI test agent comes online, it reads this subsection and runs the scenarios automatically. Until then, Vasily executes; agent is in standby.)
```

The block is **mandatory** for in-scope prompts. An in-scope prompt without it fails Step 9 review the same way it fails on missing regression shield or unregistered universals.

### Format alignment with future AI test agent

The fourth subsection ("queued for the future AI test agent") is the same scenarios as the Vasily-handoff subsection, in the same shape. This is by design: one source of truth, two consumers (Vasily now, AI agent later). When the AI test agent comes online, this skill or its successor will define the parsing convention; today the format stays human-readable.

The four-line shape (Trigger / Input / Expected / Verify at) is the minimal contract. It is structured enough for a future agent to parse and detailed enough for Vasily to execute.

### Self-directing question — exact form

> *"Of the three access tiers, where does each piece of this work fit? What do I verify now, what does Vasily verify, what does the future agent inherit?"*

---

## 7. Principle Four — Verification Gates Closure, Not Coding

When reporting on task completion — to Vasily, in `roadmap/tasks/`, anywhere — the question:

> *"What is the actual closure criterion: that the code is written, or that the feature works on a real path?"*

The answer for in-scope prompts: **the latter**. A task moves through three observable states.

### The three states

| State | Meaning | When |
|---|---|---|
| `coded` | Claude Code finished writing, unit tests green, mental simulation done. Tier-1 verification (Section 6) ran if applicable. | Intermediate. Code is committed and pushed; deploy may have happened. |
| `pending-verification` | Real-path verification is handed off but not yet completed. Vasily (or future agent) has the scenarios; no confirmation back yet. | Intermediate. Lasts hours or days depending on Vasily's schedule. |
| `verified` | Real-path verification closed — Vasily confirmed, or AI agent ran the scenarios with passing result, or tier-1 verification inside the prompt covered the full real path. | Terminal. Task is genuinely closed. |

### How this lives in `knowledge/roadmap/tasks/`

The task file's `Status:` field uses these values for in-scope tasks: `open` → `in-progress` → `coded` → `pending-verification` → `verified`. The existing terminal state `completed` remains valid for **out-of-scope tasks** (documentation-only, mechanical fixes, infrastructure operations) — these don't have a real-path to verify, so `completed` is their honest closure.

`blocked` remains valid in either flow.

This is recorded in `knowledge-structure` Section 5 as part of the D integration step.

### How this lives in Step 10 review summaries

The Step 10 review summary in `prompt-writing-standard` already has "Принятые решения" and "Осознанно оставлено" blocks. The skill adds a new mandatory line:

> **Verification status:** `coded` / `pending-verification` / `verified` — with one-line reason.

Examples:
- *Verification status: `verified` — all three calculation scenarios passed against real catalog samples (tier-1 in-prompt).*
- *Verification status: `pending-verification` — three scenarios handed off to Vasily for prod-side smoke test (see REAL-PATH VERIFICATION block).*
- *Verification status: `coded` — mental simulation passed, but tier-1 access not available; awaiting deploy before Vasily can run the handoff scenarios.*

### Self-directing question — exact form

> *"Am I saying 'done' because code is written, or because the real path is verified? If the first — say `coded` or `pending-verification`, not `done`."*

---

## 8. Future AI Test Agent — Forward-Compatible Design

Vasily has stated that a future step in the workflow is an AI test agent that automates real-path verification — taking over what Vasily currently does manually after deploy. This skill is written with that agent in mind, so that when it comes online no rewrite is needed.

### The interface design

The "What is queued for the future AI test agent" subsection in every REAL-PATH VERIFICATION block (Section 6) is the agent's interface. Today it is human-readable; tomorrow it is also agent-readable.

The four-line per-scenario format:

```
- Scenario: <short name>
  Trigger: <how to invoke — URL, command, event>
  Input: <specific data — concrete values, not placeholders>
  Expected: <what should happen — concrete outcome, not "works correctly">
  Verify at: <where to observe the result — endpoint, table, log file, UI screen>
```

This shape is the minimal contract. The agent, when it arrives, will:
1. Read scenarios from this subsection in completed prompts
2. Execute the trigger
3. Apply the input
4. Observe the verification location
5. Compare to expected
6. Report `verified` or `failed` back to the relevant `roadmap/tasks/` file

### What this skill does not do for the agent

It does not define the agent itself — how it runs, where it runs, how it authenticates to production, how it handles destructive operations. Those are the agent's own design problem, addressed in a future skill (likely `test-agent-protocol` or similar).

This skill only guarantees that the input artefact (the scenarios block) exists in a consistent format from the moment the skill is adopted. The agent inherits a corpus of pre-formatted scenarios when it comes online.

### Until the agent arrives

Vasily executes the scenarios manually. The format is the same. Nothing changes operationally for the human flow — but the foundation is laid.

---

## 9. Boundary Cases — When the Default Bends

The principles describe the default. There are legitimate exceptions, all of which are explicitly recorded, not silently invoked.

### Case 1 — Pure documentation prompts

Out of scope per Section 2. No real path to verify; no mental simulation needed for prose edits. The skill does not activate.

### Case 2 — Mechanical fixes with no behavior change

Typo in a comment, dead code removal, formatting cleanup. The skill does not activate.

### Case 3 — Emergency hotfix where verification is overridden by speed

Production is down; the fix is urgent. Vasily explicitly accepts skipping real-path verification because the cost of waiting exceeds the cost of risk. In this case:

- Verification status is `coded` not `verified`
- A `pending-verification` artefact task is opened in `roadmap/tasks/` to revisit the verification after the incident
- Mental simulation is still done — it costs minutes, even in emergency

### Case 4 — Tier-1 verification covers the full real path

When the change can be fully verified inside the prompt (e.g. a pure calculation function with no external dependencies, tested against the actual real-world inputs that production sees), there is no handoff needed. Verification status moves directly to `verified` in this prompt.

In all cases, the deviation from default is recorded explicitly. Silent skipping of verification is the failure mode this skill is built to prevent.

---

## 10. Application in Existing Processes

### `prompt-writing-standard`

- **Step 6a** — read this skill before writing the plan, in scope per Section 2
- **Step 7 (plan formulation)** — every decision in the plan carries a one-line *1-2 step consequences* note (Principle Two)
- **Step 9 (multi-perspective review)** — two new mandatory checks:
  - Stakeholder reviewer: *"Is the real-path scenario covered, or only the happy-path mock?"*
  - Technical reviewer: *"Did mental simulation run on the relevant calculations and control flows? Is the Mental Simulation note present in the commit/summary?"*
- **§3 Prompt Template** — new REAL-PATH VERIFICATION block between REGRESSION SHIELD and ACCEPTANCE CRITERIA (format per Section 6)
- **§4 Core Rules** — new rule *"Real-path verification — mandatory"* in the same shape as the existing rules (Universality, Anti-hedging, Knowledge update)
- **Step 10 (review summary)** — new mandatory line *"Verification status: coded / pending-verification / verified"* with one-line reason

### `knowledge-structure`

- **§5 (task file format in `roadmap/tasks/`)** — add `coded`, `pending-verification`, `verified` as valid `Status:` values alongside existing `open`, `in-progress`, `completed`, `blocked`. `completed` remains valid for out-of-scope tasks (Section 2 out-of-scope categories). In-scope tasks close at `verified`, not `completed`.
- **§7 (ADR format)** — new mandatory section *"Forward-thinking impact"* in the ADR body, alongside the existing Consequences section. Mandatory for **every ADR**, not just T3 strategic ones.

### `code-markup-standard`

- **§7 (Inline operational tags)** — two new tags:
  - `@verified-by: <scenario-or-link>` — marks code that has passed real-path verification, with reference to which scenario or where the verification happened
  - `@pending-verification` — marks code that is `coded` but not yet `verified`. Lifespan: until verification closes or task is closed by other means. Lingering `@pending-verification` tags in code are an integrity-check signal (per `knowledge-structure` Section 13).

### `bug-hunting`

- A bug found during real-path verification (after `coded` state, before `verified`) is a legitimate trigger for `bug-hunting`. The verification handoff that failed becomes the bug's initial diagnostic context.

### `research-protocol`

- The Premortem phase (Phase 3) explicitly asks: *"What would real-path verification reveal that the research did not?"* — surfacing pre-implementation what mental simulation and real-path will catch later.

---

## 11. Short List of Patterns That Are Almost Always Wrong

Examples (illustrative, not exhaustive). Recurring shapes that signal a verification failure. Catching them does not exempt one from the general principles for the rest.

1. **"Tests pass, shipping"** without mental simulation note and without REAL-PATH VERIFICATION block — verification gate skipped.
2. **"Should work on prod, similar to dev"** — that "should" is hedging (per `anti-hedging-language` Section 4); replace with a real-path scenario or honest unknown.
3. **Marking task `completed` when the code is in production but no one has run the user-facing scenario** — that is `pending-verification`, not `completed`.
4. **Decision made without "1-2 step consequences" line in the plan** — Forward thinking skipped.
5. **REAL-PATH VERIFICATION block where all four subsections say "N/A"** — that's a sign the prompt is genuinely out of scope (Section 2), or the author didn't think hard enough about what to verify.
6. **Mental simulation that says "ran in my head, looks fine"** without naming what was simulated — that's not simulation, that's reassurance. The note states what was traced and what the result was.

---

## 12. Anti-Patterns — Explicitly Forbidden

These are the few unconditional rules; everything else is handled by the principles above.

1. **Silent skip of mental simulation** for in-scope prompts. If the prompt's task has any calculation, parsing, control flow, or state machine — the simulation runs, even if briefly.
2. **Claiming `verified` when only `coded`.** Verification status reflects what actually happened. Coding is not verifying.
3. **Decisions made without forward-thinking note.** A plan that says "decided X" without "1-2 step consequences: …" violates Principle Two.
4. **REAL-PATH VERIFICATION block treated as ceremonial.** Empty placeholders ("- TODO: write scenario later") in the block are not legitimate — they are deferral disguised as completion. Per `anti-hedging-language` Section 5, deferral becomes an artefact, never a placeholder.
5. **Mental simulation note used as filler.** "Mental simulation: OK" without context is not the note — it is the author signing off without doing the work. The note states the inputs and the result.

---

## 13. Connections to Other Skills

These integrations are implemented as a **separate step** after this skill's commit.

- **`prompt-writing-standard`** — Step 6a Related skill, Step 7 plan format, Step 9 two new mandatory checks, §3 template REAL-PATH VERIFICATION block, §4 new core rule, Step 10 verification status line
- **`knowledge-structure`** — §5 new `Status:` values for `roadmap/tasks/`, §7 mandatory "Forward-thinking impact" section in ADR for all ADRs
- **`code-markup-standard`** — §7 two new inline tags `@verified-by` and `@pending-verification`
- **`anti-hedging-language`** — bidirectional reference: this skill's deferral mechanism (verification handoff) uses anti-hedging's artefact rule; anti-hedging's Principle Two cascade (resolve / investigate / ask / defer) is what real-path's "see consequence, decide what to do" follows
- **`bug-hunting`** — verification failures become bug triggers
- **`research-protocol`** — Phase 3 Premortem includes a real-path question
- **Future `test-agent-protocol`** — this skill's Section 6 fourth subsection is the interface the agent will read

---

## 14. Quick Reference

| Situation | Question to ask | Section |
|---|---|---|
| Finished writing code | *"Did I run it in my head on a real scenario?"* | § 4 |
| About to commit / hand off | *"Is the mental simulation note in the commit message?"* | § 4 |
| Making a decision between options | *"What is one step downstream? Two?"* | § 5 |
| Writing the plan in Step 7 | *"Does every decision carry a 1-2 step consequences line?"* | § 5 |
| Writing the AC block | *"What can I verify now, what handed off, what for the agent?"* | § 6 |
| Reporting completion | *"Is this `coded`, `pending-verification`, or `verified`?"* | § 7 |
| Drafting a new ADR | *"Is the Forward-thinking impact section filled?"* | § 5 + integrations § 10 |
| Hotfix in emergency | *"Is the deviation from default recorded explicitly?"* | § 9 |
| Empty REAL-PATH VERIFICATION block | *"Is this genuinely out of scope, or am I not looking hard enough?"* | § 11 |

| Don't | Do |
|---|---|
| Ship after green tests without mental simulation | Add the brief mental simulation note to the commit |
| Mark task `completed` when only code is in prod | Mark `pending-verification` until real-path closes |
| Decide silently — see consequences later | Record 1-2 step consequences in the plan |
| Hand off everything to Vasily | Run tier-1 verification in the prompt where access allows |
| Write "TODO write scenarios" in verification block | Either write the scenarios or treat as out of scope explicitly |
| Skip "Forward-thinking impact" in a small ADR | Fill it in every ADR — small ADRs have small but real downstream impact |
