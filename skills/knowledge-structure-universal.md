---
name: knowledge-structure
description: Create, maintain, and update the living knowledge base for any project (main project context file — CLAUDE.md or equivalent — + knowledge/ directory). Use this skill whenever creating a new project's knowledge files, migrating existing docs to the knowledge/ structure, updating knowledge files after completing a Code Agent prompt, or reviewing knowledge files at the end of a work session.
---

# Knowledge Structure Standard
<!--
  @file:        skills/knowledge-structure/SKILL.md
  @description: Standard for creating and maintaining project living knowledge base
  @version:     1.8
  @updated:     2026-05-15
-->

---

## 1. Why This System Exists

Code Agent reads the main project context file (`CLAUDE.md` or equivalent) at every session start — but ignores content it deems
irrelevant to the current task. The more non-universal content in the main project context file,
the higher the chance critical rules get ignored.

Solution: three-level progressive disclosure.

```
CLAUDE.md or equivalent main project context file ← universal rules only, read every session
knowledge/INDEX.md ← registry with section headers of every file, read when needed
knowledge/*.md     ← thematic files, read only when relevant to current task
```

This keeps context clean, rules visible, and details accessible without bloating
every session with irrelevant information.

---

## 2. Main Project Context File (`CLAUDE.md` or Equivalent) — Project Constitution

**Hard size limit: ≤80 lines.** Past this point Code Agent compliance with rules in this file degrades — instructions get treated as advisory rather than mandatory. Keep the main project context file ruthlessly compact.

**Contains exactly 6 elements, nothing more:**

1. Project name + one-line description of what it does and why
2. Stack (brief list: runtime, framework, DB, key services)
3. Critical rules — max 5, only those whose violation immediately breaks everything.
   Format: `RULE: [what] — [consequence]`
4. **Execution discipline block (Karpathy-style behavioral rules)** — universal behavioral standard for how the Code Agent approaches every task in this project. This is not project-specific critical rules (those live in element 3) — it's a behavioral standard that applies the same way to every Karpathy-aware project. The 5 standard rules:
   - **Don't guess — ask.** If the task allows multiple valid implementations, stop and ask before coding.
   - **Senior-engineer simplicity filter.** Before finalizing implementation, ask: "Would a senior engineer call this overengineered?" If yes, simplify.
   - **Strict scope discipline.** Touch only what the task explicitly names. No "improvements" to adjacent code, no opportunistic refactors, no consistency fixes outside the stated scope.
   - **Goal over steps.** When the user describes the goal, find the right algorithm yourself. When the user prescribes steps and they don't reach the goal — flag the contradiction, don't blindly follow.
   - **Sustainable solutions.** Prefer fixes that prevent recurrence over fixes that just stop the symptom. If a quick fix and a durable fix differ — name both, recommend the durable one, let the user choose.
5. Deploy commands (exact, copy-pasteable)
6. Single pointer: `→ knowledge/INDEX.md`

The Execution discipline block does not count against the limit of 5 critical rules in element 3. Critical rules are project-specific facts whose violation breaks code; Execution discipline is a universal behavioral standard.

**What does NOT go in the main project context file:**
- File navigators, API references, formula details
- Full DB schemas, environment variable lists
- Roadmaps, feature lists, known issues
- Anything that only matters for specific tasks

**Content preservation rule:**
When rewriting or updating the main project context file — preserve the wording, spirit, and tone
of existing rules. Rephrase only to reduce length. Never change the meaning.

---

## 3. knowledge/INDEX.md — Registry

**Purpose:** Allow the Code Agent to understand what's in each file without reading
all files. INDEX.md is read; individual files are opened only when needed.

**Format:**

```markdown
# [Project] — Knowledge Index
> Reading rule: read CLAUDE.md → this index → only files relevant to current task.

## File Registry

| File | Section Headers | Updated |
|------|----------------|---------|
| infrastructure.md | ## Server, ## Repository, ## PM2 Processes, ## Database, ## Deploy, ## Env Vars | YYYY-MM-DD |
| architecture.md | ## File Structure, ## Component Map, ## Key Patterns | YYYY-MM-DD |
| rules.md | ## HTML Safety, ## Error Handling, ## Payments, ## Deployment | YYYY-MM-DD |
| decisions.md | ## 2026-04-08 Decision Title, ## 2026-03-15 Decision Title | YYYY-MM-DD |
| roadmap.md | ## Open Tasks, ## In Progress, ## Completed, ## Technical Debt | YYYY-MM-DD |

## Update Rule
Update INDEX.md after every change to any knowledge file.
Section headers column must reflect actual headers in the file.
```

