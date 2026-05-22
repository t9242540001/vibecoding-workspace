# Skills Backlog

This backlog records candidate future skills. It does not create those skills.

Rule: do not create new skills until the need is recurring and not already covered by existing skills.

## Candidate Skills

### fix-ci

- Trigger: recurring GitHub Actions or check failures.
- Why useful: standardize CI log inspection and small corrective patches.
- Status: candidate, not created.
- Creation condition: create only after repeated real use or explicit decision.

### review-pr

- Trigger: repeated pull request review requests.
- Why useful: standardize review findings, risk ordering, and test-gap reporting.
- Status: candidate, not created.
- Creation condition: create only after repeated real use or explicit decision.

### address-pr-comments

- Trigger: repeated need to resolve actionable PR review comments.
- Why useful: standardize comment triage, scoped edits, and resolution reporting.
- Status: candidate, not created.
- Creation condition: create only after repeated real use or explicit decision.

### frontend-qa

- Trigger: recurring UI verification, screenshots, or responsive checks.
- Why useful: standardize visual QA and browser-based acceptance checks.
- Status: candidate, not created.
- Creation condition: create only after repeated real use or explicit decision.

### e2e-testing-loop

- Trigger: recurring AI-assisted end-to-end validation for product flows where real UI behavior, uploads, OCR, model output, admin/debug logs, or post-deploy smoke checks must be verified.
- Why useful: standardize fixture, scenario, expected checks, actual result, screenshots/logs, pass/fail, and next-action reporting for AI-assisted product testing.
- Status: candidate, not created.
- Creation condition: create only after repeated real use or explicit decision, starting from `docs/engine-change-workflow.md`.

### release-notes

- Trigger: repeated need to summarize shipped changes.
- Why useful: standardize user-facing and technical release summaries.
- Status: candidate, not created.
- Creation condition: create only after repeated real use or explicit decision.

### db-migration

- Trigger: recurring database schema or data migration work.
- Why useful: standardize migration planning, rollback notes, and verification.
- Status: candidate, not created.
- Creation condition: create only after repeated real use or explicit decision.

## Pain Map Follow-up

The pain map A–H is documented at `docs/pain-map.md`. Five pains (C, D, E, F, G) are closed by existing skills. Three remain open and are tracked here so they survive across sessions:

### Pain A — content definition

- Status: letter exists in record, content pending. Referenced in five skill rows as "partially closes A".
- What's needed: short name (1–3 words) and trigger description (1–2 sentences) from Vasily.
- Why useful: until A is defined, no primary closer can be designed — only partial overlaps from existing skills.
- Action: next session that returns to pain-map work, ask Vasily to name pain A. Then check existing skills for whether one already covers it (no new skill needed) or open a new candidate entry above (if a new skill is needed). Update `docs/pain-map.md` row for A and the corresponding row in `workspace-index.md` Skills Migration Status.

### Pain B — content definition

- Status: letter exists in record, content pending. Referenced in three skill rows as "partially closes B".
- What's needed: short name (1–3 words) and trigger description (1–2 sentences) from Vasily.
- Why useful: same as A — until B is defined, partial closure cannot be promoted to primary.
- Action: same procedure as Pain A.

### Pain H — external skill adoption decision

- Status: short name known (visual/design quality). Closure pending external skill adoption.
- What's needed: decision on which of the four external candidates (`frontend-design`, `web-design-guidelines`, `react-best-practices`, `canvas-design` — all catalogued in `skills/external/REGISTRY.md`) to install first.
- Why useful: H affects all product repositories with user-facing UI. The four candidates each cover different angles: aesthetic direction (frontend-design), web technical rigor (web-design-guidelines), React performance (react-best-practices), vector artifacts (canvas-design).
- Action: gated on the first design-output task arriving in any product repository. When that task appears, pick one or two of the four candidates based on the task's nature, install into `skills/external/<name>/`, update the REGISTRY.md decision log row, mark pain H closed in `docs/pain-map.md`.
