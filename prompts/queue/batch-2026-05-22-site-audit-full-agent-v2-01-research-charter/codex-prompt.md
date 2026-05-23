# Prompt 01 - Site Audit Full Agent V2 Research And Charter

## CONTEXT

Repository: `t9242540001/vibecoding-workspace`

This is Batch 01 of the `site-audit-full-agent-v2` series.

The existing `site-audit` system started as a safe read-only audit protocol. The target is now a full universal website audit agent protocol.

Important clarified rule:

- Audit capabilities should not be blocked by default.
- The hard prohibition is on changing product code/data/config/infrastructure during audit and on disclosing sensitive data in reports.
- If personal data, secrets, passwords, API keys, tokens, cookies, auth headers, or similar sensitive material are encountered, report the risk only in anonymized form.

This batch creates the research basis and charter only. It does not update the skill yet.

## REQUIRED READS

Read before editing:

1. `AGENTS.md`
2. `workspace-index.md`
3. `standards/VIBECODER_STANDARDS.md`
4. `standards/codex-batch-execution-standard.md`
5. `skills/research-protocol/SKILL.md`
6. `skills/skill-writing-standard/SKILL.md`
7. `skills/prompt-writing-standard/SKILL.md`
8. `skills/series-design-discipline/SKILL.md`
9. `skills/site-audit/SKILL.md`
10. `docs/site-audit/research-basis.md`
11. `docs/site-audit/series-charter.md`
12. `docs/site-audit/system-consistency-review.md`
13. `prompts/series/site-audit-full-agent-v2/series-plan.md`

Inspect existing site-audit docs/configs/templates with:

- `rg "site-audit|browser|interactive|auth|payment|admin|marketing|sales|AI|agentic|AEO|GEO|commerce|report" docs skills templates configs prompts workspace-index.md`

## TASK

Create:

1. `docs/site-audit/full-agent-v2-research-basis.md`
2. `docs/site-audit/full-agent-v2-charter.md`

Update only if strictly needed:

3. `workspace-index.md`

## RESEARCH BASIS REQUIREMENTS

`docs/site-audit/full-agent-v2-research-basis.md` must be an internal research basis. It must not pretend to be exhaustive. It must distinguish authoritative platform guidance, established UX/content guidance, and emerging industry practices.

Cover:

1. Full website audit capability model.
2. Difference between audit action and product modification.
3. Sensitive data handling and anonymized reporting.
4. Live HTTP and browser evidence.
5. Interactive flow testing with synthetic data.
6. Auth/account testing with test accounts.
7. Payment path testing with test/sandbox mode or stop-before-charge boundaries.
8. Admin/access-boundary testing with non-destructive checks.
9. Technical route/API/SSE/server connectivity verification as audit evidence, not config changes.
10. Marketing/sales/target-audience usefulness audit:
    - value proposition clarity;
    - target audience fit;
    - offer clarity;
    - trust and objection handling;
    - CTA and conversion path;
    - usefulness of information and tools for the intended audience.
11. AI/AEO/GEO/agentic-commerce readiness audit:
    - answerability;
    - entity clarity;
    - machine-readable structured data;
    - service/tool/action clarity;
    - stable URLs/deep links;
    - pricing/offer/limitations clarity;
    - readiness for AI assistants to recommend the service accurately;
    - readiness for agentic shopping/service-selection workflows where relevant.
12. Report requirements:
    - full `.md` report;
    - Russian decision-maker sections;
    - English technical section;
    - all findings included;
    - evidence, limitations, stop conditions, next batches.

Use concise source notes. If external URLs are not available locally, include source categories and exact source names to verify later. Do not fabricate direct citations.

## CHARTER REQUIREMENTS

`docs/site-audit/full-agent-v2-charter.md` must define the full multi-batch upgrade series.

Include:

1. Goal.
2. T3 classification.
3. New safety model:
   - allowed to audit;
   - forbidden to modify product during audit;
   - forbidden to disclose sensitive data;
   - sensitive findings reported anonymized.
4. Audit capability layers:
   - static repository audit;
   - live HTTP audit;
   - browser visual audit;
   - interactive user-flow audit;
   - auth/account audit;
   - payment path audit;
   - admin/access-boundary audit;
   - API/server-route/SSE audit;
   - marketing/sales/target-audience usefulness audit;
   - SEO/AEO/GEO audit;
   - AI/agentic-commerce readiness audit;
   - security/privacy/sensitive-data exposure audit;
   - post-fix regression audit.
5. Batch sequence and dependencies matching `prompts/series/site-audit-full-agent-v2/series-plan.md`.
6. Invariants.
7. Definition of done.
8. Explicit statement that YurAssistent is only a product pilot target, not a universal methodology source.

## REGRESSION SHIELD - DO NOT TOUCH

- Do not modify product repositories.
- Do not run a real website audit.
- Do not run browser automation.
- Do not install dependencies.
- Do not modify application code.
- Do not modify deploy/server/secrets/database configs.
- Do not touch `_local/`.
- Do not use Claude Routines.
- Do not rewrite existing `site-audit` skill in this batch.
- Do not change templates/configs in this batch.
- Keep edits limited to listed files and batch queue files.

## CHECKS

Run:

- `git status --short --branch`
- `git diff --check`
- `rg "full-agent-v2|agentic-commerce|target-audience|sensitive data|forbidden to modify" docs/site-audit prompts/series/site-audit-full-agent-v2 workspace-index.md`

## ACCEPTANCE CRITERIA

- [ ] Research basis exists and covers full audit, marketing/sales, and AI/agentic-commerce readiness.
- [ ] Charter exists and defines a coherent T3 series.
- [ ] No operational skill/template/config behavior changed in this batch.
- [ ] No real audit or product repo change occurred.
- [ ] `git diff --check` passes.

## FINAL OUTPUT

Print:

- changed files
- files inspected
- checks run
- whether Batch 02 can proceed
- blockers or contradictions
