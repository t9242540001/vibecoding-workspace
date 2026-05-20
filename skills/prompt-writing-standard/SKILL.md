---
name: prompt-writing-standard
description: Complete workflow and template for writing Claude Code prompts. Use this skill whenever you are about to write a prompt for Claude Code — before composing any prompt for code execution, feature implementation, bug fixes, refactoring, or documentation updates. This skill is mandatory reading before every Claude Code prompt, not optional.
---

# Prompt Writing Standard
<!--
  @file:        skills/prompt-writing-standard/SKILL.md
  @description: Complete workflow for writing Claude Code prompts
  @version:     3.7
  @updated:     2026-05-19
-->

---

## 1. Architecture

Vasily (task) → Claude (strategy + prompt) → Claude Code (execution) → Git (auto-merge claude/** → main) → Vasily (deploy on server)

Claude Code works only with the repository. No server access. Logs, process states, DB contents — all obtained through Vasily, who runs commands and sends output.

---

## 2. Prompt Workflow

Complete sequence from task to prompt. Every step is mandatory.

**Step 1 — Self-directed questions.**
Apply the standard self-directed questions from system instructions before any action.

**Step 2 — Determine task type AND complexity tier.**

Two orthogonal axes — both must be classified before proceeding.

**Axis 1 — Complexity tier** (per system instruction "Триаж сложности" and STANDARDS Section 1.2):

- **T1 — Trivial.** Unambiguous interpretation, single file, minimal change, no UX/logic/architecture impact. Examples: button text change, README typo, log message tweak.
  Workflow: skip Steps 4 (Socratic), 7 (plan approval), 8a (brief approval), 9 (multi-perspective review), 10 (review summary). Go from Step 2 directly to Step 6a/6b (read knowledge + file), then Step 8b (write the prompt) and present.
- **T2 — Standard.** 1–2 valid interpretations, several files, touches UX or logic without architectural impact. Examples: add a tool to existing product, fix a bug with clear symptom, update message format.
  Workflow: full sequence Steps 1–10 as described below. This is the default path.
- **T3 — Strategic.** Long-term consequences, series of 3+ prompts, non-obvious tradeoffs, high cost of reversal. Examples: dashboard + spec, payment provider choice, DB migration, anonymization strategy.
  Workflow: `research-protocol` skill runs FIRST (4 phases with premortem), then each prompt in the series follows full Steps 1–10. T3 is never a single prompt.

If complexity tier is unclear — ask Vasily one line ("Это T2 или T3?") with the reason. Do not guess.

If during work the task expands from T2 to T3 — stop, return to `research-protocol`.

**Axis 2 — Task type** (determines internal workflow within the chosen tier):
- **Bug fix** → Step 3 (diagnostics) mandatory
- **New feature** (doesn't touch existing code) → skip Step 3
- **Refactoring** → Step 3 mandatory, extra care on regression shield
- **Documentation-only** (knowledge/*.md update, no code changes) → skip Steps 3, 5, 6b. Step 6a still required (read INDEX + the file being edited). Go directly to Step 7 after.

**Step 3 — Diagnostics (for bug fixes and refactoring only).**
Apply the diagnostics protocol from system instructions. No fix prompt without diagnostics data.

**Step 4 — Socratic questions.**
Mandatory before writing prompts when the task is ambiguous or affects UX/business logic. Apply the Socratic method from system instructions.

**Step 5 — Identify affected files.**
Include files the new code will interact with, not just files being changed. New files can duplicate, depend on, or conflict with existing ones.

**Step 6a — Read knowledge context. BLOCKING RULE.**
Before reading code files and before writing the prompt, the model MUST read the project's knowledge context. No prompt is written without verified knowledge context — same blocking logic as for code files in Step 6b.

**Mandatory reads:**

1. **Project's `CLAUDE.md`** — project constitution: stack, critical rules (max 5), deploy commands. This is the base frame for any prompt.

2. **`knowledge/INDEX.md`** — map of knowledge files: what is where, when last updated. Used to determine which knowledge files are relevant to the current task.

3. **Relevant `knowledge/*.md` files** — selected via INDEX. Minimum: those describing modules/components affected by the task. For architectural tasks — read all main ones.

4. **`knowledge/decisions.md`** (if it exists in the project) — architectural decisions log. Goal: do not propose a prompt that contradicts a previously fixed decision.

5. **`knowledge/universals/*.md`** — universals registry. Read the thematic files relevant to the task scope (e.g. `components.md` for UI work, `engines.md` for backend modules, `text-patterns.md` for any user-facing copy). This is the data source for Checkpoint 1 in Step 7 — without it, the plan cannot state reuse decisions. If the project has no `knowledge/universals/` folder yet, the skill `universality-discipline` Bootstrap procedure (Section 5) runs as part of the current work.

**Why this matters:**
- The REGRESSION SHIELD block in the prompt template requires "critical rules for this project" — these come from CLAUDE.md and knowledge, otherwise the block is empty or fabricated.
- The domain expert in Step 9 cannot fully review the prompt without knowing project decision history.
- Without knowledge, the model works "from scratch" every session, discarding accumulated project context — defeating the purpose of the knowledge system.
- Conflicts with already-made decisions are caught BEFORE writing the prompt, not after execution.
- Without `universals/*.md`, every new feature defaults to building from scratch instead of reusing — the failure mode this whole skill set exists to prevent.

**Not accepted:**
- Knowledge file summaries from Vasily — only full reads via file MCP or AI Knowledge Base MCP.
- "I remember this project from a past session" — context does not persist across sessions, knowledge must be re-read.
- Skipping decisions.md because "the task is small" — even simple prompts can contradict architectural decisions.
- Skipping `universals/*.md` because "this is just a small component" — small components are exactly what the registry exists to consolidate.

**Exception:** For `Documentation-only` task type updating a single knowledge file — reading only that file plus `INDEX.md` is sufficient.

**Related skills:**
- When creating or updating knowledge files in this prompt, apply the rules from skill `knowledge-structure` — in particular Section 9 (Content Preservation) and the rules for anti-duplication, stale information, and INDEX integrity. Read `knowledge-structure` SKILL.md before writing any prompt that touches knowledge files.
- When the task creates or affects any technical or design unit (components, engines, tools, design tokens, text patterns, forms), apply the rules from skill `universality-discipline`. Read its SKILL.md before formulating the plan in Step 7 — the plan must state explicit reuse decisions for each candidate unit.
- When the task produces any plan, brief, prompt, ADR, knowledge entry, or review summary, apply the rules from skill `anti-hedging-language` — every hedging phrase ("possibly", "later", "should work", "not critical", "не должно", "возможно") becomes a self-directing question about knowing, searching, or deferring. Read its SKILL.md before writing the plan in Step 7.
- When the task creates or modifies runtime behavior (feature, fix, refactor with logical change, schema migration, API contract change, integration, calculation, validation, parsing), apply the rules from skill `real-path-verification` — mental simulation before delivery, forward thinking on 1-2 step harmful consequences with industry best-practice redesign, real-path verification inside the prompt where access allows, and explicit verification handoff to Vasily for prod-side checks. Read its SKILL.md before formulating the plan in Step 7.

**Step 6b — Read code file contents. BLOCKING RULE.**
Request and read FULL actual content of every affected file identified in Step 5. Summaries like "this file contains..." are not accepted. No prompt without verified file contents. No exceptions.

**Related skill:** When the prompt creates or modifies code files, apply the rules from skill `code-markup-standard` — file headers, function documentation, region comments, inline tags, RULE comments, and the rules hierarchy. Read `code-markup-standard` SKILL.md before writing any prompt that touches code.

**Step 7 — Write the plan.**
Four elements in plain language:
- What we're doing: one sentence
- Why: one sentence
- How: numbered steps, one sentence each
- What we're NOT touching: list

**Forward-thinking Checkpoint — mandatory within the plan.**
Every decision in the "How" list above must carry a one-line *1-2 step consequences* note. The note states what was actively searched for as harmful downstream effects (per `real-path-verification` Section 5 — system layer, neighbour-system layer, user layer) and what was found. If harm was found, the note also states which industry best-practice was used to redesign the decision so the harm is gone (feature flag, graceful degradation, backward-compatible change, adapter pattern, deprecation path, and similar — see `real-path-verification` Section 5 "Searching for the best practice").

The plan is rejected if a decision lacks a consequences note. "No consequences found" is not legitimate — it means the looking was not done, not that consequences do not exist. See `real-path-verification` Section 5.

**Universality Checkpoint 1 — mandatory within the plan.**
For every technical or design unit the task creates or affects (as classified by `universality-discipline` Section 2 scope), the plan must state an explicit reuse decision in one of three forms:

- *"Use existing X from `universals/<file>.md`. Adaptation via parameters: [list]."* — an analog is registered, the prompt will reuse it.
- *"No analog in registry. Creating new universal. Will add entry to `universals/<file>.md` with adaptation parameters: [list]."* — nothing fits, a new universal is being created and will be registered immediately.
- *"Existing X almost fits but [reason]. Need Vasily's decision: extend via parameters, or create parallel universal?"* — STOP within the plan, do not resolve silently. Wait for Vasily.

The plan is rejected if it creates or affects a universal-scope unit without stating one of these three forms. Silent invention is forbidden.

User approves or corrects. Prompt is written only after approval.

**Step 8a — Prompt Brief (in Russian).**
Before writing the prompt, produce a numbered brief in Russian for Vasily's review. Format:

```
### Бриф промта

1. **Цель:** [одно предложение — что должно быть достигнуто после выполнения промта]
2. **Задачи:**
   - [конкретная задача 1]
   - [конкретная задача 2]
   - [...]
3. **Стейкхолдер / целевая аудитория:** [кто заинтересован в результате — пользователь сайта, администратор, бизнес-процесс, API-потребитель и т.д.]
4. **Что будет в промте:** [краткое описание: какие файлы затрагиваются, какая логика, какие ограничения]
5. **Что НЕ входит:** [явно указать, что за рамками этого промта]
6. **Критерий успеха:** [как Василий поймёт, что задача выполнена — одно-два предложения]
```

Vasily approves or corrects the brief. Prompt is written only after brief approval.

**Step 8b — Write the prompt** using the template below.

**Universality Checkpoint 2 — mandatory right before writing.**
Just before writing the prompt body:

1. Re-read the relevant `knowledge/universals/*.md` files. The registry may have been updated between plan approval and now.
2. If a new analog appeared since Step 7, adjust the prompt to use it. If the adjustment changes scope beyond the approved plan, escalate to Vasily.
3. Inject reuse references into the prompt's CONTEXT, REGRESSION SHIELD, and ACCEPTANCE CRITERIA blocks as specified in Section 3.

Verify: all 4 blocks present, English language, single task. The prompt must match the approved brief from Step 8a and include the Universality Checkpoint 2 references in the three blocks named above.

**Step 9 — Multi-perspective review. MANDATORY — NO EXCEPTIONS.**
This step is a blocking gate. A prompt CANNOT be presented to Vasily without completing all three reviews below. Skipping this step — even partially — is equivalent to delivering an unfinished prompt. If you wrote the prompt in Step 8b, you MUST immediately proceed to this review before any output to the user. Each perspective produces 1–3 findings (or "no issues").

| Perspective | Role | What to check |
|---|---|---|
| **Stakeholder** | The person/system from Step 8a line 3 | Does the prompt deliver what the stakeholder actually needs? Are edge cases for their workflow covered? Will the result be usable without rework? |
| **Technical** | Senior developer + security engineer | Code correctness: types, imports, race conditions, error handling. Security: env variables exposed? Input validation? SQL injection / XSS? Dependencies pinned? Regression shield adequate? Knowledge updates: are knowledge-AC checkboxes present, or is there an explicit statement "knowledge update not required — reason: …"? Silent omission is an error. |
| **Domain expert** | Depends on task type (see table below) | Domain-specific quality, standards compliance, professional norms |

Domain expert selection:

| Task involves | Expert role | What they check |
|---|---|---|
| UI text, content, copywriting | Editor / copywriter | Tone, clarity, grammar, audience fit |
| Legal, compliance, terms | Lawyer | Legal accuracy, liability, regulatory compliance |
| Financial calculations, reports | Accountant / financial analyst | Formula correctness, rounding, tax rules |
| Marketing, SEO, conversion | Marketing specialist | Messaging effectiveness, CTA clarity, SEO practices |
| API design, architecture | System architect | Contract consistency, versioning, scalability |
| Database, queries | DBA | Query performance, indexing, data integrity |
| DevOps, infrastructure | SRE / DevOps engineer | Reliability, monitoring, rollback strategy |
| UX, user flows | UX designer | Usability, accessibility, flow completeness |
| Pure code (no special domain) | Code reviewer | Readability, naming, patterns, test coverage |

If the task spans multiple domains — include multiple experts. Maximum 3 expert perspectives total per review.

**Mandatory question for every reviewer (all three perspectives).**
In addition to the perspective-specific checks above, every reviewer MUST explicitly answer this question within their own area of responsibility:

> *"Check the prompt for omissions, logical errors, and possible contradictions within your area of responsibility."*

Each reviewer stays strictly within their role — the technical reviewer does not check editorial style, the lawyer does not check code, the editor does not check architecture. But within their domain, each one actively searches for:
- **Omissions** — what is missing from the prompt but should be present
- **Logical errors** — internal inconsistencies in reasoning, requirements, or flow
- **Contradictions** — conflicts between prompt blocks (CONTEXT vs TASK vs ACCEPTANCE CRITERIA), or with existing project rules

This question is not optional and not replaceable by the checklist above — it must be answered explicitly by each of the three reviewers.

**Mandatory scope integrity check** (answered by the Technical reviewer, explicitly, in addition to the question above):

> *"Are you sure the prompt does not let Claude Code change anything outside the explicitly declared scope? Walk through the prompt and verify: does the REGRESSION SHIELD block specify exactly what stays untouched within the modified files? Are all the places Claude Code might be tempted to 'improve' — adjacent sections, nearby comments, related functions, neighboring rules — explicitly named as out of scope? If the prompt permits silent edits to adjacent wording, terminology, rule severity, or examples — that is an error ❌, not a warning ⚠️. 'Claude Code will probably not touch it' is not sufficient; the prompt must make it impossible."*

This check is the primary defense against the broken-telephone drift described in `knowledge-structure` Section 9. A prompt that passes all other checks but leaves scope ambiguous still fails Step 9.

**Mandatory universality check** (answered by the Technical reviewer, explicitly, in addition to the questions above):

> *"Does the prompt create or affect any technical or design unit without an explicit reuse decision? Walk through CONTEXT, TASK, REGRESSION SHIELD, ACCEPTANCE CRITERIA — are all candidate units accounted for via 'Reuses: X from universals/<file>.md' (existing) or 'New universal added to universals/<file>.md' (new) or an explicit Vasily-approved deviation? Silent creation of a parallel variant that bypasses the registry is an error ❌, not a warning ⚠️."*

**Mandatory hedging check** (answered by the Technical reviewer, explicitly, in addition to the questions above):

> *"Read through CONTEXT, TASK, REGRESSION SHIELD, ACCEPTANCE CRITERIA, and the review summary. Find every hedging phrase — 'possibly', 'probably', 'likely', 'later', 'minimum for now', 'should work', 'should not break', 'if anything', 'in most cases', 'не должно', 'возможно', 'для начала', or equivalents. For each one, ask: is this knowledge with evidence, honest unknown with a concrete next step, or hidden deferral? Hidden deferral — softening that releases the author from action without an artefact to track it — is an error ❌, not a warning ⚠️. Tonal hedging that does not change next actions is OK. Honest unknown without a concrete next step (the 'I do not know AND must learn through X' formula from `anti-hedging-language` Section 4) is ⚠️."*

This check is the primary defense against the silent-deferral failure mode described in `anti-hedging-language`. A prompt that passes all other checks but contains hidden deferrals still fails Step 9.

**Mandatory real-path scenario check** (answered by the Stakeholder reviewer, explicitly, in addition to the question above):

> *"Walk through the prompt and identify the real-path scenario it must support — not the happy-path mock, not the unit-test fixture, but the actual workflow a real user or real system will hit on production. Is that scenario covered by the prompt's TASK and ACCEPTANCE CRITERIA? Is it covered by the REAL-PATH VERIFICATION block (Section 3 template)? If only the happy-path mock is covered while the real-path scenario is missing or hand-waved — that is an error ❌, not a warning ⚠️. The prompt must either cover the real path or explicitly state which real path is deferred to a future prompt with a tracked artefact."*

This check is the primary defense against shipping features that pass tests but fail on production data, the failure mode `real-path-verification` is built to prevent.

**Mandatory mental-simulation check** (answered by the Technical reviewer, explicitly, in addition to the questions above):

> *"Did mental simulation run on the relevant calculations, control flow branches, and obvious edge cases of the code being written by this prompt (per `real-path-verification` Section 4)? Is the Mental Simulation note present in the prompt's ACCEPTANCE CRITERIA (or planned as a commit-message line by Claude Code)? If the prompt's task includes any calculation, parsing, control flow with multiple branches, or state machine — and there is no Mental Simulation note required by the prompt — that is an error ❌, not a warning ⚠️. Mental simulation that says 'ran in my head, looks fine' without naming what was traced is not the note (per `real-path-verification` Section 11 pattern 6) — it must state the inputs and the result."*

This check is the primary defense against the "green tests, shipping" pattern that `real-path-verification` Section 11 names as recurring wrong shape.

Format each review as:
```
#### Проверка: [Role Name]
- ✅ [что хорошо — кратко]
- ⚠️ [замечание — что и почему] (если есть)
- ❌ [ошибка — что и почему] (если есть)
```

**Step 10 — Review summary, mandatory fixes, and final version.**
After all three perspectives are checked:

1. Produce a summary in Russian. Write the summary in semantic, plain language — describe what was found in your own words, not in technical jargon. Vasily must understand the logic of what was checked and decided without parsing technical terminology. Format:
```
### Резюме проверки
- **Найдено ошибок (❌):** [число]
- **Найдено замечаний (⚠️):** [число]
- **Что найдено:** [своими словами, что именно ревьюеры обнаружили — без технических терминов]
- **Принятые решения:** [список — что исправлено и почему]
- **Осознанно оставлено:** [список — что замечено, но не исправляется, с обоснованием]
- **Verification status:** `coded` / `pending-verification` / `verified` — [one-line reason]
```

Every item in **«Осознанно оставлено»** must satisfy one of two conditions:

- **(a)** Link to a concrete artefact where the deferred work is tracked — a task file under `knowledge/roadmap/tasks/`, a WIP ADR under `knowledge/decisions/`, or a discovery entry under `knowledge/discovery/`. The link makes the deferral real and recoverable.
- **(b)** Explicit phrase **«Vasily explicitly chose to defer — see chat context»** with one sentence stating why deferral was chosen.

Items lacking both (a) and (b) are not legitimate deferrals — they are silent deferrals (the failure mode `anti-hedging-language` is built to prevent). Such items must be either resolved within this prompt or escalated to Vasily for an explicit decision before the prompt is finalized.

The **Verification status** line is mandatory for prompts in scope of `real-path-verification` (Section 2). It states the closure criterion honestly — `coded` if code is written but real-path not yet verified, `pending-verification` if scenarios are handed off to Vasily but not yet confirmed, `verified` if real-path is closed. Out-of-scope prompts (pure documentation, mechanical fixes, infrastructure) state `completed — out of scope for real-path-verification` instead. Silent omission of this line is incomplete summary. See `real-path-verification` Section 7 for the three states.

The summary is mandatory. **Without this summary, Step 9 is considered incomplete** — the prompt is not ready to present to Vasily. Full review texts (the three perspectives in detail) are not output to chat by default — Vasily can request them explicitly if he wants to see the full reasoning.

2. **All ❌ errors MUST be fixed in the prompt immediately.** This is not optional. Do not defer fixes to "future prompts" or suggest Vasily handle them later. The prompt must leave Step 10 clean — with zero ❌ errors.

3. **All ⚠️ warnings MUST also be fixed in the prompt immediately.** Do not defer them or ask Vasily to handle them separately. Warnings are less severe than errors but still require correction before the prompt is finalized. If a warning genuinely cannot be fixed within this prompt's scope — state why explicitly and get Vasily's confirmation before proceeding.

4. **If fixes cause the prompt to exceed the one-file rule** (Section 6) — split into multiple prompts right here. Present the split as a numbered sequence, each prompt self-contained and following the template.

5. **Output the COMPLETE final prompt as a downloadable plain text file.** Do not output the prompt inline in chat mixed with commentary. Create a plain text file (`.txt`) containing only the prompt — title header (`# Prompt NN — [short title]`) and all 4 blocks (CONTEXT, TASK, REGRESSION SHIELD, ACCEPTANCE CRITERIA). No preamble, no review summary, no explanations inside the file — only the prompt text ready to paste into Claude Code. No extra formatting: no bold markers (`**`), no bullet decorations, no horizontal rules, no code fences around the prompt itself. Plain readable text. The review summary and any commentary stay in the chat message; the file contains the clean prompt and nothing else.

The prompt is ready for Claude Code only after Step 10 is complete and the full final version is presented.

---

## 3. Prompt Template

Four mandatory blocks plus a title header. A prompt missing any element is incomplete.

```
# Prompt NN — [short title, 2–5 words in English]

## CONTEXT
Project: [name]
Repository: [URL]
Affected files: [exact paths relative to repo root]
Reuses: [list of universals used in this prompt, with their location in the registry and the adaptation parameters being passed. Example: "PrimaryButton from universals/components.md — props: label='Сохранить', variant='default'; API error wrapper from universals/tools.md — no params". If the prompt creates a new universal, state: "Creates new universal: <name> → universals/<file>.md, Accepts: [params]". If the task touches no universal-scope units, state: "No universals affected."]
Current state: [what works, what's broken — based on collected data]

## TASK
[One task. Unambiguous wording. No room for interpretation.]

[TASK should be formulated as a goal with a verification criterion — not as a step-by-step instruction. "Add validation" → "Write a test for invalid input and make it pass". "Fix the bug" → "Write a test that reproduces the bug and make it pass". This lets Claude Code find the right algorithm itself rather than blindly executing prescribed steps. Goal-driven phrasing also produces stronger acceptance criteria — see ACCEPTANCE CRITERIA block below.]

## REGRESSION SHIELD — DO NOT TOUCH
Files not to modify: [list]
Functions/components not to modify: [list]

Within the modified file(s): only the change zone described in TASK is edited. All other content — sections, wordings, examples, terminology, rule severity, comments, numbering — stays exactly as it was. No "consistency fixes" to adjacent content. No rephrasing for clarity or style. No silent improvements. If adjacent content looks wrong, outdated, or inconsistent with the change being made — stop and ask, do not fix it in this prompt.

Rationale: unagreed edits to adjacent wording accumulate across iterations and silently change the meaning of the codebase and knowledge base over time. See `knowledge-structure` Section 9 (Content Preservation).

Universality shield: do not create parallel variants of universals already registered in `knowledge/universals/*.md`. Extensions of an existing universal are done via its declared adaptation parameters — never by forking a new variant for cosmetic differences. If a new case truly cannot fit via parameters (per `universality-discipline` Section 8 boundary cases), STOP and require a separate prompt with an explicit registry update. Forking silently is forbidden.

Critical rules for this project:
- [project-specific rule + consequence of violation]

Project-wide execution discipline (from `CLAUDE.md` Execution Discipline block — Karpathy-style behavioral rules): the standard 4–5 rules in `CLAUDE.md` (don't guess, simplicity test, surgical changes, goal-driven execution, sustainable solutions) apply to this prompt by default. They are not duplicated inline here — Claude Code reads them from the project's `CLAUDE.md` at session start. If any of those rules is especially load-bearing for this prompt — restate the relevant one explicitly here.

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

## ACCEPTANCE CRITERIA
[ ] [Task-specific check: specific action and expected result]
[ ] knowledge/*.md updated to reflect changes made in this prompt
[ ] If architectural decision was made → entry added to knowledge/decisions.md
[ ] INDEX.md updated (modification date of changed files)
[ ] If a new universal was created → entry added to `knowledge/universals/<file>.md` with file path, "Accepts" column populated with adaptation parameters, and `@universal` tag added to the source file's header
[+ applicable infrastructure checks — see Section 4]

Claude Code must report against each criterion after completion.
```

**REAL-PATH VERIFICATION block** — mandatory for in-scope prompts per `real-path-verification` Section 2. Out-of-scope tasks (pure documentation, mechanical fixes, infrastructure operations) may omit this block, stating the out-of-scope reason in the prompt's TASK block.

**Title header rules:**
- Format: `# Prompt NN — [short title]`
- `NN` — sequential number within the current series (01, 02, 03…). Single standalone prompt = `01`. Split sequence — continuous numbering `01` → `02` → `03`.
- Title — 2–5 words in English, describing the essence of the prompt (e.g. `Fix auth redirect bug`, `Add telegram webhook handler`, `Refactor price calculator`).
- The title makes prompts visually distinguishable in Claude Code history, so Vasily can track which prompts executed and which are still pending.
- The title is part of the prompt itself — it gets copied to Claude Code along with the 4 blocks, not kept as metadata outside.

---

## 4. Core Rules

### One prompt = one task
Multiple tasks → separate prompts, executed sequentially. Different logic types in different files = different tasks.

### Language
All prompts in English. RULE comments in code in English. Exception: content that must be in another language by nature (Russian UI text, bot messages) stays in target language.

### File verification is blocking
No prompt without reading actual file contents. Accept only full file output, never summaries. Applies to modifications and new files both.

### Regression shield in every prompt
Explicitly list what must NOT be touched: files, functions, behaviors. Claude Code tends to "improve" adjacent code — block this explicitly. Include critical project rules even if they seem unrelated to the current task.

After execution: ask Claude Code to confirm critical rules in affected files were not altered.

If the same error recurs after a fix — anchor the rule in code. Add a RULE comment directly next to the vulnerable code so Claude Code sees it on every future edit.

### File size limit — universal
All files — code, knowledge, CLAUDE.md — maximum 200 lines. If a file grows beyond 200 lines: split it. One file = one responsibility.

### CLAUDE.md content rule
CLAUDE.md is a project constitution, not a technical reference. It contains only:
- Project name + one-line description
- Stack (brief list)
- Critical rules (only those whose violation immediately breaks everything — max 5)
- Deploy commands
- Pointer to knowledge/INDEX.md

Everything else — technical details, file navigators, formulas, API references, roadmaps — belongs in knowledge/*.md.

### Code and knowledge file markup — see separate skill
All requirements for file headers, function documentation, region comments, inline operational tags, RULE comments, and knowledge file headers live in skill `code-markup-standard`. Read that skill alongside this one whenever a prompt creates or modifies any code file or knowledge file.

Key points enforced by `code-markup-standard`:
- Adaptive markup by file size (small files get minimal headers, large files get full structure)
- Language-specific syntax (TypeScript, Python, Go, Rust, YAML, SQL — all covered)
- Three places of rule storage and their hierarchy (`CLAUDE.md` → `knowledge/rules.md` → `@rule` in code)
- Dead code deletion (never commented out)
- No duplication of git metadata in headers

Every prompt that touches files must explicitly apply `code-markup-standard`.

### Universality discipline — mandatory
When a prompt creates or affects any technical or design unit (components, engines, tools, design tokens, text patterns, forms, identity — full scope in `universality-discipline` Section 2), the `universality-discipline` skill is mandatory. Two checkpoints are enforced within this prompt-writing workflow:

- **Checkpoint 1** runs inside Step 7 (plan formulation): every candidate unit gets an explicit reuse decision in the plan.
- **Checkpoint 2** runs inside Step 8b (just before writing the prompt): registry is re-read, reuse references are injected into CONTEXT / REGRESSION SHIELD / ACCEPTANCE CRITERIA.

The Technical reviewer in Step 9 verifies that no candidate unit slipped through without a registry decision (universality check). A prompt that creates a parallel variant of a registered universal without a stated §8 boundary reason fails Step 9 as ❌, not ⚠️.

Read `universality-discipline` SKILL.md before writing any prompt in scope.

### Anti-hedging discipline — mandatory
Every text produced during prompt writing — plan, brief, prompt itself, review summary, ADRs, knowledge entries — is subject to skill `anti-hedging-language`. Hedging language ("possibly", "probably", "later", "should work", "not critical", "minimum for now", "не должно", "возможно", "для начала") is a trigger for a self-directing question, not a stylistic choice to soften: does this hedge protect knowledge with evidence, an honest unknown with a concrete next step, or quiet deferral?

Three enforcement points within this prompt-writing workflow:

- **During Step 7 / Step 8a / Step 8b** — every hedge in the plan, brief, or prompt body is resolved into evidence, an explicit next step, or — only on Vasily's explicit defer — a tracked artefact in `knowledge/roadmap/tasks/` or `knowledge/decisions/`.
- **During Step 9 hedging check** — the Technical reviewer scans the prompt and review summary for residual hedging. Hidden deferral = ❌. Honest unknown without next step = ⚠️.
- **During Step 10 «Осознанно оставлено»** — every deferred item links to an artefact (a) or cites explicit Vasily defer (b). Silent deferral is not allowed in the summary.

A `low-confidence` ADR created as part of the prompt must include a "Next step to raise confidence" paragraph (per `anti-hedging-language` Section 7 and `knowledge-structure` integration), naming the concrete action that would move it to `medium` or `high`.

Read `anti-hedging-language` SKILL.md before writing any plan, brief, prompt, or review summary.

### Real-path verification — mandatory
When a prompt creates or modifies runtime behavior (feature, fix, refactor with logical change, schema migration, API contract change, integration, calculation, validation, parsing — full in-scope list in `real-path-verification` Section 2), the `real-path-verification` skill is mandatory. Four enforcement points within this prompt-writing workflow:

- **During Step 7 (plan)** — every decision carries a *1-2 step consequences* note that actively searched for harmful downstream effects. If harm was found, the redesign using an industry best practice is built into the current plan, not deferred (per `real-path-verification` Section 5).
- **During Step 8b (prompt body)** — the REAL-PATH VERIFICATION block (Section 3 template) is filled with concrete content across four subsections: what Claude Code verifies in the prompt, what mental simulation covers, what is handed off to Vasily, what is queued for the future AI test agent.
- **During Step 9** — Stakeholder reviewer verifies the real-path scenario is covered (not happy-path mock); Technical reviewer verifies the Mental Simulation note is present where required.
- **During Step 10** — review summary includes a mandatory line "**Verification status:** `coded` / `pending-verification` / `verified`" with one-line reason (per `real-path-verification` Section 7).

A prompt that creates or modifies runtime behavior without a filled REAL-PATH VERIFICATION block, or without a *1-2 step consequences* note for each decision, fails Step 9 as ❌.

Out-of-scope prompts (pure documentation, mechanical fixes with no behavior change, infrastructure operations) explicitly state the out-of-scope reason in their TASK block and omit the REAL-PATH VERIFICATION block accordingly.

Read `real-path-verification` SKILL.md before writing any plan, prompt, or review summary that involves runtime-behavior changes.

### Knowledge update rule — mandatory
Every prompt must explicitly assess: does this work produce new facts, rules, decisions, or structural changes that belong in knowledge? The assessment must result in one of three outcomes — not a vague "not applicable":

**Outcome 1 — Update now.** The prompt includes knowledge updates directly (AC checkboxes below). This is the default for any work that produces stable facts or decisions.

**Outcome 2 — Record as WIP.** The work produced a decision or fact, but the area is under active iteration and the decision may change within hours. The prompt adds a WIP entry to `decisions.md § Active iterations` (format per `knowledge-structure` Section 7). This is legitimate when: architecture is in flux, experiment is still running, multiple iterations are expected before stabilization. A WIP entry is real work — it captures context that would otherwise be lost. See `knowledge-structure` Section 8 for the full lifecycle (WIP → Proposed → Accepted).

**Outcome 3 — Truly not applicable.** The prompt did not produce any new facts, rules, decisions, or structural changes. The prompt states this explicitly with a concrete reason. Allowed reasons: purely mechanical fix (typo, formatting, dead code removal) that reveals no new system property, changes no behavior, and creates no precedent.

**Forbidden formulations:**
- "NOT applicable — ADR in separate prompt" → this is deferral disguised as inapplicability. Either record as WIP now (Outcome 2) or include the full update now (Outcome 1).
- "Knowledge update not required" without stating why → must give a concrete reason per Outcome 3.
- "Will update knowledge later" without a WIP entry → if later never comes, the knowledge is lost. At minimum, create a WIP entry now to prevent silent accumulation.

**Knowledge updates and the one-prompt-one-file rule:** updating `knowledge/*.md` alongside the primary code file does NOT violate the one-file rule (see Section 6). Knowledge updates are metadata about the change, not a separate task. A prompt that changes `src/parser.ts` + `knowledge/decisions.md` + `knowledge/INDEX.md` is one task (the code change and its documentation), not three.

Knowledge is updated whenever there is something to add or change — judged by content, not by the size of the code change. A one-line fix that reveals a new fact about the system requires the same knowledge update as a large feature.

Required AC checkboxes (included in template when knowledge updates apply):
```
[ ] knowledge/*.md updated to reflect changes made in this prompt
[ ] If architectural decision was made → entry added to knowledge/decisions.md (with Status and Confidence per knowledge-structure Section 7)
[ ] INDEX.md updated (modification date of changed files)
[ ] If a new universal was created → entry added to knowledge/universals/<file>.md with adaptation parameters
```

### Flexible Acceptance Criteria minimums
Select applicable checks based on task type:

| Task type | Applicable minimums |
|-----------|-------------------|
| Deploy / infrastructure | pm2 status → all processes online; health endpoint → 200 OK |
| Frontend / build | npm run build exits 0; target page loads without errors |
| Backend / API | endpoint responds with expected status and payload |
| Documentation only | all modified files have updated @updated date; INDEX.md updated |
| Any task with code change | no TypeScript/lint errors; regression shield respected |

---

## 5. Context & Session Management

Start new session when: switching between unrelated tasks; same error not solved on second attempt — write fresh prompt with clean context.

Before every Claude Code session: verify correct repository, branch main, correct project in sidebar. Vasily frequently switches between projects — always remind him to check.

---

## 6. Large Tasks & Prompt Splitting

### Prompt size rule — mandatory
**One prompt = maximum 1 file created or modified.**
Exception: 2 files allowed only when both conditions are true:
- Both files are small (well under 200 lines each)
- Both files are tightly coupled by logic (e.g. a component and its types file)

**Knowledge files exception:** updating `knowledge/*.md` (including `decisions.md`, `INDEX.md`, and `universals/*.md`) alongside the primary code file is always allowed within a single prompt. Knowledge updates are metadata about the change, not a separate functional unit. See Section 4 (Knowledge update rule) for details.

If a task touches more files → split into multiple prompts. Each prompt:
1. Covers one file (or two if exception applies), plus any knowledge updates
2. Ends with a commit
3. Next prompt starts only after user confirms the previous result

There are no other exceptions. A prompt that creates 8 code files is always wrong — split it into 8 prompts (each may include its own knowledge updates).

### Large tasks
Assess scope → propose breakdown listing each prompt separately → user approves breakdown → execute one prompt at a time → mini-report after each → confirmation before next.

After each prompt — a committable state that can be verified independently.

### Architectural changes
Request a written plan from Claude Code first (no implementation) → review → confirm → implement one file per prompt.

### Commits
Claude Code commits after each completed prompt, not at the end. Meaningful messages. Creates rollback points.

---

## 7. Git & Deploy Checklist

Include in every prompt involving deployment:
1. git pull origin main
2. Install dependencies (only if changed)
3. Build (if frontend)
4. Project-specific steps (see project context)
5. Restart processes via process manager
6. Verify: process status + health endpoint or main page

Never fix broken production by editing directly on server — everything through git. Direct server edits are lost on next pull and create conflicts.

If broken after deploy: git revert HEAD + redeploy. Do not debug in broken state — run parallel diagnostics in a separate branch.
