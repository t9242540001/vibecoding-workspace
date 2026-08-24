---
name: forward-thinking-discipline
description: Design-time discipline for thinking 1-2 steps ahead before writing any T2 prompt. Use this skill whenever a prompt for Claude Code is being prepared for a T2 task, whenever a micro-decision is being made inside a research-protocol T3 session, whenever Vasily asks "what will this touch" / "что это затронет" / "продумай вперёд", or whenever a tentative recommendation has been formed and is about to become a concrete prompt. This skill is mandatory in these situations — not optional. Do NOT use for T1 tasks (typos, label renames), for pure text content edits, for pure documentation changes, for mechanical fixes with no logic, or for verification-time work after code is written (that is real-path-verification's domain).
---

# Forward-Thinking Discipline
<!--
  @file:        skills/forward-thinking-discipline/SKILL.md
  @description: Design-time discipline for thinking 1-2 steps ahead before writing any T2 prompt
  @version:     1.1
  @updated:     2026-05-20
-->

---

## 1. Philosophy

**Treat the happy path as the exception. Treat the unhappy path as the norm.**

This skill closes the design-time gap between STANDARDS §1.1 (general "barometer" questions, easy to skim) and `real-path-verification` Section 5 (verification-time, after code is written). It runs at the moment the prompt brief is being formed — and applies one principle: senior thinking inverts the default, junior thinking writes the happy path first and patches edge cases later. Past incidents (WhatScan 4096-char limit, ЮрАссистент `nextSteps` miss, productcenter edge cases) all share one pattern: a T2 task missed a non-obvious unhappy path at design time, and the cost surfaced post-deployment.

**Two overriding principles:** (1) self-directing questions, not checklists — questions stay live, checklists become rituals; (2) hard rules where ritualization is the real risk (hard exclusions, prohibition of generic edge case lists, mandatory material artefact).

---

## 2. Activation Triggers

Mandatory when any of the following is true:

- **T2 prompt being prepared** — runs inside `prompt-writing-standard` Step 6a, before the TASK block is formed
- **Micro-decision inside research-protocol Phase 3** — lightweight predecessor to the formal premortem
- **Explicit invocation** — "продумай вперёд", "что это затронет", "какие последствия", "forward thinking"

**Hard exclusions (override triggers):** T1 tasks; pure text content edits; pure documentation edits; mechanical fixes (formatting, lint); verification-time work after code is written (that is `real-path-verification`'s domain). If an exclusion fires, Claude states which one and proceeds without the skill.

---

## 3. The Three Mental Moves

All three are mandatory. Each has a question, an output format, and a hard rule against ritualization.

### Move 1 — Default inversion

**Question:** *"If the happy path were the exception and the unhappy path were the norm, which case would become the norm?"*

Attacks WYSIATI bias and planning optimism. The grammatical shift from "what might break?" to "which case is the actual norm?" activates the same mechanism that makes formal premortem work.

**Output format:** one concrete sentence: *"Case X is the norm because Y."*

**Hard rule:** name a concrete case (not "errors happen") and a concrete reason (not "just in case"). Generic phrasing = ritual, redo.

*Correct:* "A response longer than Telegram's 4096-character limit is the norm because the new format has 6 blocks and max_tokens=4000 produces ~6000-8000 Cyrillic chars."

### Move 2 — What-it-touches on 1-2 steps

**Question:** *"Which component does this touch first, and what depends on that second?"*

Surfaces second-order effects using the three-layer model from `real-path-verification` Section 5 (System / Neighbour-system / User) in **predictive mode**.

**Output format:** 1-3 bullets per layer: *"X → Y → Z"*. Layers with no effect are stated as such ("System: no effect"), not omitted.

**Hard rule:** empty across all three layers = T1, not T2 — return to triage. Forward thinking that finds nothing on every layer is a signal of misclassification, not safety.

*Correct:* "System: ResultBlock signature change → UniversalToolDialog updated → ToolDialog NOT updated → build fails. Neighbour-system: build failure blocks all deploys. User: no impact if both files updated; extended outage if missed."

### Move 3 — User-lens

**Question:** *"Which specific user hits this first, and what do they see when it goes wrong?"*

Forces a concrete persona into the design loop. "The user" is a placeholder; specific personas — new user with no data, slow connection, empty state, unsupported browser, edge data shape — each have different failure modes, and the worst one is the persona never consciously considered.

**Output format:** one specific user (named by a distinguishing condition) + one specific observation (what they see, hear, or fail to receive).

**Hard rule:** "user" without distinguishing condition = not legitimate output. Observation must be concrete (not "they experience errors").

*Correct:* "An active user with several successful scans hits a complex product with many ingredients, expects an answer, sees silence — bot stops mid-conversation."

---

## 4. Output Artefact

**Primary destination — REGRESSION SHIELD block** of the prompt (per `prompt-writing-standard` Section 3): add 2-3 lines in the form *"Forward-thinking: <Move 1 sentence>. Most-touched: <Move 2 sentence>. User-first-hit: <Move 3 sentence>."* The three sentences may be condensed if natural, but each move's content must be findable.

**Secondary destination (when applicable):** if Move 1/2/3 surfaces a scenario not covered by planned happy-path verification, add it as a new unhappy-path verification scenario per `real-path-verification` Section 6 (Trigger / Input / Expected / Verify at).

**Without artefact, step is not closed.** Same rule as `real-path-verification`: thinking only in the head is not thinking.

---

## 5. Anti-patterns — explicitly forbidden

1. **Generic edge case lists** (empty/null/large/negative) — junior-level, Claude already does this by default
2. **"No harmful consequences" without active search** — state "No harmful consequences after explicit search through Moves 1-3" or do not state it (analogous to `knowledge-structure` §7 ADR rule)
3. **Abstract user references** ("the user", "users") — Move 3 fails, specify the persona
4. **Ritual output** — "errors may occur", "may affect downstream" — each move's hard rule rejects this
5. **Substituting this skill for `real-path-verification`** — design-time vs verification-time, not interchangeable
6. **Substituting this skill for `research-protocol` premortem** — T2 micro-scale vs T3 strategic scale
7. **Stretching past 2-3 minutes on T2** — the task is probably T3, escalate triage
8. **Skipping "because it's obvious"** — every past incident felt obvious in hindsight; that is exactly when the skill earns its keep

---

## 6. Lightweight Pass for T2

- **Time:** 2-3 minutes, not more. Longer = misclassified, return to triage.
- **Output:** 3 short pillars (one per move), condensed into 6-8 lines maximum in REGRESSION SHIELD.
- **When Move 2 is empty across all three layers** — task is T1, escalate triage.
- **When task triggers both this skill (T2) and `research-protocol` (T3)** — run this first as lightweight predecessor, then run formal premortem.

---

## 7. Connections to Other Skills

- **`prompt-writing-standard`** — primary integration. Activates in Step 6a before TASK block; output lands in REGRESSION SHIELD.
- **`real-path-verification`** — counterpart in time. This skill = design-time (before code); `real-path-verification` = verification-time (after code). Borrows the three-layer model for Move 2. May feed new scenarios into Section 6.
- **`research-protocol`** — counterpart in scale. This skill = T2 micro-decision; premortem = T3 strategic decision. Runs as lightweight predecessor inside Phase 3.
- **`bug-hunting`** — counterpart in stance. This skill = proactive (before code); bug-hunting = reactive (after incident). Effective forward thinking reduces bug-hunting frequency.
- **STANDARDS §1.1** — general "barometer" questions remain upstream; this skill is the structured workflow for one of them ("риск регрессии").
- **`anti-hedging-language`** — applies to this skill's output. Each move's hard rule against generic phrasing exists precisely to keep output unhedged.

---

## 8. Examples — Real Cases from Past Sessions

Illustrative, not exhaustive. Reconstructions of what the skill would have produced if applied at design time to incidents that actually occurred.

### Example 1 — WhatScan Telegram 4096-character limit (March 2026)

Real incident: prompt format change pushed responses past Telegram's per-message limit; bot failed mid-response; three fix attempts before durable solution.

- *Move 1:* "A response longer than 4096 chars is the norm because new format has 6 blocks and max_tokens=4000 produces ~6000-8000 Cyrillic chars."
- *Move 2:* "System: prompt change → output length grows → Telegram limit hit. Neighbour-system: bot.ts reply fails → decrementReports skipped → user loses scan from quota. User: sees silence."
- *Move 3:* "An active user with several successful simple scans hits a complex product with many ingredients, expects an answer, gets nothing; next attempt also fails."

REGRESSION SHIELD output would have triggered explicit defenses: character limit in prompt, lower max_tokens, graceful truncation — the three fixes the team eventually arrived at reactively.

### Example 2 — ЮрАссистент `nextSteps` refactor miss (March 2026)

Real incident: prop removed from ResultBlock; `UniversalToolDialog` updated; `ToolDialog` missed; build broke during deploy.

- *Move 1:* "Other callers of a shared component using the removed prop are the norm because shared components in this codebase are reused across multiple dialogs."
- *Move 2:* "System: ResultBlock signature change. Neighbour-system: grep for ResultBlock → ToolDialog also calls it with nextSteps → must update both. User: broken deploy if only one updated."
- *Move 3:* "A developer running the deploy pipeline after this prompt sees `Type error: Property 'nextSteps' does not exist` in `ToolDialog.tsx:903` — deploy halts before any user sees the change."

REGRESSION SHIELD output would have explicitly named `ToolDialog.tsx` as requiring the same update.

---

## 9. Quick Reference

| Mental Move | Question | Output format | Hard rule |
|---|---|---|---|
| **1. Default inversion** | If happy path were the exception, which case is the actual norm? | "Case X is the norm because Y." | Concrete case + concrete reason. |
| **2. What-it-touches** | Which component does this touch first, and what depends on that second? | 1-3 bullets per layer (System / Neighbour-system / User). | Empty across all three layers = T1, return to triage. |
| **3. User-lens** | Which specific user hits this first, and what do they see when it goes wrong? | Specific persona + specific observation. | "User" without distinguishing condition = not legitimate. |

| Don't | Do |
|---|---|
| List generic edge cases (empty/null/large) | Identify one specific unhappy path per move |
| State "no consequences" without searching | State "after explicit search through Moves 1-3" |
| Reference "the user" abstractly | Specify by one distinguishing condition |
| Produce ritual output | Produce material output in REGRESSION SHIELD |
| Spend 5+ min on T2 | Spend 2-3 min, escalate if longer |
| Substitute this for `real-path-verification` | Use this at design time, that one at verification time |
| Substitute this for `research-protocol` premortem | Use this for T2, premortem for T3 |
| Skip "because obvious" | Run the skill — past incidents all felt obvious in hindsight |
