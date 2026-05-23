# Site Audit Full Agent V2 Consistency Review
<!--
  @file:        docs/site-audit/full-agent-v2-consistency-review.md
  @description: Consistency review for the full-agent v2 site-audit system
  @updated:     2026-05-24
  @version:     1.0
-->

## Review Scope

This review checked whether the `site-audit` full-agent v2 system is internally consistent after Batches 01-05.

No product audit was run. No browser automation, dependency installation, deploy, server, database, secrets, auth, payment, admin, submit, production, or product-repository action was performed.

## Files Inspected

- `AGENTS.md`
- `workspace-index.md`
- `standards/codex-batch-execution-standard.md`
- `standards/VIBECODER_STANDARDS.md`
- `prompts/queue/batch-2026-05-22-site-audit-full-agent-v2-06-consistency/manifest.json`
- `prompts/queue/batch-2026-05-22-site-audit-full-agent-v2-06-consistency/codex-prompt.md`
- `prompts/series/site-audit-full-agent-v2/series-plan.md`
- `docs/site-audit/full-agent-v2-research-basis.md`
- `docs/site-audit/full-agent-v2-charter.md`
- `skills/site-audit/SKILL.md`
- `docs/site-audit/agentic-audit-pipeline.md`
- `docs/site-audit/live-browser-interactive-audit-contract.md`
- `docs/site-audit/marketing-ai-agentic-readiness-standard.md`
- `templates/site-audit/full-audit-scope-template.md`
- `templates/site-audit/test-data-and-access-template.md`
- `templates/site-audit/marketing-ai-agentic-checklist.md`
- `templates/site-audit/report-template.md`
- `templates/site-audit/codex-live-audit-prompt-template.md`
- `prompts/series/site-audit-skill/pilot-public-site-audit-prompt.md`
- `docs/site-audit/validation-gates.md`
- `configs/site-audit-default-scope.json`
- `configs/site-audit-severity-taxonomy.json`
- `templates/site-audit/finding-taxonomy.md`
- `examples/site-audit/sanitized-audit-report-example.md`

## Consistency Matrix

| Area | Status | Evidence |
|---|---|---|
| Full audit capability layers | Aligned | Charter, skill, pipeline, default scope config, live contract, prompt template, and report template all cover static, live HTTP, browser visual, interactive, auth/account, payment-path, admin/access-boundary, API/server-route/SSE, marketing/sales, SEO/AEO/GEO, AI/agentic-commerce, security/privacy, and post-fix regression layers. |
| No product modification rule | Aligned | Skill, pipeline, live contract, full scope template, prompt templates, validation gates, and example report consistently separate audit action from product modification and forbid code, content, data, infrastructure, deploy, server, database, secrets, account, payment, and production-state changes during audit execution. |
| Sensitive data anonymization rule | Aligned | Research basis, charter, skill, live contract, test-data/access template, default scope config, severity taxonomy, validation gates, and report template all forbid raw sensitive values and require anonymized exposure-class reporting. |
| Browser/interactive/auth/payment/admin/server-route evidence contract | Aligned | `docs/site-audit/live-browser-interactive-audit-contract.md`, `docs/site-audit/agentic-audit-pipeline.md`, `templates/site-audit/full-audit-scope-template.md`, and `templates/site-audit/test-data-and-access-template.md` define required scope, allowed evidence, forbidden actions, artifact policy, stop-before points, synthetic data, test accounts, sandbox/stop-before-charge payment policy, and non-destructive admin checks. |
| Marketing/sales/target-audience usefulness | Aligned | The standard, checklist, skill, taxonomy, report template, validation gates, prompt template, and synthetic example all treat marketing/sales effectiveness and target-audience usefulness as first-class, evidence-based dimensions. |
| AI/agentic-commerce readiness | Aligned | The research basis, charter, skill, marketing standard, checklist, severity taxonomy, prompt template, validation gates, and example report require AI/agentic-commerce readiness coverage and label emerging-practice risks without overstating them as hard platform requirements. |
| Report structure | Aligned | `templates/site-audit/report-template.md`, validation gates, prompt template, pilot prompt, and sanitized example require a Markdown report with Russian decision-maker sections, `## 2. Все найденные замечания`, `## 5. English Technical Section`, evidence inventory, finding table, safety notes, stop conditions, and next fix batches. |
| Validation gates | Aligned | `docs/site-audit/validation-gates.md` covers scope completeness, safety boundary compliance, evidence quality, severity quality, SEO/AEO/GEO plus marketing and AI/agentic quality, accessibility, bilingual report completeness, artifact safety, and regression quality. |
| Prompt templates | Aligned | `templates/site-audit/codex-live-audit-prompt-template.md` and `prompts/series/site-audit-skill/pilot-public-site-audit-prompt.md` require scoped evidence, forbidden action boundaries, bilingual report sections, unavailable-layer reporting, and no fabricated browser evidence. |
| Configs and taxonomy | Aligned | `configs/site-audit-default-scope.json`, `configs/site-audit-severity-taxonomy.json`, and `templates/site-audit/finding-taxonomy.md` share the same severity labels, evidence requirements, categories, audit layers, forbidden actions, artifact policy, stop conditions, and sensitive-data handling model. |

## Contradictions Found And Fixes Applied

| Issue | Fix |
|---|---|
| `prompts/series/site-audit-full-agent-v2/series-plan.md`, `docs/site-audit/full-agent-v2-charter.md`, and the Batch 06 prompt referenced `templates/site-audit/test-data-and-credentials-template.md`, but the actual template is `templates/site-audit/test-data-and-access-template.md`. | Updated all three references to the existing `test-data-and-access-template.md` path. |

## Remaining Blockers

No readiness blocker remains in the reusable site-audit system.

The only residual limitation is operational: future product pilots must still provide a product-specific scope, approved routes, report path, artifact policy, and any needed test accounts, sandbox payment mode, admin boundaries, or sanitized browser evidence before those layers can execute.

## JSON Validation Results

- `configs/site-audit-default-scope.json`: valid JSON.
- `configs/site-audit-severity-taxonomy.json`: valid JSON.

## Final Readiness Decision

Ready for full product pilot.

Recommended next batch id:

`batch-2026-05-24-site-audit-full-agent-v2-product-pilot-01`

The pilot should use the v2 system against a single product with a narrow approved scope. It should create a product-specific full audit report only, not product fixes, deploys, server actions, secrets actions, or production-changing actions.
