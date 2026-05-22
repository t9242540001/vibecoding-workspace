# Prompt 01 - Site Audit Skill Research Basis And Series Charter

## CONTEXT

Repository: `t9242540001/vibecoding-workspace`

This repository is the shared infrastructure workspace for Vibe Coding. The goal is to create a universal, reusable website audit system, not a YurAssistent-specific checklist.

The user explicitly wants a T3, multi-prompt, internally consistent series that creates a new `site-audit` skill and supporting standards/templates for future website audits across multiple projects.

This batch is Batch 01 of the series. It must create the research basis and series charter only. Do not create the skill file yet.

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
9. `skills/knowledge-structure/SKILL.md`
10. `skills/universality-discipline/SKILL.md`
11. `skills/anti-hedging-language/SKILL.md`
12. `skills/real-path-verification/SKILL.md`
13. `skills/forward-thinking-discipline/SKILL.md`

Use `rg` to inspect existing site/browser/e2e docs before writing:
- `docs/*browser*`
- `configs/*browser*`
- `docs/*e2e*`
- `configs/*e2e*`
- `docs/real-staging-browser-workflow-design.md`
- `docs/real-public-browser-summary-mvp.md`

## RESEARCH BASIS

Synthesize current website audit best practices from these source categories. If internet access is available, verify and cite official URLs. If internet is unavailable, use the URLs below as named references and clearly state that they are unverified in this runtime.

Primary source URLs to include in the research basis:

- W3C WCAG 2.2 Quick Reference: https://www.w3.org/WAI/WCAG22/quickref/
- Nielsen Norman Group 10 Usability Heuristics: https://www.nngroup.com/articles/ten-usability-heuristics/
- Google Lighthouse overview: https://developer.chrome.com/docs/lighthouse/overview
- Google SEO Starter Guide: https://developers.google.com/search/docs/fundamentals/seo-starter-guide
- Google Helpful Content: https://developers.google.com/search/docs/fundamentals/creating-helpful-content
- Google Structured Data Guidelines: https://developers.google.com/search/docs/appearance/structured-data/sd-policies
- Schema.org documentation: https://schema.org/docs/documents.html

Research dimensions to cover:

1. Technical frontend health:
   - console errors
   - failed network requests
   - broken routes and links
   - hydration/runtime failures
   - asset loading
   - browser compatibility signals
2. UX/usability:
   - navigation
   - clarity
   - user control
   - consistency
   - error prevention
   - state visibility
   - task completion paths
3. Accessibility:
   - WCAG 2.2 Level A/AA practical audit subset
   - keyboard navigation
   - focus
   - labels
   - contrast
   - reflow/mobile zoom
   - status/error messages
4. Responsive/mobile:
   - common mobile widths
   - touch targets
   - layout reflow
   - sticky elements
   - modals/dropdowns
5. Forms and tools:
   - validation
   - error states
   - empty states
   - loading states
   - disabled states
   - file upload
   - consent/terms
   - submit safety boundaries
6. SEO:
   - crawlability
   - titles/descriptions
   - headings
   - canonical URLs
   - internal links
   - robots/sitemap
   - structured data
   - page experience
7. AEO/GEO/AI-friendly content:
   - clear answerable content
   - entity clarity
   - source/citation quality where relevant
   - structured data alignment
   - anti-spam / no manipulative AI-search optimization
   - helpful, reliable, people-first content
8. Copy, grammar, and trust:
   - clarity
   - tone
   - grammar
   - claims
   - legal/compliance disclaimers where relevant
   - no misleading promises
9. Design and visual consistency:
   - typography
   - spacing
   - color
   - components
   - hierarchy
   - visual regressions
10. Analytics and conversion:
   - CTA visibility
   - funnel clarity
   - event instrumentation presence only if safe to inspect
   - no tracking/secrets exposure
11. Public UI security/privacy:
   - no exposed secrets
   - no PII leakage in UI/logged output
   - auth/payments/admin boundaries
   - unsafe form behavior
   - mixed content / insecure assets

## TASK

Create:

1. `docs/site-audit/research-basis.md`
2. `docs/site-audit/series-charter.md`

### `docs/site-audit/research-basis.md`

Must include:

- purpose
- source basis
- audit dimensions
- what is automated vs what requires human/browser judgment
- severity principles
- safe live-audit boundaries
- what must never be done without explicit approval
- how this maps to existing Vibe Coding skills
- open decisions, if any

### `docs/site-audit/series-charter.md`

Must include:

- series goal
- T3 classification
- batch sequence
- dependencies between batches
- acceptance criteria for each batch
- invariants across the series
- handoff rules between research, skill, templates, agentic audit design, validation, and pilot prompt
- expected final repository artifacts

## REGRESSION SHIELD - DO NOT TOUCH

- Do not create `skills/site-audit/SKILL.md` in this batch.
- Do not modify product repositories.
- Do not modify application code.
- Do not modify deploy/server/secrets.
- Do not install dependencies.
- Do not run browser automation.
- Do not touch `_local/`.
- Do not use Claude Routines.
- Do not create YurAssistent-specific audit methodology.
- Keep this batch limited to `docs/site-audit/` and the batch queue files.

## CHECKS

Run:

- `git status --short --branch`
- `git diff --check`

If you inspect files, list them in the final report.

## ACCEPTANCE CRITERIA

- [ ] `docs/site-audit/research-basis.md` exists and is universal.
- [ ] `docs/site-audit/series-charter.md` exists and defines a coherent multi-batch system.
- [ ] The documents do not contradict existing skills/standards.
- [ ] The documents clearly separate read-only audit, non-submit form inspection, and submit/auth/payment/admin actions requiring explicit approval.
- [ ] The documents cover technical, UX, accessibility, responsive, forms/tools, SEO, AEO/GEO, copy/grammar/trust, design consistency, analytics/conversion, and public UI security/privacy.
- [ ] `git diff --check` passes.

## FINAL OUTPUT

Print:

- changed files
- files inspected
- checks run
- any contradictions found and resolved
- whether Batch 02 can proceed
