---
name: skill-writing-standard
description: Standard workflow and template for creating new skills and updating existing ones in Vasily's skill system. Use this skill whenever creating a new skill from scratch, restructuring an existing skill, splitting a large skill, merging overlapping skills, deprecating a skill that has become stale, or making non-trivial edits to any skill in the system. Also use when reviewing a draft skill for quality, triggering accuracy, cross-reference correctness, or anti-pattern violations. This skill is mandatory before publishing any new skill — not optional. Do NOT use for one-off prompt edits, single-line corrections to skill files, or general writing tasks unrelated to skills.
---

# Skill Writing Standard
<!--
  @file:        skills/skill-writing-standard/SKILL.md
  @description: Standard workflow and template for creating skills in Vasily's system
  @version:     1.3
  @updated:     2026-04-30
-->

---

## 1. Philosophy

**A skill is your accumulated experience in a form the model applies automatically.**

A skill is not documentation. Documentation describes what *exists*; a skill prescribes what *happens*. When the trigger fires, the skill takes over and the model behaves according to its rules — even when you didn't think to ask. That is the point.

This skill exists because Vasily's system already has four skills (`prompt-writing-standard`, `knowledge-structure`, `code-markup-standard`, `bug-hunting`), and without a unifying standard, future skills will drift in style, contradict each other, or fail to trigger when needed. The cost of inconsistency compounds with every new skill.

**Two principles override everything else in this skill:**

1. **Self-directing questions over rigid rules** — wherever a judgment call is involved, prefer questions the model asks itself over prescriptions it must obey. Rules are for invariant boundaries; questions are for context-dependent decisions.
2. **Honesty over completeness** — if the AI model / orchestrator adds a section, rule, or paragraph that Vasily did not ask for, the AI model / orchestrator says so explicitly and proposes to keep, modify, or remove. Never sneak in additions.

---

## 2. When to Create a New Skill

Before creating, answer these questions honestly. If the answer to any of (1)–(4) is "no" or "not sure" — do not create the skill yet.

- **Is this a recurring task?** A one-off problem solved once does not deserve a skill. Wait for it to repeat at least 3 times. The third occurrence is when patterns become visible; the first two are anecdotes.
- **Does an existing skill already cover this?** Check the system's skill list. If yes — extend the existing skill, do not create a new one. Anti-Duplication applies to skills the same way it applies to knowledge files (`knowledge-structure` Section 11).
- **Is this workflow encoding or capability uplift?**
  - *Workflow encoding* — captures Vasily's processes, rules, conventions. Does not become obsolete as the model improves. All four existing skills are workflow encoding.
  - *Capability uplift* — teaches the model something it currently struggles with (e.g. specific design taste, niche file format). Has a natural retirement date — eventually the model improves and the skill becomes training wheels. Subject to mandatory periodic review (Section 19).
  - Both are valid, but the type changes how to write the skill. Workflow encoding is most of what this standard targets.
- **Can the activation triggers be described in one paragraph?** If not, the task is too vague to be a skill — it's a domain, not a procedure. Either narrow it down or split into multiple skills.
- **Is this skill for the AI model / orchestrator, for the Code Agent, or for both?** Different surfaces have different conventions. Vasily's existing skills mostly target the AI model / orchestrator (with prompts produced for the Code Agent). Be explicit about the surface.

---

## 3. Workflow Architecture — Three Layers

Skills in Vasily's system are created through chat conversation, not through test-driven iteration with subagents. The Anthropic skill-creator's evaluation pipeline (subagents, eval JSONs, browser-based reviewers) is not the model used here.

| Layer | Role | What they do |
|---|---|---|
| **Vasily** (decision layer) | Manager / visionary | Articulates the problem the skill should solve, approves structure, validates the result on real tasks |
| **AI model / orchestrator** (reasoning layer) | Senior partner | Researches best practices, drafts the skill iteratively, runs multi-perspective review, maintains honesty about additions |
| **Filesystem** | Storage | The skill folder containing `SKILL.md` and optionally `references/`, `scripts/`, `assets/` |

### Autonomy principle

Same as in `bug-hunting` Section 1.5: the AI model / orchestrator works as autonomously as possible. For skill creation specifically:
- Read existing skills via file MCP to check for overlap, find patterns to reuse, ensure cross-references stay valid
- Use `web_search` to research current best practices (Anthropic skill-creator docs, official guide, public examples)
- Use `conversation_search` to find prior discussions of the same problem with Vasily

Vasily is involved at decision points: approving the brief, accepting the multi-perspective review, validating the final draft.

---

## 4. Languages of Artifacts

Same model as `bug-hunting` Section 1.5, adapted for skill creation:

| Artifact | Language | Reason |
|---|---|---|
| Brief (Phase 1), research summary, multi-perspective review reports, conversational responses to Vasily, disclosure of additions | Russian | Vasily's working language; these are read in chat |
| `SKILL.md` body, YAML frontmatter, file header, RULE comments inside the skill, descriptions, anti-pattern lists | English | Repository artifacts stay in English (per `prompt-writing-standard` Section 4 «Language») |
| Examples and templates inside SKILL.md | English by default; localized only when the skill is *about* Russian-language content (e.g. a Russian copywriting skill) | Match the language of the domain the skill targets |