**Key principle:** The "Section Headers" column lists *actual H2 headers* from each file —
not a prose description. This lets the Code Agent navigate without opening the file.

**When INDEX.md becomes heavy:** see Section 4 — the decision on whether to split is made through reflection, not by a fixed threshold.

---

## 4. When INDEX Grows — A Thinking Protocol

Like any knowledge file, `INDEX.md` is bound by the 200-line limit (Section 6). But the decision *when* and *how* to split it is not mechanical — every project is different, and rigid rules break on real cases. Instead, this section is a set of self-directed questions to walk through when INDEX starts feeling heavy.

**Signals that INDEX deserves reflection:**
- Hard to read in one pass
- Several thematic blocks are clearly independent of each other
- Approaching the 200-line limit
- You find yourself scrolling past irrelevant entries to reach what you need

Any of these is a signal to stop and think — not an automatic trigger to split.

### Question 1 — Is a split actually needed?

- Can INDEX be shortened without losing navigational value? (Sometimes growth is verbosity, not real complexity.)
- Are the topics inside INDEX genuinely independent, or is it one domain laid out in layers?
- If you were looking for a specific file right now — is the volume actually in the way, or only aesthetically?

If after these questions the split still feels right — continue.

### Question 2 — How to divide?

- Along which natural lines does this project fall apart — not invented categories, but the way you actually think about it?
- How many clusters emerge naturally — 2, 3, 5? If more than 5 — the boundaries are probably drawn too thin.
- What name conveys each cluster's meaning most accurately? (Names come from content, not from a canonical list.)

Naming is a thinking act, not a lookup. Use the form `INDEX-[theme].md` where the theme reflects how *this* project actually organizes itself.

### Question 3 — Where does a file on the boundary belong?

A file must live in exactly one sub-index — duplication is never the answer.

- From what context will this file most often be read — when working on what?
- If you removed it from sub-index A, would people searching in A's context fail to find it? If yes — place it in A, add a cross-reference in B.
- Does this file have a clear home, or does it truly live on the boundary? If the second — it's a signal that the boundary between sub-indexes is drawn in the wrong place. Reconsider the division, don't duplicate the file.

### Question 4 — After the split, what does INDEX.md become?

The original `INDEX.md` becomes a router — a short map pointing to sub-indexes. The file registries (the tables with section headers and dates) move into sub-indexes. The router itself stays minimal: one line per sub-index saying what it covers.

Cross-linking principle: star, not mesh. Each sub-index links back to the router in its header; the router links to all sub-indexes. Sub-indexes do not need to link directly to each other — the router is the single source of truth about structure.

### Question 5 — What if a sub-index itself grows heavy?

Same questions, one level down. But also one question from above: is this a sign that *the project itself* has outgrown the current structure, not that the sub-index needs further division?

Deeper than two levels (router → sub-index → sub-sub-index) is a warning sign. If three levels don't solve it, the problem is probably not in the index structure.

### Question 6 — Should we merge back?

If sub-indexes have shrunk over time:
- Do they still hold meaningful thematic independence? If yes — keep them.
- Or have they merely drifted apart historically, with no real reason to stay separate? If yes — merge back into a single INDEX.

Size alone is not the reason to merge — meaning is.

### Closing checks — before finishing the split

- If you forget about this in a month and open the router — will you understand where to go for what?
- Are there files that fell into no sub-index? Files that fell into two? (Both are problems.)
- Is Content Preservation (Section 9) intact? Registry entries are copied verbatim — not rephrased.
- If knowledge is indexed by an available knowledge-indexing tool (for example LightRAG / AI Knowledge Base MCP) — is re-indexing needed after the split? Verify that searches still return expected files.

### Procedural note

A split is a structural migration. It is executed as a planned sequence of prompts after Vasily approves the thematic division — not opportunistically mid-task. The integrity check (Section 13) must pass before the session closes; the system should not be left in a half-split state.

---

## 5. Standard File Set

### Mandatory for every project

