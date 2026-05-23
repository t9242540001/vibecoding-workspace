---
name: site-audit
description: Evidence-based workflow for full website audits, including static repository, live HTTP, browser visual, interactive user-flow, auth/account, payment-path, admin/access-boundary, API/server-route/SSE, marketing/sales, target-audience usefulness, SEO/AEO/GEO, AI/agentic-commerce readiness, security/privacy/sensitive-data exposure, and post-fix regression checks. Use this skill whenever the user asks to audit, review, inspect, test, improve, or prepare a report/prompt for a website, page, frontend, UI, flow, form/tool, SEO/AEO/GEO/readability/accessibility/performance/conversion audit, agentic-commerce readiness audit, or browser-summary audit review. This skill is mandatory in these situations - not optional. Do NOT use for pure backend architecture audits, generic marketing strategy without website review, one-off copy rewrites not framed as an audit, or deploy/server/secrets debugging unless the issue is audit evidence.
---

# Site Audit
<!--
  @file:        skills/site-audit/SKILL.md
  @description: Evidence-based full website audit workflow and safety boundaries
  @version:     1.2
  @updated:     2026-05-24
-->

---

## 1. Philosophy

Website audit is a repeatable evidence-based process, not casual opinion. The full audit model is:

approved scope -> audit action -> sanitized evidence -> severity-rated findings -> human decision or approved follow-up prompt.

Universal first, product-specific later. The skill defines the reusable process across Vibe Coding product repositories; project-specific context enters through the audit scope, repository knowledge, approved routes, and final report path.

The safety model is capability-positive and modification-negative. A scoped audit may inspect, browse, click, submit synthetic test data, authenticate with approved test accounts, inspect payment paths in sandbox/test or stop-before-charge mode, check admin/access boundaries non-destructively, verify API/server-route/SSE behavior, and evaluate marketing, SEO/AEO/GEO, and AI/agentic-commerce readiness.

The hard boundary is product modification and sensitive-data disclosure. The audit must not change product code, deployed configuration, infrastructure, real product data, real accounts, real payments, secrets, or production state. Sensitive material found during evidence collection is reported only by exposure class, safe location, impact, and remediation path, never by raw value.

---

## 2. Activation Triggers

This skill activates when any observable signal appears:

1. **Website audit request.** The user asks to audit, review, inspect, test, improve, or evaluate a website, landing page, frontend UI, public page, product UI, or browser summary.
2. **Dimension-specific audit request.** The user asks for SEO, AEO/GEO, readability, accessibility, performance, responsive/mobile, form/tool, conversion, trust, copy, design consistency, or public UI security/privacy audit.
3. **Live audit prompt request.** The user asks to prepare a prompt or batch for a live public website audit, browser-summary audit, no-auth flow review, or post-fix regression audit.
4. **Audit report request.** The user asks to create, fill, validate, or summarize a website audit report or finding list.

When the trigger fires, apply the workflow in Section 6 before collecting evidence or writing findings.

### Non-Triggers

Do not use this skill for:

- pure backend architecture audits with no website, frontend, UI, or public page review;
- generic marketing strategy where no website evidence is inspected;
- one-off copy rewrites unless the user frames them as part of a website audit;
- production deployment, server debugging, database work, or secrets work unless the only issue is public UI audit evidence.

---

## 3. Audit Modes And Capability Layers

Do not force a full audit into exactly one mode. Define a scope contract that lists enabled layers, allowed actions, test data/accounts, artifact policy, stop conditions, and unavailable layers. A full audit may combine multiple layers when the scope supports them.

