---
name: research-protocol
description: Deep investigation protocol using the virtual team roster, with a dedicated critical phase and premortem, for decisions with long-term consequences. Use this skill whenever the cost of reversing a decision is high (architecture, stack choice, monetization, infrastructure), whenever a decision depends on external facts that may be outdated (laws, service terms, market numbers, tool versions), whenever there is a non-obvious tradeoff between resources and quality, whenever the question is phrased as "how should we" / "is it worth" / "what is the right way" rather than "do X", or whenever Vasily asks for research explicitly. This skill is mandatory in these situations — not optional. Do NOT use for implementing an already-approved decision, for local bugs or single-file refactors, for standard operational tasks (deploy, migration, config), or when Vasily explicitly says "just do it".
---

# Research Protocol
<!--
  @file:        skills/research-protocol/SKILL.md
  @description: Deep investigation by the virtual team for decisions with long-term consequences
  @version:     1.2
  @updated:     2026-05-20
-->

---

## 1. Philosophy

**Research exists because memory lies and consensus forms too fast.**

Two failure modes have appeared repeatedly in past work. First, the model answers from training data on questions where facts have since changed — market numbers, affiliate terms, API limits, regulatory details — and the answer looks confident but ages badly within months. Second, the virtual team converges on a consensus quickly and stops looking; a simpler or cheaper path that would have worked is missed because no one tried to attack the consensus. The past case where the team proposed registering as a personal-data operator instead of anonymizing with placeholders is the canonical example of both failures combined.

This skill replaces those failure modes with a structured protocol: explicit sourcing of facts, a critical phase that attacks the tentative recommendation, and a premortem that treats failure as already-happened rather than hypothetical. The protocol exists to be used when the cost of a wrong answer exceeds the cost of a focused research session to get it right.

**Two principles override everything else in this skill:**

1. **Self-directing questions over rigid rules** for trigger detection and critical-phase work — these are judgment calls that context-dependent questions handle better than checklists.
2. **Hard rules for the few things that fail when soft** — web-search for external facts, premortem as a formal step, fixed report skeleton, user approval before launch.

---

## 2. Activation Triggers

The trigger test is four self-directing questions, asked before answering any non-trivial decision-support request. If **any one** triggers, Claude proposes research before proceeding.

### The four questions

1. **Cost of reversal.** If I answer now from my own knowledge and the answer turns out to be wrong, how expensive is the rollback? Rewriting an architecture, changing a monetization scheme, redoing a regulatory filing, losing user trust, repaying users — all high. Renaming a variable, adjusting a copy — low.
2. **Freshness of facts.** Does my answer depend on external facts that can change — laws, service tariffs, API prices, affiliate terms, model capabilities, library versions, market numbers? If yes, my training data is suspect by default.
3. **Hidden tradeoff.** Does the task contain a non-obvious choice between resources and quality where it would be easy to pick an expensive solution when a sufficient one exists? The canonical example: defaulting to "register as an operator" when "anonymize on the server" solves the same problem.
4. **Shape of the question.** Is the question phrased as "how should we do X" / "is it worth doing Y" / "what is the right approach" — rather than "do X"? The first form implies uncertainty about the decision itself; the second implies the decision is made.

**One trigger is enough.** Claude does not need to count how many questions fire — one clear yes is the threshold.

### Hard exclusions — research is not proposed

These override the four questions:

- The task is implementing something already decided (previous chats, approved plan, explicit `decisions.md` entry).
- The task is a local bug, a single-file refactor, a rename, or similar narrow edit.
- The task is a standard operational action — deploy, migration, restart, config change, SSL renewal.
- Vasily has explicitly said "just do it" / "без обсуждений" / "делай как знаешь" for this task.

### How the proposal is made

Claude never launches research unilaterally — the cost to Vasily (waiting, reading) is real. When a trigger fires, Claude proposes in one phrase, names the trigger, and waits for one-word approval:

> "Вижу триггер [короткая формулировка какого именно вопроса] — предлагаю исследование перед ответом. Запускать?"

If Vasily approves, Claude runs the full protocol. If Vasily says no, Claude proceeds directly with a brief answer noting the skipped step.

---

## 3. Workflow Architecture — Three Layers

| Layer | Role | What they do |
|---|---|---|
| **Vasily** (decision layer) | Manager / visionary | Approves the research launch, validates the final recommendation, decides whether to apply it |
| **Claude — this chat** (reasoning layer) | Senior partner | Runs all four phases: data gathering, team discussion, critical phase, final report |
| **External sources** | Fact layer | `web_search` for current external facts, `conversation_search` for past decisions, `knowledge/` for project state |

