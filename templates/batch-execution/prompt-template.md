# Prompt NN — Short Title

<!--
  @file:        templates/batch-execution/prompt-template.md
  @description: Format reminder for individual prompts inside a batch queue
  @owner:       Claude (Anthropic)
  @updated:     2026-05-12
  @version:     1.1
-->

This file is a format reminder for prompts that go into a batch queue under `prompts/queue/{batch_id}/` in a product repository.

The format is identical to the standard from `skills/prompt-writing-standard-universal.md` Section 3 — Prompt Template. Use this file as a checklist; the authoritative format is the skill.

When composing a real prompt, copy the structure below, replace placeholders, and save as `prompts/queue/{batch_id}/{NN}-{kebab-title}.md`.

---

## Title Header Rule

```
# Prompt NN — [short title, 2–5 words in English]
```

- `NN` — two-digit sequential number within the batch (`01`, `02`, ..., `12`).
- Title — 2-5 words in English, describing the prompt's essence.
- Title must match `manifest.prompts[i].title` exactly.

---

## Mandatory Blocks

A prompt missing any of the four blocks below is incomplete and the routine will fail it.

### Block 1 — CONTEXT

```
## CONTEXT
Project: [name]
Repository: [URL]
Affected files: [exact paths relative to repo root]
Current state: [what works, what's broken — based on collected data]
```

### Block 2 — TASK

```
## TASK
[One task. Unambiguous wording. No room for interpretation.]

[TASK should be formulated as a goal with a verification criterion — not as a step-by-step instruction. "Add validation" → "Write a test for invalid input and make it pass". This lets the Code Agent find the right algorithm itself.]
```

### Block 3 — REGRESSION SHIELD

```
## REGRESSION SHIELD — DO NOT TOUCH
Files not to modify: [list]
Functions/components not to modify: [list]

Within the modified file(s): only the change zone described in TASK is edited. All other content — sections, wordings, examples, terminology, rule severity, comments, numbering — stays exactly as it was. No "consistency fixes" to adjacent content. No rephrasing for clarity or style. No silent improvements. If adjacent content looks wrong, outdated, or inconsistent with the change being made — stop and ask, do not fix it in this prompt.

Critical rules for this project:
- [project-specific rule + consequence of violation]

Project-wide execution discipline (from CLAUDE.md or equivalent main project context file): the standard 4–5 rules (don't guess, simplicity test, surgical changes, goal-driven execution, sustainable solutions) apply by default and are not duplicated inline.
```

### Block 4 — ACCEPTANCE CRITERIA

```
## ACCEPTANCE CRITERIA
[ ] [Task-specific check: specific action and expected result]
[ ] knowledge/*.md updated to reflect changes made in this prompt
[ ] If architectural decision was made → entry added to knowledge/decisions.md
[ ] INDEX.md updated (modification date of changed files)
[ ] Local CI dry-run BEFORE committing (per `standards/batch-execution-standard.md` Section 13):
    - `uv run ruff check .` exits 0
    - `uv run ruff format --check .` exits 0
    - `uv run mypy src/ --ignore-missing-imports` exits 0 (when src/ exists)
    - `uv run pytest -q` exits 0 (when tests/ exists; mock LLM only)
    If a check's toolchain is not yet available in this prompt's environment, skip
    that specific check and record the reason in the commit message. See §13.3 for
    rules on skipping; indefinite skipping is not allowed.
[ ] If ANY check above fails, fix the cause within this prompt's declared scope
    before committing. If the cause is outside scope (would violate REGRESSION
    SHIELD), STOP and report to Vasily.
[+ applicable infrastructure checks per the standard]

Code Agent must report against each criterion after completion.
```

---

## Notes Specific To Batch Execution

When a prompt runs inside a batch (not standalone):

1. **Commit message format is dictated by the routine.** Do not include "commit message:" instructions inside the prompt — the routine uses `[batch:{batch_id}] {prompt.title}`.

2. **The branch is dictated by the routine.** Do not specify branch name in the prompt — the routine pushes to `claude/{batch_id}`.

3. **Health check happens after the prompt completes.** Do not include health-check or smoke-test instructions in the prompt itself — the routine handles health verification between prompts.

4. **One prompt = one file (with knowledge updates allowed).** Same rule as in `prompt-writing-standard-universal.md` Section 6. If the task touches more files, split into multiple prompts in the manifest.

5. **No cross-prompt dependencies in instructions.** Each prompt must be self-contained. Do not write "as we did in the previous prompt" — the routine reads each prompt fresh.

---

## Pre-Submission Checklist

Before adding a prompt file to a batch queue, verify:

- [ ] Title header matches `manifest.prompts[i].title` exactly
- [ ] All 4 blocks present (CONTEXT, TASK, REGRESSION SHIELD, ACCEPTANCE CRITERIA)
- [ ] English language used throughout (except content that must be in target language by nature)
- [ ] Single task, single file modification (or coupled file pair per the rule)
- [ ] Regression shield explicitly lists what stays untouched
- [ ] Acceptance criteria includes knowledge update check
- [ ] Acceptance criteria includes Local CI dry-run block (per `standards/batch-execution-standard.md` Section 13)
- [ ] No commit/branch instructions inside the prompt body
- [ ] Prompt does NOT specify a target branch anywhere — the Code Agent picks its own branch under its safeguard, per `standards/batch-execution-standard.md` Section 15. Targeted edits to an existing feature branch go through GitHub MCP from the planning chat, not through a Code Agent prompt.
- [ ] Step 9 review from `prompt-writing-standard-universal.md` completed
- [ ] Step 10 review summary present in the planning chat (not in this file)
