# Series Charter - Site Audit V3 Multi-Agent

@series:      batch-2026-05-25-site-audit-v3-multi-agent
@status:      ready-for-review
@created:     2026-05-25
@updated:     2026-05-25

## 1. Product frame

Goal in user-facing terms: Vasily can run a universal multi-agent website audit for different product sites, receive an honest completeness status, get evidence-based findings and prioritized fix batches, and preserve the audit output in project-specific knowledge and Obsidian notes.

Stakeholder: Vasily as the Vibe Coding operator, with product teams and future Code Agents as downstream users of the audit artifacts.

Definition of Done in product language: for a scoped product site, the system can decide whether a full live/browser audit is possible, run only the layers that are approved and supported by evidence, aggregate independent expert findings into a decision-maker report, produce a fix-batch queue, and hand off safe project-level output for Obsidian without changing product code or production systems during the audit.

## 2. Invariants

- V3 is additive first; it wraps and upgrades existing V2 site-audit assets without deleting or renaming them.
- No false full-audit status is allowed; missing live/browser/flow evidence downgrades the outcome.
- V3 artifacts are universal and product-neutral unless the file name explicitly marks a product pilot.
- Findings must separate observed fact, evidence, inferred risk, impact, recommendation, confidence, and status.
- Agent profiles must be future-tunable without rewriting the whole pipeline.
- Audit execution must not change product code, infrastructure, accounts, payments, production data, or deployment state.
- Obsidian output preserves the existing local vault and adds project files only through an approved handoff.
- Secrets, credentials, cookies, raw HAR, raw request/response bodies, payment data, and personal data are never stored in audit artifacts.
- GitHub remains the source of truth for reusable workspace infrastructure; product-specific audit outputs belong in product repositories and project knowledge.

## 3. Dependency map

Prompt 01 produces this Series Charter. All later prompts consume the product frame, invariants, dependency plan, and status tracker.

Prompt 02 produces `docs/site-audit/v3-architecture-contract.md`. Prompts 03-14 consume it as the controlling V3 pipeline contract.

Prompt 03 produces `configs/site-audit-v3-outcome-statuses.json` and `docs/site-audit/v3-outcome-statuses.md`. Prompts 04-14 consume the status model to prevent overstated audit completeness.

Prompt 04 produces `configs/site-audit-v3-evidence-registry.json` and `docs/site-audit/v3-evidence-registry.md`. Prompts 05-14 consume the evidence vocabulary.

Prompt 05 produces `configs/site-audit-v3-agent-registry.json` and `docs/site-audit/v3-agent-registry.md`. Prompts 06-10 consume agent IDs, dependencies, evidence classes, and tunable parameters.

Prompt 06 produces the core agent pack. Prompts 07-10 consume its orchestration, preflight, discovery, static, browser, and scenario rules.

Prompts 07, 08, and 09 produce human/product, risk, and growth/AI agent packs. These are logically parallel after Prompt 05 and after the core preflight/discovery contract exists. Each pack owns distinct expert roles and is consumed by Prompt 10.

Prompt 10 produces the aggregator/risk-board skill plus agent handoff and final report templates. Prompts 11-13 consume the aggregation and output contracts.

Prompt 11 produces the Obsidian output contract and project audit note template. Prompts 12-13 consume the output safety and handoff rules.

Prompt 12 produces validation gates and a reusable checklist. Prompt 13 consumes these gates in the YurAssistent pilot prompt.

Prompt 13 produces the YurAssistent V3 pilot prompt template only. It does not run the audit or modify a product repository.

Prompt 14 verifies expected artifacts, updates navigation, closes this charter, and records missing artifacts if any.

Sequential path: 01 -> 02 -> 03 -> 04 -> 05 -> 06 -> 10 -> 11 -> 12 -> 13 -> 14. Agent-pack path: 07, 08, and 09 are parallelizable after 05 and compatible with the core rules from 06.

Universality decisions: V3 creates universal configs, docs, skill packs, and templates under existing workspace directories. The only product-specific artifact is the YurAssistent pilot prompt template under `prompts/series/site-audit-v3/`; actual YurAssistent audit output belongs in the product repository later.

