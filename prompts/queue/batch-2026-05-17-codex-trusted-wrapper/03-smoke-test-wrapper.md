# Prompt 03 — Smoke test wrapper

## CONTEXT
Project: vibecoding-workspace
Repository: github.com/t9242540001/vibecoding-workspace
Affected files:
- docs/codex-workflow.md

Current state:
Prompts 01 and 02 should create and document `scripts/codex-trusted-checkpoint.sh`. This final prompt performs a low-risk documentation smoke test to verify the complete automatic flow: Codex makes a scoped repo-local file change, then the trusted wrapper validates, commits, and pushes without human git commands.

## TASK
Add exactly one short bullet to `docs/codex-workflow.md` under the existing smoke-test or Codex batch execution area:

- 2026-05-17: trusted checkpoint wrapper smoke test completed for a documentation-only Codex batch.

After Codex makes the file change and runs verification, use `scripts/codex-trusted-checkpoint.sh` to create and push the git checkpoint automatically.

Expected wrapper command:

```
scripts/codex-trusted-checkpoint.sh batch-2026-05-17-codex-trusted-wrapper "Smoke test trusted wrapper"
```

## REGRESSION SHIELD — DO NOT TOUCH
Files not to modify:
- standards/**
- scripts/**
- templates/**
- skills/**
- README.md
- workspace-index.md
- docs/codex-isolated-runner-setup.md

Within docs/codex-workflow.md:
- Add only one short bullet.
- Do not rewrite existing sections.
- Do not change commands, safety wording, headings, or unrelated paragraphs.
- Do not change Claude Routine references.

Critical rules for this project:
- RULE: This is a smoke test, not a feature change. Scope must stay tiny.
- RULE: Do not touch secrets, deploy, production, server actions, or runner configuration.
- RULE: Do not use Claude Routines.

## ACCEPTANCE CRITERIA
[ ] Exactly one short bullet added to `docs/codex-workflow.md`.
[ ] No other files modified before wrapper execution.
[ ] `git diff --check` passes.
[ ] `scripts/codex-trusted-checkpoint.sh batch-2026-05-17-codex-trusted-wrapper "Smoke test trusted wrapper"` creates a commit.
[ ] Commit message contains `[batch:batch-2026-05-17-codex-trusted-wrapper] Smoke test trusted wrapper`.
[ ] Push completed to current branch.
[ ] Final report includes whether any approval prompts appeared.
