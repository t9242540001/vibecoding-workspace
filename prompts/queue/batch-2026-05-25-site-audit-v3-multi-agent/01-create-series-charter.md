# Prompt 01 — Create Series Charter

## CONTEXT
Project: Vibe Coding workspace infrastructure
Repository: t9242540001/vibecoding-workspace
Series: prompts/queue/batch-2026-05-25-site-audit-v3-multi-agent/00-series-context.md
Affected files:
- knowledge/series-charters/2026-05-25-site-audit-v3-multi-agent.md
- workspace-index.md only if the new knowledge path must be registered for navigation

Current state:
The workspace already contains a universal `site-audit` skill, V2 site-audit documents, templates, configs, browser/E2E audit materials, and a prompt package for a public no-auth pilot. The next increment is Site Audit V3: a multi-agent website audit pipeline with explicit preflight gating, expert role passes, evidence registry, aggregation, validation, and Obsidian project output. This batch must stay coherent across many prompts, so a Series Charter is required before implementation prompts add the V3 artifacts.

Relevant series invariants:
- V3 is additive/connecting first; do not delete or rename V2 files.
- No false full-audit status is allowed.
- Every new V3 artifact must be universal and product-neutral unless explicitly marked as product-specific.
- Each agent must be future-tunable without rewriting the whole pipeline.
- Obsidian output rules must not recreate or reorganize the existing local vault.

## TASK
Create the Site Audit V3 Multi-Agent Series Charter as the controlling design artifact for this implementation series.

The charter must follow `skills/series-design-discipline/SKILL.md` and contain exactly these five main sections:

1. Product frame
2. Invariants
3. Dependency map
4. Per-step plan
5. Definition of Done

The charter must define the final user-facing capability: Vasily can run a universal multi-agent audit of different websites, get honest audit completeness status, receive evidence-based findings and fix-batches, and preserve the audit output in project-specific Obsidian knowledge.

Include the full dependency plan for this batch using these implementation steps:

01. Create Series Charter
02. V3 Architecture Contract
03. Outcome Status Registry
04. Evidence Registry
05. Agent Registry
06. Core Agent Pack
07. Human Product Agent Pack
08. Risk Agent Pack
09. Growth AI Agent Pack
10. Aggregator Risk Board
11. Obsidian Output Contract
12. Validation Gates
13. YurAssistent V3 Pilot Prompt
14. Workspace Navigation Update

Mark Prompt 01 as in progress or done according to the actual implementation result; all later prompts must be pending.

The charter must explicitly state which artifacts are produced by each step and which later steps consume them. It must also state which parts are sequential and which agent-pack steps are logically parallel after Prompt 05.

If `knowledge/series-charters/` does not exist, create it. If `workspace-index.md` already has a suitable knowledge/series-charters navigation area, register this charter there. If no suitable area exists and updating the index would require restructuring the file, do not restructure; add only the smallest navigation line needed or state in the completion report that registration should be handled by Prompt 14.

## REGRESSION SHIELD — DO NOT TOUCH
Files not to modify:
- skills/site-audit/SKILL.md
- skills/series-design-discipline/SKILL.md
- skills/prompt-writing-standard/SKILL.md
- docs/site-audit/*
- templates/site-audit/*
- configs/site-audit-*.json
- README.md

Functions/components not to modify:
- Not applicable; this is a documentation/knowledge prompt.

Within modified file(s): only create the new Site Audit V3 Series Charter and the minimal navigation entry if needed. Do not rewrite existing index sections, do not cleanup wording, do not rename paths, do not edit existing V2 site-audit artifacts, and do not alter any existing skill language.

Critical rules for this project:
- GitHub is the source of truth; local Obsidian is output/storage context, not the source of implementation truth.
- Product-specific knowledge belongs in product repositories; this workspace stores shared standards, skills, prompts, templates, docs, and configs.
- No secrets, credentials, `.env` values, tokens, cookies, raw HAR, raw request bodies, or personal data may be committed.
- Existing skills, standards, templates, and knowledge files are edited only inside explicitly approved scope.
- The local Obsidian vault already exists and must not be recreated, reorganized, or structurally rewritten.

## ACCEPTANCE CRITERIA
[ ] `knowledge/series-charters/2026-05-25-site-audit-v3-multi-agent.md` exists.
[ ] The charter has the five required sections from `series-design-discipline`.
[ ] The charter defines the Site Audit V3 product frame in user-facing terms.
[ ] The charter lists series-specific invariants, including no false full-audit status and additive V3 rollout.
[ ] The dependency map explains what each prompt produces and consumes.
[ ] The per-step plan lists Prompts 01-14 with statuses.
[ ] The Definition of Done includes an end-to-end real-path scenario for running a V3 audit and saving outputs to project knowledge/Obsidian.
[ ] `workspace-index.md` is updated only if a minimal safe navigation entry is needed; otherwise the completion report explains that Prompt 14 will handle navigation.
[ ] No existing V2 site-audit docs, templates, configs, or skills are edited.
[ ] No secrets, credentials, personal data, or private artifacts are added.

Code Agent must report against each criterion after completion.
