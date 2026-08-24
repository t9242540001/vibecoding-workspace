---
name: knowledge-structure
description: Create, maintain, and update the living knowledge base for any project (CLAUDE.md + knowledge/ directory). Use this skill whenever creating a new project's knowledge files, migrating existing docs to the knowledge/ structure, deciding whether an artefact should live as a single file or a folder of records, adding a new ADR / bug / task / rule, updating knowledge files after completing a Claude Code prompt, running a wiki lint pass, or reviewing knowledge files at the end of a work session. This skill is mandatory in these situations — not optional. Do NOT use for one-off prose edits inside a single existing file or for general writing tasks unrelated to project knowledge structure.
---

# Knowledge Structure Standard
<!--
  @file:        skills/knowledge-structure/SKILL.md
  @description: Standard for creating and maintaining project living knowledge base
  @version:     2.3
  @updated:     2026-05-19
-->

---

## 1. Why This System Exists

Claude Code reads CLAUDE.md at every session start — but ignores content it deems
irrelevant to the current task. The more non-universal content in CLAUDE.md,
the higher the chance critical rules get ignored.

Solution: three-level progressive disclosure.

```
CLAUDE.md                       ← universal rules only, read every session
knowledge/INDEX.md              ← root registry of files and folders, read when needed
knowledge/<folder>/INDEX.md     ← local registry of records inside a folder
knowledge/*.md                  ← thematic files, read only when relevant to current task
```

This keeps context clean, rules visible, and details accessible without bloating
every session with irrelevant information.

The model is inspired in spirit by Andrej Karpathy's LLM Wiki pattern (April 2026):
the LLM maintains a persistent, interlinked knowledge layer that compounds over time
rather than re-deriving knowledge on every query. We adopt the parts that fit our
domain (one-record-per-file for list-of-records artefacts, a periodic lint pass,
filing valuable query results back into knowledge) and deliberately decline the
parts that don't (auto-injected Obsidian-style wikilinks, aggressive cascading
updates across many files on every change). See Section 11.5 (Cross-Linking) and
Section 16 (Wiki Lint Pass) for the concrete adaptations.

---

## 2. CLAUDE.md — Project Constitution

**Hard size limit: ≤80 lines.** Past this point Claude Code's compliance with rules in this file degrades — instructions get treated as advisory rather than mandatory. Keep CLAUDE.md ruthlessly compact.

**Contains exactly 6 elements, nothing more:**

1. Project name + one-line description of what it does and why
2. Stack (brief list: runtime, framework, DB, key services)
3. Critical rules — max 5, only those whose violation immediately breaks everything.
   Format: `RULE: [what] — [consequence]`
4. **Execution discipline block (Karpathy-style behavioral rules)** — universal behavioral standard for how Claude Code approaches every task in this project. This is not project-specific critical rules (those live in element 3) — it's a behavioral standard that applies the same way to every Karpathy-aware project. The 5 standard rules:
   - **Don't guess — ask.** If the task allows multiple valid implementations, stop and ask before coding.
   - **Senior-engineer simplicity filter.** Before finalizing implementation, ask: "Would a senior engineer call this overengineered?" If yes, simplify.
   - **Strict scope discipline.** Touch only what the task explicitly names. No "improvements" to adjacent code, no opportunistic refactors, no consistency fixes outside the stated scope.
   - **Goal over steps.** When the user describes the goal, find the right algorithm yourself. When the user prescribes steps and they don't reach the goal — flag the contradiction, don't blindly follow.
   - **Sustainable solutions.** Prefer fixes that prevent recurrence over fixes that just stop the symptom. If a quick fix and a durable fix differ — name both, recommend the durable one, let the user choose.
5. Deploy commands (exact, copy-pasteable)
6. Single pointer: `→ knowledge/INDEX.md`

The Execution discipline block does not count against the limit of 5 critical rules in element 3. Critical rules are project-specific facts whose violation breaks code; Execution discipline is a universal behavioral standard.

**What does NOT go in CLAUDE.md:**
- File navigators, API references, formula details
- Full DB schemas, environment variable lists
- Roadmaps, feature lists, known issues
- Anything that only matters for specific tasks

**Content preservation rule:**
When rewriting or updating CLAUDE.md — preserve the wording, spirit, and tone
of existing rules. Rephrase only to reduce length. Never change the meaning.

---

## 3. Two-Level Navigation — Root INDEX and Local INDEX

The knowledge base navigates in **two levels**:

**Root INDEX** — `knowledge/INDEX.md`. Lists every top-level artefact:
- Files at the top level (`infrastructure.md`, `architecture.md`, etc.) — listed individually with a one-line description.
- Folders at the top level (`decisions/`, `roadmap/`, etc.) — listed as folders with a one-line description and a pointer to their local INDEX.

**Local INDEX** — `knowledge/<folder>/INDEX.md`. Lists every record inside that folder. Each folder has its own local INDEX.

### Contract between levels

| Event | Updates root INDEX? | Updates local INDEX? |
|---|---|---|
| New top-level file added | Yes | — |
| New top-level folder added | Yes | Yes (create new local INDEX) |
| File or folder renamed at top level | Yes | — (if it's a file) / Yes inside (if it's a folder) |
| New record added inside a folder | **No** | Yes |
| Record renamed/superseded inside a folder | **No** | Yes |
| Record moved to `archive/` inside a folder | **No** | Yes |

**The root INDEX does not know how many records are inside each folder, and it must not try to list them.** That is the local INDEX's job. This separation is what makes the root INDEX stable: it changes only when the project's *structure* changes, not when records accumulate.

### Why this matters

Adding records is the most frequent knowledge operation — every ADR, every bug, every task. If every record-add touched the root INDEX, the root INDEX would churn constantly and grow indefinitely. By containing record-level changes inside their folder's local INDEX, the root stays compact and predictable.

A reader (human or Claude session) sees the root INDEX first, picks the right folder, then reads that folder's local INDEX. The cost of "find the right record" stays bounded by folder size, not by the size of the whole knowledge base.

### Format

**Root INDEX** — same format as the legacy single-INDEX, but folders appear as folders:

```markdown
| File / Folder | Description | Updated |
|------|-------------|----------|
| [infrastructure.md](infrastructure.md) | Server, PM2, deploy, nginx, … | 2026-05-17 |
| [decisions/](decisions/) | **Folder** — Architectural Decision Records. Local INDEX: `decisions/INDEX.md` | 2026-05-17 |
| [roadmap/](roadmap/) | **Folder** — open tasks, in-progress, recent activity. Local INDEX: `roadmap/INDEX.md` | 2026-05-17 |
| [universals/](universals/) | **Folder** — registry of reusable technical and design units. Local INDEX: `universals/INDEX.md` | 2026-05-19 |
```

