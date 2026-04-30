# Codex Workflow

The working loop is:

Vasily -> ChatGPT orchestrator -> Codex / Code Agent -> GitHub -> ChatGPT verification.

Vasily provides the task and reviews outcomes. ChatGPT orchestrates scope and prompts. Codex or another Code Agent edits the repository. GitHub remains the source of truth. ChatGPT verifies the result against the requested scope.

Vasily should not manually edit repository files unless explicitly needed.