| Layer | Allowed audit action | Boundary |
|---|---|---|
| Static repository audit | Inspect approved source, routes, content, metadata, tests, docs, and public config. | No product-code edits during audit. |
| Live HTTP audit | Check public status, redirects, headers, assets, robots/sitemap, public links, and approved route availability. | No broad crawling, rate-heavy checks, private URLs, or server config changes. |
| Browser visual audit | Inspect rendered pages, viewports, layout, media, visual states, console/network summaries, and approved screenshots when captured. | No raw session artifacts or sensitive screenshots unless explicitly approved and sanitized. |
| Interactive user-flow audit | Exercise approved flows with synthetic data, including clicks, typing, client states, reversible submissions, and documented stop-before points. | Stop before unapproved state change, real data use, destructive action, or sensitive exposure. |
| Auth/account audit | Test login, registration, account states, recovery, profile, roles, and permissions using approved test accounts. | No credential disclosure, real account mutation, or private data reporting. |
| Payment-path audit | Test pricing, checkout, payment states, error handling, receipts, and cancellation in sandbox/test mode or explicit stop-before-charge mode. | No real charge, refund, saved payment mutation, or billing change without separate approval. |
| Admin/access-boundary audit | Check permissions, blocked states, role boundaries, restricted UI/API exposure, and server-side denial non-destructively. | No create/delete/export/refund/settings mutation in production. |
| API/server-route/SSE audit | Verify route connectivity, safe response-shape summaries, stream start/stop behavior, errors, timeouts, and client integration evidence. | No environment, deployment, server, feature-flag, or secrets changes. |
| Marketing/sales/target-audience usefulness audit | Evaluate offer clarity, audience fit, trust, objections, CTA path, proof, pricing, limitations, and decision usefulness. | Findings must be evidence-based and route/section-specific. |
| SEO/AEO/GEO audit | Evaluate crawlability, metadata, structured data, answerability, entity clarity, and people-first content. | No manipulative ranking or AI-search tactics. |
| AI/agentic-commerce readiness audit | Evaluate assistant recommendation accuracy, service/action clarity, stable deep links, structured offers, pricing, availability, policies, and agentic selection/shopping readiness where relevant. | Emerging-practice findings must be labeled and not overstated as platform requirements. |
| Security/privacy/sensitive-data exposure audit | Detect exposed secrets, PII, private endpoints, unsafe errors, and artifact leakage. | Stop risky evidence collection and anonymize sensitive findings. |
| Post-fix regression audit | Re-check prior finding IDs and acceptance criteria after separately approved fixes. | Do not broaden scope, routes, or artifact policy during retest. |

---

## 4. Audit Dimensions

Cover dimensions that are relevant to the approved scope. State skipped dimensions as out of scope; do not force irrelevant findings.

- **Technical frontend health:** console errors, failed public requests, broken routes/links, hydration/runtime failures, blocked assets, mixed content, browser compatibility signals.
- **UX/usability:** navigation clarity, first-viewport task clarity, state visibility, user control, consistency, error prevention, primary user path completion.
- **Accessibility:** titles, headings, landmarks, labels, alt text, keyboard flow, focus, contrast, reflow, status messages, name/role/value where inspectable.
- **Responsive/mobile:** common mobile widths, reflow without horizontal scrolling, readable text, touch targets, sticky overlays, mobile menus/modals/forms.
- **Forms/tools:** labels, required markers, hints, validation, empty/loading/disabled/success/error states, consent/privacy clarity, submit safety.
- **Interactive flows:** clicks, typing, reversible submissions, synthetic data behavior, flow continuity, validation and recovery paths, stop-before boundaries.
- **Auth/account:** login, registration, account recovery, session states, role behavior, profile flows, and credential-handling UX using approved test accounts.
- **Payment-path:** pricing clarity, checkout continuity, sandbox/test payment states, stop-before-charge boundary, error handling, receipts, cancellation, and billing trust signals.
- **Admin/access-boundary:** non-destructive role boundaries, restricted UI visibility, server-side denial behavior, and sensitive admin/API exposure risks.
- **API/server-route/SSE:** public or approved route contracts, status behavior, safe response-shape summaries, stream behavior, timeout/error surfaces, and client integration failures.
- **SEO:** indexability signals, titles, descriptions, headings, canonicals, internal links, public link health, structured data, people-first content.
- **AEO/GEO/AI-friendly content:** answerable sections, entity clarity, useful summaries/FAQs, visible-content and schema alignment, reliable sourcing where claims need support.
- **AI/agentic-commerce readiness:** assistant recommendation fit, service/action clarity, stable deep links, structured offers, pricing/availability/policy clarity, and safe next-step paths.
- **Copy/grammar/trust/legal-risk wording:** clarity, grammar, claim strength, guarantees, pricing/risk wording, disclaimers, contact/company/support signals.
- **Marketing/sales/target-audience usefulness:** audience fit, value proposition, offer specificity, proof, objections, CTA path, and usefulness for real decision questions.
- **Design/visual consistency:** typography hierarchy, spacing, alignment, color/state semantics, component consistency, visual hierarchy, overlap/clipping/broken media.
- **Analytics/conversion:** primary CTA visibility, funnel clarity, safe public instrumentation signals, conversion friction, dead ends, trust gaps.
- **Public UI security/privacy:** exposed secrets, PII, debug output, private endpoints, unsafe errors, mixed content, auth/payment/admin boundary risks.

