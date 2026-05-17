# Prompt 02 — Document wrapper workflow

## CONTEXT
Project: vibecoding-workspace
Repository: github.com/t9242540001/vibecoding-workspace
Affected files:
- standards/codex-batch-execution-standard.md
- docs/codex-workflow.md
- docs/codex-isolated-runner-setup.md

Current state:
The Codex batch standard and workflow describe a trusted wrapper or human handoff for git add/commit/push. Prompt 01 creates `scripts/codex-trusted-checkpoint.sh` as the trusted wrapper. The documentation now needs to reference that script as the default low-risk checkpoint mechanism while preserving the current safety model.

## TASK
Update only the three affected files to document the trusted wrapper workflow.

Required changes:
1. In `standards/codex-batch-execution-standard.md`, add a short subsection or paragraph naming `scripts/codex-trusted-checkpoint.sh` as the default trusted checkpoint wrapper for low-risk repo-local batches. Explain that it validates diff, blocks high-risk paths/deletes by default, commits with `[batch:<batch_id>]`, and pushes current branch.
2. In `docs/codex-workflow.md`, update the Codex Batch Execution section so the workflow says Codex reports the verified diff and then the trusted wrapper creates the git checkpoint.
3. In `docs/codex-isolated-runner-setup.md`, add a short command example for running the trusted checkpoint wrapper after Codex completes a prompt or batch.

Keep changes small. Do not rewrite existing sections.

## REGRESSION SHIELD — DO NOT TOUCH
Files not to modify:
- scripts/**
- templates/**
- skills/**
- README.md
- workspace-index.md
- standards/batch-execution-standard.md
- docs/routine-launcher-setup.md
- docs/batch-execution-guide.md

Within modified files:
- Do not weaken existing warnings about secrets, deploy, production, auth, payments, or PII.
- Do not remove the human fallback.
- Do not claim wrapper is safe for high-risk tasks.
- Do not change Claude Routine references.
- Do not do style cleanup.

Critical rules for this project:
- RULE: The wrapper automates low-risk git checkpointing only after scoped diff verification.
- RULE: Human review remains valid fallback and required for high-risk tasks.
- RULE: Codex and Claude Routine paths remain separate.

## ACCEPTANCE CRITERIA
[ ] `standards/codex-batch-execution-standard.md` references `scripts/codex-trusted-checkpoint.sh` as low-risk trusted wrapper.
[ ] `docs/codex-workflow.md` describes wrapper checkpoint step.
[ ] `docs/codex-isolated-runner-setup.md` includes wrapper command example.
[ ] Existing safety warnings remain intact.
[ ] No files outside the affected files were modified.
[ ] Code Agent reports changed sections and confirms scope was respected.