**infrastructure.md**
Server details, OS, paths, repository URL and branches, process manager (PM2/systemd)
with exact process names and IDs, database connection and schema, deploy commands,
environment variable names (never values), monitoring setup, bot/app identity.

**architecture.md**
File/directory structure, navigator table (task → file), component relationships,
key patterns and conventions used in this codebase, API endpoint map if applicable.

**rules.md**
Every RULE entry from the codebase and project history.
Format per entry:
```
RULE: [what must / must not happen]
  File: [location] | Consequence: [what breaks if violated]
```
Group by domain (payments, auth, deployment, etc.).

**decisions.md**
Append-only log. New entries at top. Never delete or overwrite existing entries.
Format per entry (see Section 7).

**roadmap.md**
Project progress hub: open tasks in priority order, in-progress items, **recent activity (compact session log of the last 2–3 weeks with brief context)**, completed items (with dates), technical debt with priority markers.

Sections in order, top to bottom:
- `## Open Tasks` — what's planned, prioritized
- `## In Progress` — what's currently being worked on (1–3 items typically)
- `## Recent Activity` — session log, newest entries on top, format per Section 6
- `## Completed` — what's done, dated, brief
- `## Technical Debt` — known issues with priority

**Archival when approaching 200-line limit:** older Recent Activity and Completed entries move together to `roadmap-archive-N.md` (`-1`, `-2` etc.). Active roadmap.md keeps only the recent window readable in one pass. Archives are not read by default — only when explicitly relevant. See Section 6 for archival mechanics.

### Optional — add when needed

Create additional files whenever a domain becomes large enough to need its own file.
Name reflects content: `monetization.md`, `integrations.md`, `bot.md`,
`calculator.md`, `design.md`, `prompts.md`, `content-rules.md`, etc.

### Scalable folder structure

The flat `knowledge/*.md` structure remains valid for small projects. Do not force a folder migration when five to ten thematic files are still readable through `knowledge/INDEX.md`.

Larger projects may use thematic folders under `knowledge/` when the flat set stops being navigable. Common patterns:
- `knowledge/rules/README.md`, `secrets.md`, `deploy.md`, `pii.md`, `prompts.md`
- `knowledge/architecture/README.md`, `backend.md`, `frontend.md`, `prompt-pipeline.md`, `database.md`
- `knowledge/infrastructure/README.md`, `deploy.md`, `rollback.md`, `github-actions.md`, `server-runtime.md`
- `knowledge/decisions/README.md` plus `ADR-YYYY-MM-DD-short-title.md` files
- `knowledge/runbooks/deploy.md`, `rollback.md`, `failed-automerge.md`, `failed-deploy.md`, `failed-health-check.md`

Folder `README.md` files act as local indexes for that theme. `knowledge/INDEX.md` remains the top-level router and points to folder READMEs or sub-indexes.

No fixed list — project complexity determines the set.

---

## 6. File Format Standard

**File header:** every `knowledge/*.md` file **must start with** a standard header. The exact format (fields `@file`, `@project`, `@description`, `@updated`, `@version`, `@lines`) is defined in skill `code-markup-standard`, Section 11. Read that skill for the authoritative format.

**Size limit:** 200 lines maximum. If a file approaches this:
- Split into two logically coherent files
- Update INDEX.md with both new files
- Preserve all wording — do not rephrase when splitting

**decisions.md exception:** append-only, grows indefinitely. When it exceeds 200 lines,
archive older entries to `decisions-archive.md` and add a reference in decisions.md.

**roadmap.md archival:** when roadmap.md approaches 200 lines, move oldest entries from `## Recent Activity` and `## Completed` together to `roadmap-archive-N.md` (`-1` first, then `-2`, etc.). Move whole entries, never half. Active roadmap.md retains only the recent window. The archive file gets a header note: "Archive — read only when investigating a specific historical question. Default reading does not include this file." Reference the archive from active roadmap.md: `Older entries → roadmap-archive-1.md`.

**Folder file headers:** files inside thematic folders follow the same header, size, split, preservation, and INDEX update rules as flat `knowledge/*.md` files. The path in `@file` and in INDEX entries includes the folder path.

**Recent Activity entry format** (per session, newest on top):

```markdown
### 2026-04-25 — Short session title

- **Сделано:** [1–3 lines, what was actually completed]
- **Прервались на:** [one line] | **Следующий шаг:** [one line]
- **Контекст:** [optional, 1–2 lines — what to keep in mind, why decisions went the way they did]
- **Ссылки:** [optional — `decisions.md → 2026-04-25 OAuth choice`; `commit a3f12b8`; `rules.md → Auth section`]
```