When in doubt — repository artifacts in English, communication artifacts in Russian.

---

## 5. Filesystem Conventions

**Platform-specific path used in the current skill runtime:** `/mnt/skills/user/<skill-name>/SKILL.md`

This is where new skills are saved by default in that runtime. Other locations exist:
- `/mnt/skills/public/` — Anthropic-provided skills (read-only, do not modify)
- `/mnt/skills/private/` — private skills (rarely used in this workflow)
- `/mnt/skills/examples/` — example skills (reference material)

**Skill folder structure:**
```
<skill-name>/
├── SKILL.md          (required — main file)
├── references/       (optional — long reference material per Section 17)
│   └── *.md
├── scripts/          (optional — executable helpers, currently unused in our skills)
└── assets/           (optional — templates, fixtures)
```

**Skill name conventions:**
- Lowercase letters, numbers, hyphens only (Anthropic format requirement)
- Reflects the activity (gerund or `<noun>-standard` pattern)
- Consistent with existing skills: `prompt-writing-standard`, `knowledge-structure`, `code-markup-standard`, `bug-hunting`

When Vasily saves a finalized skill in this runtime — confirm the path matches `/mnt/skills/user/<skill-name>/SKILL.md` so future sessions discover it correctly. In other runtimes, use the equivalent canonical skill path.

### Delivering skills to Vasily — `.skill` package

