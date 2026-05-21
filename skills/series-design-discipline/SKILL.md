---
name: series-design-discipline
description: Design-time discipline for tight series of 3+ prompts that together form one project increment. Use this skill whenever a task decomposes into a series of 3+ sequential prompts for Claude Code — a new ЭТАП in a project ТЗ, a feature implementation across multiple files, a recommendation from research-protocol that translates into multiple prompts, or any moment when Vasily says "это серия" / "разобьём на этапы" / "series of prompts". This skill is mandatory in these situations — not optional. The skill operates at the design layer between research-protocol (strategic decision) and prompt-writing-standard (individual prompt). Do NOT use for genuinely single-prompt tasks (T1); for pure mechanical batches with no logical state between prompts (formatting passes, batch renames); for pure documentation series where each prompt is an isolated knowledge edit with no shared state.
---

# Series Design Discipline
<!--
  @file:        skills/series-design-discipline/SKILL.md
  @description: Design-time discipline for tight series of 3+ prompts forming one project increment
  @version:     1.0
  @updated:     2026-05-21
-->

---

## 1. Philosophy

**A series of prompts in one PROJECT is one project increment, decomposed into stages. All prompts in the series obey a single namespace of goals, rules, and invariants.**

A series is not a chain of independent work items. It is one design, expressed across multiple atomic prompts because the `prompt-writing-standard` one-file rule prevents physical fusion. The fusion happens at the design layer — shared goal, shared invariants, shared context handoff — not in the prompt body.

**"Project" is a scalable concept.** A series may span one feature inside one repository, several connected repositories under one initiative, or one ЭТАП inside a project's ТЗ. The scale parameter varies; the discipline is identical. A series that touches `yurassistent` + `whatscan` + `productcenter-moderator` is the same kind of work as a series that touches three files inside one repository — just with a wider PROJECT boundary.

**Base rule for every prompt in any series:** "do no harm — leave the PROJECT better than you found it." Each prompt must serve the series' goal and respect the series' invariants. A prompt that completes its own task while violating a series invariant is a failed prompt, regardless of whether its own AC pass.

**Meta-interpretation (correct):** the series has a single namespace of goals and rules, available to every prompt through one shared artefact (the Series Charter — see Section 3).

**Literal interpretation (rejected):** "the series is one big multi-page prompt." This violates `prompt-writing-standard` §6 (one prompt = max 1 file) and one prompt = one task. The series stays a series of prompts; the Charter provides logical coherence between them.

This skill structures the informal practice that already works in past sessions (productcenter-moderator audit-of-producers, ЮрАссистент Этап 7 three-phase architecture, Products Research Agency 12-15 prompts in 4 phases). The ТЗ-document at the project level continues to be the source of truth for the whole product; the Series Charter is a sub-level document for one concrete series.

---

## 2. Activation Triggers

This skill is **mandatory** when any of the following observable conditions is true. Claude informs Vasily: "Подключаю series-design-discipline — пишу Series Charter до первого промпта серии."

### Trigger 1 — Forward mode

The task is a distinct series from the start. Signals:
- `research-protocol` Phase 4 recommendation requires multiple prompts to implement
- A new ЭТАП in the project's ТЗ
- A feature implementation that obviously touches 3+ files in sequence (schema → API → UI, or similar)
- Vasily explicitly says "это серия" / "разобьём на этапы" / "series of prompts" / "фаза N" / "multi-prompt"

Charter is written **before the first prompt** of the series.

### Trigger 2 — Discovery mode

A T2 task that was expected to be single-prompt expanded mid-flight. After the first or second prompt it becomes clear that 3+ more prompts are needed. STOP the current flow → write the Charter retroactively (including a description of what was already done) → resume the series.

This trigger handles the realistic case where series-shape emerges organically. Skipping the Charter "because we already started" lets the rest of the series drift; writing it retroactively recovers the discipline.

### Trigger 3 — Explicit invocation

Vasily says "это серия", "разобьём на этапы", "series of prompts", "multi-prompt", "фаза N", or any equivalent.

### Hard exclusions — skill is not applied

These override the triggers above:

- **Genuinely single-prompt tasks** — T1, or T2 that fits in one prompt
- **Pure mechanical batches** — formatting passes, batch renames, mass label changes where each prompt has no logical dependency on the previous one (operational concern for `batch-execution-standard`, not design concern for this skill)
- **Pure documentation series** — each prompt is an isolated knowledge edit with no shared state, no shared invariants, no logical handoff

