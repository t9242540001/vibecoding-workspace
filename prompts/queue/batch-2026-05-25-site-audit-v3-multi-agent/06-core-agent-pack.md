# Prompt 06 — Core Agent Pack

## CONTEXT
Project: Vibe Coding workspace infrastructure
Repository: t9242540001/vibecoding-workspace
Series: prompts/queue/batch-2026-05-25-site-audit-v3-multi-agent/00-series-context.md
Series Charter: knowledge/series-charters/2026-05-25-site-audit-v3-multi-agent.md
Architecture contract: docs/site-audit/v3-architecture-contract.md
Agent registry: configs/site-audit-v3-agent-registry.json
Evidence registry: configs/site-audit-v3-evidence-registry.json
Outcome statuses: configs/site-audit-v3-outcome-statuses.json
Affected files:
- skills/site-audit-v3-core-agents/SKILL.md

Current state:
Prompts 02-05 define the architecture, outcome statuses, evidence classes, and agent registry. The first skill pack must implement the core pipeline agents that decide whether audit execution is possible and what the remaining agents should inspect.

Relevant series invariants:
- No false full-audit status is allowed.
- Missing live/browser/flow evidence must downgrade the audit outcome.
- Each agent must include role logic, self-directed questions, evidence policy, boundaries, self-check, and handoff.
- Skills must be universal and product-neutral.
- No audit execution may change product code, infrastructure, accounts, payments, or production data.

## TASK
Create `skills/site-audit-v3-core-agents/SKILL.md` as a new skill pack for Site Audit V3 core agents.

The skill must include these agents:

00. Lead Auditor / Orchestrator
01. Preflight / Readiness Agent
02. Discovery / Site Map Agent
03. Static Technical Audit Agent
04. Live Browser QA Agent
05. Scenario / Flow Agent

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
- handoff outputs to downstream agents or aggregator;
- tunable parameters.

The Preflight / Readiness Agent section must define a strict decision gate:
- `go_full_live_browser_audit`
- `go_partial_audit_with_unavailable_layers`
- `blocked_at_preflight`

The skill must explicitly state that the Live Browser QA Agent and Scenario / Flow Agent cannot claim live/browser/flow completion without actual browser/flow evidence classes from the evidence registry.

Use the repository's existing skill style: frontmatter, title, metadata comment, numbered sections, activation triggers, workflow, safety boundaries, anti-patterns, and quick reference.

Update the Series Charter step status for Prompt 06 if the charter exists.

## REGRESSION SHIELD — DO NOT TOUCH
Files not to modify:
- skills/site-audit/SKILL.md
- skills/prompt-writing-standard/SKILL.md
- skills/skill-writing-standard/SKILL.md
- configs/site-audit-v3-agent-registry.json
- configs/site-audit-v3-evidence-registry.json
- configs/site-audit-v3-outcome-statuses.json
- docs/site-audit/v3-architecture-contract.md
- templates/site-audit/*
- README.md
- workspace-index.md

Functions/components not to modify:
- Not applicable; this is a skill/documentation prompt.

Within modified file(s): create only the new core agent skill pack and update only the relevant Series Charter status if available. Do not edit the existing `skills/site-audit/SKILL.md` in this prompt. Do not create the human/product, risk, growth/AI, or aggregator packs in this prompt.

Critical rules for this project:
- Existing skills are edited only inside explicitly approved scope; this prompt creates a new skill pack instead of rewriting the existing site-audit skill.
- No existing safety boundary may be weakened.
- No secrets, credentials, personal data, raw browser/session artifacts, or private data may be added.
- Product-specific audit details belong in product repositories, not this universal skill pack.

## ACCEPTANCE CRITERIA
[ ] `skills/site-audit-v3-core-agents/SKILL.md` exists.
[ ] The skill has frontmatter and metadata consistent with existing workspace skills.
[ ] The skill includes agents 00-05.
[ ] Each agent has role, mission, inputs, questions, evidence policy, process, handoff format, boundaries, self-check, handoff outputs, and tunable parameters.
[ ] Preflight defines the three required gate decisions.
[ ] Live/browser/flow completion claims require actual matching evidence classes.
[ ] The skill is universal and product-neutral.
[ ] The Series Charter status for Prompt 06 is updated if the charter exists.
[ ] Existing `skills/site-audit/SKILL.md` and V2 assets are not edited.
[ ] No secrets, credentials, personal data, or private artifacts are added.

Code Agent must report against each criterion after completion.