Claude conducts the research autonomously once launched. Vasily is not asked intermediate questions during phases — intermediate input breaks the critical-phase dynamic (consensus forms around what Vasily seems to want). Vasily sees the completed report and responds once.

Exception: if during phase 1 or 2 Claude discovers the original question was misframed (e.g. Vasily asked "which payment provider" but the real question is "do we need payments at all yet"), Claude pauses and reports this to Vasily before continuing.

### Language of artifacts

| Artifact | Language | Reason |
|---|---|---|
| All conversational output (proposal, report, TL;DR, discussion) | Russian | Vasily reads these in chat |
| Ready-to-paste `decisions.md` block | Per the project's convention (usually Russian for RU-facing projects, English for code-only repos) | Matches the existing `decisions.md` style in the target project |

---

## 4. The Four Phases

Each phase has a clear output before the next begins. The full protocol is substantial work — comparable to a focused session of research and writing — but the phases scale down for narrower questions (see Section 6).

### Phase 1 — Data reconnaissance

**Guiding question:** *"What do I need to know that I don't currently know with enough confidence?"*

From the answer, Claude picks sources — **in this order of priority**:

1. **Past chats first** — run `conversation_search` before any other source when the question looks like it may have been discussed in earlier sessions, when Vasily references prior decisions, or when a similar task exists in another project. Accumulated history frequently already contains the answer or half of it, and starting here prevents redoing research we've already done. This is the single most under-used source across past cases.
2. **Project knowledge** — read `knowledge/INDEX.md` + the relevant files when the question touches existing project state, architecture, or past decisions recorded in `decisions.md`.
3. **External sources** — use `web_search` when the answer depends on facts about the outside world.

**Hard rule — web search for external facts.** Any fact about the outside world that the recommendation rests on is verified via web search, not taken from training data. This applies to: laws and regulations (152-ФЗ, ГК, GDPR, product liability, advertising law), commercial service terms (API tariffs, payment commissions, affiliate rates), current state of fast-moving technologies (LLM models, framework versions, SDK capabilities), market numbers behind the decision (conversion rates, average revenue, audience size). Not every fact — only those the recommendation rests on.

Phase 1 output: a short note — what was searched, what was found, what was deliberately not searched and why.

### Phase 2 — Team discussion

The roster lives in the system prompt; this skill does not duplicate it. The discussion uses that roster and the existing «Обсуждение» mode conventions — with the following specifics:

- **Specialist selection is by relevance, not count.** One specialist for a clearly single-domain question, four or five for a cross-cutting one.
- **Each specialist states their position as fully as the argument requires** — short when the argument is short, longer when it isn't. No artificial word limits.
- **Disagreements are named explicitly.** Where positions diverge, Claude states where and on what basis. Where positions converge, Claude states that too ("team converges on X").

Phase 2 output: named specialists, their positions, explicit points of agreement and disagreement, a tentative recommendation.

### Phase 3 — Critical phase

This phase exists because phases 1 and 2 tend to produce a converging consensus. The job of phase 3 is to attack that consensus. Claude switches role: stops looking for the best answer, starts looking for reasons to reject the tentative recommendation.

**Self-directing questions for the critical phase:**

- If I had to argue this recommendation is wrong — what would the strongest attack look like?
- What is the simplest solution that could work? Why did we reject it? Is the reason substantive or inertial?
- What data and assumptions does this recommendation rest on? Which of them is the most fragile?
- Did I gather evidence that supports the recommendation, or also evidence that could contradict it? If only the former — I've been confirming, not investigating.
- What do I not know that I should know to be confident in this?
- How do comparable products solve this — Russian and global? If our answer differs from what most of them do, what is our specific reason?
- Which part of this recommendation can only be verified by running it against the real path, not by analysis? Per skill `real-path-verification` Section 5, every recommendation has consequences on the System, Neighbour-system, and User layers — some of these only surface when the code actually runs in production. State what real-path verification would test that this research cannot. If the answer is "nothing — pure analysis is sufficient", say so explicitly; if there is a layer that research cannot reach, that gap goes into the report as "what to verify before/after implementation".
- Does this research contain any micro-decisions (tactical choices inside the strategic recommendation — specific adapter, specific library version, specific copy variant) that would benefit from forward thinking at the design-time level, before the formal premortem runs on the strategic decision as a whole? If yes, per skill `forward-thinking-discipline` Section 2, that skill is mandatory for each micro-decision: three mental moves (Default inversion / What-it-touches / User-lens) before the micro-decision is fixed. Formal premortem covers the strategic level; forward-thinking covers the tactical level. Both run — they are not interchangeable.

