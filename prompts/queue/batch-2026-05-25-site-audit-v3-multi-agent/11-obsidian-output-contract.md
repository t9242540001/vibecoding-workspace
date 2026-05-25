# Prompt 11 — Obsidian Output Contract

## CONTEXT
Project: Vibe Coding workspace infrastructure
Repository: t9242540001/vibecoding-workspace
Series: prompts/queue/batch-2026-05-25-site-audit-v3-multi-agent/00-series-context.md
Series Charter: knowledge/series-charters/2026-05-25-site-audit-v3-multi-agent.md
Architecture contract: docs/site-audit/v3-architecture-contract.md
Aggregator skill: skills/site-audit-v3-aggregator-risk-board/SKILL.md
Final report template: templates/site-audit/v3-final-report-template.md
Affected files:
- docs/site-audit/v3-obsidian-output-contract.md
- templates/site-audit/v3-obsidian-project-audit-template.md

Current state:
Site Audit V3 must write audit outputs into project-specific knowledge/Obsidian without recreating or reorganizing the existing local vault. The workspace already records that the local Obsidian vault exists at `D:\WipeCoder\Obsidian\Vibe Knowledge` and must not be structurally rewritten without explicit approval.

Relevant series invariants:
- Obsidian output rules must respect the existing local vault and must not recreate or reorganize it.
- GitHub remains source of truth for implementation artifacts.
- Product-specific audit outputs belong to product repositories and project-specific Obsidian folders, not hardcoded into universal workspace docs.
- Sensitive data must not be written to Obsidian outputs.

## TASK
Create the Site Audit V3 Obsidian output contract and project audit template.

Create `docs/site-audit/v3-obsidian-output-contract.md` defining:
- purpose of Obsidian output in the V3 pipeline;
- relationship between GitHub source of truth and local Obsidian knowledge;
- project-level output structure;
- required audit output files;
- naming convention;
- status history convention;
- finding register convention;
- fix-batch queue convention;
- decisions handoff convention;
- sensitive-data exclusion rules;
- manual sync boundary when the Code Agent cannot access the local vault.

The contract must not hardcode a destructive vault structure. It may reference the known active local vault path as context, but it must state that the existing vault is preserved and that new project folders/files are additive.

Create `templates/site-audit/v3-obsidian-project-audit-template.md` as a reusable project audit note template containing:
- project name;
- site URL;
- audit date;
- audit outcome status;
- completeness summary;
- scope;
- unavailable layers;
- top findings;
- full finding register link/path;
- evidence summary link/path;
- fix-batch queue;
- decisions/questions for Vasily;
- follow-up audit/regression status.

Update the Series Charter step status for Prompt 11 if the charter exists.

## REGRESSION SHIELD — DO NOT TOUCH
Files not to modify:
- README.md
- workspace-index.md
- existing Obsidian vault files outside this repository
- skills/site-audit/SKILL.md
- skills/site-audit-v3-aggregator-risk-board/SKILL.md
- templates/site-audit/v3-final-report-template.md
- existing templates/site-audit/report-template.md

Functions/components not to modify:
- Not applicable; this is a documentation/template prompt.

Within modified file(s): create only the Obsidian output contract and project audit template, plus the relevant Series Charter status update if available. Do not modify or assume direct access to the local Obsidian vault. Do not reorganize existing repository navigation in this prompt.

Critical rules for this project:
- The local Obsidian vault already exists and must not be recreated, reorganized, or structurally rewritten without explicit approval.
- GitHub remains source of truth for reusable implementation artifacts.
- Product-specific outputs must not pollute universal workspace docs.
- No secrets, credentials, personal data, raw browser/session artifacts, or private data may be written.

## ACCEPTANCE CRITERIA
[ ] `docs/site-audit/v3-obsidian-output-contract.md` exists.
[ ] The contract defines additive project-level output rules without recreating or reorganizing the vault.
[ ] The contract distinguishes GitHub source of truth from local Obsidian output/knowledge.
[ ] The contract defines required audit outputs, naming, status history, finding register, fix-batch queue, and decisions handoff.
[ ] The contract includes sensitive-data exclusion rules.
[ ] `templates/site-audit/v3-obsidian-project-audit-template.md` exists.
[ ] The template includes all required project audit note sections.
[ ] The Series Charter status for Prompt 11 is updated if the charter exists.
[ ] No local Obsidian files are modified directly.
[ ] Existing skills/templates/docs are not edited outside the explicit scope.

Code Agent must report against each criterion after completion.
