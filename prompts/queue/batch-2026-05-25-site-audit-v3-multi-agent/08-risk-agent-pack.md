# Prompt 08 — Risk Agent Pack

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
Affected files:
- skills/site-audit-v3-risk-agents/SKILL.md

Current state:
Core and human/product agent packs exist or are planned by earlier prompts. Site Audit V3 also needs a separate risk pack so legal, privacy, security, and accessibility checks do not become side-notes inside UX or technical review.

Relevant series invariants:
- Risk findings must be evidence-based and must not expose sensitive data.
- Legal/privacy/security agents must identify risks and review needs, not overstate professional conclusions.
- Security checks must remain safe and non-destructive unless a separate pentest scope exists.
- Accessibility findings must separate automated signals from manual judgment.
- Skills must be universal and product-neutral.

## TASK
Create `skills/site-audit-v3-risk-agents/SKILL.md` as a new skill pack for Site Audit V3 risk agents.

The skill must include these agents:

10. Legal / Compliance Agent
11. Privacy / Data Protection Agent
12. Security / Boundary Agent
13. Accessibility Agent

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
- Legal / Compliance Agent produces risk register and approval-needed questions, not a legal opinion.
- Privacy / Data Protection Agent maps data-flow and policy mismatch risks without quoting personal data.
- Security / Boundary Agent performs only safe, non-destructive boundary checks and marks pentest-needed items separately.
- Accessibility Agent uses WCAG-oriented principles and separates verified issues from items requiring manual or assistive-technology testing.

Use existing workspace skill style: frontmatter, title, metadata comment, numbered sections, activation triggers, workflow, boundaries, anti-patterns, and quick reference.

Update the Series Charter step status for Prompt 08 if the charter exists.

## REGRESSION SHIELD — DO NOT TOUCH
Files not to modify:
- skills/site-audit/SKILL.md
- skills/site-audit-v3-core-agents/SKILL.md
- skills/site-audit-v3-human-product-agents/SKILL.md
- configs/site-audit-v3-agent-registry.json
- configs/site-audit-v3-evidence-registry.json
- configs/site-audit-v3-outcome-statuses.json
- docs/site-audit/v3-architecture-contract.md
- templates/site-audit/*
- README.md
- workspace-index.md

Functions/components not to modify:
- Not applicable; this is a skill/documentation prompt.

Within modified file(s): create only the new risk agent skill pack and update only the relevant Series Charter status if available. Do not edit existing site-audit skills or create growth/aggregator packs in this prompt.

Critical rules for this project:
- No secrets, credentials, `.env` values, tokens, cookies, raw HAR, raw request bodies, raw response bodies, or personal data may be committed.
- Security audit work in this system is safe boundary review, not exploitation or pentest unless separately approved.
- Existing skills are edited only inside explicitly approved scope.
- Product-specific risk facts belong in product repositories and audit outputs, not this universal skill pack.

## ACCEPTANCE CRITERIA
[ ] `skills/site-audit-v3-risk-agents/SKILL.md` exists.
[ ] The skill has frontmatter and metadata consistent with existing workspace skills.
[ ] The skill includes agents 10-13.
[ ] Each agent has role, mission, inputs, questions, evidence policy, process, handoff format, boundaries, self-check, handoff outputs, and tunable parameters.
[ ] The legal agent explicitly avoids giving a legal opinion.
[ ] The privacy agent forbids quoting personal data or sensitive values.
[ ] The security agent limits checks to safe non-destructive boundaries and marks pentest-needed items separately.
[ ] The accessibility agent separates verified findings from manual/assistive-tech follow-up needs.
[ ] The Series Charter status for Prompt 08 is updated if the charter exists.
[ ] Existing skills and V2 assets are not edited.

Code Agent must report against each criterion after completion.