If an exclusion fires, Claude states which one and proceeds without the skill — no silent skipping, but no unnecessary friction either. Most T2/T3 tasks that expand into 3+ prompts are **not** in the exclusion list; they activate this skill.

---

## 3. The Series Charter — Core Artefact

The Series Charter is a structured document written before the first prompt of a forward-mode series, or retroactively after the first or second prompt of a discovery-mode series. The Charter file lives at `knowledge/series-charters/YYYY-MM-DD-<series-name>.md` in the relevant project. For cross-repository series, the Charter lives in `vibecoding-workspace/knowledge/series-charters/` with explicit listing of affected repositories.

**Precision over compactness.** There is no hard size limit on the Charter. A precise document that prevents drift and rework is worth more than a short document that misses an invariant. Compactness is achieved through the fixed five-section structure, not by cutting content.

### Section 1 — Product frame

The series' goal stated from the stakeholder's perspective, not the implementer's. Three things must be explicit:

- **Goal of the series in user-facing terms** — what new capability the system will have after the series completes. Not "8 prompts merged"; not "code in main"; rather "the moderator can audit producers automatically" or "the user can attach a PDF and get a parsed contract".
- **Stakeholder** — who is the named beneficiary of this series. May be a user role (new user, paying user, moderator), an internal role (admin, developer), or a business process (lead capture, payment flow). The stakeholder is a person or process, not a code unit.
- **Definition of Done in product language** — when the series is "really done" from the stakeholder's view. The technical DoD (Section 5) is downstream of this; this is the contractual outcome.

If the Charter starts with technical decomposition instead of product frame, the Charter is malformed — redo Section 1.

### Section 2 — Invariants

Architectural, UX, tonal, or domain-specific rules that **every** prompt in the series must obey. Not a duplication of `CLAUDE.md` critical rules — those apply to the whole project always. These are **series-specific** rules — true for the duration of this series, possibly retired afterwards or absorbed into project rules.

Examples (illustrative, not exhaustive):
- "All routes for this feature live under `/api/audit/`"
- "User-facing copy uses ты, not вы"
- "PII never leaves the Russian server in any prompt of this series"
- "Every prompt that touches the producers table also writes to the audit log"
- "Naming convention: ProducerX for entities, producer_x for tables, producerX for variables"

The invariants are short, declarative, and verifiable. Each prompt in the series cites the invariants relevant to it in its CONTEXT block.

### Section 3 — Dependency map

The order of prompts and the rationale for that specific order. Three things must be explicit:

- **What depends on what** — which prompt produces state (schema, file, API contract, configuration) that a later prompt consumes. Dependencies are stated as "prompt N produces X; prompt N+M consumes X".
- **What is sequential vs parallelizable** — a series rarely is purely sequential. Parts that can run in parallel are marked so; parts that must wait are marked so. Parallelizable prompts may still execute one at a time (Claude Code one-file rule), but the design declares them independent.
- **Universality decisions** — per skill `universality-discipline` (G), every series touches universal-scope units (components, engines, tools, design tokens, text patterns, forms). The Dependency map states which universals the series **reuses** from existing `knowledge/universals/*.md`, which universals the series **creates new** (and where the new entry will be registered), and which universals are **shared between prompts inside the series** (created in prompt N, consumed in prompt N+M). Silent invention of a parallel universal mid-series is forbidden; the Charter is where that decision lives.

The Dependency map is the contract that prevents prompt N+1 from breaking prompt N's work and prevents prompt N+M from re-creating what prompt N already created.

### Section 4 — Per-step plan

A numbered list of the prompts in the series. Each step has:

- **Number and short title** — "01. Schema and base API"
- **One or two lines of description** — what this prompt does in plain language
- **Dependencies cited** — "depends on: 02 schema; produces: producer table" (referring to entries from Section 3)
- **Status** — `⏳ pending` / `🔄 in-progress` / `✅ done` (with date)

This is the **forward parade** — when the series later goes through `batch-execution-standard` §4 (parade-of-prompts), that parade is a tabular projection of this section, not a separately-authored summary.

A series with fewer than 3 steps is not a series — return to triage. A series with more than 15 steps is probably two series; consider splitting at a natural product-frame boundary.

### Section 5 — Definition of Done