**Hard procedure — premortem.** After the questions above, run an explicit premortem. Not a soft "think about risks" — the formal version, because it works specifically as a formal step. The grammatical shift from "what could go wrong" (speculative, low engagement) to "why did this go wrong" (observed, explanatory) activates a different kind of reasoning — that is the whole technique and what gives it its disproportionate value.

Premortem procedure:
1. State the premise in past tense: *"It is 6 months from now. This decision failed badly."*
2. List 2–4 reasons, each phrased as a past-tense fact, not a hypothetical: *"It failed because X."*
3. For each reason, note what could be done now to prevent or detect it earlier.

Phase 3 output: 2–4 lines on what the critical phase attacked and what survived, plus the premortem result.

### Phase 4 — Final report

Fixed skeleton (so Vasily can scan predictably), with some blocks conditional on relevance.

**Always present:**

- **TL;DR** — 3–5 lines: the recommendation and its main basis.
- **Recommendation with justification** — the full argument.
- **Ready-to-paste `decisions.md` block** — in Context / Decision / Consequences format, matching the target project's existing style.

**What the critical phase attacked and what survived** — 2–4 lines showing which attacks the recommendation faced and why it still holds (or what was changed in response). Always present, kept short.

**Conditional — include only when genuinely applicable:**

- **Alternatives considered and rejected** — only when alternatives were actually examined in phase 2 or 3. Don't invent rejected alternatives to fill the section.
- **What to re-verify before implementation** — only when the recommendation rests on data that can age (affiliate rates, API tariffs, service terms). For purely architectural decisions about internal code, skip this block.
- **Team disagreements** — only when phase 2 produced real disagreements. Don't stage disagreements for the format's sake.

The principle: a shorter report with only the applicable blocks is better than a longer report with ritual-filled sections.

---

## 5. Rules for `decisions.md` Integration

Every completed research produces a ready-to-paste block for the target project's `decisions.md`. This is part of phase 4's standard output.

Format (matching `knowledge-structure` conventions for append-only decision logs):

```
## [Date] — [Short title of the decision]

**Context.** [What situation the decision addresses — 2–4 sentences]

**Decision.** [What was decided — 1–3 sentences, concrete]

**Consequences.** [What this means going forward — what changes, what stays, what depends on this decision]

**Source.** Research conducted in chat [link or date], phases 1–4.
```

Claude generates this block pre-filled; Vasily copies it into the project's `decisions.md` if he applies the recommendation. If Vasily rejects the recommendation — no entry.

---

## 6. Scope — Scaling the Protocol to the Question

Not every triggered research needs the full treatment. The protocol scales down for narrower questions, but **no phase is ever skipped**.

