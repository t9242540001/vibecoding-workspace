---
id: JCK-EXPERIENCE-TRANSFER-BRIEF
type: raw-input-for-integration
author: Claude (strategic partner, JCK chat)
created_for: Hermes Agent
created_at: 2026-06-04
status: raw — to be studied and integrated by Hermes, not consumed verbatim
canonical_sources: github.com/t9242540001/vibecoding-workspace (skills/), project STANDARDS, knowledge/
---

# JCK Experience Transfer Brief — for Hermes

## 0. What this document is, and what it is NOT

This is a **map of accumulated JCK working experience** (skills, standards, rules) built up
in the Vasily↔Claude↔Claude-Code workflow. The goal is to transfer the *useful* parts of
that experience into your (Hermes) own knowledge / skills / instructions — so the same
lessons do not have to be re-learned.

**This document is a raw input, not a finished instruction.** Your job is to study the
sources, decide what is relevant to *you* (a multi-agent orchestration runtime, not a
Claude-Code prompt author), and integrate the relevant parts into your canonical knowledge
(`/var/www/knowledge/platform/{skills,rules,standards}`) as thin loaders, without duplication.

### THE BROKEN-TELEPHONE RULE (highest priority for this task)

The single biggest risk in this transfer is distortion-through-paraphrase ("сломанный
телефон"): you read a summary, reword it, lose the exact constraint that the rule existed
to protect, and the rule becomes decorative.

Three hard protections, binding for this whole task:

1. **The first-source wins over my summary.** Each entry below has a `source` path in the
   canonical repo. My `anchor` text is a *checksum for meaning*, NOT a replacement for
   reading the source. When your understanding diverges from the first source — the
   **first source is right, my anchor is wrong**. Read the source file before integrating
   any rule you intend to keep.

2. **`verbatim` items are copied word-for-word.** Entries marked `precision: verbatim`
   contain rules whose meaning lives in the exact wording (specific thresholds, specific
   prohibitions). Transfer their operative sentences as exact text — do NOT paraphrase
   them. Everything else (`precision: adapt`) you are free to re-express in your own
   structure and language.

3. **Relevance is my hint, integration is your call — but show the plan first.** My
   `relevance` field is advisory ("what", not "how"). You decide the final structure. BUT:
   before you write anything into your canonical knowledge, produce an **integration plan**
   (what goes where, what you skip and why) and wait for Vasily's confirmation. Do not
   silently restructure your knowledge base — that is the exact failure mode (duplicate
   files, divergent systems) this whole effort is meant to cure.

---

## 1. How to read each entry

```
### <skill-name>
- source:     <path in canonical repo — READ THIS, it is the truth>
- raw_url:    <direct raw link if GitHub access is available to you>
- precision:  verbatim | adapt
- relevance:  high | medium | low | claude-code-specific  (my advisory hint)
- anchor:     <2–5 lines — the meaning checksum, NOT a substitute for the source>
- note:       <what is universal vs what is tied to the Vasily/Claude-Code mechanics>
```

Repo: `t9242540001/vibecoding-workspace`, branch `main`, path `skills/<name>/SKILL.md`.
Raw URL shape: `https://raw.githubusercontent.com/t9242540001/vibecoding-workspace/main/skills/<name>/SKILL.md`

---

## 2. The canon — skill by skill

### research-protocol
- source:    skills/research-protocol/SKILL.md
- precision: adapt
- relevance: high  (you ALREADY use this — 28 uses in your usage log)
- anchor: Deep-investigation protocol for high-cost-of-reversal decisions. Four phases,
  none ever skipped: (1) data reconnaissance — past chats first, then project knowledge,
  then web for external facts; (2) virtual-team discussion by relevance not headcount;
  (3) CRITICAL PHASE — attack the consensus + formal past-tense PREMORTEM ("it is 6 months
  later, this failed because X"); (4) fixed-skeleton report. Premortem never softened — it
  is the part that delivers disproportionate value.
- note: Almost fully universal for any autonomous decision-maker. The premortem and
  critical-phase are the core. Tied-to-us: the specialist roster lives in the chat system
  prompt; the `decisions.md` output format is our convention — you map both to your own
  team model and your own decisions log.

### forward-thinking-discipline
- source:    skills/forward-thinking-discipline/SKILL.md
- precision: adapt
- relevance: high
- anchor: Design-TIME discipline (before acting). Treat the happy path as the exception,
  the unhappy path as the norm. Three mandatory mental moves: (1) Default inversion —
  "which case is actually the norm, and why" (concrete case + concrete reason, never
  "errors happen"); (2) What-it-touches 1–2 steps across System / Neighbour-system / User
  layers; (3) User-lens — one concrete persona + one concrete observation when it breaks.
  Generic edge-case lists (empty/null/large) are explicitly forbidden as ritual.
- note: Fully universal — pure thinking discipline. Only the output destination
  ("REGRESSION SHIELD block of the prompt") is Claude-Code-specific; you redirect the
  output into whatever your pre-action reasoning artefact is.

### real-path-verification
- source:    skills/real-path-verification/SKILL.md
- precision: adapt
- relevance: high  (directly relevant to your planned AI-test-agent)
- anchor: "Code written" ≠ "task done". A task closes only when its REAL path is verified,
  not when code compiles. Rewires three defaults: (1) mental simulation before delivery —
  run the logic in your head on 2–3 real inputs, state what you traced and the result;
  (2) forward thinking on consequences — when a decision harms a downstream system, redesign
  NOW using an established pattern (feature flag, graceful degradation, adapter, API
  versioning), do not defer; (3) verify on real data where access allows, hand off the rest
  as structured scenarios (Trigger / Input / Expected / Verify-at). Three honest states:
  coded → pending-verification → verified.
- note: The three states and the scenario format (Trigger/Input/Expected/Verify-at) are a
  ready-made interface for your future AI-test-agent — this is the most forward-useful skill
  for you. Tied-to-us: the prompt block names and the "hand off to Vasily" tier; you remap
  the tiers to "agent verifies / human verifies".

### anti-hedging-language
- source:    skills/anti-hedging-language/SKILL.md
- precision: adapt
- relevance: high  (critical for an agent that must self-report honestly)
- anchor: Hedging ("probably", "should work", "later", "not critical") is a SIGNAL, not a
  style — it grants permission not to finish. Three principles: (1) about a fact — either
  KNOW it (state evidence) or honestly NOT-know with a concrete next step to learn it;
  (2) about a future action — deferral is the LAST option after a cascade (resolve now →
  investigate now → ask Vasily → only-on-explicit-defer becomes a tracked artefact);
  (3) tone vs avoidance — "if I removed the hedge, would my next action change? if yes, the
  hedge was hiding work". Silent deferral without an artefact = lost work.
- note: Fully universal and especially load-bearing for an autonomous agent that reports
  status. Your recurring failure (yesterday's "all models work" report contradicting the
  registry) is exactly the failure this skill prevents. Nothing Claude-Code-specific in the
  core.

### universality-discipline
- source:    skills/universality-discipline/SKILL.md
- precision: adapt
- relevance: high  (direct cure for your duplicate-files / divergent-systems pain)
- anchor: Reuse is the norm, create-new is the exception requiring an explicit reason.
  Anything technical/design is "universal by default"; it goes into a registry
  (`knowledge/universals/`) at first creation, not after second use. Every universal must be
  adaptable by construction (a non-parametrizable one-off is not a universal). Removal only
  by explicit owner command, never inferred. "Almost fits" → STOP and ask, never fork
  silently.
- note: The core principle (one source of truth per unit; do not fork; consolidate
  duplicates) is exactly what cures the "two days spent merging duplicate systems" problem.
  Tied-to-us: examples are UI/code-centric (buttons, tokens); you generalize "unit" to
  agents, tools, prompts, workflows in your runtime.

### prompt-writing-standard
- source:    skills/prompt-writing-standard/SKILL.md
- precision: adapt  (mostly claude-code-specific — extract principles only)
- relevance: claude-code-specific
- anchor: The full workflow for writing Claude-Code prompts: T1/T2/T3 triage; 10 steps;
  4-block template (CONTEXT / TASK / REGRESSION SHIELD / ACCEPTANCE CRITERIA); Step 9
  multi-perspective review; one-prompt-one-file; English prompts; mandatory "build in AC".
- note: WARNING — most of this is tied to OUR mechanics (Claude Code, claude/** branches,
  the 4-block prompt). You have Claude Code DISABLED in your runtime, so the prompt-template
  parts are NOT for you. EXTRACT only the universal kernel: the T1/T2/T3 complexity triage,
  the "verify before done" gate, the regression-shield *principle* (name explicitly what
  must NOT change). Do NOT import the 4-block template or Step 9 wholesale.

### bug-hunting
- source:    skills/bug-hunting/SKILL.md
- precision: adapt
- relevance: high  (you have it but it is nearly dormant — 2 uses)
- anchor: Hypothesis-driven debugging protocol. Activates when a fix failed twice with the
  same approach, a bug recurs, or a prod incident is live. Core move: after the 2nd identical
  failure, change the CLASS of evidence source (not just the client) and offer 3
  fundamentally different hypotheses before acting. Read raw error logs unfiltered (200+
  lines) — pre-filtering hides the key signal. Diagnose before acting; fix the root, not the
  symptom.
- note: Universal debugging discipline. Highly relevant to you given how much of your recent
  history is incident-fighting (OmniRoute, resource-governor flapping). Verify the exact
  procedure against the source — I am summarizing from its description, READ the file before
  integrating.

### knowledge-structure
- source:    skills/knowledge-structure/SKILL.md
- precision: adapt
- relevance: high  (you already live this — thin loaders + canonical knowledge)
- anchor: How to build/maintain a living knowledge base: CLAUDE.md + knowledge/ directory;
  single source of truth; thin loaders pointing to canon, no duplication; ADR log; INDEX
  navigators; content-preservation (Section 9) — do not silently reword adjacent content;
  file-size discipline; WIP→Proposed→Accepted decision lifecycle.
- note: Your CONSTITUTION already echoes this ("git markdown repo = source of truth", "no
  silent edits", "skills are thin loaders"). High overlap — use it to STRENGTHEN what you
  have, not to add a parallel system. Read the source; map its ADR/INDEX conventions onto
  your existing platform/ structure.

### code-markup-standard
- source:    skills/code-markup-standard/SKILL.md
- precision: adapt
- relevance: medium
- anchor: Standard for marking up code + knowledge files: file headers, function docs,
  region comments, inline operational tags, and the @rule / @important distinction
  (@rule = prohibition anchored next to vulnerable code; @important = explanation). Three
  places rules live and their hierarchy.
- note: The @rule-next-to-vulnerable-code idea is a universal anti-regression pattern worth
  adopting. The language-specific syntax sections are reference-only. Read source before
  integrating.

### series-design-discipline
- source:    skills/series-design-discipline/SKILL.md
- precision: adapt
- relevance: medium
- anchor: Design-time discipline for a tight series of 3+ prompts forming one increment.
  Central artefact = Series Charter (Product frame / Invariants / Dependency map / Per-step
  plan / Definition of Done), written before the first step, cited and updated by every step.
- note: Concept maps onto your multi-step workflows / batch runs. "Charter with invariants
  + per-step plan + DoD" is a clean pattern for any orchestrated multi-step task. Tied-to-us:
  the Claude-Code prompt-series mechanics. Take the Charter concept, drop the prompt mechanics.

### skill-writing-standard
- source:    skills/skill-writing-standard/SKILL.md
- precision: adapt
- relevance: high  (you author your own skills — created_by:agent seen in your usage log)
- anchor: Standard workflow + template for creating/updating skills: description-triggering
  accuracy, structure, cross-reference correctness, anti-pattern avoidance, when to
  split/merge/deprecate.
- note: Directly relevant because you GENERATE skills yourself. Adopting this would make your
  self-authored skills consistent in shape and triggering. You already have a copy of this
  on disk — verify it is the current version against the source.

### geo-content-discipline
- source:    skills/geo-content-discipline/SKILL.md
- precision: verbatim  (the 7 rules are threshold-specific)
- relevance: medium  (relevant when you touch JCK web content / SEO pipeline)
- anchor: GEO/AEO content discipline — seven Princeton-tier rules for AI-citation-ready web
  content (answer-first; ≥1 statistic per 300-word section; ≥1 quoted authority; one idea per
  paragraph; conversational long-tail headings; ≤1 H2 as a question; Date schema) + the
  Yandex Neuro 5-of-30 constraint + schema-coverage checklist.
- note: Relevant only to JCK-business content surfaces (blog, news, FAQ, car cards). The
  seven rules have specific numeric thresholds — transfer them VERBATIM, do not round or
  reword. Not relevant to your internal reasoning.

### ai-visibility-measurement-ritual
- source:    skills/ai-visibility-measurement-ritual/SKILL.md
- precision: adapt
- relevance: medium  (relevant to JCK business growth — your stated mission)
- anchor: Weekly/monthly ritual to measure JCK brand visibility across 5+ LLM platforms
  (ChatGPT, Claude, Perplexity, Yandex Neuro, DeepSeek): structured logging of Citation
  Frequency, Mention Rate, Share of Voice, Sentiment, Source Diversity; ensemble rule (3+
  runs per prompt due to LLM non-determinism); trend analysis.
- note: Directly serves your "help grow the business" mission. The ensemble rule (3+ runs)
  is a real measurement-validity point worth keeping exact. Read source before integrating.

### site-audit
- source:    skills/site-audit/SKILL.md
- precision: adapt
- relevance: low-medium
- anchor: (Summarizing from repo listing — READ THE SOURCE, I have not opened this file.)
  A site-audit procedure for the JCK web property.
- note: I did NOT read this file's contents — treat my anchor as UNVERIFIED. Read the source
  in full before deciding relevance. Flagging the gap honestly rather than inventing a
  summary.

---

## 3. The STANDARDS document (project constitution-of-how)

- source:    project STANDARDS file (jck-auto-technical-context.md / STANDARDS_v2.0)
- precision: adapt
- relevance: high
- anchor: The "why and how" layer behind the system instruction. Key transferable sections:
  partnership model (strategic partner, not order-taker — say no with arguments); complexity
  triage T1/T2/T3 with the multilingual-research protocol (5 research questions across 7
  languages, the refuting question #2 mandatory); virtual team (permanent members + when to
  convene others; Discussion vs Decision modes); diagnose-before-acting (two-step protocol,
  recurring-error rule); @rule anti-regression; security-as-baseline; resource economy
  (local → cache → free API → paid API); scope discipline (touch only what was named).
- note: Much of this you already encode in your CONSTITUTION. Use it to fill gaps, not to
  duplicate. The multilingual-research protocol and the partnership "disagree with arguments"
  stance are the highest-value transfers.

---

## 4. What is almost certainly NOT for you (skip list — my advisory)

- The 4-block Claude-Code prompt template and Step 9 review (prompt-writing-standard) — you
  do not author Claude-Code prompts; Claude Code is disabled in your runtime.
- claude/** branch / auto-merge / deploy mechanics — our git workflow, not yours.
- Anything assuming "Vasily runs the command and pastes output" — you have direct server
  access through your own tools.

If you disagree with any skip recommendation — say so in your integration plan with a reason.
That disagreement is exactly the kind of input Vasily wants to see, not suppress.

---

## 5. Definition of done for this transfer

1. You have READ each source you intend to integrate (not just my anchor).
2. You produced an integration plan: per skill — integrate / skip / partial, with target
   location in your canon and a one-line reason.
3. Vasily confirmed the plan BEFORE you wrote into your canonical knowledge.
4. Integrated rules marked `verbatim` carry their operative sentences as exact text.
5. No duplication: each transferred rule lives in ONE canonical place, referenced by thin
   loaders — not copied into multiple SKILL.md files.
6. Where your understanding diverged from my anchor, you noted it and followed the SOURCE.
