---
name: prompt-writing-standard
description: Complete workflow and template for writing Code Agent prompts. Use this skill whenever you are about to write a prompt for a Code Agent — before composing any prompt for code execution, feature implementation, bug fixes, refactoring, or documentation updates. This skill is mandatory reading before every Code Agent prompt, not optional.
---

# Prompt Writing Standard
<!--
  @file:        skills/prompt-writing-standard/SKILL.md
  @description: Complete workflow for writing Code Agent prompts
  @version:     3.6
  @updated:     2026-05-15
-->

---

## 1. Architecture

Vasily (task) → AI model / orchestrator (strategy + prompt) → Code Agent (execution) → Git (agent branches, e.g. claude/** → main) → Vasily (deploy on server)

Code Agent works only with the repository. No server access. Logs, process states, DB contents — all obtained through Vasily, who runs commands and sends output.

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

**Step 3a — Existing engine / pipeline gate.**
If the task changes an existing complex engine, pipeline, prompt orchestration, AI-call chain, OCR/upload flow, generation/evaluation flow, storage/logging/admin flow, or recurring bug path, apply `docs/engine-change-workflow.md` before writing an implementation prompt.

Implementation prompts are blocked until the current mechanism is understood. The audit must identify what already exists in code, what exists only as prompt-level intention, what works partially, which layers are disconnected, where the real failure point is, and what must not be changed.

For engine/pipeline changes, the prompt must also answer: "How will we later see in logs/debug/admin surfaces that the new layer actually worked?" It must either update safe diagnostics/log metadata, explain why existing diagnostics are enough, or create a separate follow-up prompt for diagnostics.

The prompt must also assess whether AI-assisted E2E validation is required. If required but not included in the same prompt, create a follow-up prompt or explicit follow-up item.

**Step 4 — Socratic questions.**
Mandatory before writing prompts when the task is ambiguous or affects UX/business logic. Apply the Socratic method from system instructions.

**Step 5 — Identify affected files.**
Include files the new code will interact with, not just files being changed. New files can duplicate, depend on, or conflict with existing ones.

**Step 6a — Read knowledge context. BLOCKING RULE.**
Before reading code files and before writing the prompt, the model MUST read the project's knowledge context. No prompt is written without verified knowledge context — same blocking logic as for code files in Step 6b.

**Mandatory reads:**

1. **Project's main context file (`CLAUDE.md` or equivalent)** — project constitution: stack, critical rules (max 5), deploy commands. This is the base frame for any prompt.

2. **`knowledge/INDEX.md`** — map of knowledge files: what is where, when last updated. Used to determine which knowledge files are relevant to the current task.

3. **Relevant `knowledge/*.md` files** — selected via INDEX. Minimum: those describing modules/components affected by the task. For architectural tasks — read all main ones.

4. **`knowledge/decisions.md`** (if it exists in the project) — architectural decisions log. Goal: do not propose a prompt that contradicts a previously fixed decision.

**Why this matters:**
- The REGRESSION SHIELD block in the prompt template requires "critical rules for this project" — these come from the main project context file and knowledge, otherwise the block is empty or fabricated.
- The domain expert in Step 9 cannot fully review the prompt without knowing project decision history.
- Without knowledge, the model works "from scratch" every session, discarding accumulated project context — defeating the purpose of the knowledge system.
- Conflicts with already-made decisions are caught BEFORE writing the prompt, not after execution.

**Not accepted:**
- Knowledge file summaries from Vasily — only full reads via file MCP or AI Knowledge Base MCP.
- "I remember this project from a past session" — context does not persist across sessions, knowledge must be re-read.
- Skipping decisions.md because "the task is small" — even simple prompts can contradict architectural decisions.

**Exception:** For `Documentation-only` task type updating a single knowledge file — reading only that file plus `INDEX.md` is sufficient.

**Related skill:** When creating or updating knowledge files in this prompt, apply the rules from skill `knowledge-structure` — in particular Section 9 (Content Preservation) and the rules for anti-duplication, stale information, and INDEX integrity. Read `knowledge-structure` SKILL.md before writing any prompt that touches knowledge files.

**Step 6b — Read code file contents. BLOCKING RULE.**
Request and read FULL actual content of every affected file identified in Step 5. Summaries like "this file contains..." are not accepted. No prompt without verified file contents. No exceptions.

**Related skill:** When the prompt creates or modifies code files, apply the rules from skill `code-markup-standard` — file headers, function documentation, region comments, inline tags, RULE comments, and the rules hierarchy. Read `code-markup-standard` SKILL.md before writing any prompt that touches code.

**Step 7 — Write the plan.**
Four elements in plain language:
- What we're doing: one sentence
- Why: one sentence
- How: numbered steps, one sentence each
- What we're NOT touching: list

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
Verify: all 4 blocks present, English language, single task. The prompt must match the approved brief from Step 8a.

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

> *"Are you sure the prompt does not let the Code Agent change anything outside the explicitly declared scope? Walk through the prompt and verify: does the REGRESSION SHIELD block specify exactly what stays untouched within the modified files? Are all the places the Code Agent might be tempted to 'improve' — adjacent sections, nearby comments, related functions, neighboring rules — explicitly named as out of scope? If the prompt permits silent edits to adjacent wording, terminology, rule severity, or examples — that is an error ❌, not a warning ⚠️. 'The Code Agent will probably not touch it' is not sufficient; the prompt must make it impossible."*

This check is the primary defense against the broken-telephone drift described in `knowledge-structure` Section 9. A prompt that passes all other checks but leaves scope ambiguous still fails Step 9.

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
```

The summary is mandatory. **Without this summary, Step 9 is considered incomplete** — the prompt is not ready to present to Vasily. Full review texts (the three perspectives in detail) are not output to chat by default — Vasily can request them explicitly if he wants to see the full reasoning.

2. **All ❌ errors MUST be fixed in the prompt immediately.** This is not optional. Do not defer fixes to "future prompts" or suggest Vasily handle them later. The prompt must leave Step 10 clean — with zero ❌ errors.

3. **All ⚠️ warnings MUST also be fixed in the prompt immediately.** Do not defer them or ask Vasily to handle them separately. Warnings are less severe than errors but still require correction before the prompt is finalized. If a warning genuinely cannot be fixed within this prompt's scope — state why explicitly and get Vasily's confirmation before proceeding.

4. **If fixes cause the prompt to exceed the one-file rule** (Section 6) — split into multiple prompts right here. Present the split as a numbered sequence, each prompt self-contained and following the template.

5. **Output the COMPLETE final prompt as a downloadable plain text file.** Do not output the prompt inline in chat mixed with commentary. Create a plain text file (`.txt`) containing only the prompt — title header (`# Prompt NN — [short title]`) and all 4 blocks (CONTEXT, TASK, REGRESSION SHIELD, ACCEPTANCE CRITERIA). No preamble, no review summary, no explanations inside the file — only the prompt text ready to paste into the Code Agent. No extra formatting: no bold markers (`**`), no bullet decorations, no horizontal rules, no code fences around the prompt itself. Plain readable text. The review summary and any commentary stay in the chat message; the file contains the clean prompt and nothing else.

**Step 11 — Prompt Readiness Gate.**
For T2/T3 Code Agent prompts, before presenting the final prompt file, show Vasily a short factual readiness confirmation. This is a visible quality gate, not a full reasoning transcript. Do not expose hidden chain-of-thought. Do not output the full internal review unless Vasily explicitly asks for details.

Use this template:

```
### Prompt Readiness Gate

- Level: T2 / T3
- Mode used: prompt-writing-standard / research-protocol + prompt-writing-standard
- Knowledge checked:
  - [ ] CLAUDE.md or equivalent
  - [ ] knowledge/INDEX.md
  - [ ] relevant knowledge files
  - [ ] knowledge/decisions.md, if present
- Code checked:
  - [ ] affected files read in full
  - [ ] related files inspected when needed
- Review completed:
  - [ ] stakeholder review
  - [ ] technical/security review
  - [ ] domain review
  - [ ] scope integrity check
- Review result:
  - Errors: 0 after fixes
  - Warnings: 0 after fixes / explicitly accepted
- Status: prompt ready / not ready
```

The final prompt must not be presented if the readiness gate is not passed.

The prompt is ready for the Code Agent only after Step 10 is complete, the Prompt Readiness Gate is passed, and the full final version is presented.

---

## 3. Prompt Template

Four mandatory blocks plus a title header. A prompt missing any element is incomplete.

```
# Prompt NN — [short title, 2–5 words in English]

## CONTEXT
Project: [name]
Repository: [URL]
Affected files: [exact paths relative to repo root]
Current state: [what works, what's broken — based on collected data]

## TASK
[One task. Unambiguous wording. No room for interpretation.]

[TASK should be formulated as a goal with a verification criterion — not as a step-by-step instruction. "Add validation" → "Write a test for invalid input and make it pass". "Fix the bug" → "Write a test that reproduces the bug and make it pass". This lets the Code Agent find the right algorithm itself rather than blindly executing prescribed steps. Goal-driven phrasing also produces stronger acceptance criteria — see ACCEPTANCE CRITERIA block below.]

## REGRESSION SHIELD — DO NOT TOUCH
Files not to modify: [list]
Functions/components not to modify: [list]

Within the modified file(s): only the change zone described in TASK is edited. All other content — sections, wordings, examples, terminology, rule severity, comments, numbering — stays exactly as it was. No "consistency fixes" to adjacent content. No rephrasing for clarity or style. No silent improvements. If adjacent content looks wrong, outdated, or inconsistent with the change being made — stop and ask, do not fix it in this prompt.

Rationale: unagreed edits to adjacent wording accumulate across iterations and silently change the meaning of the codebase and knowledge base over time. See `knowledge-structure` Section 9 (Content Preservation).

Critical rules for this project:
- [project-specific rule + consequence of violation]

Project-wide execution discipline (from the main project context file — `CLAUDE.md` or equivalent — Execution Discipline block / Karpathy-style behavioral rules): the standard 4–5 rules in the main project context file (don't guess, simplicity test, surgical changes, goal-driven execution, sustainable solutions) apply to this prompt by default. They are not duplicated inline here — the Code Agent reads them from the project's main context file at session start. If any of those rules is especially load-bearing for this prompt — restate the relevant one explicitly here.

## ACCEPTANCE CRITERIA
[ ] [Task-specific check: specific action and expected result]
[ ] knowledge/*.md updated to reflect changes made in this prompt
[ ] If architectural decision was made → entry added to knowledge/decisions.md
[ ] INDEX.md updated (modification date of changed files)
[+ applicable infrastructure checks — see Section 4]

Code Agent must report against each criterion after completion.
```

**Title header rules:**
- Format: `# Prompt NN — [short title]`
- `NN` — sequential number within the current series (01, 02, 03…). Single standalone prompt = `01`. Split sequence — continuous numbering `01` → `02` → `03`.
- Title — 2–5 words in English, describing the essence of the prompt (e.g. `Fix auth redirect bug`, `Add telegram webhook handler`, `Refactor price calculator`).
- The title makes prompts visually distinguishable in Code Agent history, so Vasily can track which prompts executed and which are still pending.
- The title is part of the prompt itself — it gets copied to Code Agent along with the 4 blocks, not kept as metadata outside.

---

## 4. Core Rules

### One prompt = one task
Multiple tasks → separate prompts, executed sequentially. Different logic types in different files = different tasks.

### Language
All prompts in English. RULE comments in code in English. Exception: content that must be in another language by nature (Russian UI text, bot messages) stays in target language.

### File verification is blocking
No prompt without reading actual file contents. Accept only full file output, never summaries. Applies to modifications and new files both.

### Regression shield in every prompt
Explicitly list what must NOT be touched: files, functions, behaviors. Code Agent tends to "improve" adjacent code — block this explicitly. Include critical project rules even if they seem unrelated to the current task.

After execution: ask the Code Agent to confirm critical rules in affected files were not altered.

If the same error recurs after a fix — anchor the rule in code. Add a RULE comment directly next to the vulnerable code so the Code Agent sees it on every future edit.

### File size limit — universal
All files — code, knowledge, and the main project context file (`CLAUDE.md` or equivalent) — maximum 200 lines. If a file grows beyond 200 lines: split it. One file = one responsibility.

### Main project context file content rule
The main project context file (`CLAUDE.md` or equivalent) is a project constitution, not a technical reference. It contains only:
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
- Three places of rule storage and their hierarchy (main project context file → `knowledge/rules.md` → `@rule` in code)
- Dead code deletion (never commented out)
- No duplication of git metadata in headers

Every prompt that touches files must explicitly apply `code-markup-standard`.

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
| Engine / pipeline change | current engine audited; failure point mapped; diagnostics/log/admin visibility addressed or explicitly deferred; E2E validation need assessed |

---

## 5. Context & Session Management

Start new session when: switching between unrelated tasks; same error not solved on second attempt — write fresh prompt with clean context.

Before every Code Agent session: verify correct repository, branch main, correct project in sidebar. Vasily frequently switches between projects — always remind him to check.

---

## 6. Large Tasks & Prompt Splitting

### Prompt size rule — mandatory
**One prompt = maximum 1 file created or modified.**
Exception: 2 files allowed only when both conditions are true:
- Both files are small (well under 200 lines each)
- Both files are tightly coupled by logic (e.g. a component and its types file)

**Knowledge files exception:** updating `knowledge/*.md` (including `decisions.md` and `INDEX.md`) alongside the primary code file is always allowed within a single prompt. Knowledge updates are metadata about the change, not a separate functional unit. See Section 4 (Knowledge update rule) for details.

If a task touches more files → split into multiple prompts. Each prompt:
1. Covers one file (or two if exception applies), plus any knowledge updates
2. Ends with a commit
3. Creates an independently verifiable rollback point before the next prompt starts

There are no other exceptions. A prompt that creates 8 code files is always wrong — split it into 8 prompts (each may include its own knowledge updates).

### Large tasks
Large tasks are split into small sequential prompts to preserve quality, verification, rollback points, and context stability.

Assess scope → propose breakdown or batch plan listing each prompt separately → user approves the overall breakdown before execution starts → execute prompts in order → commit and verify each prompt independently.

In Autonomous Batch Mode, no user confirmation is required between prompts after the batch plan is approved, provided the batch has an approved safe corridor, explicit stop conditions, verification gates, and per-prompt commits. The Code Agent continues through the sequence until all prompts complete or a critical stop condition is hit.

If a critical stop condition is hit, the Code Agent stops immediately, records the reason, and reports instead of continuing to the next prompt.

After each prompt — a committable state that can be verified independently.

### Architectural changes
Request a written plan from the Code Agent first (no implementation) → review → confirm → implement one file per prompt.

### Commits
Code Agent commits after each completed prompt, not at the end. Meaningful messages. Creates rollback points.

A Code Agent task is not complete after a local commit only. After every completed prompt:
1. Run `git status -sb`.
2. If the local branch is ahead of origin, push to origin.
3. Run `git log --oneline -3`.
4. Verify the commit is visible in GitHub, or explicitly report that verification is blocked.
5. Report branch, commit SHA, push result, and final `git status -sb`.
6. Do not start a new task after push.

A task is complete only when the commit is pushed and visible in GitHub, or the push/verification failure is explicitly reported.

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