## 4. Per-step plan

01. Create Series Charter
Status: done 2026-05-25.
Produces: `knowledge/series-charters/2026-05-25-site-audit-v3-multi-agent.md`.
Consumed by: all later prompts.

02. V3 Architecture Contract
Status: done 2026-05-25.
Produces: `docs/site-audit/v3-architecture-contract.md`.
Consumed by: statuses, registries, skills, validation, pilot prompt.

03. Outcome Status Registry
Status: done 2026-05-25.
Produces: `configs/site-audit-v3-outcome-statuses.json`, `docs/site-audit/v3-outcome-statuses.md`.
Consumed by: preflight, aggregator, validation, final reports, pilot prompt.

04. Evidence Registry
Status: done 2026-05-25.
Produces: `configs/site-audit-v3-evidence-registry.json`, `docs/site-audit/v3-evidence-registry.md`.
Consumed by: agent registry, agent packs, aggregator, validation.

05. Agent Registry
Status: done 2026-05-25.
Produces: `configs/site-audit-v3-agent-registry.json`, `docs/site-audit/v3-agent-registry.md`.
Consumed by: all V3 agent packs and aggregator.

06. Core Agent Pack
Status: done 2026-05-25.
Produces: `skills/site-audit-v3-core-agents/SKILL.md`.
Consumed by: expert packs, aggregator, pilot prompt.

07. Human Product Agent Pack
Status: done 2026-05-25.
Produces: `skills/site-audit-v3-human-product-agents/SKILL.md`.
Consumed by: aggregator and pilot prompt.

08. Risk Agent Pack
Status: done 2026-05-25.
Produces: `skills/site-audit-v3-risk-agents/SKILL.md`.
Consumed by: aggregator and pilot prompt.

09. Growth AI Agent Pack
Status: done 2026-05-25.
Produces: `skills/site-audit-v3-growth-ai-agents/SKILL.md`.
Consumed by: aggregator and pilot prompt.

10. Aggregator Risk Board
Status: done 2026-05-25.
Produces: `skills/site-audit-v3-aggregator-risk-board/SKILL.md`, `templates/site-audit/v3-agent-handoff-template.md`, `templates/site-audit/v3-final-report-template.md`.
Consumed by: Obsidian output, validation, pilot prompt.

11. Obsidian Output Contract
Status: done 2026-05-25.
Produces: `docs/site-audit/v3-obsidian-output-contract.md`, `templates/site-audit/v3-obsidian-project-audit-template.md`.
Consumed by: validation and pilot prompt.

12. Validation Gates
Status: done 2026-05-25.
Produces: `docs/site-audit/v3-validation-gates.md`, `templates/site-audit/v3-validation-checklist.md`.
Consumed by: pilot prompt and future audit runs.

13. YurAssistent V3 Pilot Prompt
Status: done 2026-05-25.
Produces: `prompts/series/site-audit-v3/yurassistent-v3-pilot-prompt.md`.
Consumed by: a separate later product-repository pilot.

14. Workspace Navigation Update
Status: done 2026-05-25.
Produces: minimal `workspace-index.md` discoverability updates and this close-out.
Consumed by: future AI orchestrators and Code Agents.

## 5. Definition of Done

Series-level real-path scenario:

- Trigger: Vasily asks to audit a product website using Site Audit V3.
- Input: product repository path, live URL, approved routes, browser profiles, test-account/payment/admin boundaries, allowed artifacts, report path, and Obsidian output path.
- Expected: the Code Agent runs preflight, assigns a V3 outcome status, executes only supported layers, creates agent handoffs, aggregates findings into a final report with fix batches, validates the report, and prepares safe Obsidian output handoff.
- Verify at: product repository report under `reports/site-audit/`, V3 validation checklist, and project-specific Obsidian handoff path.

Knowledge updates required at series close: `workspace-index.md` must reference the V3 docs, configs, skills, templates, and pilot prompt package. Product-specific results are not written by this infrastructure batch.

Close-out: all expected V3 infrastructure artifacts from Prompt 14 exist. This implementation series is ready for review. The next separate action is running the YurAssistent V3 product pilot in the YurAssistent repository with separate approval and scope.