When the series is complete from a technical and verifiable standpoint, downstream of the product DoD in Section 1. Three things must be explicit:

- **Series-level real-path scenario** — per `real-path-verification` §6, but scoped to the whole series, not individual prompts. The scenario that exercises the new capability end-to-end. Format: Trigger / Input / Expected / Verify at.
- **Knowledge updates required at series close** — what entries appear in `decisions.md`, what is marked ✅ in the project ТЗ, what is registered in `knowledge/universals/*.md`, what is updated in `INDEX.md`. The series close is itself a knowledge event.
- **Charter close-out** — after the series completes, the Charter is moved to `knowledge/series-charters/completed/` (or equivalent) and stays as historical record. It is not deleted; it is not modified after close. The Charter at close is the historical truth of what was decided and what was done.

---

## 4. Charter Lifecycle

### Creation — Forward mode

Before the first prompt of the series:
1. Claude drafts the Charter from the series brief (research-protocol report, ТЗ section, or Vasily's request).
2. Vasily reviews and approves the Charter. Disagreements get resolved at this point — cheaper than mid-series.
3. The Charter is committed to the project's `knowledge/series-charters/` as the **first commit of the series**. The series cannot start without this commit landing.

### Creation — Discovery mode

After the first or second prompt of what was expected to be a single-prompt or short task:
1. STOP the current flow as soon as the series-shape becomes visible.
2. Claude drafts the Charter, including a description of what was already done in the first one or two prompts.
3. Vasily approves the Charter.
4. The Charter is committed.
5. The series resumes; the first not-yet-done prompt is the next one.

Discovery mode is not a failure — it is the realistic case where intent emerges from work. Skipping the Charter "because we already started" lets the rest of the series drift; writing it retroactively recovers the discipline.

### Update after each prompt

After each prompt in the series is completed and merged, the Charter is updated:

- **Section 4 Per-step plan** — status of the just-completed prompt moves to `✅ done` with the date
- **Section 3 Dependency map** — if new dependencies surfaced during the prompt, they are added (with a one-line note: "discovered during prompt 04 — promtp 06 will need access to the new table X")
- **Section 2 Invariants** — if the prompt revealed a missing invariant (something that "should have been a rule from the start"), it is added explicitly. Adding an invariant mid-series is allowed; silently violating one is not.

The update happens **in the same commit** as the prompt's other knowledge updates (per `prompt-writing-standard` §4 Knowledge update rule). A prompt that does not update its Charter is incomplete.

### Hard rules

1. **Every prompt in the series cites the Charter in its CONTEXT block.** Format: `Series: <link to Charter>. Invariants from Charter that apply to this prompt: <list>.` Citation without listing relevant invariants is malformed citation.
2. **Update step is mandatory** — after each prompt of the series, the Charter is updated. Skipping the update means the series loses its continuity mechanism.
3. **Charter does not replace project ТЗ** — ТЗ is project-level source of truth; Charter is series-level mini-spec. Both exist; the Charter cites the ТЗ section it implements.

---

## 5. Connection to Other Skills

- **`research-protocol`** — frequent predecessor. Phase 4 strategic recommendation often translates into a multi-prompt implementation. The handoff from research-protocol to this skill is: research recommendation → Series Charter draft → first prompt of series. Not every series requires research-protocol; some series implement already-approved decisions where the strategic phase is already closed.
- **`prompt-writing-standard`** — every prompt in the series follows this standard. The CONTEXT block of each prompt cites the Charter and lists relevant invariants. The brief in Step 8a refers to the Charter as the source of the goal.
- **`batch-execution-standard`** — operational layer for autonomous series execution. The parade-of-prompts (§4 of that standard) is now a forward tabular projection of the Charter's Section 4 Per-step plan, not a reverse-engineered summary written after all prompts are composed.
- **`forward-thinking-discipline`** (C) — applies inside each prompt of the series at design time. Charter Section 2 Invariants may include forward-thinking insights at the series level ("the happy path for this series is case X; the unhappy path that every prompt must defend against is case Y").
- **`real-path-verification`** (D) — Charter Section 5 Definition of Done contains the series-level real-path scenario. Each prompt in the series also has its own per-prompt verification scenarios per D §6.
- **`universality-discipline`** (G) — directly referenced from Charter Section 3 Dependency map. A series typically touches multiple universal-scope units and may itself produce new universals consumed later within the same series. The Charter is the natural place to record reuse / create / share-across-prompts decisions for the series as a whole, rather than letting each prompt re-discover them independently. Without this series-level record, the same universal can be re-invented across two prompts of the same series — the failure mode G exists to prevent, amplified by series length.
- **`knowledge-structure`** — Charter files live in `knowledge/series-charters/`, are registered in `INDEX.md`, and after series close are moved to `knowledge/series-charters/completed/`. The Charter is itself a knowledge artefact and obeys knowledge-structure conventions (header, dates, append-modify history through git).

---

## 6. Anti-patterns — Explicitly Forbidden

If Claude catches itself doing any of these, stop and revisit the relevant section.

1. **Charter as ritual** — a formal document with no live connection to the prompts of the series. Check: each prompt's CONTEXT block cites the Charter; each prompt's commit includes a Charter update.
2. **Charter as full project spec** — bloating to 10+ pages with descriptions of the whole product. The Charter is about **one series**, not the whole PROJECT. The project ТЗ is upstream; the Charter cites it but does not duplicate it.
3. **Charter without Product frame** — starting with technical decomposition before stating who benefits and what new capability appears. Section 1 is non-negotiable as the opening.
4. **Drift between Charter and prompts** — Charter written, then prompts written outside its frame. Update step after each prompt is the prevention; the Step 9 review of each prompt verifies citation.
5. **Literal "one big prompt"** — attempting to fuse the series into a single multi-page Claude Code prompt. Violates `prompt-writing-standard` §6 one-file rule. The fusion happens at the design layer (the Charter), not in the prompt body.
6. **Charter created in forward mode but the project organically evolved** — Charter is "fulfilled formally" even after intent has shifted. The Charter must be updated when intent changes, not preserved for the sake of preservation. An obsolete Charter is worse than no Charter.
7. **Series without a Charter "because only 3 prompts"** — 3 is the lower bound of the trigger, not a threshold for exclusion. 3+ prompts require a Charter unless one of the hard exclusions in Section 2 applies.
8. **Silent universality decisions across the series** — creating a universal in prompt 03 without registering it, then re-creating a parallel variant in prompt 07 because the registration step was skipped. Section 3 Dependency map of the Charter is where universality decisions for the whole series live; failing to record them there is the cause of the duplicated-variant failure mode `universality-discipline` exists to prevent.

---

## 7. Example — Real Series from Past Sessions

Illustrative, not exhaustive. Reconstruction of how the Series Charter would have looked for a real series in past work (productcenter-moderator Producer Audit, ~April 2026).

```
# Series Charter — productcenter-moderator: Producer Audit

@series:      productcenter-moderator-producer-audit
@status:      in-progress
@created:     2026-04-01
@updated:     2026-04-12

## 1. Product frame

Goal (stakeholder language): the catalog moderator opens the dashboard,
sees a Producers card with daily statistics, can drill into a specific
producer, and sees the AI audit decision with reasoning — without manual
moderation.

Stakeholder: catalog moderator (primary) and end user of productcenter.ru
(downstream — sees a cleaner catalog).

Definition of Done (product language): the moderator processes a day of
flagged producers using the dashboard alone, without consulting raw data
or running queries.

## 2. Invariants

- DaData API calls only from server, never from browser
- PII masking v2 applied to all producer-data before any call to DeepSeek
- All new routes under APP_PREFIX via _prefixed() helper
- Batch processing: 2-5 producers per cycle, ≥1 hour between cycles, no
  retries on transient errors
- Producer audit decisions are append-only; corrections are new entries

## 3. Dependency map

Step 01 (schema + API methods) produces: producers_audit table,
producer_runs table, /audit/producers endpoints.
→ Blocks all later steps.

Step 02 (DaData client) and Step 03 (PII masking v2) are independent of
each other; both depend on Step 01.

Step 04 (Producer Processor) depends on 02 + 03 (uses both DaData and
PII masking).

Step 05 (Scheduler) depends on Step 04 (schedules the processor).

Step 06 (Dashboard UI) depends on Step 05 (consumes the audit data
produced by the scheduled processor).

Universality decisions:
- REUSES: APP_PREFIX helper _prefixed() from
  knowledge/universals/tools.md (no new params)
- REUSES: DeepSeek client wrapper from knowledge/universals/engines.md
  (param: model="deepseek-chat")
- CREATES NEW: ProducerAuditCard component, registered in Step 06 to
  knowledge/universals/components.md with adaptation params: status,
  flag_reason, drill_url
- SHARED ACROSS SERIES: producers_audit table schema created in Step 01,
  consumed by Steps 02-06; PII masking function created in Step 03,
  consumed by Steps 04-05

## 4. Per-step plan

01. Schema + base API methods — producers_audit, producer_runs tables;
    GET /audit/producers, POST /audit/producers/{id}/decision endpoints.
    Depends on: nothing. Produces: schema, endpoints.
    Status: ✅ done 2026-04-05

02. DaData client integration + caching — DaData lookups for producer
    INN/OGRN, SHA256 cache key, no TTL.
    Depends on: 01. Produces: DaData client module.
    Status: ✅ done 2026-04-08

03. PII masking v2 — placeholder substitution for producer-data before
    DeepSeek call, reverse substitution on response.
    Depends on: 01. Produces: PII masking module.
    Status: ✅ done 2026-04-12

04. Producer Processor — classifier using DeepSeek, applies PII masking,
    uses DaData lookups, writes decision to producers_audit.
    Depends on: 02 + 03. Produces: producer_processor.py.
    Status: ⏳ pending

05. Scheduler — APScheduler job runs Producer Processor on configured
    interval; respects batch size and cycle gap invariants.
    Depends on: 04. Produces: scheduler.py extension.
    Status: ⏳ pending

06. Dashboard UI — Producers card on admin dashboard, drill-down view,
    decision history.
    Depends on: 05. Produces: ProducerAuditCard component + admin route.
    Status: ⏳ pending

## 5. Definition of Done

Series-level real-path scenario:
- Trigger: moderator opens https://[domain]/admin/x7k9p2/
- Input: at least 10 producers processed by the scheduled audit in the
  previous 24 hours, at least 2 flagged for review
- Expected: Producers card shows "Producers: 142 checked today, 12
  flagged for review"; clicking flagged opens drill-down with AI
  decision and reasoning per producer
- Verify at: admin dashboard URL above

Knowledge updates at series close:
- ТЗ productcenter-moderator: Producer Audit section → ✅ ЗАВЕРШЁН
- decisions.md: ADR for the audit flow architecture
- knowledge/universals/components.md: ProducerAuditCard entry
- INDEX.md: updated dates for all touched knowledge files

Charter close-out: this file moves to
knowledge/series-charters/completed/2026-04-01-producer-audit.md after
Step 06 completes and the series-level real-path scenario is verified.
```

This Charter is approximately one page when rendered. It would have prevented the late-series surprise that Step 04 needed both DaData and PII masking by making the dependency explicit upfront, and would have prevented re-discovery of the APP_PREFIX helper by listing it as a reuse in Section 3.

---

## 8. Quick Reference

| Charter section | Contains | Hard rule |
|---|---|---|
| **1. Product frame** | Goal in stakeholder language, named stakeholder, product-DoD | Always starts with product, not technical decomposition |
| **2. Invariants** | Series-specific rules (architectural, UX, tonal, domain) | Not a duplication of CLAUDE.md rules — series-scope only |
| **3. Dependency map** | What depends on what; parallelizable vs sequential; universality decisions (reuse / create / share-across-series) | Universality decisions explicit per `universality-discipline` |
| **4. Per-step plan** | Numbered list of prompts, each with title, description, dependencies, status | ≥3 steps (else not a series); ≤15 (else split) |
| **5. Definition of Done** | Series-level real-path scenario + knowledge updates at close + Charter close-out | Series-level scenario, not per-prompt |

| Don't | Do |
|---|---|
| Skip Charter "because only 3 prompts" | Write Charter — 3 is the lower bound, not a threshold for exclusion |
| Start Charter with technical decomposition | Start with Product frame (Section 1) |
| Bloat Charter to a full project spec | Keep to series scope; ТЗ stays upstream |
| Cite Charter without listing relevant invariants | Cite + list applicable invariants for this prompt |
| Skip Charter update after a prompt commit | Update Section 4 status + add discovered dependencies/invariants in the same commit |
| Re-invent a universal in prompt N+M that prompt N created | Record universality decisions in Section 3 once for the series |
| Fuse the series into one big prompt | Keep prompts atomic; fusion happens in the Charter, not the prompt body |
| Treat obsolete Charter as still valid | Update when intent shifts, or close the series and start a new one |
