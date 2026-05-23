# Prompt 06 - Site Audit Full Agent V2 Consistency Review And Orchestrator

## CONTEXT

Repository: `t9242540001/vibecoding-workspace`

This is Batch 06 of the `site-audit-full-agent-v2` series.

Batches 01-05 should have upgraded the universal site-audit system into a full audit agent protocol with:

- full audit capability model;
- no product modification during audit;
- no sensitive data disclosure;
- browser/interactive/auth/payment/admin/server-route evidence contract;
- marketing/sales/target-audience usefulness;
- AI/agentic-commerce readiness;
- full bilingual `.md` report requirements.

This batch checks consistency and writes a series README/orchestrator note. It does not run a product audit.

## REQUIRED READS

Read before editing:

1. `AGENTS.md`
2. `workspace-index.md`
3. `prompts/series/site-audit-full-agent-v2/series-plan.md`
4. `docs/site-audit/full-agent-v2-research-basis.md`
5. `docs/site-audit/full-agent-v2-charter.md`
6. `skills/site-audit/SKILL.md`
7. `docs/site-audit/agentic-audit-pipeline.md`
8. `docs/site-audit/live-browser-interactive-audit-contract.md`
9. `docs/site-audit/marketing-ai-agentic-readiness-standard.md`
10. `templates/site-audit/full-audit-scope-template.md`
11. `templates/site-audit/test-data-and-credentials-template.md`
12. `templates/site-audit/marketing-ai-agentic-checklist.md`
13. `templates/site-audit/report-template.md`
14. `templates/site-audit/codex-live-audit-prompt-template.md`
15. `prompts/series/site-audit-skill/pilot-public-site-audit-prompt.md`
16. `docs/site-audit/validation-gates.md`
17. `configs/site-audit-default-scope.json`
18. `configs/site-audit-severity-taxonomy.json`
19. `templates/site-audit/finding-taxonomy.md`
20. `examples/site-audit/sanitized-audit-report-example.md`

Use `rg "full-agent-v2|agentic-commerce|target-audience|product modification|sensitive data|browser visual|interactive|auth|payment|admin|English Technical Section|Все найденные замечания" docs skills templates configs prompts examples workspace-index.md` before editing.

## TASK

Create:

1. `docs/site-audit/full-agent-v2-consistency-review.md`
2. `prompts/series/site-audit-full-agent-v2/README.md`

Update only if strictly needed:

3. `workspace-index.md`
4. `prompts/series/site-audit-full-agent-v2/series-plan.md`
5. Any site-audit docs/templates/configs only for small consistency fixes discovered during review.

## CONSISTENCY REVIEW REQUIREMENTS

`docs/site-audit/full-agent-v2-consistency-review.md` must include:

1. Review scope.
2. Files inspected.
3. Consistency matrix for:
   - full audit capability layers;
   - no product modification rule;
   - sensitive data anonymization rule;
   - browser/interactive/auth/payment/admin/server-route evidence contract;
   - marketing/sales/target-audience usefulness;
   - AI/agentic-commerce readiness;
   - report structure;
   - validation gates;
   - prompt templates;
   - configs and taxonomy.
4. Contradictions found and fixes applied.
5. Remaining blockers if any.
6. JSON validation results.
7. Final readiness decision:
   - ready for full product pilot / not ready;
   - exact next recommended batch id if ready.

## README / ORCHESTRATOR REQUIREMENTS

`prompts/series/site-audit-full-agent-v2/README.md` must explain:

- goal of the series;
- batch sequence;
- how to run batches with `vcw`;
- final expected outcome;
- next product-pilot batch recommendation.

It must include copy-paste commands:

```powershell
vcw pull
vcw batch batch-2026-05-22-site-audit-full-agent-v2-01-research-charter
vcw batch batch-2026-05-22-site-audit-full-agent-v2-02-skill-modes
vcw batch batch-2026-05-22-site-audit-full-agent-v2-03-interactive-contract
vcw batch batch-2026-05-22-site-audit-full-agent-v2-04-marketing-ai-agentic
vcw batch batch-2026-05-22-site-audit-full-agent-v2-05-report-validation
vcw batch batch-2026-05-22-site-audit-full-agent-v2-06-consistency
vcw status
```

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
- Do not weaken no-product-modification or sensitive-data anonymization rules.
- Keep edits limited to listed files and batch queue files.

## CHECKS

Run:

- `python3 -m json.tool configs/site-audit-default-scope.json >/dev/null`
- `python3 -m json.tool configs/site-audit-severity-taxonomy.json >/dev/null`
- `git diff --check`
- `rg "full product pilot|agentic-commerce|target-audience|sensitive data|product modification|English Technical Section|Все найденные замечания" docs/site-audit skills/site-audit templates/site-audit prompts/series configs examples/site-audit workspace-index.md`

## ACCEPTANCE CRITERIA

- [ ] Consistency review exists.
- [ ] Series README/orchestrator exists.
- [ ] Review covers all V2 dimensions and rules.
- [ ] Contradictions are fixed or recorded as blockers.
- [ ] JSON configs remain valid.
- [ ] No product repo/audit/code changes occurred.
- [ ] `git diff --check` passes.

## FINAL OUTPUT

Print:

- changed files
- files inspected
- checks run
- contradictions fixed
- readiness decision
- next recommended product-pilot batch id