---

## 5. Evidence And Severity Rules

Every finding must include:

- **Location:** route, file, selector, section, viewport, or report artifact where the issue appears.
- **Evidence:** observed fact, command output, sanitized browser summary, screenshot reference if actually captured, or source line reference.
- **Impact:** user, accessibility, SEO, conversion, trust, safety, privacy, or maintenance consequence.
- **Severity:** Critical, High, Medium, Low, or Observation.
- **Recommendation:** concrete next action or fix prompt direction.

Separate observed facts from inferred risk. Use wording such as "Observed:" and "Inferred risk:" when a risk follows from evidence but was not directly reproduced.

Do not fabricate browser evidence. Screenshots, logs, HAR summaries, Lighthouse results, console output, and network summaries may be cited only when actually captured or provided in an approved sanitized artifact.

### Severity Taxonomy

| Severity | Definition |
|---|---|
| Critical | Blocks a primary user path, exposes secrets/PII, creates auth/payment/admin risk, causes legal/compliance risk, or makes the site unusable. |
| High | Strongly damages task completion, accessibility, trust, SEO discoverability, conversion, or safe decision-making. |
| Medium | Creates meaningful friction, confusion, quality loss, or ranking/measurement weakness without blocking the path. |
| Low | Local polish issue or minor inconsistency with limited user impact. |
| Observation | Useful non-defect signal, opportunity, unknown, or future check that does not currently justify a fix by itself. |

Escalate severity when the issue affects vulnerable users, mobile users, new users, legal/financial/medical decisions, data submission, or high-traffic conversion paths.

---

## 6. Workflow

### Phase 1 - Scope Gate

Define the target site/project, enabled audit layers, allowed actions, forbidden actions, routes/pages, devices/viewports, forms/tools, test data/accounts, payment/admin boundaries, output path, artifact policy, and stop conditions. Use `templates/site-audit/audit-scope-template.md` when a scope is not already explicit.

Stop before execution when the scope omits the required route, test data/account, sandbox/stop-before-charge boundary, artifact policy, or stop condition for the requested layer. Missing tooling, credentials, test accounts, or sandbox payment mode is a limitation to report, not a reason to remove that layer from the universal model.

### Phase 2 - Source And Context Read

For repository audits, read the relevant project instructions, knowledge files, source files, and prior audit reports before judging. For live audits, read the approved scope, route/profile definitions, sanitized summaries, and relevant Vibe Coding browser-safety documents.

### Phase 3 - Audit Plan

Map the approved scope to audit dimensions and evidence sources. State what will be automated, what requires human/browser judgment, and what is out of scope.

### Phase 4 - Execution

Collect only approved evidence. Keep findings tied to locations. Interactive/auth/payment/admin/API actions are allowed audit actions when scoped, synthetic or test-only where required, and non-destructive. Do not change code, deployed config, infrastructure, product data, real accounts, or production state during an audit.

### Phase 5 - Report

Use `templates/site-audit/report-template.md`. The report must be a `.md` file with Russian decision-maker sections and a separate English technical section. Include a Russian executive summary, a Russian complete list of all findings, Russian method and limitations, English technical evidence and finding details, safety/boundary notes, stop conditions, and prioritized next fix batches.

### Phase 6 - Fix Prompt Planning

When fixes are requested, translate findings into scoped Code Agent prompts using `prompt-writing-standard`. Each fix prompt must preserve the original audit evidence, regression shield, and acceptance criteria. High-risk actions remain separately approval-gated.

### Phase 7 - Regression Check

After fixes, run a post-fix regression audit against the original finding IDs and acceptance criteria. Report fixed, partially fixed, not fixed, new regression, or not retested with evidence.

---

## 7. Safety Boundaries

The site audit skill may authorize audit evidence collection across the layers in Section 3 when the scope contract explicitly enables the layer and defines safe data, accounts, artifacts, and stop conditions.

The site audit skill must never authorize these as part of audit execution:

