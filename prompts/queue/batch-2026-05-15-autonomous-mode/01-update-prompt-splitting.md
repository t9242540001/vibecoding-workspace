# Prompt 01 — Update prompt splitting

## CONTEXT
Project: vibecoding-workspace
Repository: github.com/t9242540001/vibecoding-workspace
Affected files:
- skills/prompt-writing-standard-universal.md

Current state:
The prompt-writing standard still contains wording that makes large-task execution depend on manual user confirmation after every prompt. That wording is a broken-telephone drift from the original intent. The intended rule is: large tasks are split into small sequential stages to preserve quality, verification, rollback points, and context stability. In an approved autonomous batch, confirmation between stages is not required; the Code Agent continues until success or a stop condition.

## TASK
Update only the Large Tasks & Prompt Splitting section in skills/prompt-writing-standard-universal.md so it restores the original meaning:

Large tasks must be decomposed into small sequential prompts, each independently verifiable and committable. User approval is required for the overall breakdown or batch plan before execution starts. In Autonomous Batch Mode, prompts execute in order without user confirmation between prompts, provided the batch has an approved safe corridor, explicit stop conditions, verification gates, and per-prompt commits. The Code Agent stops and reports only when a critical stop condition is hit.

Preserve the Regression Shield, Step 9 review, Step 10 review summary, Prompt Readiness Gate, file verification, and knowledge update rules exactly in meaning and force. Do not weaken any quality rule.

## REGRESSION SHIELD — DO NOT TOUCH
Files not to modify:
- standards/VIBECODER_STANDARDS.md
- skills/knowledge-structure-universal.md
- standards/batch-execution-standard.md
- templates/**
- docs/**
- README.md

Within skills/prompt-writing-standard-universal.md:
- Only edit the wording in Section 6, Large Tasks & Prompt Splitting, where it says the next prompt starts only after user confirmation and where large tasks require confirmation after each mini-report.
- Do not edit Sections 1–5 or Section 7.
- Do not edit the prompt template, Regression Shield wording, Step 9, Step 10, Step 11, or the Knowledge update rule.
- Do not rephrase adjacent paragraphs for style.
- Do not change headings unless strictly necessary inside Section 6.

Critical rules for this project:
- RULE: No skill, standard, template, or knowledge file is changed outside explicitly approved scope. Violation creates broken-telephone drift.
- RULE: Regression Shield and prompt-quality gates are not being relaxed by this change. Violation reduces quality and safety of Code Agent work.
- RULE: Do not specify a target branch inside Code Agent prompts; branch ownership is handled outside the prompt.

## ACCEPTANCE CRITERIA
[ ] Section 6 no longer says each next prompt requires user confirmation in all cases.
[ ] Section 6 says large tasks are split to preserve quality, verification, rollback points, and context stability.
[ ] Section 6 explicitly supports Autonomous Batch Mode: no confirmations between prompts after the batch is approved.
[ ] Section 6 includes stop-and-report behavior for critical stop conditions.
[ ] Regression Shield, Step 9, Step 10, Step 11, file verification, and knowledge update rules are unchanged in meaning and force.
[ ] No files outside the affected file were modified.
[ ] Documentation-only verification completed: modified file header @updated date and @version updated if the project convention requires it.
[ ] Local verification: grep or equivalent confirms the old unconditional phrase "Next prompt starts only after user confirms" no longer exists.
[ ] Code Agent reports changed lines and confirms scope was respected.