The "Ссылки" field is optional — include only when the session produced an ADR, a new rule, a notable commit, or other artifact a future session might want to find. Cross-link format follows Section 11.5.

Keep entries compact. The point is fast re-entry into project state at the start of next session, not exhaustive logging.

---

## 7. decisions.md Format

The file has two sections: **Active iterations (WIP)** at the top for unstable records under active work, and the main append-only log below for stabilized records.

For small projects, a single `knowledge/decisions.md` file remains valid. For larger projects, the preferred structure is `knowledge/decisions/` with `README.md` as the decision index and one ADR file per stable decision: `ADR-YYYY-MM-DD-short-title.md`.

### File structure

```markdown
# Decisions

## Active iterations (WIP)
Mutable section for records under active iterative work. Entries here may be
edited, merged, or deleted freely. After stabilization — moved to the main log
below with status Proposed or Accepted. See Section 8 for lifecycle details.

### YYYY-MM-DD — [Title] — WIP
**Status:** WIP — iteration active
**Current direction:** [current hypothesis / tentative choice]
**Confidence:** low / medium
**Why WIP:** [architecture in flux / 3+ iterations expected / vendor response pending / experiment in progress]
**Related prompts:** [prompt numbers, e.g. 09.2, 09.3]

---

## Accepted decisions

### YYYY-MM-DD — Decision Title
**Status:** Accepted | Proposed | Superseded by [YYYY-MM-DD]
**Confidence:** high | medium | low
**Context:** Concise but complete. What was the situation, what problem needed solving,
what constraints existed. Preserve the full spirit of the context — do not over-abbreviate.
**Decision:** What was decided. Exact and unambiguous.
**Rationale:** Why this decision over alternatives. Include the reasoning that
future readers will need to understand why it made sense at the time.

---
```

### ADR file structure for larger projects

Each stable ADR file in `knowledge/decisions/` uses this format:

```markdown
# ADR YYYY-MM-DD вЂ” Decision Title

**Status:** Proposed | Accepted | Superseded by [ADR link]
**Confidence:** high | medium | low
**Scope:** [project area, subsystem, or rule this decision applies to]
**Context:** [situation, problem, constraints]
**Decision:** [what was decided]
**Consequences:** [benefits, costs, tradeoffs, follow-up work]
**Rollback / Revisit Trigger:** [what would invalidate or reopen this decision]
**Links:** [markdown links to related files, commits, PRs, rules, runbooks]
```

`knowledge/decisions/README.md` lists ADR files newest first, with status and a one-line scope. WIP records may still live in a mutable "Active iterations" section in the README or in `decisions.md` until stabilized; stable decisions move into individual ADR files.

### Status field

Every record below the WIP section has an explicit `Status:` field. Allowed values:

- **Proposed** — decision has been made but not yet validated by time or operation. Record is in the main log but flagged as not fully confirmed. Most decisions enter the main log with Proposed.
- **Accepted** — decision validated by actual use. Append-only from here — changes happen only through new entries that supersede this one.
- **Superseded by [link to new ADR]** — a later decision replaced this one. Format: markdown link to the new entry, e.g. `Superseded by [2026-04-25 — OAuth choice](#2026-04-25-oauth-choice)`. Never edit the superseded record itself; add a new entry with its own date and link back to the one it replaces.

### Confidence field

Every main-log record also has a `Confidence:` field — `low / medium / high`. This legitimizes recording decisions under uncertainty without pretending they are final. A Proposed record with Confidence: low is an honest state; hiding it behind a generic "Accepted" is not.

### Rules

- New entries at the **top of their section** (most recent first) — within WIP section and within the main log
- Records in the main log are append-only. Never modify or delete existing entries in the main log.
- Never change wording of past Accepted entries
- If a decision is superseded — add a new entry with Status: Accepted (or Proposed) referencing the old one via "Superseded by" in the old entry's Status field. Do not edit the old entry's other fields.
- WIP records **are** mutable — they may be edited, merged, or deleted during iteration. They do not follow append-only.

---

## 8. Decision Lifecycle and Stabilization