- production-changing actions, deploys, server operations, SSH/SCP, process restarts, database work, or secrets changes;
- reading, printing, storing, or committing secrets, tokens, `.env` values, passwords, cookies, local storage, auth headers, raw request bodies, or raw response bodies;
- real personal data, client data, payment data, real contact-message sending, real account mutation, refunds, deletes, settings changes, or unapproved uploads;
- real payments, live billing changes, saved payment-method mutation, destructive admin actions, irreversible account changes, or production data mutation;
- screenshots, videos, traces, raw HAR, private URLs, broad crawling, scraping, or rate-heavy checks by default;
- bypassing robots, rate limits, auth controls, paywalls, private endpoints, or anti-abuse systems;
- changing application code, product repositories, dependencies, deployment config, or infrastructure as part of the audit itself.

If a secret, credential, personal data, private user data, auth/session material, cookie, token, payment data, or sensitive business data appears in evidence, stop that risky evidence path, do not quote or store the value, and report only the exposure type, safest useful location class, impact, and remediation path.

---

## 8. Connections To Other Skills

- `research-protocol` Section 4 supplies external-source verification and critical review for strategic audit methodology or high-reversal-cost recommendations.
- `docs/site-audit/marketing-ai-agentic-readiness-standard.md` and `templates/site-audit/marketing-ai-agentic-checklist.md` define the reusable audit standard and checklist for marketing/sales effectiveness, target-audience usefulness, SEO/AEO/GEO, AI readability, and AI/agentic-commerce readiness.
- `prompt-writing-standard` Section 2 governs follow-up Code Agent prompts created from audit findings.
- `series-design-discipline` Section 3 keeps multi-batch audit-system work aligned through a Charter.
- `knowledge-structure` Sections 3-5 govern where audit knowledge, reports, and reusable records belong in product repositories.
- `code-markup-standard` applies when an approved follow-up fix touches code comments, headers, RULE comments, or markup.
- `real-path-verification` Sections 4-6 govern runtime fix verification and production-side handoff after audit findings become implementation tasks.
- `forward-thinking-discipline` Section 3 shapes fix prompts that need design-time consequence checks.
- `anti-hedging-language` applies to audit findings: evidence, unknowns, and deferrals must be explicit and actionable.

---

## 9. Anti-Patterns

1. **Generic checklist without evidence.** A finding without location, evidence, impact, severity, and recommendation is not a finding.
2. **Confusing audit action with product modification.** Scoped browsing, clicking, test submission, auth, payment-path, admin-boundary, and API checks can be audit actions; changing code, config, data, infrastructure, accounts, or payments is product modification.
3. **Treating Lighthouse as complete audit.** Automated scores are signals; they do not replace UX, trust, content, accessibility meaning, or mobile judgment.
4. **SEO spam or manipulative AI-search tactics.** Do not recommend keyword stuffing, hidden content, fake freshness, fake reviews, misleading schema, or content made primarily for ranking systems.
5. **Product-specific assumptions in the universal skill.** Product context belongs in scope files and reports, not in this reusable workflow.
6. **Changing code during audit.** An audit observes and reports. Fixes require a separate scoped task.
7. **Unsupported visual claims.** Do not claim layout, color, mobile, or interaction proof without approved visual/browser evidence.
8. **Unsafe artifact expansion.** Do not add screenshots, traces, HAR, cookies, or private session artifacts because they would be convenient.
9. **Over-restricting without reason.** Do not block browser, interactive, auth, payment-path, admin/access-boundary, API/server-route, marketing, or agentic-commerce checks solely because they are beyond read-only observation; scope them safely or report the missing prerequisites.
10. **Sensitive data in reports.** Do not reproduce secrets, credentials, cookies, tokens, personal data, private client data, payment data, or raw private payloads. Report anonymized exposure facts only.

---

## 10. Quick Reference

| Step | Output |
|---|---|
| Scope gate | Enabled audit layers, allowed/forbidden actions, routes, devices, forms/tools, test data/accounts, artifacts, stop conditions |
| Context read | Project/source/live-summary context actually inspected |
| Plan | Dimensions, evidence sources, automated vs human/browser judgment, out-of-scope items |
| Execute | Approved audit actions only, no product modification, no sensitive-data disclosure, no fabricated browser proof |
| Report | Bilingual Markdown report with Russian decision-maker sections and English technical findings with location, evidence, impact, severity, recommendation, and status |
| Fix planning | Separate scoped prompts with regression shield and approval gates |
| Regression | Finding-by-finding retest with evidence and stop conditions |