**Local INDEX** — table of records inside the folder. Format depends on the folder's natural unit; see Section 5 for per-folder layouts.

---

## 4. Natural Unit — File or Folder?

The most important design decision for any knowledge artefact: **does the natural unit of this artefact match the file, or does it match a record inside the file?**

This is the rule that replaces the older "split when the file exceeds 200 lines". Splitting by size is reactive — by the time the file is 200 lines, the wrong dozens of records have already accreted in one place, cross-references are tangled, and the file is hard to read. The new rule is design-time: pick the right shape *before* writing.

### The two shapes

**Reference document** — one connected piece of text on a single topic. The reader reads it like a chapter: top to bottom, with H2 headers as navigation. Examples: infrastructure, architecture, calculator business logic, customs reference, a tech stack overview. These remain **single files**. Splitting them by sub-topic destroys the connection that makes them useful.

**List of records** — many discrete entries, each with its own ID, date, and self-contained meaning. The reader looks up a specific record by its ID or date. Examples: decisions (ADRs), bugs, tasks, rules. These live as **folders**, with one file per record.

### The question to ask

When introducing or refactoring a knowledge artefact: **"Do I think about this as a single subject area, or as a collection of records?"**

- "How is our infrastructure organized?" → single subject → file.
- "What did we decide about OAuth in April?" → look up one record → folder.
- "What bugs are open right now?" → enumerate records → folder.
- "How does the customs calculation work?" → single subject → file.

If the artefact is borderline, the deciding question is: **"Does each record have an ID, a date, and a stand-alone meaning?"** If yes → folder. If the records only make sense in the context of the surrounding text → file.

### Defer the decision honestly

If you're not sure which shape fits — keep it as a file for now. Reverse migration (file → folder) is mechanically possible later; the cost of reversing is much lower than the cost of designing the wrong shape and living with it for months. Premature folder-ification creates many small files that may not earn their separation.

---

## 5. Standard File Set

### Mandatory for every project

**infrastructure.md** *(file)*
Server details, OS, paths, repository URL and branches, process manager (PM2/systemd)
with exact process names and IDs, database connection and schema, deploy commands,
environment variable names (never values), monitoring setup, bot/app identity.

**architecture.md** *(file)*
File/directory structure, navigator table (task → file), component relationships,
key patterns and conventions used in this codebase, API endpoint map if applicable.

