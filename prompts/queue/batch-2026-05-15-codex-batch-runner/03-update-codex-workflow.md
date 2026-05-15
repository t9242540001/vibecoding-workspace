# Prompt 03 — Update Codex workflow

## CONTEXT
Project: vibecoding-workspace
Repository: github.com/t9242540001/vibecoding-workspace
Affected files:
- docs/codex-workflow.md

Current state:
`docs/codex-workflow.md` is currently a very short workflow note. It does not describe Codex batch execution, isolated runner safety, permission modes, or the separation from Claude Routine-specific batch infrastructure.

## TASK
Update only `docs/codex-workflow.md` to add the Codex batch execution workflow and references.

Required content:
1. Keep the existing single-prompt working loop meaning.
2. Add a short section for Codex Batch Execution:
   - batch manifest and prompt queue under `prompts/queue/{batch_id}/`;
   - Codex reads manifest and executes prompts sequentially;
   - per-prompt commit;
   - stop on critical condition;
   - final report.
3. Add a short section for safety:
   - main machine default keeps interactive permission checks;
   - unattended execution belongs only inside an isolated runner;
   - do not use full host access on the host OS.
4. Add references to:
   - `standards/codex-batch-execution-standard.md`;
   - `docs/codex-isolated-runner-setup.md`.
5. Clearly say Claude Routine files are separate and not the Codex batch path.

## REGRESSION SHIELD — DO NOT TOUCH
Files not to modify:
- standards/**
- scripts/**
- templates/**
- skills/**
- README.md
- workspace-index.md
- docs/codex-isolated-runner-setup.md
- docs/routine-launcher-setup.md
- docs/batch-execution-guide.md

Within docs/codex-workflow.md:
- Preserve the existing core loop meaning.
- Do not add Claude Routine setup instructions.
- Do not mention real local tokens or secrets.
- Do not recommend unsafe host-level permission bypass.

Critical rules for this project:
- RULE: Codex workflow must not route users to Claude Routine tokens.
- RULE: Safe autonomy requires an isolated environment.
- RULE: GitHub remains the source of truth.

## ACCEPTANCE CRITERIA
[ ] `docs/codex-workflow.md` describes both single-prompt Codex workflow and batch workflow.
[ ] It links to the new Codex batch standard and isolated runner setup guide.
[ ] It states unattended execution only belongs in an isolated runner.
[ ] It clearly separates Codex batch execution from Claude Routine infrastructure.
[ ] No other files were modified.
[ ] Code Agent reports changed sections and confirms scope was respected.