Knowledge records — especially decisions — have a natural lifecycle during iterative work. Trying to record every intermediate choice as a final ADR clogs the log with SUPERSEDED entries; trying to wait until everything stabilizes loses context along the way. The WIP section in Section 7 exists to handle this.

### The four states

```
WIP ──→ Proposed ──→ Accepted
                       │
                       ↓ (when replaced)
                   Superseded
```

- **WIP** — record lives in the `## Active iterations (WIP)` section of `decisions.md`. Exists only during active iteration on the underlying problem. Mutable.
- **Proposed** — record has been moved to the main log. Decision is made but not yet battle-tested. Append-only from here.
- **Accepted** — validated by actual use. Most stable state. Append-only.
- **Superseded by [date]** — later decision replaced this one. Original record stays untouched in the log; the superseding record is a separate entry that points back.

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

Stabilization is the act of moving WIP records into the main log. It has two triggers:

**Trigger 1 — Manual (primary).** Vasily says "стабилизируй knowledge", "закрой итерацию", or equivalent. The AI model runs the stabilization procedure on `decisions.md § Active iterations`.

**Trigger 2 — Automatic reminder (secondary).** When the AI model detects Vasily is switching to a different major task (new unrelated topic after 5+ prompts on the current one, explicit phrases like "перейдём к другому" / "теперь другая задача"), and there are unresolved WIP records in `decisions.md` — the AI model reminds: «В `decisions.md § Active iterations` остались N WIP-записей. Стабилизировать перед переключением?» This is a reminder, not automatic execution — Vasily decides whether to run the procedure or defer.

**Procedure — one question per WIP record:**

1. Read each WIP record in `decisions.md § Active iterations`
2. Ask Vasily for its outcome: **Accept / Supersede / Discard**
   - **Accept** — move to main log with Status: Accepted (or Proposed, if not yet battle-tested). Confidence is reassessed based on what is now known.
   - **Supersede** — a later choice made this record obsolete. Move to main log with Status: Superseded by [date of replacement]; create the replacing record separately with Status: Accepted or Proposed.
   - **Discard** — the WIP record was a hypothesis that did not pan out. Delete it — do not preserve history of every rejected hypothesis. The main log is for things that mattered, not every branch explored.
3. Update `INDEX.md` modification date for `decisions.md`
4. Confirm the WIP section is empty (or only contains still-active WIP records if some iterations are not yet closed)

### Why Discard is legal

Classical ADR practice is strictly append-only and forbids deletion. This skill is less strict for WIP specifically: WIP records that turn out to be dead ends are not history, they are scratch work. Preserving every "we tried X for 2 hours, abandoned it" clutters the log without informing future readers. The main log's append-only rule begins at Proposed — that is the point where a record becomes history.

---

## 9. Content Preservation Rule

**Absolute principle.** No existing wording outside the explicitly agreed change scope is edited — not "for clarity", not "for consistency", not "while I'm here". The agreed scope may cover several places, but each must be named explicitly before the edit begins. If during the work it becomes visible that another place needs changing too — stop and get agreement, do not silently modify it.

This rule is absolute. "The meaning is preserved" is not a valid justification: meaning is not judged by the editor, it is judged by whether the text itself is preserved. "I only shortened it a little" — after 5 iterations becomes a different text with different meaning. This is the "broken telephone" effect the rule exists to prevent.

**Why there is no list of "allowed techniques":** any such list becomes a loophole. "I rephrased, but it's within the allowed list" — and over several edits the text drifts. The only safe rule is: outside the agreed scope, wording is not touched.

**Illustrative example of the risk.** Shortening "Не стоит этого делать" to "Не делай это" looks harmless — meaning preserved, two words saved. But in another context the same kind of shortening loses tone, removes a hedge that was load-bearing, or drops a qualifier that someone relied on. Over 3–5 iterations of such "harmless" edits the original text is gone. This is why the rule applies to the act of editing, not to judgments about whether a specific edit "mattered".

**Practical consequence.** When updating a knowledge file: identify the exact scope of what must change, change only that, leave every other line untouched. If you catch yourself "improving" an adjacent sentence — that is a violation, regardless of how much better the new version reads.

**Agreed scope can be multi-point.** The rule does not forbid changing several places at once — it forbids changing places that were not agreed. If the agreement says "update sections 3 and 5", both sections are in scope. If it says "update section 3", section 5 is out of scope even if it looks related.

---

