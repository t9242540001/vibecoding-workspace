# Prompt 09 — Growth AI Pack

## CONTEXT
Project: Vibe Coding workspace infrastructure
Repository: t9242540001/vibecoding-workspace
Series: prompts/queue/batch-2026-05-25-site-audit-v3-multi-agent/00-series-context.md
Series Charter: knowledge/series-charters/2026-05-25-site-audit-v3-multi-agent.md
Architecture contract: docs/site-audit/v3-architecture-contract.md
Agent registry: configs/site-audit-v3-agent-registry.json
Evidence registry: configs/site-audit-v3-evidence-registry.json
Core agent pack: skills/site-audit-v3-core-agents/SKILL.md
Human/product pack: skills/site-audit-v3-human-product-agents/SKILL.md
Risk pack: skills/site-audit-v3-risk-agents/SKILL.md
Affected files:
- skills/site-audit-v3-growth-ai-agents/SKILL.md

Current state:
V3 needs a dedicated growth/AI pack so SEO, answer-engine readiness, AI/agentic-commerce readability, performance, reliability, and measurement are treated as expert passes with evidence and boundaries, not as generic marketing comments.

Relevant series invariants:
- Growth/AI findings must be evidence-based and must not promise rankings or platform outcomes.
- Agentic-commerce findings must mark emerging-practice gaps honestly, without pretending they are mandatory standards.
- Performance measurements must state environment limitations.
- Analytics recommendations must be privacy-safe and not collect unnecessary data.
- Skills must be universal and product-neutral.

## TASK
Create `skills/site-audit-v3-growth-ai-agents/SKILL.md` as a new skill pack for Site Audit V3 growth/AI agents.

The skill must include these agents:

14. SEO / AEO / GEO Agent
15. AI / Agentic Commerce Agent
16. Performance / Reliability Agent
17. Analytics / Measurement Agent

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
- SEO / AEO / GEO Agent checks crawlability, metadata, structured content, helpful content, and answerability; it must not promise rankings.
- AI / Agentic Commerce Agent checks whether AI agents can understand, compare, recommend, and safely route users; it must mark emerging practice as readiness, not compliance.
- Performance / Reliability Agent checks speed, degradation, fallback behavior, and external-service dependency risks; it must mark measurement environment limits.
- Analytics / Measurement Agent checks whether funnel, errors, conversions, and quality can be measured without privacy leakage or unnecessary data collection.

Use existing workspace skill style: frontmatter, title, metadata comment, numbered sections, activation triggers, workflow, boundaries, anti-patterns, and quick reference.

Update the Series Charter step status for Prompt 09 if the charter exists.

## REGRESSION SHIELD — DO NOT TOUCH
Files not to modify:
- skills/site-audit/SKILL.md
- skills/site-audit-v3-core-agents/SKILL.md
- skills/site-audit-v3-human-product-agents/SKILL.md
- skills/site-audit-v3-risk-agents/SKILL.md
- configs/site-audit-v3-agent-registry.json
- configs/site-audit-v3-evidence-registry.json
- configs/site-audit-v3-outcome-statuses.json
- docs/site-audit/v3-architecture-contract.md
- templates/site-audit/*
- README.md
- workspace-index.md

Functions/components not to modify:
- Not applicable; this is a skill/documentation prompt.

Within modified file(s): create only the new growth/AI agent skill pack and update only the relevant Series Charter status if available. Do not edit existing site-audit skills or create the aggregator pack in this prompt.

Critical rules for this project:
- No existing safety boundary may be weakened.
- No manipulative SEO, fake reviews, hidden content, misleading schema, or AI-search spam recommendations.
- No privacy-invasive analytics recommendations.
- Product-specific growth facts belong in product repositories and audit outputs, not this universal skill pack.

## ACCEPTANCE CRITERIA
[ ] `skills/site-audit-v3-growth-ai-agents/SKILL.md` exists.
[ ] The skill has frontmatter and metadata consistent with existing workspace skills.
[ ] The skill includes agents 14-17.
[ ] Each agent has role, mission, inputs, questions, evidence policy, process, handoff format, boundaries, self-check, handoff outputs, and tunable parameters.
[ ] SEO/AEO/GEO agent explicitly avoids ranking promises.
[ ] AI/Agentic Commerce agent marks emerging practice as readiness, not compliance.
[ ] Performance/Reliability agent marks measurement environment limits.
[ ] Analytics/Measurement agent requires privacy-safe measurement.
[ ] The Series Charter status for Prompt 09 is updated if the charter exists.
[ ] Existing skills and V2 assets are not edited.

Code Agent must report against each criterion after completion.