**rules/** *(folder)*
Every RULE entry from the codebase and project history. One file per rule.
Folder structure:
```
rules/
├── INDEX.md
├── R-CRON-1-cron-tsx-path.md
├── R-TG-CHANNEL-LOG-1-...md
└── archive/
    └── (superseded or deprecated rules)
```
File format per entry:
```markdown
# R-CRON-1 — Cron uses local tsx

**Status:** Active
**Date:** 2026-05-11
**File:** /etc/cron.d/jckauto-imports
**Consequence:** Global `npx tsx` resolves dotenv from its own global node_modules.
                 Cron entries must use `./node_modules/.bin/tsx`.

**Rationale.** …
```

**decisions/** *(folder)*
Append-only log of Architectural Decision Records. One file per ADR.
Folder structure:
```
decisions/
├── INDEX.md
├── 2026-05-17-1-tls-webroot-renewal.md
├── 2026-05-16-2-reviewer-as-editor.md
└── archive/
    └── (older / superseded ADRs)
```
File naming: `YYYY-MM-DD-N-kebab-slug.md`. The `N` differentiates multiple ADRs on the same day (start at 1). The slug is a 2–5 word summary; never put status into the filename — status lives inside the file. See Section 7 for the per-file format.

**roadmap/** *(folder)*
Project progress hub. Each task is its own file; cross-cutting sections (recent activity, technical debt) live as their own files inside the folder.
Folder structure:
```
roadmap/
├── INDEX.md                        — overview + status counts
├── tasks/
│   ├── 2026-05-12-china-auction-reactivate.md
│   ├── 2026-05-08-ocr-label-swap.md
│   └── …
├── recent-activity.md              — session log, newest-first, sliding window
├── technical-debt.md               — TD-* records
└── archive/
    ├── completed-2026-Q2.md
    └── recent-activity-2026-04.md
```
Each task file holds: status, priority, owner, brief context, acceptance criteria, links to related ADRs or commits. Status changes happen inside the file — the file does not get renamed.

**Valid status values:**
- `open` — not yet started
- `in-progress` — currently being worked on
- `coded` — code is written but real-path not yet verified (per skill `real-path-verification` Section 7)
- `pending-verification` — verification scenarios handed off to Vasily but not yet confirmed
- `verified` — real-path verification closed; task complete for in-scope work (per `real-path-verification` Section 2)
- `completed` — task closed; used for out-of-scope tasks (pure documentation, mechanical fixes, infrastructure operations) where `real-path-verification` does not apply
- `blocked` — cannot proceed; blocker named in the task body

In-scope tasks (runtime behavior changes) close at `verified`, not `completed`. Out-of-scope tasks close at `completed`. The `coded` / `pending-verification` / `verified` trio mirrors the three-state lifecycle defined in `real-path-verification` Section 7.

**bugs/** *(folder)*
Open / verify-status / won't-fix bugs tracker. One file per bug.
Folder structure:
```
bugs/
├── INDEX.md
├── B-2026-05-12-china-che168-antibot.md
├── B-2026-05-12-encar-flat-qdsl.md
└── archive/
    └── (resolved or won't-fix bugs older than ~90 days)
```
File naming: `B-YYYY-MM-DD-kebab-slug.md` (or project-specific bug ID prefix). Status, severity, and resolution live inside the file.

**universals/** *(folder)*
Registry of reusable technical and design units. Drives the `universality-discipline` skill — the default flips from "create new" to "reuse existing" for every component, engine, tool, design token, text pattern, or identity element in the project. One **thematic file** per category of unit; one **row** per unit inside each file.

Folder structure:
```
universals/
├── INDEX.md              — registry of thematic files in this folder
├── components.md         — UI components: buttons, forms, modals, navigation, layouts
├── design-tokens.md      — colors, spacing, typography, icons, animations, themes
├── text-patterns.md      — headings, toasts, errors, placeholders, empty states
├── identity.md           — contacts, addresses, legal text, brand copy
├── tools.md              — calculators, validators, formatters, parsers, handlers
├── engines.md            — large modules: AI agents, search, OCR, auth, payments
└── forms-and-leads.md    — data collection, contact blocks, lead capture
```

Additional thematic files are added on demand when a project develops a category that does not fit (e.g. `email-templates.md`, `notifications.md`). The folder's `INDEX.md` is updated whenever a thematic file is added.

File format per thematic file:
```markdown
# Universals — Components — <Project Name>

<!--
  @file:        knowledge/universals/components.md
  @project:     <Project Name>
  @description: Reusable UI components
  @updated:     YYYY-MM-DD
  @version:     1.0
-->

| Unit | Lives at | Accepts (adaptation params) | When to use | When to deviate |
|---|---|---|---|---|
| PrimaryButton | src/components/ui/Button.tsx | label, onClick, variant ('default' / 'large'), disabled, loading | Any primary action | If destructive — use DestructiveButton |
| FormField | src/components/ui/FormField.tsx | label, name, type, placeholder, error, required | All form inputs | — |
```

**The `Accepts` column is mandatory** — it lists the adaptation parameters of the universal (props, config keys, slots). An empty `Accepts` column is a red flag: the unit is rigid, not a real universal. Either parametrize it or remove it from the registry. See `universality-discipline` Section 6 for the adaptability requirement.

**Bootstrap for existing projects:** when this skill is first applied to a project that already has code but no `knowledge/universals/` folder yet, run the Bootstrap procedure from `universality-discipline` Section 5: scan `src/components/`, `src/lib/`, design configuration, and build the initial registry by entering every technical or design unit found. Vasily reviews the result and **removes** entries that should not be universals — universal-by-default means removal is the only exit, not the entry.

### Optional — add when needed

Create additional artefacts (file or folder, per Section 4) whenever a domain becomes large enough to need its own space.
Naming examples: `monetization.md`, `integrations.md`, `bot.md`, `calculator.md`, `design.md`, `prompts.md`, `content-rules.md`, or folders like `experiments/`, `incidents/`.

No fixed list — project complexity determines the set.

### Migration from legacy monolithic files

Projects with pre-existing `decisions.md`, `roadmap.md`, `bugs.md`, or `rules.md` as single files migrate to the folder shape using the **archive-and-seed** pattern, not full decomposition:

1. Take the last N records (typically 10–20) from the legacy file. Convert each into its own file under the new folder, following the per-record format above.
2. Rename the original legacy file to `{name}-archive-pre-migration-YYYY-MM-DD.md` and leave it in `knowledge/`. **Do not delete it.** It is a frozen historical snapshot.
3. Add one line to the root INDEX pointing at the archive: "Pre-migration archive — read only when investigating older records."
4. The new folder's local INDEX lists only the freshly migrated records; the archive is referenced once, not enumerated.

**The goal is to establish the new shape for future work, not to retroactively decompose the entire history.** Older records remain accessible via grep on the archive file. If a specific old record proves to be heavily referenced later, it can be lifted out of the archive into the new folder on demand — point migration, not bulk migration.

---

## 6. File Format Standard

**File header:** every `knowledge/*.md` file **must start with** a standard header. The exact format (fields `@file`, `@project`, `@description`, `@updated`, `@version`, `@lines`) is defined in skill `code-markup-standard`, Section 11. Read that skill for the authoritative format.

**Optional YAML frontmatter for vector-DB readiness.** Files may carry a YAML frontmatter block in addition to the HTML comment header. This is a forward-looking provision: if the project later adopts a vector-search backend (LightRAG, qmd, or similar), these fields make documents indexable without retroactive rewriting. Frontmatter is **not mandatory** — it is added to new files at creation time and to existing files when they are next edited. Mass migration is not required.

Suggested frontmatter fields:
```yaml
---
tags: [infrastructure, deploy, nginx]
entities: [VDS, PM2, jckauto-bot, certbot]
tier: facts          # facts | working | wisdom (see below)
relates-to: [ADR-2026-05-17-1, R-TLS-RENEW-HOOK-1]
---
```

**Tier field** — explicit memory layer, optional. Three values:
- `facts` — immutable reference (infrastructure, architecture, customs constants).
- `working` — actively iterating state (open tasks, in-progress bugs, WIP decisions).
- `wisdom` — durable lessons (accepted ADRs, active rules, retrospectives).

The tier helps both human readers and the wiki lint pass (Section 16) calibrate expectations: facts should not drift, working should be re-examined regularly, wisdom should be referenced when justifying new decisions.

**Size limit:** the 200-line target is now a *signal*, not a hard limit. When a single file approaches 200 lines, the relevant question is: **is this still a coherent single subject (Section 4 "reference document"), or has it accreted into a list of records?** If list of records — refactor to a folder (Section 4). If still a single subject — splitting may still be useful for readability, but it is no longer a forced rule; a 300-line reference document on a genuinely connected subject is acceptable.

**Folder size:** there is no fixed limit on records per folder. The `archive/` subfolder absorbs older records when a folder grows enough to feel heavy at a glance. Decision to archive is taken record-by-record, not by overall count: a record is archived when it has been inactive for a meaningful period (typical: 90 days for ADRs and bugs, one quarter for completed tasks). Archives are not read by default — only when investigating a specific historical question.

**Recent Activity entry format** (one entry per session, newest first, lives in `roadmap/recent-activity.md`):

```markdown
### 2026-04-25 — Short session title

- **Сделано:** [1–3 lines, what was actually completed]
- **Прервались на:** [one line] | **Следующий шаг:** [one line]
- **Контекст:** [optional, 1–2 lines — what to keep in mind, why decisions went the way they did]
- **Ссылки:** [optional — `decisions/2026-04-25-1-oauth-choice.md`; `commit a3f12b8`; `rules/R-AUTH-1-cookie-flags.md`]
```

The "Ссылки" field is optional — include only when the session produced an ADR, a new rule, a notable commit, or other artefact a future session might want to find. Cross-link format follows Section 11.5.

Keep entries compact. The point is fast re-entry into project state at the start of next session, not exhaustive logging.

---

## 7. decisions/ Format — Per-ADR File

Each ADR lives as a single file under `decisions/`. Filename: `YYYY-MM-DD-N-kebab-slug.md`.

**File body:**

```markdown
# ADR-2026-05-17-1 — TLS Webroot Renewal

**Status:** Accepted
**Date:** 2026-05-17
**Confidence:** high
**Tier:** wisdom

## Context
What was the situation, what problem needed solving, what constraints existed.
Preserve the full spirit of the context — do not over-abbreviate.

## Decision
What was decided. Exact and unambiguous.

## Rationale
Why this decision over alternatives. Include the reasoning that future readers
will need to understand why it made sense at the time.

## Consequences
What changes. What new constraints exist now. What risks remain.

## Forward-thinking impact
**Mandatory for every ADR.** Per skill `real-path-verification` Section 5, every decision must be examined for 1-2 step downstream consequences before it is recorded as accepted. State here:

- **System layer** — what this decision changes inside the system itself (data, code, schemas).
- **Neighbour-system layer** — what this affects in adjacent systems (other services, processes, integrations, monitoring).
- **User layer** — what this changes for end users, operators, or downstream consumers (UX, response time, error messages, expectations).

If harm was found on any layer, state which industry best-practice was used to redesign the decision so the harm is gone (feature flag, graceful degradation, backward-compatible change, adapter pattern, deprecation path, and similar — see `real-path-verification` Section 5 «Searching for the best practice»). If no harm was found after active searching, state "No harmful downstream consequences identified after explicit search."

"No consequences found" without active search is not legitimate — it means the looking was not done, not that consequences do not exist.

## Alternatives considered
What else was on the table and why it was not picked.

## Next step to raise confidence
**Mandatory when `Confidence: low`.** Concrete action that would move this ADR
from low to medium or high confidence (e.g. "run experiment X for two weeks",
"observe production behavior under load N", "consult specialist Y on tradeoff Z").
Without this section, a low-confidence ADR is hedging in disguise.
See skill `anti-hedging-language` Section 7.

## Source
Where the data behind this decision came from (research session date, diagnostic logs,
commit SHAs, external documentation).
```

### Status field — lifecycle

Allowed values:

- **WIP** — record is in active iteration. Mutable. Typically lives in this state for hours or days while a multi-prompt refactor is in flight.
- **Proposed** — decision has been made but not yet validated by time or operation. Most decisions enter at Proposed.
- **Accepted** — decision validated by actual use. Append-only from this point.
- **Superseded by [filename of replacing ADR]** — a later decision replaced this one. Format: `Superseded by 2026-06-12-1-oauth-revised.md`. Never edit the superseded record's body; the new record is a separate file that names this one in its own Context section.

The Confidence field (`low / medium / high`) coexists with Status and reflects how much trust the team currently puts in the decision. A Proposed-low ADR is honest; pretending it is Accepted-high is not.

### Low-confidence ADRs require a next step

When an ADR has `Confidence: low`, it must include a "Next step to raise confidence" section in the body, stating what concrete action would move it to medium or high. A low-confidence ADR without this section is hedging in disguise — claiming to record a decision while leaving the decision-quality unstated. See skill `anti-hedging-language` Section 7.

### Local INDEX of decisions/

`decisions/INDEX.md` lists every ADR, grouped by status:

```markdown
# Decisions — INDEX

## Active
| File | Title | Date | Confidence |
|---|---|---|---|
| [2026-05-17-1-tls-webroot-renewal.md](2026-05-17-1-tls-webroot-renewal.md) | TLS Webroot Renewal | 2026-05-17 | high |
| …

## WIP
| File | Title | Date | Why WIP |
|---|---|---|---|
| …

## Archive
See `archive/` and `decisions-archive-pre-migration-YYYY-MM-DD.md` for older records.
```

### Append-only and Discard

ADRs in Accepted state are append-only — never modify or delete the body. The only field that may change post-acceptance is `Status:` flipping to "Superseded by …".

WIP records are mutable — they may be edited, merged, or *discarded* (deleted outright). Discard is legal for WIP because WIP records are scratch work, not history. The main log is for things that mattered, not every branch explored. Once a record moves out of WIP into Proposed or Accepted, append-only kicks in.

---

## 8. Decision Lifecycle and Stabilization

Knowledge records — especially decisions — have a natural lifecycle during iterative work. Trying to record every intermediate choice as a final ADR clogs the log with SUPERSEDED entries; trying to wait until everything stabilizes loses context along the way.

### The four states

```
WIP ──→ Proposed ──→ Accepted
                       │
                       ↓ (when replaced)
                   Superseded
```

- **WIP** — record lives in `decisions/` with `Status: WIP`. Listed under the WIP section of the local INDEX. Mutable.
- **Proposed** — record stays in the same file. `Status:` flips to Proposed. Listed under Active in the local INDEX. Append-only from here.
- **Accepted** — validated by actual use. Same file. `Status:` flips to Accepted. Most stable state.
- **Superseded by [filename]** — later decision replaced this one. Same file, `Status:` updated to include the replacing filename. The replacement is a separate ADR file.

State transitions update only the `Status:` field. The body is preserved.

### When to use which state

**Use WIP when:**
- Architecture is actively in flux (multiple iterations expected within hours or days)
- The decision depends on an experiment that is still running
- Vendor/external response is pending and may change the direction
- You are exploring alternatives and have not yet chosen

**Use Proposed when:**
- The choice has been made
- Implementation is happening or has just happened
- But there is no real-world validation yet (no production traffic, no end-user feedback, no observed behavior under load)

**Use Accepted when:**
- The decision has been validated in practice — worked, did not need rework, behaves as expected
- Or enough time has passed and no reason emerged to change it

Proposed → Accepted is usually a silent transition (edit the Status field). WIP → Proposed is a **stabilization** event — described below.

### Stabilization protocol

Stabilization is the act of moving WIP records into stable states. Two triggers:

**Trigger 1 — Manual (primary).** Vasily says "стабилизируй knowledge", "закрой итерацию", or equivalent. Claude runs the stabilization procedure on all WIP records in `decisions/`.

**Trigger 2 — Automatic reminder (secondary).** When Claude detects Vasily is switching to a different major task (new unrelated topic after 5+ prompts on the current one, explicit phrases like "перейдём к другому" / "теперь другая задача"), and there are unresolved WIP records — Claude reminds: «В `decisions/` остались N WIP-записей. Стабилизировать перед переключением?» This is a reminder, not automatic execution.

**Procedure — one question per WIP record:**

1. Read each WIP record in `decisions/`
2. Ask Vasily for its outcome: **Accept / Supersede / Discard**
   - **Accept** — flip Status to Accepted (or Proposed, if not yet battle-tested). Reassess Confidence.
   - **Supersede** — create the replacing ADR as a new file. In the old file, set Status to "Superseded by [new filename]".
   - **Discard** — delete the WIP file. WIP discards are legal (see Section 7).
3. Update `decisions/INDEX.md` to reflect new statuses.
4. Confirm the WIP section of the local INDEX is empty (or contains only still-active WIPs).

---

## 9. Content Preservation Rule

**Absolute principle.** No existing wording outside the explicitly agreed change scope is edited — not "for clarity", not "for consistency", not "while I'm here". The agreed scope may cover several places, but each must be named explicitly before the edit begins. If during the work it becomes visible that another place needs changing too — stop and get agreement, do not silently modify it.

This rule is absolute. "The meaning is preserved" is not a valid justification: meaning is not judged by the editor, it is judged by whether the text itself is preserved. "I only shortened it a little" — after 5 iterations becomes a different text with different meaning. This is the "broken telephone" effect the rule exists to prevent.

**Why there is no list of "allowed techniques":** any such list becomes a loophole. "I rephrased, but it's within the allowed list" — and over several edits the text drifts. The only safe rule is: outside the agreed scope, wording is not touched.

**Illustrative example of the risk.** Shortening "Не стоит этого делать" to "Не делай это" looks harmless — meaning preserved, two words saved. But in another context the same kind of shortening loses tone, removes a hedge that was load-bearing, or drops a qualifier that someone relied on. Over 3–5 iterations of such "harmless" edits the original text is gone. This is why the rule applies to the act of editing, not to judgments about whether a specific edit "mattered".

**Practical consequence.** When updating a knowledge file: identify the exact scope of what must change, change only that, leave every other line untouched. If you catch yourself "improving" an adjacent sentence — that is a violation, regardless of how much better the new version reads.

**Agreed scope can be multi-point.** The rule does not forbid changing several places at once — it forbids changing places that were not agreed. If the agreement says "update sections 3 and 5", both sections are in scope. If it says "update section 3", section 5 is out of scope even if it looks related.

---

## 10. Update Protocol — Three Triggers

### Trigger 1: After every Claude Code prompt
As part of Acceptance Criteria (already in prompt template):
- Update knowledge files that reflect changes made in the prompt
- Add a new ADR file to `decisions/` if an architectural decision was made
- Add a new entry to `universals/<file>.md` if a new universal was created
- Update `@updated` date and `@lines` count in every modified file's header
- Update the relevant **local** INDEX for any folder whose contents changed
- Touch the **root** INDEX only if a top-level file or folder was added, renamed, or removed (per Section 3)

### Trigger 2: End of work session
Before closing the chat — review what was done in the session and update:

| What happened | Where to update |
|---------------|----------------|
| Infrastructure changed | infrastructure.md |
| New files or patterns added | architecture.md |
| New RULE discovered | new file in `rules/` |
| Architectural decision made | new file in `decisions/` |
| Task completed or added | task file in `roadmap/tasks/`, status flipped |
| Bug found / resolved | new or updated file in `bugs/` |
| New reusable unit created or registered | corresponding file in `universals/` |
| **Always** — session happened | new entry on top of `roadmap/recent-activity.md` (format per Section 6) |
| Local content changed in a folder | that folder's local INDEX |
| Top-level structure changed | root INDEX |

**The Recent Activity entry is mandatory at end of session** — even if no code changed. An exploratory or planning-only session still produces an entry: what was discussed, what was decided, what to pick up next session. This is what enables the Session Start Ritual (Section 11.6) to work.

### Trigger 3: A valuable exploration produced durable knowledge

(See Section 11 — "Query → Wiki".) When a session produced a substantive piece of analysis, a comparative breakdown, a research summary, or a diagnostic discovery that future sessions will likely want to retrieve — file it back into knowledge as its own page, not just chat history.

If updates were already done prompt-by-prompt — verify they are complete and accurate.
If the session was exploratory (no code changes) — still add the Recent Activity entry, and add an ADR or discovery file if any durable conclusion was reached.

---

## 11. Anti-Duplication and Query → Wiki

### Anti-Duplication

**Before creating any new knowledge file — check the root INDEX first, and the relevant folder's local INDEX.** Scan existing files for overlapping topics. If the topic fits within an existing file or folder — add a section there, do not create a new top-level file.

**Duplication signals to watch for:**
- Proposed filename is a synonym of an existing one (`auth.md` vs `authentication.md`, `api.md` vs `endpoints.md`)
- The topic already has a section header in an existing file's registry
- The content would split naturally across two existing files — means it belongs in whichever is primary, with a cross-reference in the other

**When in doubt — extend an existing file rather than create a new one.** New files are justified only when:
- The topic is genuinely new and does not fit any existing file
- The artefact is a list-of-records that needs its own folder (Section 4)
- Splitting an overgrown file into two coherent halves (follow Section 9 Content Preservation rules)

**Cross-file references:**
When a fact relates to content in another knowledge file, reference it rather than duplicating. The source of truth lives in one place. Full cross-linking system (six link types, when to link, format) — see Section 11.5.

### Query → Wiki — file durable outputs back

A session often produces analysis that is more valuable than a single answer: a comparative breakdown of two approaches, a diagnostic walk-through of a tricky incident, a research summary on an external service, a stakeholder map. If this analysis stays only in the chat, the next session re-derives it from scratch — and the cumulative cost of that re-derivation, across months, is substantial.

**The rule:** when a session produced a piece of analysis that future Claude sessions are likely to want, **file it into knowledge as its own page**. Decide where based on the analysis type:

| Analysis type | Where it lands |
|---|---|
| Diagnostic deep-dive on an incident or bug | `knowledge/discovery/YYYY-MM-DD-tag.md` |
| Architectural decision with rationale | new ADR in `decisions/` |
| External service investigation (API quirks, vendor behavior) | append to relevant integrations file, or new dedicated file |
| Comparative analysis of two approaches | new ADR if it informed a decision, else `knowledge/discovery/` |
| Research summary done via `research-protocol` | new file in the relevant subject area or `decisions/` |

**This is not "file everything".** The signal is: "would a future session benefit from finding this written down rather than re-deriving it?" If yes → file. If the analysis was a one-time clarification that no one will need again → leave it in chat.

**Inspiration.** This pattern echoes Karpathy's LLM Wiki: explorations compound in the knowledge base just like ingested sources do. Adapted for our domain: we file when the analysis is durable, not on every query.

---

## 11.5. Cross-Linking System

Knowledge gains value not just from individual files but from the connections between them. A decision references the rule it produced; a rule references the code where it lives; a session entry references the commit that ships its work. These links let a future reader (human or Claude) trace context without reading everything.

This section defines the linking system: six link types, one universal format, clear criteria for when a link earns its place.

### Universal format

All cross-links use markdown link syntax: `[visible text](target)`.

This is human-readable, Claude Code-readable, and requires no toolchain. Obsidian-style wikilinks (`[[file]]`) are deliberately avoided. We considered them when reviewing Karpathy's LLM Wiki pattern and rejected them: they require Obsidian-specific tooling (auto-linking by name match, graph view, backlink computation) that our environment (VS Code, MCP file readers, Claude Code) does not have. Plain markdown links work everywhere and never silently rot when the Obsidian assumption is broken.

### Six link types

**1. Link to a knowledge file or record (most common).**
```
[см. infrastructure.md → Deploy section](knowledge/infrastructure.md#deploy)
[см. ADR TLS Webroot Renewal](knowledge/decisions/2026-05-17-1-tls-webroot-renewal.md)
[см. R-CRON-1](knowledge/rules/R-CRON-1-cron-tsx-path.md)
```
Use anchor (`#section-id`) when pointing to a specific H2 inside a single-file artefact. For folder-based artefacts, link to the specific record file directly — no anchors needed because each record is its own file.

**2. Link to a skill.**
When referencing a procedure or standard fully defined in a skill:
```
(см. skill knowledge-structure → Section 16)
```
Plain-text reference is sufficient — clickable URL is not required for skills since their canonical location may vary by environment.

**3. Link to project code — by symbol, not line number.**
```
[ProducersMixin.get_producers()](src/api/client_producers.py)
```
Reference the function, class, or module name plus the file path. Never reference by line number — line numbers shift on every edit and the link goes stale silently. If the exact location must be pinned to a specific moment in time, append a commit SHA: `[client.py @ a3f12b8](src/api/client.py)`.

**4. Link to git commit or PR.**
GitHub-standard syntax — Claude Code recognizes it natively:
```
commit `a3f12b8`
PR #42
fixes #15
```
No need to construct full URLs — short SHA and `#N` notation are enough for any Git tool to resolve.

**5. Link to an ADR (cross-reference between decisions).**
```
[ADR TLS Webroot Renewal](knowledge/decisions/2026-05-17-1-tls-webroot-renewal.md)
```
Inside `decisions/` itself, when one ADR supersedes or relates to another, this link is mandatory (already required by Section 7 — `Superseded by [filename]`).

**6. Link to a chat session — optional, no URL.**
```
(session: 2026-04-25)
```
Date as a marker for `conversation_search` if the past discussion needs to be retrieved. A clickable Claude.ai URL is added only when Vasily explicitly asks for one — those URLs are useful only to him personally and clutter the file otherwise.

### When to link

Not every mention of another file deserves a link. The criterion is reader value: would a future reader (or future Claude session) want to follow this link to verify or continue work?

**Link is mandatory when:**
- A fact in one knowledge file is the source of truth for a fact mentioned in another (e.g., a `rules/` record mentions a RULE that originated from an ADR — link to that ADR).
- An ADR references the code or commit that implements it.
- A Recent Activity entry references an ADR, RULE, or commit produced in that session.
- Inside a record (ADR, bug, rule), when it supersedes, replaces, or is consequence of another record.

**Link is optional (use when helpful) when:**
- Referencing a skill that fully describes a procedure mentioned briefly here.
- Pointing to a code symbol that the reader is likely to want to open.
- Cross-referencing related but independent records.

**No link needed when:**
- The mention is self-contained in context (e.g., "run `pm2 restart`" doesn't need a link to PM2 docs).
- The reference is to something already obvious from context (e.g., the file you're reading mentions itself).
- Adding the link would clutter prose without adding value.

### Direction principle

Links flow from **newer** record to **older** record. A new entry references the older context it builds on; the older entry is not edited (Content Preservation, Section 9).

The one exception is supersedence: when an old ADR is replaced, the old ADR's `Status:` field gets updated to `Superseded by [new filename]`. This is allowed because Section 7 explicitly permits it — supersedence updates a status field, not the body of the past record.

Backlinks (the older record automatically knowing it's referenced) are not maintained. For our scale this complexity is not justified. If a link genuinely needs to work both ways, write it explicitly in both files at creation time.

### Link integrity

When a knowledge file is moved, renamed, or has a section renamed — links pointing at it become stale. There is no automated check; this falls under end-of-session integrity review (Section 13) and the periodic Wiki Lint pass (Section 16).

---

## 11.6. Session Start Ritual

When opening a new chat session for a project, before any work — read these files in order:

1. **CLAUDE.md** — universal rules and Execution discipline. Always.
2. **knowledge/INDEX.md** — root registry: what files and folders exist at the top level.
3. **knowledge/roadmap/recent-activity.md** — last session log. Where work stopped, what comes next.
4. **knowledge/roadmap/INDEX.md** — current state of tasks (open, in-progress).

These four files are the minimum context for a useful start. They tell you: what the project's hard rules are (CLAUDE.md), where things live at top level (root INDEX), where work stopped (recent-activity), what is currently active (roadmap local INDEX).

**After reading these — and only after — proceed to the actual task.** Open additional knowledge files (other folders' local INDEX, specific records, single-file references) only when the current task requires them, guided by the root INDEX descriptions.

**Do not read archive files at session start** (`*-archive-pre-migration-*.md`, `archive/` subfolders). They are read only when investigating a specific historical question.

**Do not read `knowledge/universals/*.md` files at session start.** The registry is large by design — reading all of it every session would flood the working set. Universals are read **per task** during Step 6a of `prompt-writing-standard`, when the relevant thematic file is selected by task scope. The exception is a one-time check on first work with a project: if `knowledge/universals/` does not exist yet, run the Bootstrap procedure from `universality-discipline` Section 5 before proceeding to actual work.

This ritual exists because the previous default — reading everything, or guessing context from past chats — was either wasteful or unreliable. A handful of compact files, read every session, give predictable context entry without flooding the working set.

If `roadmap/recent-activity.md` does not yet exist for this project (or is empty) — note this and ask Vasily where work stopped. Do not fabricate context.

---

## 12. Stale Information Protocol

Knowledge files accumulate facts that can become incorrect over time. A fact that was true six months ago may no longer match reality.

**When a fact is discovered to be stale (no longer true):**

1. **Do not silently rewrite it.** The Content Preservation Rule (Section 9) still applies — but staleness is a legitimate reason to update, if handled openly.
2. **Update the fact in place** with the new correct information.
3. **If the change is significant** (was a rule, a decision, or an architectural fact) — add a new ADR to `decisions/` explaining: what was thought before, what is now known, why it changed. This creates an audit trail.
4. **Bump `@updated` date and `@version`** in the file header.

**When a fact is no longer relevant (not wrong, just obsolete — e.g. deprecated feature removed):**
- Delete the fact, don't comment it out.
- If the deletion is non-trivial — note it in `decisions/` with rationale.

**Never:**
- Leave known-wrong information in knowledge "because removing it feels destructive"
- Add contradictory facts without resolving the contradiction
- Use vague hedges ("may be", "possibly") to avoid committing — either the fact is true or it isn't; if unknown, mark it `@todo: verify`

**Hedging language as a drift signal.** When reviewing an existing knowledge file and noticing hedging phrases that did not used to be there (or that were added by a recent edit) — that is a signal that a fact has drifted into uncertainty without being formally re-examined. Treat hedging in a knowledge file as if it were a `@todo: verify` flag: stop, re-verify the fact, either confirm it as fact (remove the hedge with evidence) or escalate to ADR if the situation has actually changed. See skill `anti-hedging-language` Section 7 for the discipline applied to writing.

**Periodic review:** At the end of a work session, if any fact was touched tangentially and its currentness is in doubt — flag it with an `@todo: verify` inline comment. Do not rewrite on suspicion alone. The periodic Wiki Lint pass (Section 16) picks these flags up and resolves them.

---

## 13. INDEX Integrity Check — Two-Level

INDEX files are the navigation contract of the knowledge base. If they drift from reality, every future session reads the wrong files or misses relevant ones.

**Two-level integrity check — run at end of session when any knowledge file or folder was modified:**

### Root INDEX check

1. For every top-level file listed in the root INDEX — verify the file still exists at that path.
2. For every top-level folder listed in the root INDEX — verify the folder exists and contains its own `INDEX.md`.
3. For every top-level file or folder that exists in `knowledge/` — verify it is listed in the root INDEX.
4. For every top-level file or folder modified in this session at the *top level* (renamed, created, removed), verify the "Updated" column in root INDEX shows today's date.

The root INDEX does **not** need to reflect record-level changes inside folders — that is the local INDEX's job.

### Local INDEX check (per modified folder)

For each folder whose contents changed in this session:

1. For every record listed in the folder's local INDEX — verify the file still exists.
2. For every file that exists in the folder — verify it is listed in the local INDEX.
3. Verify status fields, dates, and any other tracked metadata in the local INDEX match the records' actual front matter.
4. Verify the local INDEX's own `@updated` date is today.

### Universals-specific integrity check

The `universals/` folder undergoes the standard Local INDEX check above, plus one additional check unique to its format:

5. For every row in every `universals/*.md` thematic file, verify the `Accepts` column is non-empty. An empty `Accepts` column is a red flag per `universality-discipline` Section 6 — either the unit must be parametrized (and the column filled), or the entry must be removed by Vasily's explicit command. Flag any empty `Accepts` rows in the integrity report so they can be resolved.

### Cross-link integrity (across both levels)

For every file modified in this session, scan its outgoing markdown links. Verify each link target still exists — file path resolves, anchor `#section-id` matches an actual H2 header in the target. If a link is stale because the target was renamed in the same session — fix the link. If the target itself was deleted — replace the link with plain text or remove it, do not leave a broken link silently.

### Resolution

**Inconsistencies found — fix immediately in the same session.** Do not defer INDEX fixes to "next time" — by next session the drift compounds.

**Treat INDEX as source-of-truth contract:** if a file exists but is not in INDEX (root or local), the file is effectively invisible to future sessions. If INDEX lists a file that doesn't exist, future sessions will waste time searching for it.

---

## 14. How Claude Code Reads knowledge/

**Correct reading sequence:**
1. Read CLAUDE.md — universal rules, always.
2. Read `knowledge/INDEX.md` — root registry: understand what files and folders exist at the top level.
3. For the current task, identify the relevant artefact:
   - If a top-level file (e.g. `infrastructure.md`) — read it directly.
   - If a folder (e.g. `decisions/`) — read that folder's local INDEX first, then open the specific record file(s) needed.
4. Read only the files relevant to the current task.

**Do not** read all knowledge files at session start.
**Do not** skip INDEX files and guess which files exist.
**Do not** read folder local INDEX files unless the task touches that folder.
**Do** use INDEX descriptions to determine which file or folder to open.

**Example:** Task is to fix a payment bug.
→ Read root INDEX → see `bugs/` folder, `rules/` folder, `infrastructure.md` file.
→ Read `bugs/INDEX.md` to see if this bug is already tracked.
→ Read `rules/INDEX.md` to find payment-related rules → open those rule files.
→ Read `infrastructure.md` payment section.
→ Do not read `roadmap/` or `decisions/` unless they become relevant.

---

## 15. Creating knowledge/ for a New or Existing Project

**Step 1 — Audit sources**
Read all existing documentation: current CLAUDE.md, any docs/ files, README,
comments in code. Do not start writing until all sources are read.

**Step 2 — Plan the file/folder set**
Based on project complexity, decide which artefacts are needed beyond the mandatory set.
For each artefact, decide file or folder using Section 4 (natural unit).
Present the plan to Vasily before creating files.

**Step 3 — Create artefacts one prompt at a time**
Maximum 1 file or folder per Claude Code prompt. Maximum 2 if both are small and
tightly coupled. Never batch all knowledge creation into one prompt.

Order: CLAUDE.md first → root INDEX.md second → top-level files and folders one by one
(each folder created with its local INDEX in the same prompt). The `universals/` folder
is created as part of this sequence — its `INDEX.md` and the seven standard thematic
files (components, design-tokens, text-patterns, identity, tools, engines,
forms-and-leads) are scaffolded in one or two prompts (empty tables with the standard
file format header).

**Step 4 — Migrate legacy documentation**
After all new artefacts are created, deal with legacy:
- Old single-file `decisions.md` / `roadmap.md` / `bugs.md` / `rules.md` → archive-and-seed pattern (Section 5).
- Old `docs/` or README content → moved into relevant new files where it fits.
- Verify nothing was lost before deleting old sources.

**Bootstrap universals/ for existing projects.** When the project already has code
but no `knowledge/universals/` folder yet, run the Bootstrap procedure from
`universality-discipline` Section 5 right after Step 3: scan `src/components/`,
`src/lib/`, design configs, build the initial registry by entering every technical
or design unit found, fill the `Accepts` column for each row from the actual code,
and present the result to Vasily. His task is to **remove** entries that should not
be universals — universal-by-default means removal is the only exit, not entry.

**Step 5 — Verify both INDEX levels**
Run the Section 13 integrity check on the root INDEX and every folder's local INDEX.

---

## 16. Wiki Lint Pass

The Wiki Lint Pass is a periodic, deliberate sweep across the knowledge base looking for problems that the per-session integrity check (Section 13) does not catch. It is the standing-back step — the moment when the knowledge base is examined as a whole rather than file by file.

This operation is adapted from Karpathy's LLM Wiki "lint" concept: instead of waiting for problems to surface during normal work, periodically ask "is the knowledge base healthy?" and fix what is not.

### What Wiki Lint looks for

1. **Contradictions between files.** Two files asserting different things about the same fact. Example: `infrastructure.md` says PM2 process is `jckauto-bot`, but `bot.md` says `jck-bot`. Reconcile and update the wrong file with an ADR explaining the change.

2. **Orphan files.** Files that exist in `knowledge/` but are not listed in any INDEX (root or local). Either add them to the right INDEX or delete them if no longer relevant.

3. **Ghost references.** INDEX entries pointing at files that no longer exist. Remove the entry or restore the file.

4. **Stale facts** (flagged by `@todo: verify` from Section 12, or detected by reading against current reality). Verify, update, or remove.

5. **Missing cross-links.** A record references another concept that has its own file, but does not link to it. Add the link.

6. **Concepts mentioned but lacking their own page.** A term keeps recurring across files but has no canonical definition. Decide whether it earns a page (Section 4 natural unit test).

7. **Broken outgoing links.** Markdown links whose targets no longer resolve. Fix or remove.

8. **Duplicate records.** Two ADRs covering the same decision under different filenames, or two RULE files restating the same constraint. Merge or supersede.

### When to run

- **By Vasily's command.** "Сделай wiki-lint" / "прочеши knowledge" / "lint check". Most common trigger.
- **Scoped command.** "Wiki-lint decisions/" or "wiki-lint roadmap/" — checks only one folder. Faster, useful when one folder has seen heavy activity.
- **Monthly reminder.** Claude proactively suggests a lint pass when the last full lint was more than ~30 days ago, or when the volume of records in any one folder has grown noticeably since last check.
- **After major migrations.** Whenever the structure of `knowledge/` changes (folder added, file split, large rename), the next session should run a lint pass to confirm nothing was lost in transit.

### Procedure

Wiki Lint is **never silent and never automatic on the writing side.** Claude reads, finds issues, reports them to Vasily, and proposes fixes; Vasily approves each fix before it lands. This preserves Content Preservation (Section 9) and prevents drift through batched "minor cleanups".

1. Determine scope: whole `knowledge/` or one folder.
2. For each file in scope: read it, check it against the eight criteria above.
3. Build a report:
   - Item-by-item: file, problem, proposed fix.
   - Group items by severity: red (active contradictions, broken links) / yellow (orphans, stale flags) / green (cosmetic).
4. Present report to Vasily.
5. For each accepted fix, apply via a Claude Code prompt (or directly via MCP write when the change is purely textual and isolated to one file). Each fix is its own atomic change.
6. After all fixes land, update affected INDEX files (Section 13 integrity check).
7. Log the lint pass in `roadmap/recent-activity.md` with a one-line summary: how many items found, how many fixed.

### What Wiki Lint is not

- It is not a replacement for the per-session Section 13 integrity check. Section 13 keeps the boat afloat between lint passes; Section 16 is the dry-dock maintenance.
- It is not a license for batch rewriting. Content Preservation (Section 9) still applies to every individual edit.
- It is not a search engine substitute. If the goal is "find all mentions of X", grep does that better.

### Why this exists

Without an explicit lint operation, the knowledge base accumulates drift that none of the day-to-day mechanisms catch. Per-session integrity checks only see what changed today. Stale facts, orphans, and contradictions hide between the cracks. The lint pass is the deliberate step back that catches them, and it pays for itself every time it surfaces a contradiction that would otherwise have informed a wrong decision.

---

## 17. What This Skill Inherits from Karpathy's LLM Wiki — and What It Does Not

This skill was reviewed against Karpathy's `llm-wiki.md` (April 2026) before publication of v2.0. The review concluded that our knowledge system already implements most of the pattern in spirit; we adopted three specific elements explicitly and declined three others with reasoning. Recording the result here so future reviewers do not re-litigate the same questions.

### Adopted

- **One-record-per-file for list-of-records artefacts** (Section 4 + Section 5). ADRs, bugs, rules, tasks. Direct match to Karpathy's "entity pages, concept pages, source pages" — each idea its own file.
- **Wiki Lint Pass** (Section 16). Direct adoption of the "lint" operation in his architecture: periodic health-check for contradictions, orphans, gaps, broken links.
- **Query → Wiki** (Section 11). Direct adoption of "good answers can be filed back into the wiki as new pages" — adapted to mean diagnostics, comparisons, and research summaries with future re-use value.

### Declined, with reasoning

- **Obsidian-style wikilinks** (`[[Page Name]]`). Reject. They depend on Obsidian-specific tooling (auto-linking, graph view, backlinks). Our environment is VS Code / MCP / Claude Code; plain markdown links work everywhere. See Section 11.5 for full reasoning.
- **Aggressive cascading updates on every source** (one new source touches 10–15 files). Reject. Karpathy's domain is reading-driven knowledge management (papers, articles, books); our domain is code-driven engineering. Cascading updates across many files is, in our context, almost always a symptom of a poorly-scoped prompt (R-PROC: one prompt = one logical unit, max 1–2 files). Adopting cascade-by-default would undermine our prompt discipline.
- **LLM owns the entire wiki layer with no human in the loop** ("you rarely or never write the wiki yourself"). Partial reject. We keep the human-in-the-loop pattern: Claude proposes, Vasily approves, Claude Code commits. Content Preservation (Section 9) is non-negotiable in our system and is incompatible with fully unattended LLM editing.

### Considered for future

- **YAML frontmatter + tiers** (Section 6). Adopted as optional structure, not mandatory. The fields `tags`, `entities`, `tier`, `relates-to` lay groundwork for a future vector-DB or graph-DB backend without forcing a rewrite when (if) we adopt one.
- **Vector-DB / semantic retrieval.** Not adopted now. Re-evaluated when the knowledge base passes ~150 files or when grep-based navigation becomes insufficient.

This section is itself a knowledge artefact and is updated when our position on any of these elements changes.

---

## 18. Quick Reference

| Situation | Section to consult |
|---|---|
| Should this new thing be a file or a folder? | § 4 — Natural Unit |
| What's mandatory in every project's knowledge/? | § 5 — Standard File Set |
| Where do reusable units (components, engines, design tokens, text patterns) get registered? | § 5 — Standard File Set, `universals/` subsection; full discipline in skill `universality-discipline` |
| How do I migrate a legacy monolithic file? | § 5 — Archive-and-seed pattern |
| What goes in a new ADR's file? | § 7 — decisions/ Format |
| What states can an ADR be in? | § 8 — Decision Lifecycle |
| Can I edit this old record's text? | § 9 — Content Preservation |
| Session ended, what do I update? | § 10 — Update Protocol Trigger 2 |
| Should I create a new file for this topic? | § 11 — Anti-Duplication |
| This analysis was useful — should I file it? | § 11 — Query → Wiki |
| How do I link between knowledge files? | § 11.5 — Cross-Linking |
| Starting a new session — what do I read first? | § 11.6 — Session Start Ritual |
| Found a fact that's wrong now — what do I do? | § 12 — Stale Information |
| End of session, am I sure INDEX is consistent? | § 13 — INDEX Integrity Check |
| Project has no `knowledge/universals/` yet — what now? | § 15 — Bootstrap step; full procedure in skill `universality-discipline` § 5 |
| Starting fresh on a project — how do I bootstrap? | § 15 — Creating knowledge/ |
| Vasily said "сделай wiki-lint" — what now? | § 16 — Wiki Lint Pass |
| Why don't we use [[wikilinks]]? | § 17 — Inheritance from Karpathy |