## 10. Update Protocol — Two Triggers

### Trigger 1: After every Code Agent prompt
As part of Acceptance Criteria (already in prompt template):
- Update knowledge files that reflect changes made in the prompt
- Add to decisions.md if an architectural decision was made
- Update @updated date and @lines count in every modified file's header
- Update INDEX.md section headers column for any modified file

### Trigger 2: End of work session
Before closing the chat — review what was done in the session and update:

| What happened | Where to update |
|---------------|----------------|
| Infrastructure changed | infrastructure.md |
| New files or patterns added | architecture.md |
| New RULE discovered | rules.md |
| Architectural decision made | decisions.md |
| Task completed or added | roadmap.md (Completed / Open Tasks) |
| **Always** — session happened | **roadmap.md → Recent Activity (new entry on top, format per Section 6)** |
| Any of the above | INDEX.md (dates) |

**The Recent Activity entry is mandatory at end of session** — even if no code changed. An exploratory or planning-only session still produces an entry: what was discussed, what was decided, what to pick up next session. This is what enables the Session Start Ritual (Section 11.6) to work.

If updates were already done prompt-by-prompt — verify they are complete and accurate.
If the session was exploratory (no code changes) — still add the Recent Activity entry, and update decisions.md with key conclusions if any.

---

## 11. Anti-Duplication Rule

**Before creating any new knowledge file — check INDEX.md first.** Scan existing files and their section headers for overlapping topics. If the topic fits within an existing file — add a section there, do not create a new file.

**Duplication signals to watch for:**
- Proposed filename is a synonym of an existing one (`auth.md` vs `authentication.md`, `api.md` vs `endpoints.md`)
- The topic already has a section header in an existing file's registry
- The content would split naturally across two existing files — means it belongs in whichever is primary, with a cross-reference in the other

**When in doubt — extend an existing file rather than create a new one.** New files are justified only when:
- The topic is genuinely new and does not fit any existing file
- An existing file would exceed 200 lines after adding this content
- Splitting an overgrown file into two coherent halves (follow Section 9 Content Preservation rules)

**Cross-file references:**
When a fact relates to content in another knowledge file, reference it rather than duplicating. The source of truth lives in one place. Full cross-linking system (six link types, when to link, format) — see Section 11.5.

---

## 11.5. Cross-Linking System

Knowledge gains value not just from individual files but from the connections between them. A decision references the rule it produced; a rule references the code where it lives; a session entry references the commit that ships its work. These links let a future reader (human or AI model) trace context without reading everything.

This section defines the linking system: six link types, one universal format, clear criteria for when a link earns its place.

### Universal format

All cross-links use markdown link syntax: `[visible text](target)`.

This is human-readable, Code Agent-readable, and requires no toolchain. Wikilinks (`[[file]]`) are deliberately avoided — they're tied to Obsidian-specific tooling and we don't have a graph view to benefit from them.

"Wiki-like" means a navigable folder structure, folder README/router pages, markdown links, and ADR files. It does not mean switching to Obsidian-only `[[wikilink]]` syntax.

### Six link types

**1. Link to a knowledge file (most common).**
```
[см. rules.md → Auth section](knowledge/rules.md#auth)
[см. infrastructure.md](knowledge/infrastructure.md)
```
Use anchor (`#section-id`) when pointing to a specific section. Omit when pointing to the file as a whole.

**2. Link to a skill.**
When referencing a procedure or standard fully defined in a skill:
```
(см. skill knowledge-structure → Section 6)
```
Plain-text reference is sufficient — clickable URL is not required for skills since their canonical location may vary by environment. The reader (and Code Agent) understands what to look up.

**3. Link to project code — by symbol, not line number.**
```
[ProducersMixin.get_producers()](src/api/client_producers.py)
```
Reference the function, class, or module name plus the file path. Never reference by line number — line numbers shift on every edit and the link goes stale silently. If the exact location must be pinned to a specific moment in time, append a commit SHA: `[client.py @ a3f12b8](src/api/client.py)`.

**4. Link to git commit or PR.**
GitHub-standard syntax — Code Agent recognizes it natively:
```
commit `a3f12b8`
PR #42
fixes #15
```
No need to construct full URLs — short SHA and `#N` notation are enough for any Git tool to resolve.