**Lightweight pass.** For narrow questions with one decision point:
- Phase 1: one or two targeted source lookups
- Phase 2: fewer specialists — whoever is directly relevant, which for a narrow question may be just one
- Phase 3: critical questions + premortem (same formal step — not shortened, because it's the part that delivers disproportionate value)
- Phase 4: TL;DR, recommendation, short critical summary, `decisions.md` block

**Standard pass.** Default for most triggers. Phases as described in Section 4.

**Deep pass.** For questions with multiple decision points, regulatory weight, or long-term architectural lock-in:
- Phase 1: broad search across all three source types
- Phase 2: more specialists, multiple rounds if positions shift after new data surfaces
- Phase 3: critical phase may surface new questions that require a mini-return to phase 1
- Phase 4: full report with all conditional blocks

**Rule that does not scale:** phase 3's premortem runs in every pass, formal procedure unchanged. Dropping or softening premortem is the most common way this protocol degrades into a formality.

**On specialist count:** the principle from Section 4 Phase 2 holds across all passes — specialists are chosen by relevance, not by filling a quota. Lightweight pass tends to need fewer because the question is narrow; deep pass tends to need more because the question is cross-cutting. The pass sets the expected range; relevance sets the actual selection.

**Lightweight predecessor at micro-level:** for tactical micro-decisions inside any pass (specific adapter, specific library version, specific copy variant), skill `forward-thinking-discipline` runs at design-time per micro-decision. This is in addition to premortem (which covers the strategic level), not a replacement.

---

## 7. Anti-patterns — Explicitly Forbidden

These are the specific failure modes this skill exists to prevent. If Claude catches itself doing any of them — stop, return to the phase that was skipped.

1. **Running research without Vasily's approval** — waste of his time, breaks the agreement that he sees the proposal first.
2. **Skipping premortem or softening it to "think about risks"** — the formal past-tense procedure is what gives the technique its disproportionate value. A softened version is theater.
3. **Phase 3 as ritual** — asking the critical questions without genuinely trying to break the recommendation. If phase 3 never changes anything across multiple researches, it's being run as a checkbox.
4. **Using training data for external facts that can change** — laws, tariffs, affiliate terms, API prices, library versions. Memory here is unreliable by default.
5. **Filling conditional report blocks to satisfy the format** — inventing "alternatives considered" that weren't really considered; inventing "disagreements" that didn't happen. A short honest report beats a long ritual one.
6. **Adding too many specialists** — engaging six specialists because "it seems thorough" dilutes each position and slows phase 2. Relevance, not count.
7. **Converging in phase 2 so smoothly that phase 3 has nothing to attack** — if phase 3 can't find a credible attack, the research is probably shallow, not the recommendation obvious. Deepen phase 1 or broaden specialists.
8. **Running the protocol on excluded task types** — implementing already-approved decisions, local bugs, operational actions. The hard exclusions in Section 2 override the four questions.
9. **Producing the `decisions.md` block in the wrong language** — match the target project's convention, not the chat's conversational Russian by default.
10. **Treating this skill as optional when a trigger clearly fires** — the purpose of the skill is exactly the cases where skipping it feels tempting.
11. **Inflating the research proposal into a long pitch** — the proposal is one phrase naming the trigger. If Claude needs three paragraphs to justify why research is needed, that pitch competes with the research itself and trains Vasily to dismiss the skill as overhead.

---

## 8. Connections to Other Skills

- **System prompt — Виртуальная команда.** The specialist roster and «Обсуждение» / «Решение» modes live in the system prompt. This skill uses phase 2 on top of that roster; it does not redefine the roster or its rules.
- **`knowledge-structure`** — phase 4's `decisions.md` block follows the append-only log convention from that skill. When in doubt about format, match the existing entries in the target project's `decisions.md`.
- **`prompt-writing-standard`** — research often produces, as its result, a Claude Code prompt based on the approved decision. That prompt still follows `prompt-writing-standard` Section 2 (Context / Task / Regression Shield / Acceptance Criteria). This skill stops at the research report; prompt-writing takes over from there.
- **`bug-hunting`** — different domain. `bug-hunting` handles "something is broken, find the cause"; this skill handles "before we decide, investigate". A bug that requires a decision about whether to fix, refactor, or rewrite may hand off from `bug-hunting` to this skill.
- **`forward-thinking-discipline`** — counterpart in scale. This skill (research-protocol) handles T3 strategic decisions where formal premortem covers the whole recommendation; `forward-thinking-discipline` handles T2 micro-decisions and tactical choices inside Phase 3 where premortem would be overkill but design-time forward thinking is still mandatory. They are complementary — both run on a T3 task with tactical sub-decisions, neither replaces the other. See §4 Phase 3 critical questions for the activation rule.

---

## 9. Quick Reference

| Phase | Guiding question | Always-present output |
|---|---|---|
| **1. Reconnaissance** | What do I need to know that I don't know? | Sources consulted, findings |
| **2. Team discussion** | What do relevant specialists say, where do they disagree? | Positions, agreements, tentative recommendation |
| **3. Critical phase** | What would it take to reject this recommendation? Why did it fail in 6 months? | 2–4 lines on attack + survival, premortem result |
| **4. Final report** | What does Vasily need to decide and apply? | TL;DR, recommendation, critical summary, `decisions.md` block |

| Hard rules | Self-directing judgments |
|---|---|
| Propose research with one-phrase trigger naming, wait for approval | Whether a trigger fires (the four questions) |
| Web search for external facts the recommendation rests on | Which sources to consult in phase 1 |
| Premortem as formal past-tense procedure | How deep phase 2 needs to go (number of specialists) |
| Fixed report skeleton: TL;DR / recommendation / critical summary / `decisions.md` | What to attack in phase 3, how hard |
| Conditional blocks only when genuinely applicable | Which pass (lightweight / standard / deep) fits the question |
| Hard exclusions override the four trigger questions | — |

| Don't | Do |
|---|---|
| Launch research without approval | Propose with trigger named, wait |
| Use training data for fresh external facts | Web-search facts the decision rests on |
| Soften premortem to "think about risks" | Run the formal past-tense procedure |
| Fill report blocks to look complete | Omit blocks that don't apply |
| Skip phase 3 when consensus feels strong | Attack harder when consensus feels strong — that's exactly when bias hides |
