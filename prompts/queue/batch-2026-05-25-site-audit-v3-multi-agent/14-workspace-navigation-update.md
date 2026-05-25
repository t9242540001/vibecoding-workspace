# Prompt 14 — Workspace Navigation Update

## CONTEXT
Project: Vibe Coding workspace infrastructure
Repository: t9242540001/vibecoding-workspace
Series: prompts/queue/batch-2026-05-25-site-audit-v3-multi-agent/00-series-context.md
Series Charter: knowledge/series-charters/2026-05-25-site-audit-v3-multi-agent.md
All V3 artifacts expected from Prompts 01-13:
- docs/site-audit/v3-architecture-contract.md
- docs/site-audit/v3-outcome-statuses.md
- docs/site-audit/v3-evidence-registry.md
- docs/site-audit/v3-agent-registry.md
- docs/site-audit/v3-obsidian-output-contract.md
- docs/site-audit/v3-validation-gates.md
- configs/site-audit-v3-outcome-statuses.json
- configs/site-audit-v3-evidence-registry.json
- configs/site-audit-v3-agent-registry.json
- skills/site-audit-v3-core-agents/SKILL.md
- skills/site-audit-v3-human-product-agents/SKILL.md
- skills/site-audit-v3-risk-agents/SKILL.md
- skills/site-audit-v3-growth-ai-agents/SKILL.md
- skills/site-audit-v3-aggregator-risk-board/SKILL.md
- templates/site-audit/v3-agent-handoff-template.md
- templates/site-audit/v3-final-report-template.md
- templates/site-audit/v3-obsidian-project-audit-template.md
- templates/site-audit/v3-validation-checklist.md
- prompts/series/site-audit-v3/yurassistent-v3-pilot-prompt.md
Affected files:
- workspace-index.md
- README.md only if it already has a directly relevant site-audit file list that needs a minimal additive line
- knowledge/series-charters/2026-05-25-site-audit-v3-multi-agent.md

Current state:
The V3 artifacts have been created by previous prompts. The final implementation prompt must connect them to workspace navigation without restructuring existing documents or rewriting V2 site-audit descriptions.

Relevant series invariants:
- Navigation update is additive and minimal.
- Existing V2 files remain valid and must not be renamed, deleted, or re-described as obsolete.
- V3 artifacts must be discoverable by future AI orchestrators and Code Agents.
- The Series Charter must close the implementation series only if all expected artifacts exist.

## TASK
Update workspace navigation minimally so Site Audit V3 artifacts are discoverable.

First verify which expected V3 artifacts from the CONTEXT list exist. Do not assume they exist.

Update `workspace-index.md` by adding concise references to the new Site Audit V3 docs, configs, skills, templates, and pilot prompt package in the most appropriate existing sections. Preserve existing structure and wording. Do not rewrite the file globally.

Update `README.md` only if it already contains a directly relevant site-audit list and a minimal additive reference is necessary for top-level discoverability. If not necessary, leave `README.md` unchanged and report why.

Update the Series Charter:
- mark Prompt 14 done if this prompt succeeds;
- record any missing expected V3 artifacts as follow-up items instead of pretending the series is complete;
- if all expected V3 artifacts exist, mark the series implementation as ready for review and note that the next separate action is running the YurAssistent V3 product pilot.

Do not execute the YurAssistent pilot and do not modify any product repository.

## REGRESSION SHIELD — DO NOT TOUCH
Files not to modify:
- skills/site-audit/SKILL.md
- skills/site-audit-v3-*/*
- docs/site-audit/* except no changes needed there in this prompt
- configs/site-audit-v3-*.json
- templates/site-audit/*
- prompts/series/site-audit-v3/yurassistent-v3-pilot-prompt.md
- product repositories

Functions/components not to modify:
- Not applicable; this is a navigation/charter update prompt.

Within modified file(s): only add minimal navigation references and update the Series Charter status/follow-up section. Do not reword existing entries for style. Do not reorganize sections. Do not change V2 descriptions to V3 descriptions. Do not add product-specific audit results.

Critical rules for this project:
- Existing documents are edited only inside explicitly approved scope.
- No silent style cleanup, restructuring, or meaning changes.
- GitHub is the source of truth for workspace artifacts.
- Product-specific audit execution belongs in a separate product batch.
- No secrets, credentials, personal data, or private artifacts may be added.

## ACCEPTANCE CRITERIA
[ ] The prompt verifies the expected V3 artifacts and reports which exist or are missing.
[ ] `workspace-index.md` includes minimal discoverability references for Site Audit V3 artifacts.
[ ] `README.md` is updated only if necessary; otherwise the completion report explains why it was left unchanged.
[ ] The Series Charter status for Prompt 14 is updated.
[ ] Missing artifacts, if any, are recorded as follow-up items instead of hidden.
[ ] If all expected artifacts exist, the Series Charter marks the V3 implementation ready for review.
[ ] Existing V2 site-audit descriptions remain intact.
[ ] No existing skills, docs, configs, templates, or product repositories are edited outside explicit scope.
[ ] No YurAssistent audit is executed.
[ ] No secrets, credentials, personal data, or private artifacts are added.

Code Agent must report against each criterion after completion.
