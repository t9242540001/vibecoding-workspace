# Prompt 07 — Human Product Pack

## CONTEXT
Project: Vibe Coding workspace infrastructure
Repository: t9242540001/vibecoding-workspace
Series: prompts/queue/batch-2026-05-25-site-audit-v3-multi-agent/00-series-context.md
Series Charter: knowledge/series-charters/2026-05-25-site-audit-v3-multi-agent.md
Architecture contract: docs/site-audit/v3-architecture-contract.md
Agent registry: configs/site-audit-v3-agent-registry.json
Evidence registry: configs/site-audit-v3-evidence-registry.json
Core agent pack: skills/site-audit-v3-core-agents/SKILL.md
Affected files:
- skills/site-audit-v3-human-product-agents/SKILL.md

Current state:
The core agent pack defines orchestration, preflight, discovery, static technical, live browser QA, and scenario/flow agents. The next pack must cover the human-facing and product-facing expert passes that evaluate whether the site is understandable, trustworthy, visually coherent, commercially clear, and editorially safe for its audience.

Relevant series invariants:
- Expert findings must be evidence-based, not taste-based.
- Findings must separate observed facts, inferred risk, impact, recommendation, confidence, and status.
- Each agent must be future-tunable without rewriting the whole pipeline.
- Product-facing agents must not make legal, privacy, security, SEO, or performance claims outside their role.
- Skills must be universal and product-neutral.

## TASK
Create `skills/site-audit-v3-human-product-agents/SKILL.md` as a new skill pack for Site Audit V3 human/product agents.

The skill must include these agents:

06. UX / Target Audience Agent
07. Visual Designer / Design System Agent
08. Product / Conversion Agent
09. Content / Editorial Trust Agent

For each agent define:
- role;
- mission;
- required inputs;
- self-directed questions;
- evidence policy using V3 evidence class names;
- process;
- finding/handoff format;
- boundaries;
- self-check;
- handoff outputs to aggregator;
- tunable parameters.

The skill must make these boundaries explicit:
- UX Agent evaluates user task clarity and friction, not visual taste by itself.
- Visual Agent evaluates visual hierarchy, consistency, readability, and trust, not subjective preference alone.
- Product / Conversion Agent separates proven conversion blockers from product hypotheses.
- Content / Editorial Trust Agent identifies clarity, trust, terminology, and claim-risk issues, but does not rewrite the site or provide legal conclusions.

Use existing workspace skill style: frontmatter, title, metadata comment, numbered sections, activation triggers, workflow, boundaries, anti-patterns, and quick reference.

Update the Series Charter step status for Prompt 07 if the charter exists.

## REGRESSION SHIELD — DO NOT TOUCH
Files not to modify:
- skills/site-audit/SKILL.md
- skills/site-audit-v3-core-agents/SKILL.md
- skills/prompt-writing-standard/SKILL.md
- configs/site-audit-v3-agent-registry.json
- configs/site-audit-v3-evidence-registry.json
- configs/site-audit-v3-outcome-statuses.json
- docs/site-audit/v3-architecture-contract.md
- templates/site-audit/*
- README.md
- workspace-index.md

Functions/components not to modify:
- Not applicable; this is a skill/documentation prompt.

Within modified file(s): create only the new human/product agent skill pack and update only the relevant Series Charter status if available. Do not edit existing site-audit skills or create risk/growth/aggregator packs in this prompt.

Critical rules for this project:
- Existing skills are edited only inside explicitly approved scope; this prompt creates a new skill pack.
- No existing safety boundary may be weakened.
- Product-specific audit details belong in product repositories, not this universal skill pack.
- No secrets, credentials, personal data, raw browser/session artifacts, or private data may be added.

## ACCEPTANCE CRITERIA
[ ] `skills/site-audit-v3-human-product-agents/SKILL.md` exists.
[ ] The skill has frontmatter and metadata consistent with existing workspace skills.
[ ] The skill includes agents 06-09.
[ ] Each agent has role, mission, inputs, questions, evidence policy, process, handoff format, boundaries, self-check, handoff outputs, and tunable parameters.
[ ] The skill explicitly blocks taste-only design findings.
[ ] The skill separates product hypotheses from observed blockers.
[ ] The skill is universal and product-neutral.
[ ] The Series Charter status for Prompt 07 is updated if the charter exists.
[ ] Existing skills and V2 assets are not edited.
[ ] No secrets, credentials, personal data, or private artifacts are added.

Code Agent must report against each criterion after completion.