Direct writes to `/mnt/skills/user/...` from a chat session are **local to the session container**. The changes are visible inside that session, but other sessions (and Vasily's real skill storage) stay on the old version. This has caused confusion before: one chat "updated" a skill, a parallel chat continued reading the old version, and the mismatch was only caught later.

The working delivery method for the current Anthropic-style skill runtime — confirmed to trigger the "Save" button in Vasily's interface — is a `.skill` package file:

```bash
cd /mnt/skills/examples/skill-creator
python -m scripts.package_skill /path/to/skill-folder /mnt/user-data/outputs
```

The script validates the skill and produces a `<skill-name>.skill` file (a zip archive) in the output directory. When presented to Vasily via `present_files`, his interface recognizes the `.skill` extension and offers an install action — this is what actually updates the skill system-wide.

**Procedure when updating a skill:**
1. Prepare the edited `SKILL.md` in a temporary folder matching the skill name (e.g. `/home/claude/packaging/<skill-name>/SKILL.md`).
2. Run `package_skill` against that folder. It validates and produces a `.skill` file in `/mnt/user-data/outputs/`.
3. Present the `.skill` file via `present_files`.
4. Vasily clicks Save in the interface — the skill updates in his real storage.

**Do not rely on direct `cp` writes to `/mnt/skills/user/...`** as the delivery mechanism. They are fine as scratch work inside a session but do not propagate. The `.skill` package is the only verified channel.

**Verification in a new session:** after Vasily saves, the next session should show the new `@version` and `@updated` values. If it still shows the old version, the save did not propagate — re-deliver the `.skill`.

---

## 6. Creation Workflow — Six Phases

Each phase has a clear output that must exist before the next phase begins.

### Phase 1 — Discovery

A conversation with Vasily that produces a brief in Russian. The format adapts the prompt brief from `prompt-writing-standard` Section 2 Step 8a, with addition of the «Тип» field for skill type:

```
### Бриф нового скилла

1. **Цель:** [одно предложение — какую проблему скилл решает]
2. **Триггеры:** [список наблюдаемых сигналов, при которых скилл должен активироваться]
3. **Что входит:** [scope — какие задачи покрывает]
4. **Что НЕ входит:** [explicit exclusions — что НЕ должно вызывать триггер]
5. **Связи с другими скиллами:** [какие существующие скиллы пересекаются и как граница проводится]
6. **Тип:** [workflow encoding / capability uplift]
7. **Критерий успеха:** [как Василий поймёт, что скилл работает]
```

Vasily approves the brief. No drafting before approval.

### Phase 2 — Research

The AI model / orchestrator researches autonomously:
- Read existing skills in the system to identify reusable patterns
- `web_search` for current Anthropic recommendations and public examples in the same category
- `conversation_search` for prior discussions of related topics with Vasily
- Identify which best practices to import, which to adapt, which to skip

Output: a short research summary in Russian — what was found, what will be applied, what was deliberately rejected and why.

### Phase 3 — Drafting

The AI model / orchestrator writes the first version using the mandatory structure (Section 7). The draft includes:
- All mandatory sections (philosophy through quick reference)
- A description that meets Section 9 requirements (triggering accuracy)
- File header per `code-markup-standard` Section 11
- Cross-references to other skills where applicable

The draft is not shown to Vasily yet — it goes through Phase 4 first.

### Phase 4 — Multi-perspective Review

Three mandatory perspectives, same model as `prompt-writing-standard` Section 2 Step 9:

| Perspective | Role | What to check |
|---|---|---|
| **Stakeholder** | Vasily — **simulated by the AI model / orchestrator** (see below) | Will Vasily actually use this? Is it written in his idiom? Does it solve the brief from Phase 1? Does it fit his workflow (chat-based discussion, MCP autonomy, manager role)? |
| **Technical** | Senior AI model / skill engineer | Description triggers correctly (not too vague, not too narrow)? Cross-references correct and specific (section numbers, not just file names)? Size within 500-line guideline? File header present? Anti-patterns absent? |
| **Domain expert** | Depends on skill topic | A skill about debugging needs a senior debugger's review; a skill about content needs an editor; a skill about knowledge structure needs an archivist/librarian |

**Stakeholder simulation rule.** Phase 4 happens before Vasily sees the draft. The Stakeholder perspective is therefore **simulated by the AI model / orchestrator on Vasily's behalf**, drawing on the Phase 1 brief, Memory of Vasily's preferences, and conversation history. The simulated review is not a substitute for Vasily's own validation — it catches obvious misalignments early so Vasily's actual review in Phase 6 starts from a cleaner draft. The AI model / orchestrator must explicitly flag anything where the simulation feels uncertain ("I'm guessing Vasily would object to X — please confirm in Phase 6").

**Mandatory question for every reviewer:**

> "Check the skill for omissions, logical errors, and possible contradictions within your area of responsibility."

(Same wording as `prompt-writing-standard` Section 2 Step 9, deliberately preserved.)

**Mandatory scope integrity check** (answered by Technical reviewer, explicitly, in addition to the question above):

> «Уверен ли ты, что в этой редактуре не изменилось ничего за пределами явно согласованного скоупа? Пройди по черновику и сверь с исходной версией скилла секция за секцией. Любая формулировка, текст примера, строгость правила или нумерация, которые отличаются от исходника и не входили в согласованный скоуп, — это ошибка ❌, а не замечание ⚠️. «Я только уточнил» и «так читается лучше» — не оправдания. Правило — §14, Content Preservation.»

This check is mandatory for every skill edit, including edits to this skill itself. It is the primary defense against the broken-telephone drift described in Section 14.

Each reviewer answers in the format:
```
#### Проверка: [Role Name]
- ✅ [что хорошо]
- ⚠️ [замечание] (если есть)
- ❌ [ошибка] (если есть)
```

### Phase 5 — Iteration

All ❌ errors and ⚠️ warnings from Phase 4 are addressed before Vasily sees the draft. Same rule as `prompt-writing-standard` Section 2 Step 10: errors and warnings are fixed in place, not deferred.

When fixing, the Content Preservation Rule (Section 14) applies — do not lose meaning while shortening.

If the AI model / orchestrator added anything during drafting that was not in the Phase 1 brief — disclose explicitly. See Section 15 (Honesty about additions).

### Phase 6 — Finalization

The skill is presented to Vasily with:
- Final draft of `SKILL.md`
- Summary of what was added beyond the brief (if anything) with rationale
- Summary of what was found in research and applied
- Suggested location in the skills folder (per Section 5)

Vasily performs **Trigger Validation** (Section 12) on the draft and validates that simulated Stakeholder review matched his actual reaction. Any gaps — fix in this phase, do not save until aligned.

After Vasily approves and saves — versioning entry in the file header is set to `1.0`. Future edits follow the versioning policy (Section 16).

---

## 7. Mandatory SKILL.md Structure

Every skill in Vasily's system has these elements in this order. Sections may be merged or split, but the listed concepts must all be present.

### Required elements

1. **YAML frontmatter** — `name` and `description`. See Section 9 for description rules.
2. **File header** — comment block per `code-markup-standard` Section 11, with `@file`, `@description`, `@version`, `@updated`.
3. **Section 1: Philosophy** — the skill's worldview in one or two paragraphs. This is the "spirit" — when in doubt about a rule, the philosophy decides.
4. **Section 2: Activation Triggers** — observable signals, not subjective judgments. See Section 10.
5. **Workflow Architecture (where relevant)** — three-layer model (Vasily / AI model / Code Agent or Filesystem) when the skill involves coordination between Vasily, AI model / orchestrator, Code Agent, or external systems. Skip if the skill is purely a reasoning/format standard with no actor coordination. Pattern from `bug-hunting` Section 1.5.
6. **Core sections (process / rules / phases)** — the actual content of the skill.
7. **Anti-patterns** — explicit list of what is forbidden, with brief rationale for each. Pattern from `bug-hunting` Section 7.
8. **Connections to Other Skills** — cross-references to related skills with specific section numbers. See Section 17.
9. **Quick Reference** — a table at the end summarizing the skill for fast recall. Pattern from `bug-hunting` Section 9.

### Optional elements

- **Examples** — concrete cases illustrating the rules. Anthropic's official guide recommends including reasoning chains, not just outputs, so the AI model has a model of how to think through the skill's domain.
- **Templates** — when the skill produces structured outputs (briefs, reports, formats).
- **References folder** — for content that does not fit in the main file (Section 18).

---

## 8. Self-Directing Questions Over Rigid Rules — When Each Applies

This is the most important design choice in the skill. It governs how every section is written.

**Use rigid rules for:**
- Invariant safety boundaries (`@rule` comments, never expose secrets)
- Format requirements (YAML frontmatter is mandatory, file headers are mandatory)
- Hard technical limits (200 lines per knowledge file, copyright limits)
- Things that are wrong in all contexts (no commented-out dead code)

**Use self-directing questions for:**
- Judgments that depend on context (when to split INDEX, when to apply Lightweight Mode in bug-hunting)
- Choices between equally valid approaches (which thematic split to use, which mitigation to apply)
- Boundaries that have to be assessed case by case (when a knowledge file has "outgrown" its scope)
- Anything where over-prescription would be brittle

**The test:** if you find yourself writing "always do X" or "never do Y" for something that has reasonable exceptions — convert to a question. If the rule has no real exceptions — keep it as a rule. The mistake to avoid is writing a brittle rule that the model will work around or violate; a good question forces the model to think.

**Why this matters specifically for the AI model:** an over-prescribed skill becomes a ritual the model performs without engagement. A skill built around questions makes the model reason about each application. The latter produces consistently better results because the model adapts to the specific situation rather than blindly executing.

---

## 9. The Description Field — Critical for Triggering

This is the single most undervalued part of a skill. The description is the only thing the model sees when deciding whether to load the skill. A perfect skill body is wasted if the description doesn't trigger when needed.

### Known problem

The AI model **under-triggers skills by default** — it errs toward not loading even when the skill is relevant. Anthropic's official guidance: descriptions should be slightly aggressive, explicitly listing synonyms and edge cases.

### Requirements

- **Length:** 100–200 words, up to 1024 characters maximum.
- **Person:** always third person ("Use this skill whenever...", not "I help with..."). The description is injected into the system prompt and inconsistent point-of-view confuses the trigger logic.
- **Structure:** one sentence describing what the skill does, then explicit trigger conditions, then explicit exclusions.
- **Trigger keywords:** include synonyms and natural phrasings Vasily actually uses, not just formal terminology. If Vasily says "ищу баг" — the description should match that pattern, not only "looking for a bug".
- **Mandatory phrasing for important skills:** "This skill is mandatory in these situations — not optional." Anthropic's research shows this phrase materially improves trigger reliability for high-importance skills.
- **Negative triggers:** if a skill is at risk of over-triggering on related-but-different tasks, add explicit "Do NOT use for X" exclusions.

### Template

```
[What the skill does — one sentence]. Use this skill whenever [trigger 1], [trigger 2], [trigger 3], or [synonym variations]. This skill is mandatory in these situations — not optional. Do NOT use for [exclusion 1] or [exclusion 2].
```

### Anti-patterns in descriptions

- **Too vague:** "Helps with projects" — never triggers.
- **Too narrow:** "Generates Kyverno NetworkPolicy YAML for namespace finance" — only triggers in one exact case.
- **First person:** "I help with debugging" — confuses trigger logic.
- **Generic verbs only:** "manages", "handles", "supports" — not trigger keywords.
- **No exclusions on broad-scope skills:** invites over-triggering.

### Iteration over time

Description is never final after v1.0. After deploying a skill, observe whether it actually triggers in real situations. If under-triggering or over-triggering is observed — revise the description and re-validate (Section 12). Description optimization is a continuous loop, not a one-time activity.

---

## 10. Activation Triggers — Observable Signals Only

A trigger that the model cannot observe will not fire. This eliminates entire categories of failed triggers.

**Bad triggers (model cannot observe):**
- "When more than 30 minutes have passed" — model has no clock
- "When Vasily is frustrated" — model can't measure mood directly
- "When the bug is complex" — subjective without an operational definition

**Good triggers (model can observe):**
- "When Vasily writes 'долго ищу' or 'не могу найти'" — text patterns
- "When 5+ messages in the chat are about the same topic without resolution" — countable
- "When a fix prompt fails twice on the same problem" — stateful but observable
- "When a previously-resolved issue recurs in the same chat" — observable from history

(Examples above are illustrative — they happen to come from `bug-hunting`, but the principle of observable signals applies to triggers in any skill.)

**Pattern from `bug-hunting`:** name each trigger with a number and a short title. State the observable signal. State what the model does when the trigger fires (usually: switch to skill mode and inform Vasily explicitly with a phrase like "Перехожу в режим X по триггеру Y").

---

## 11. Tooling and Frontmatter Options

Anthropic's skill format supports several frontmatter fields beyond `name` and `description`. None of Vasily's current skills use them, but future skills may benefit.

| Field | Effect | When to use |
|---|---|---|
| `disable-model-invocation: true` | Skill can only be invoked manually (`/skill-name`), the AI model won't auto-trigger | For skills that perform actions with consequences (deploy, rollback, payment operations) where unintended invocation is unsafe |
| `context: fork` | Skill runs in a forked subagent context, results returned to main conversation | For research-heavy skills that pollute context if run inline |
| `agent: Explore` (or other built-in / custom agent) | Skill spawns a specific subagent configuration | When the skill needs read-only exploration or specialized tools |
| `allowed-tools: [...]` | Grants tool access without per-use approval when skill is active | When the skill genuinely requires specific tools to function |
| `compatibility: <runtime>` | Marks the skill as runtime-specific (Code Agent runtimes, Claude.ai, Codex, etc.) | When the skill uses platform-specific features |

**Default for Vasily's skills:** none of these — model can auto-invoke, runs inline, no special agents, standard tool permissions. Add fields only when the skill genuinely requires them, and document the choice in the skill's Philosophy section.

---

## 12. Trigger Validation — Before Release

A skill that doesn't trigger when needed is worse than no skill — it gives false confidence the workflow is covered. Trigger validation must happen in Phase 6 (Finalization) before a skill is saved.

### Procedure

1. **Generate test queries.** The AI model / orchestrator generates 6–10 queries:
   - Half should trigger the skill (positive cases)
   - Half should NOT trigger the skill (negative cases — **near-misses**, not obviously unrelated tasks)
   - Negative cases must share keywords or topic with positive cases — otherwise the test proves nothing
2. **Run the test.** For each query, in a fresh conversation context, ask the AI model: "Given this query: [Q]. Would you load skill `<skill-name>`? Cite the description text that supports your decision."
3. **Score results.**
   - Positive cases that trigger: count correct
   - Negative cases that don't trigger: count correct
   - Triggering accuracy = (correct positive + correct negative) / total
4. **Threshold:** if accuracy < 80% — the description needs revision. Common fixes:
   - Under-triggering on positives → add synonym keywords, more explicit trigger phrases
   - Over-triggering on negatives → add explicit "Do NOT use for X" exclusions
5. **Iterate.** Revise description, re-run validation. Repeat until accuracy ≥ 80% on the test set.

### Where to run

This is a chat-based validation, not subagent-based (Vasily's current workflow doesn't use subagents). Vasily and the AI model / orchestrator run it together in Phase 6.

### Honest limitation

A test set of 6–10 queries is not statistical proof of triggering quality at scale. It is a sanity check that catches obvious failures. Real-world triggering accuracy emerges over time and informs description iteration (Section 9 «Iteration over time»).

---

## 13. Test on Real Task Before Closure

A skill that looks correct in theory can fail on first real application. Phase 6 closure requires at least one successful application to a real task.

### Closure criterion

After Vasily approves the draft and saves the file, the skill is in **provisional v1.0** state. It becomes **confirmed v1.0** after:

1. The skill triggers correctly on a real task (not a synthetic test query)
2. The skill's workflow runs to completion on that task
3. Vasily confirms the result is what he expected

If the first real application reveals problems — fix them as a v1.0.1 patch (or v1.1 if structural) before the skill is considered confirmed.

This rule prevents the «looks good in chat, breaks on real task» failure mode that's especially common for capability uplift skills.

---

## 14. Content Preservation — Absolute Rule

This rule is the same rule as `knowledge-structure` Section 9, applied to skill files. The principle comes from there; this section only restates the consequences for skills. If the two ever drift apart, `knowledge-structure` Section 9 is authoritative.

**Absolute principle.** No existing wording in a skill outside the explicitly agreed change scope is edited — not "for clarity", not "for consistency", not "while I'm here". The agreed scope may cover several places in the skill, but each must be named explicitly before the edit begins. If during the work it becomes visible that another section or paragraph needs changing too — stop and get agreement from Vasily, do not silently modify it.

"The meaning is preserved" is not a valid justification. The rule applies to the act of editing, not to the editor's judgment about whether a specific change "mattered". Over 3–5 edits of "harmless" rewording the skill becomes a different skill — the broken telephone effect this rule exists to prevent.

**Why there is no list of "allowed editing techniques":** any such list becomes a loophole. Skills carry Vasily's accumulated process; a rule softened from "must" to "should", a concrete example replaced with an abstract description, a hedge removed because it "read awkwardly" — each edit looks defensible in isolation, but the skill drifts. The safe rule is: outside the agreed scope, wording stays.

**Practical consequence when editing a skill.** Identify the exact scope of what must change, change only that, leave every other section untouched. Do not "improve" an adjacent paragraph. Do not renumber sections if renumbering was not agreed. Do not "clean up" phrasing that looks rough — rough phrasing may be load-bearing.

**Agreed scope can be multi-point.** The rule does not forbid changing several sections at once — it forbids changing sections that were not agreed. If the agreement says "update Section 14 and Phase 4", both are in scope. If it says "update Section 14", Phase 4 is out of scope even if it looks related.

**This skill self-applies.** Any edit to this skill itself — including this section — must follow this rule. An edit to Section 14 does not license a "harmonization pass" through Sections 9, 13, or 22.

---

## 15. Honesty About Additions

If the AI model / orchestrator, during drafting or editing a skill, adds content that Vasily did not explicitly ask for — the AI model / orchestrator must disclose this before presenting the result.

**What counts as an addition:**
- A new section beyond what the brief specified
- A new rule beyond what was discussed
- A new exclusion or exception not mentioned by Vasily
- An "obvious" extension that seemed reasonable but was not requested

**Format and location of disclosure:**

After presenting the skill draft, the AI model / orchestrator posts a separate message in the chat (not as a comment inside `SKILL.md` — that pollutes the file) titled "Самовольные добавления", listing:
- What was added
- Why the AI model / orchestrator thought it was needed
- A clear question: keep, modify, or remove?

Vasily decides. The default is **remove unless explicitly approved**, not "keep unless explicitly removed."

This rule exists because skills are persistent — they will run for months on every relevant trigger. An unauthorized rule in a skill propagates silently into every session. Catching it at creation time is far cheaper than discovering it months later.

---

## 16. Versioning Policy

Skills evolve. Use semantic versioning in the file header (`@version` field).

| Version change | When to apply | Examples from existing skills |
|---|---|---|
| **Major (X.0)** | Structural rework, philosophy change, breaking compatibility with prior usage | `prompt-writing-standard` v2.0 → v3.0 (added Steps 8a/9/10) |
| **Minor (X.Y)** | New section, new functionality, expanded rules — backward compatible | `knowledge-structure` v1.0 → v1.1 (added 3 new sections) |
| **Patch (X.Y.Z)** | Targeted fix, clarification, error correction, small additions | `code-markup-standard` v1.0 → v1.0.1 (corrected wording) |

Always update both `@version` and `@updated` together. Date format: `YYYY-MM-DD`.

For major version bumps, include a brief note in the file header comment block explaining what changed. For minor and patch — no changelog needed in the file (git history serves).

---

## 17. Cross-References Between Skills

Skills in Vasily's system reference each other extensively. Done well, this prevents duplication and keeps each rule with one source of truth. Done badly, it creates broken links and confused authority.

### Rules

- **Reference by file name and specific section number.** "See `code-markup-standard` Section 8" — not "see code-markup-standard". For workflow steps inside sections, specify the full path: "see `prompt-writing-standard` Section 2, Step 9".
- **Do not duplicate content from another skill.** If a rule lives in skill A, skill B that needs it points at A. Pattern: rules hierarchy from `code-markup-standard` Section 9.
- **One source of truth per rule.** If the same rule appears in two skills, one of them is wrong — pick the more relevant home and remove from the other.
- **Update references when a skill changes.** If `knowledge-structure` Section 7 becomes Section 8 after a renumbering, all skills referencing the old number must be updated. This is part of the renumbering work, not an afterthought.
- **Avoid circular dependencies.** If skill A says "see B" and B says "see A" — restructure. One should be primary, the other should reference.

### Discovery

When creating a new skill, check existing ones for overlap by reading their philosophy and activation triggers. If the new skill's purpose overlaps significantly with an existing one — extend the existing skill instead of creating a new one (anti-duplication, same as `knowledge-structure` Section 11 for knowledge files).

---

## 18. Size and Progressive Disclosure

Anthropic recommends `SKILL.md` body under 500 lines for optimal performance. This is a guideline, not a hard limit — exceeding by 5–20% for substance is acceptable; exceeding by 50% means restructuring is needed.

### When approaching the limit

Ask the questions:
- Is anything in this skill *reference material* (long tables, language-specific variants, format specifications) that's only needed in specific situations?
- Is the main flow still readable in one pass?
- Would a future AI model / orchestrator (or Vasily after 3 months) easily find the right section?

If yes to "reference material exists" — consider moving to `references/` folder.

### What to move to `references/`

- Long technical tables (language-specific syntax, API endpoint maps)
- Format specifications (templates, schemas)
- Domain-specific deep dives (how X works in detail)
- Historical context that's useful but not actively needed

### What NOT to move

- Philosophy
- Activation triggers
- Main workflow / phases
- Anti-patterns
- Cross-references
- Quick reference

These must stay in the main `SKILL.md` because they're needed every time the skill triggers.

### Discussion before splitting

Before moving anything to `references/`, discuss with Vasily. This is a structural change — silent moves are forbidden by Section 15 (Honesty about additions, applied to structure too).

---

## 19. Splitting and Merging Skills

Skills evolve. Sometimes a skill grows beyond its original scope (split candidate); sometimes two skills creep toward each other (merge candidate). Both operations are structural changes, requiring Vasily's explicit approval.

### When to split a skill

Self-directing questions:
- Has the skill's scope quietly expanded? (Triggers now cover more than one clear topic, philosophy section feels like two ideas glued together)
- Has the file stably exceeded 600 lines after multiple iterations, with no path back below 500?
- Are there two clusters of rules that rarely interact — i.e. when applying the skill, you typically use one cluster *or* the other, not both?
- Would two narrower descriptions trigger more accurately than one broad description?

If yes to two or more — propose a split.

### When to merge skills

Self-directing questions:
- Do two skills frequently trigger together on the same kinds of tasks?
- Do their descriptions overlap by more than ~30% in keywords or scope?
- Does one skill's rules section frequently cite the other skill?
- Would a single skill with a clear unified philosophy be cleaner than two with a fuzzy boundary?

If yes to two or more — propose a merge.

### Splitting procedure

1. **Identify boundaries.** What are the two (or more) cohesive clusters? Where does each cluster's responsibility end?
2. **Draft new descriptions.** Each new skill needs its own description meeting Section 9 requirements. Test that the new descriptions cover the original's scope without overlap.
3. **Move content with Content Preservation (Section 14).** Verbatim moves are preferred over paraphrasing. Sections may be renumbered but wording stays.
4. **Update all cross-references.** Other skills referencing the original must point at the correct successor — the work must complete in the same session, not "later".
5. **Deprecate the original.** Mark the original `SKILL.md` with a deprecation notice in the file header (`@deprecated: see <successor-skill-1>, <successor-skill-2>`) for 2–4 weeks before deletion. Do not delete immediately — gives time to catch missed cross-references.
6. **Trigger Validation (Section 12) for each new skill.** Required.

### Merging procedure

1. **Identify the unified philosophy.** What single idea covers both originals? If you can't articulate one — the merge is wrong, keep them separate.
2. **Write the merged description.** Must cover triggers from both originals. Validate per Section 12.
3. **Combine content with Content Preservation.** Both originals contribute verbatim sections; structure them under the unified philosophy.
4. **Update all cross-references.** Both originals' incoming references redirect to the merged skill.
5. **Deprecate both originals** with the deprecation notice pointing to the merged skill, same 2–4 week window.
6. **Trigger Validation** for the merged skill.

### Honesty principle still applies

Splitting or merging without Vasily's explicit approval is forbidden — even if the AI model / orchestrator is convinced it's the right move. Propose, get approval, execute.

---

## 20. Stale Skill Protocol

Skills can become stale in three ways:

1. **Capability uplift becomes redundant.** The model improves and now does the task well without the skill. The skill adds tokens and overhead without value.
2. **Workflow encoding diverges from reality.** Vasily's actual workflow has shifted, but the skill still encodes the old one. The skill misleads rather than helps.
3. **Cross-references break.** Other skills changed structure, sections renumbered, files moved — and this skill still points at outdated locations.

### Periodic review triggers

Review applicable skills at any of these triggers:

- **After a major model update** — capability uplift skills are particularly suspect; the model may have absorbed the capability into baseline behavior
- **After a significant pivot** in Vasily's projects or workflow
- **Quarterly** — calendar review of all skills, regardless of triggers
- **When a cross-reference breaks** — a referencing skill's structure changed, this skill now has dangling pointers

### Capability uplift staleness test

For capability uplift skills only:

1. Pick a task the skill was designed to improve
2. Run the task in a fresh conversation **with the skill loaded** — note quality
3. Run the same task in a fresh conversation **without the skill loaded** — note quality
4. Compare. If the without-skill version is within ~5% of with-skill quality, the skill is coasting on inertia
5. Check token overhead — does the skill load 200+ lines of context for marginal improvement?

If the skill fails the staleness test → deprecate (see below).

### Workflow encoding staleness check

Workflow encoding skills rarely become fully stale — they encode Vasily's processes, which change but don't usually disappear. Check:
- Do the activation triggers still match how Vasily actually works?
- Are the rules in the skill still applied in practice, or has the project moved on?
- Are the cross-references to other skills still accurate?

Update rather than deprecate is the usual outcome for workflow encoding.

### Three deprecation outcomes

1. **Update** — the skill is still useful but needs revision. New version (minor or major per Section 16). This is the most common outcome.
2. **Deprecate** — the skill is no longer needed. Mark with `@deprecated` header, keep file for 4–8 weeks for reference, then archive (move to `references/archived-skills/` or delete via Vasily's git workflow).
3. **Replace** — the skill should be rewritten from scratch with new philosophy. Treat as creation of a new skill (Sections 2–6), then deprecate the old.

### Honesty about deprecation

Deprecating a skill the AI model / orchestrator helped create is uncomfortable — there's a temptation to defend it. Resist. If the staleness test shows the skill no longer earns its place — say so plainly.

---

## 21. A/B Testing for Capability Uplift

Capability uplift skills require empirical evidence of value. Workflow encoding skills don't — they encode Vasily's process and value comes from consistency, not measurable output improvement. Apply this section only to capability uplift skills.

### When to run

- After initial creation (Phase 6 closure for capability uplift skills)
- During periodic review (Section 20)
- When considering deprecation

### Procedure

1. **Pick 3–5 representative tasks** the skill targets
2. **For each task, generate two outputs:**
   - With the skill loaded
   - Without the skill loaded
   - Use fresh conversation contexts each time to avoid carryover
3. **Compare on explicit criteria** (defined in advance, not after seeing outputs):
   - Did the agent complete the task?
   - How many turns did it take?
   - Token consumption
   - Quality on a checklist specific to the task type
   - Did the AI model reach for the skill at the right moments? (For default-trigger skills)
4. **Score the comparison.** If the skill version is meaningfully better (e.g. 15%+ improvement on quality checklist, or notably fewer turns) — keep. If marginal — flag for review.

### What "meaningfully better" means

Avoid false precision. A 2% improvement on a 5-task sample is noise. Look for clear patterns:
- Skill version completes tasks the no-skill version fails
- Skill version is consistently more focused, no-skill version wanders
- Skill version handles edge cases the no-skill version misses

If the difference is "I think the skill version is slightly better" — that's not enough to justify keeping a capability uplift skill in production.

### Honest limitation

A 3–5 task A/B test is a sanity check, not statistical proof. It catches obvious cases (skill clearly helps, skill clearly doesn't matter). For ambiguous cases, real-world usage over weeks is the only honest answer.

---

## 22. Anti-patterns — Explicitly Forbidden

The skill exists to prevent these. If the AI model / orchestrator catches itself doing any of them — stop, back up to the relevant phase.

1. **`README.md` inside the skill folder** — Anthropic explicitly recommends against. The `SKILL.md` IS the README. A separate README confuses tooling.
2. **First-person description** — "I help with..." breaks trigger logic. Always third person.
3. **Vague description** — "Helps with projects" never triggers.
4. **Overly narrow description** — fires only in one exact case, misses obvious variations.
5. **Duplicate or overlapping skills** — pick one home for each topic. If two skills compete for the same trigger, neither will fire reliably.
6. **Skill made of rigid rules with no questions** — model executes ritualistically without engagement.
7. **Creating a skill after the first occurrence of a problem** — premature; wait for 3+ recurrences to see real patterns.
8. **Ignoring the under-triggering tendency** — if the description is "polite" and minimal, the AI model will under-load it. Be slightly aggressive.
9. **Shortening that loses meaning** — violates Content Preservation (Section 14).
10. **Unauthorized additions** — violates Honesty (Section 15).
11. **Skill that contradicts another skill in the system** — conflicts must be resolved before publication, not deferred.
12. **Capability-uplift skill for something the model now does well** — outdated capability uplifts are noise; check whether the gap still exists before creating (Section 20 staleness test).
13. **Cross-references without section numbers** — "see prompt-writing-standard" is not enough; specify which section (and step, when applicable).
14. **Skipping the multi-perspective review** — Phase 4 is mandatory; without it, blind spots stay blind.
15. **Skipping Trigger Validation** — Section 12 is mandatory in Phase 6. A skill that doesn't trigger reliably is worse than no skill.
16. **Splitting or merging silently** — structural changes require explicit approval (Section 19).
17. **Defending a stale skill out of attachment** — periodic review (Section 20) is honest. If a capability uplift skill no longer earns its place, deprecate it.
18. **Closing without real-task validation** — Section 13 closure requires at least one real application succeeding.

---

## 23. Connections to Other Skills

- **`prompt-writing-standard`** — every change to a skill is delivered as a Code Agent prompt following that standard. Phase 6 (Finalization) of this workflow produces the prompt. Multi-perspective review pattern (`prompt-writing-standard` Section 2 Step 9) is the model for this skill's Phase 4.
- **`knowledge-structure`** — Content Preservation Rule (Section 9) and Anti-Duplication (Section 11) are imported in spirit. File header standard (Section 6) applies to `SKILL.md` files via `code-markup-standard` Section 11. Stale Skill Protocol (this skill's Section 20) parallels `knowledge-structure` Section 12 (Stale Information Protocol) — same logic, different artifact type.
- **`code-markup-standard`** — Section 11 specifies the header format used in every `SKILL.md`. Section 9 (Rules Hierarchy) is the model for cross-referencing between skills.
- **`bug-hunting`** — provides several patterns reused here: three-layer architecture (Section 1.5), observable triggers (Section 2), anti-patterns block (Section 7), quick reference table (Section 9). These patterns are not duplicated — bug-hunting is the example, this skill abstracts the patterns into a standard.

---

## 24. Self-Test — The Skill Applies to Itself

This skill describes how to write skills. Therefore it must itself follow its own rules.

**What "applies to itself" means concretely:**

- The skill's own `SKILL.md` must follow Section 7 (Mandatory Structure) — all required elements present
- The skill's description must meet Section 9 requirements — third person, length, triggers, exclusions
- The skill must pass its own Section 12 (Trigger Validation) test
- The skill must pass its own Section 22 (Anti-patterns) — none of the listed forbidden patterns appear in this file
- The skill must have gone through its own Phase 4 (Multi-perspective review)
- All cross-references in this file must be valid (correct section numbers in target skills)

**Periodic self-check:** at least when major version bumps to other skills in the system happen — re-check this skill against its own anti-patterns and against the latest cross-reference targets.

If this skill fails its own review, fix this skill first, then propagate the lesson to whichever skill prompted the failure.

---

## 25. Quick Reference — Creation Checklist

| Phase | Question to ask | Output |
|---|---|---|
| **Discovery** | What problem? Triggers? Scope? Boundaries? Type (workflow / uplift)? | Бриф нового скилла (Russian, approved by Vasily) |
| **Research** | What does Anthropic recommend? What patterns exist in our skills? Prior chats on this topic? | Research summary |
| **Drafting** | All mandatory sections present? Description meets Section 9? Path per Section 5? | First draft |
| **Multi-perspective review** | Stakeholder (simulated) + Technical + Domain expert each find omissions, logical errors, contradictions? | Three review reports with ✅ ⚠️ ❌ |
| **Iteration** | All ❌ and ⚠️ addressed? Content preservation respected? Additions disclosed? | Revised draft |
| **Finalization** | Trigger Validation (Section 12) passes? Real-task validation (Section 13) succeeds? Final draft + summary of additions + research notes presented to Vasily? | Approved skill, version 1.0 |

| Don't | Do |
|---|---|
| Vague description | Specific triggers + exclusions |
| First person | Third person |
| Rigid rules everywhere | Self-directing questions for judgment calls |
| Silent additions | Explicit disclosure (Section 15) |
| Shortening with meaning loss | Preserve substance, exceed limit slightly if needed |
| Cross-refs without section numbers | Specific section numbers (and step numbers when applicable) |
| Skip multi-perspective review | Always run it before Vasily sees the draft |
| Skip Trigger Validation | Run Section 12 in Phase 6 |
| Skip real-task validation | Section 13 — confirm v1.0 only after real use |
| Defend stale skills | Run Section 20 periodically, deprecate honestly |
| Split / merge silently | Section 19 — explicit approval required |
