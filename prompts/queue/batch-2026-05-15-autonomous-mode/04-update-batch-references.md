# Prompt 04 — Update batch references

## CONTEXT
Project: vibecoding-workspace
Repository: github.com/t9242540001/vibecoding-workspace
Affected files:
- standards/batch-execution-standard.md
- templates/batch-execution/prompt-template.md

Current state:
The repository already contains a Batch Execution Standard and batch prompt templates. The new approved direction should be connected to those files without creating duplicate standards. The standard already supports automated batch execution; this prompt aligns wording with the universal Autonomous Batch Mode, safe corridor, stop conditions, CI gates, and the updated knowledge-structure model.

## TASK
Update only the batch execution standard and prompt template where needed so they explicitly align with the universal autonomous model:

1. Autonomous Batch Mode means no user confirmation between prompts after the batch/parade is approved.
2. Each prompt still follows full prompt-writing-standard quality rules, including Regression Shield and Step 9 review.
3. Safe errors inside scope are fixed in the current step before commit.
4. Critical stop conditions stop the batch and produce a clear report.
5. CI/build/test gates and health/E2E checks are part of the safe corridor.
6. Knowledge updates must follow the updated knowledge-structure skill, including flat files for small projects or folders/ADR files for larger projects.
7. Do not duplicate entire rules from other standards when a short reference is enough.

## REGRESSION SHIELD — DO NOT TOUCH
Files not to modify:
- skills/**
- standards/VIBECODER_STANDARDS.md
- templates/batch-execution/manifest-template.json
- templates/batch-execution/routine-prompt.md
- docs/**
- README.md

Within affected files:
- Do not rewrite existing Sections 1–16 of standards/batch-execution-standard.md except for targeted wording additions that align with the approved model.
- Do not remove existing foundation, pre-commit verification, branch discipline, or recovery-mode rules.
- Do not change manifest schema.
- Do not weaken prompt-template acceptance criteria.
- Do not add target-branch instructions to prompt-template.

Critical rules for this project:
- RULE: Existing batch execution standard is the canonical batch protocol; do not create a parallel duplicate standard.
- RULE: Automation removes manual waiting, not quality gates.
- RULE: Batch prompts must not specify target branches.

## ACCEPTANCE CRITERIA
[ ] Batch standard explicitly states no confirmation between prompts after approved parade/batch plan.
[ ] Batch standard or template explicitly documents safe error vs critical stop behavior.
[ ] Batch standard or template references CI/build/test gates and health/E2E checks as part of the safe corridor.
[ ] Batch standard or template references updated knowledge-structure behavior for flat or folder/ADR structures.
[ ] Existing pre-commit verification, foundation PR, branch discipline, and recovery-mode rules remain intact.
[ ] Manifest schema was not changed.
[ ] No unrelated files were modified.
[ ] Modified file headers/versions updated if project convention requires it.
[ ] Code Agent reports changed sections and confirms scope was respected.
