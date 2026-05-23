# Prompt 04 - Marketing, Sales, Target Audience, AI And Agentic Readiness

## CONTEXT

Repository: `t9242540001/vibecoding-workspace`

This is Batch 04 of the `site-audit-full-agent-v2` series.

Batches 01-03 define the full audit target, update the core skill/modes, and create the live/browser/interactive evidence contract. This batch makes marketing, sales, target-audience usefulness, SEO/AEO/GEO, AI-friendliness, and agentic-commerce readiness first-class audit areas.

This batch updates methodology only. Do not run a product audit.

## REQUIRED READS

Read before editing:

1. `AGENTS.md`
2. `workspace-index.md`
3. `docs/site-audit/full-agent-v2-research-basis.md`
4. `docs/site-audit/full-agent-v2-charter.md`
5. `skills/site-audit/SKILL.md`
6. `docs/site-audit/agentic-audit-pipeline.md`
7. `docs/site-audit/live-browser-interactive-audit-contract.md`
8. `templates/site-audit/finding-taxonomy.md`
9. `configs/site-audit-severity-taxonomy.json`
10. `templates/site-audit/report-template.md`
11. `templates/site-audit/full-audit-scope-template.md`
12. `docs/site-audit/validation-gates.md`

Use `rg "marketing|sales|target|audience|AI|AEO|GEO|agentic|commerce|structured data|schema|offer|CTA|trust" docs skills templates configs workspace-index.md` before editing.

## TASK

Create:

1. `docs/site-audit/marketing-ai-agentic-readiness-standard.md`
2. `templates/site-audit/marketing-ai-agentic-checklist.md`

Update:

3. `templates/site-audit/finding-taxonomy.md`
4. `configs/site-audit-severity-taxonomy.json`
5. `skills/site-audit/SKILL.md` only if needed to cross-reference the new standard
6. `workspace-index.md` only if needed

## STANDARD REQUIREMENTS

`docs/site-audit/marketing-ai-agentic-readiness-standard.md` must define how to audit:

### Marketing / Sales / Target Audience Usefulness

- target audience clarity;
- user pain and job-to-be-done clarity;
- value proposition clarity in first viewport;
- service/tool usefulness for the intended audience;
- offer clarity and differentiation;
- pricing/tariff clarity;
- conversion path clarity;
- CTA relevance;
- objections and trust gaps;
- proof, credibility, and company/contact signals;
- content usefulness and decision support;
- mismatch between claimed value and actual tool/page behavior.

### SEO / AEO / GEO

- people-first content;
- answerability for user questions;
- entity clarity;
- headings and page structure;
- internal links and stable URLs;
- metadata and snippets;
- FAQ and direct-answer sections where useful;
- sources or support for high-stakes claims;
- avoid manipulative SEO/AI-search tactics.

### AI / Agentic Commerce Readiness

Treat this as a separate first-class audit block, not just SEO.

Audit whether AI assistants and future agentic-commerce/service-selection agents can:

- understand who operates the site;
- understand what service/tools are offered;
- understand who the service is for;
- understand when to recommend it and when not to;
- identify stable URLs/deep links for services/tools/pricing/FAQ/terms;
- parse offer/pricing/limitations/refund or no-guarantee conditions;
- compare the service with alternatives without hallucinating;
- route a user to the right tool/action;
- understand input requirements and expected outputs;
- avoid unsafe recommendations in legal/financial/medical/high-stakes contexts;
- use structured data that matches visible content;
- respect user confirmation points for actions.

Include recommended evidence types:

- visible page content;
- schema.org / JSON-LD;
- sitemap/robots/canonical signals;
- service/tool pages;
- pricing and terms pages;
- FAQ/direct answer pages;
- internal links and deep links;
- browser and source evidence.

Include anti-patterns:

- keyword stuffing;
- hidden content;
- misleading schema;
- AI-only content not useful to users;
- fake reviews/proof;
- unclear operator or offer;
- tools hidden only inside modals with no stable page;
- pricing/actions unclear to humans or agents;
- unsafe high-stakes recommendation wording.

## CHECKLIST REQUIREMENTS

`templates/site-audit/marketing-ai-agentic-checklist.md` must be a reusable checklist with sections:

1. Target audience.
2. User problem and value proposition.
3. Offer and sales path.
4. Content usefulness.
5. Trust and objections.
6. Conversion and CTA.
7. SEO/AEO/GEO.
8. AI assistant readability.
9. Agentic-commerce/service-selection readiness.
10. Structured data and machine readability.
11. High-stakes safety and limitations.
12. Required findings and evidence.

## TAXONOMY UPDATES

Update finding categories so marketing/sales/target-audience and AI/agentic-commerce readiness can be reported distinctly.

Required categories or equivalents:

- Marketing/sales effectiveness.
- Target-audience usefulness.
- AI/agentic-commerce readiness.
- SEO/AEO/GEO remains separate but connected.

JSON must remain valid.

## REGRESSION SHIELD - DO NOT TOUCH

- Do not run a real audit.
- Do not modify product repositories.
- Do not modify application code.
- Do not deploy or change server/database/secrets/config.
- Do not install dependencies.
- Do not run browser automation.
- Do not touch `_local/`.
- Do not use Claude Routines.
- Do not create YurAssistent-specific content.
- Do not recommend manipulative SEO or AI-search tactics.
- Keep edits limited to listed files and batch queue files.

## CHECKS

Run:

- `python3 -m json.tool configs/site-audit-severity-taxonomy.json >/dev/null`
- `git diff --check`
- `rg "agentic-commerce|target-audience|Marketing/sales|AI assistant|structured data|people-first|CTA" docs/site-audit templates/site-audit skills/site-audit configs workspace-index.md`

## ACCEPTANCE CRITERIA

- [ ] Marketing/sales/target-audience standard exists.
- [ ] AI/agentic-commerce readiness is a separate first-class audit block.
- [ ] Checklist exists and is reusable.
- [ ] Finding taxonomy supports the new areas.
- [ ] JSON remains valid.
- [ ] No product repo/audit/code changes occurred.
- [ ] `git diff --check` passes.

## FINAL OUTPUT

Print:

- changed files
- files inspected
- checks run
- whether Batch 05 can proceed
- blockers or contradictions