**5. Link to a decisions.md entry (ADR cross-reference).**
```
[ADR 2026-04-25 — OAuth choice](knowledge/decisions.md#2026-04-25-oauth-choice)
```
Inside `decisions.md` itself, when one entry supersedes or relates to another, this link is mandatory (already required by Section 7 — `Superseded by [link]`).

**6. Link to a chat session — optional, no URL.**
```
(session: 2026-04-25)
```
Date as a marker for `conversation_search` if the past discussion needs to be retrieved. A clickable platform chat URL is added only when Vasily explicitly asks for one — those URLs are useful only to him personally and clutter the file otherwise.

### When to link

Not every mention of another file deserves a link. The criterion is reader value: would a future reader (or future AI session) want to follow this link to verify or continue work?

**Link is mandatory when:**
- A fact in one knowledge file is the source of truth for a fact mentioned in another (e.g., rules.md mentions a RULE that originated from a decision — link to that decision).
- A `decisions.md` entry references the code or commit that implements it.
- A Recent Activity entry in roadmap.md references an ADR, RULE, or commit produced in that session.
- Inside `decisions.md`, when an entry supersedes, replaces, or is consequence of another entry.

**Link is optional (use when helpful) when:**
- Referencing a skill that fully describes a procedure mentioned briefly here.
- Pointing to a code symbol that the reader is likely to want to open.
- Cross-referencing related but independent decisions.

**No link needed when:**
- The mention is self-contained in context (e.g., "run `pm2 restart`" doesn't need a link to PM2 docs).
- The reference is to something already obvious from context (e.g., the file you're reading mentions itself).
- Adding the link would clutter prose without adding value.

### Direction principle

Links flow from **newer** record to **older** record. A new entry references the older context it builds on; the older entry is not edited (Content Preservation, Section 9).

The one exception is supersedence: when an old ADR is replaced, the old entry's `Status:` field gets updated to `Superseded by [link to new ADR]`. This is allowed because Section 7 explicitly permits it — supersedence updates a status field, not the body of the past record.

Backlinks (the older record automatically knowing it's referenced) are not maintained. For our scale this complexity is not justified — and Obsidian-style automated backlinks would require tooling we don't run. If a link genuinely needs to work both ways, write it explicitly in both files at creation time.

### Link integrity

When a knowledge file is moved, renamed, or has a section renamed — links pointing at it become stale. There is no automated check; this falls under end-of-session integrity review (Section 13).

---

## 11.6. Session Start Ritual

When opening a new chat session for a project, before any work — read these three files in order:

1. **Main project context file (`CLAUDE.md` or equivalent)** — universal rules and Execution discipline. Always.
2. **knowledge/INDEX.md** — registry of what files exist and what's in them.
3. **knowledge/roadmap.md** — active sections only (Open Tasks, In Progress, Recent Activity, Completed, Technical Debt). Do not read `roadmap-archive-N.md` files unless investigating a specific historical question.

These three files are the minimum context for a useful start. They tell you: what the project's hard rules are (main project context file), where things live (INDEX.md), where work stopped and what comes next (roadmap.md → Recent Activity + In Progress).

**After reading these three — and only after — proceed to the actual task.** Open additional knowledge files only when the current task requires them, guided by INDEX.md section headers.

This ritual exists because the previous default — reading everything, or guessing context from past chats — was either wasteful or unreliable. Three compact files, read every session, give predictable context entry without flooding the working set.

If `roadmap.md` does not yet exist for this project (or the Recent Activity section is empty) — note this and ask Vasily where work stopped. Do not fabricate context.

---

## 12. Stale Information Protocol

Knowledge files accumulate facts that can become incorrect over time. A fact that was true six months ago may no longer match reality.

**When a fact is discovered to be stale (no longer true):**

1. **Do not silently rewrite it.** The Content Preservation Rule (Section 9) still applies — but staleness is a legitimate reason to update, if handled openly.
2. **Update the fact in place** with the new correct information.
3. **If the change is significant** (was a rule, a decision, or an architectural fact) — add an entry to `decisions.md` explaining: what was thought before, what is now known, why it changed. This creates an audit trail.
4. **Bump `@updated` date and `@version`** in the file header.

**When a fact is no longer relevant (not wrong, just obsolete — e.g. deprecated feature removed):**
- Delete the fact, don't comment it out.
- If the deletion is non-trivial — note it in `decisions.md` with rationale.

**Never:**
- Leave known-wrong information in knowledge "because removing it feels destructive"
- Add contradictory facts without resolving the contradiction
- Use vague hedges ("may be", "possibly") to avoid committing — either the fact is true or it isn't; if unknown, mark it `@todo: verify`

**Periodic review:** At the end of a work session, if any fact was touched tangentially and its currentness is in doubt — flag it with an `@todo: verify` inline comment. Do not rewrite on suspicion alone.

---

## 13. INDEX Integrity Check

`INDEX.md` is the single navigation point for the entire knowledge base. If it drifts from reality, every future session reads the wrong files or misses relevant ones.

**Integrity check — run at end of session when any knowledge file was modified:**

1. For every file listed in INDEX — verify the file still exists at that path.
2. For every file that exists in `knowledge/` — verify it is listed in INDEX.
3. For every file, verify the "Section Headers" column matches actual H2 headers in the file (no missing, no extra, no renamed).
4. For every file modified in this session, verify the "Updated" column shows today's date.
5. **Cross-link integrity** (per Section 11.5): for every file modified in this session, scan its outgoing markdown links. Verify each link target still exists — file path resolves, anchor `#section-id` matches an actual H2 header in the target. If a link is stale because the target was renamed in the same session — fix the link. If the target itself was deleted — replace the link with plain text or remove it, do not leave a broken link silently.

**Inconsistencies found — fix immediately in the same session.** Do not defer INDEX fixes to "next time" — by next session the drift compounds.

**Treat INDEX as source-of-truth contract:** if a file exists but is not in INDEX, the file is effectively invisible to future sessions. If INDEX lists a file that doesn't exist, future sessions will waste time searching for it.

**If INDEX is split (router + sub-indexes, see Section 4):** the integrity check covers the whole system — router + every sub-index. Every sub-index listed in the router exists; every `INDEX-*.md` in `knowledge/` is listed in the router; every file in `knowledge/` appears in exactly one sub-index (no orphans, no duplicates).

**If knowledge uses thematic folders:** the integrity check covers the router, every folder README or sub-index, every ADR file, and every runbook. Anti-duplication applies across folders: a file must have one canonical home, with markdown cross-links from related folders instead of duplicated content.

---

## 14. How the Code Agent Reads knowledge/

**Correct reading sequence:**
1. Read the main project context file (`CLAUDE.md` or equivalent) — universal rules, always
2. Read knowledge/INDEX.md — understand what files exist and what sections they contain
3. Read only the specific file(s) relevant to the current task

**If INDEX is split (Section 4):** the sequence becomes main project context file (`CLAUDE.md` or equivalent) → INDEX.md (router) → the relevant `INDEX-*.md` sub-index → the specific file. If the task spans two themes, read both relevant sub-indexes — but not all of them by default.

**If knowledge uses thematic folders:** the sequence becomes main project context file (`CLAUDE.md` or equivalent), then `knowledge/INDEX.md` router, then relevant folder `README.md` or sub-index, then the specific knowledge file, ADR, or runbook. Read only the folders relevant to the task.

**Do not** read all knowledge files at session start.
**Do not** skip INDEX.md and guess which files exist.
**Do** use INDEX.md section headers to determine which file to open.

**Example:** Task is to fix a payment bug.
→ Read rules.md (payment rules section) + infrastructure.md (DB details).
→ Do not read roadmap.md or decisions.md.

---

## 15. Creating knowledge/ for a New or Existing Project

**Step 1 — Audit sources**
Read all existing documentation: current main project context file (`CLAUDE.md` or equivalent), any docs/ files, README,
comments in code. Do not start writing until all sources are read.

**Step 2 — Plan the file set**
Based on project complexity, decide which files are needed beyond the mandatory 5.
Present plan to user before creating files.

**Step 3 — Create files one prompt at a time**
Maximum 1 file per Code Agent prompt. Maximum 2 if both files are small and
tightly coupled. Never batch all knowledge files into one prompt.

Order: main project context file (`CLAUDE.md` or equivalent) first → INDEX.md second → knowledge files one by one.

**Step 4 — Delete old documentation**
After all content has been transferred to knowledge/ — delete the old source files
(old main project context file content replaced, docs/ files removed). Verify nothing was lost.

**Step 5 — Verify INDEX.md**
Check that section headers in INDEX.md match actual H2 headers in each file.
