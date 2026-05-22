---
name: site-audit
description: Evidence-based workflow for auditing websites, landing pages, frontend UI, public no-auth flows, SEO, AEO/GEO, accessibility, performance signals, forms, readability, trust, and live browser audit reports. Use this skill whenever the user asks to audit, review, inspect, test, improve, or prepare a report/prompt for a website, page, frontend, UI, public site flow, form/tool, SEO/AEO/GEO/readability/accessibility/performance/conversion audit, or browser-summary audit review. This skill is mandatory in these situations - not optional. Do NOT use for pure backend architecture audits, generic marketing strategy without website review, one-off copy rewrites not framed as an audit, or deploy/server/secrets debugging unless the issue is public UI audit evidence.
---

# Site Audit
<!--
  @file:        skills/site-audit/SKILL.md
  @description: Evidence-based website audit workflow and safety boundaries
  @version:     1.0
  @updated:     2026-05-22
-->

---

## 1. Philosophy

Website audit is a repeatable evidence-based process, not casual opinion. The audit model is:

approved scope -> safe observation -> structured evidence -> severity-rated findings -> human decision or approved follow-up prompt.

Universal first, product-specific later. The skill defines the reusable process across Vibe Coding product repositories; project-specific context enters through the audit scope, repository knowledge, approved routes, and final report path.

Safety gates come before live actions. Read-only public observation, non-submit form/tool inspection, and submit/auth/payment/admin flows are separate modes. The audit must not expand from observation into production-changing action without separate explicit approval.

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

## 3. Audit Modes

Choose exactly one mode before execution. If the requested action crosses modes, stop and ask for approval.

| Mode | Allowed | Approval gate |
|---|---|---|
| Static repository audit | Read repository files, public configuration, docs, source, and tests inside scope. | Repo-local reads only; no product-code edits unless a separate fix task is approved. |
| Read-only live public audit | Observe approved public no-auth pages, visible text, metadata, high-level console/network summaries, and public link status. | Approved URL/routes and artifact policy required. |
| Non-submit form/tool audit | Inspect fields, labels, hints, validation, disabled/loading/error states, and client-side behavior without submitting data. | Explicit non-submit approval and safe synthetic data only. |
| Approved submit/auth/payment/admin audit | Perform submit, auth, payment, admin, account, upload, or state-changing flows. | Separate explicit approval with route, data, stop conditions, and artifact policy. |
| Post-fix regression audit | Re-check fixed pages or flows against prior findings and acceptance criteria. | Must cite previous report/finding IDs and allowed checks. |

---

## 4. Audit Dimensions

Cover dimensions that are relevant to the approved scope. State skipped dimensions as out of scope; do not force irrelevant findings.

- **Technical frontend health:** console errors, failed public requests, broken routes/links, hydration/runtime failures, blocked assets, mixed content, browser compatibility signals.
- **UX/usability:** navigation clarity, first-viewport task clarity, state visibility, user control, consistency, error prevention, primary user path completion.
- **Accessibility:** titles, headings, landmarks, labels, alt text, keyboard flow, focus, contrast, reflow, status messages, name/role/value where inspectable.
- **Responsive/mobile:** common mobile widths, reflow without horizontal scrolling, readable text, touch targets, sticky overlays, mobile menus/modals/forms.
- **Forms/tools:** labels, required markers, hints, validation, empty/loading/disabled/success/error states, consent/privacy clarity, submit safety.
- **SEO:** indexability signals, titles, descriptions, headings, canonicals, internal links, public link health, structured data, people-first content.
- **AEO/GEO/AI-friendly content:** answerable sections, entity clarity, useful summaries/FAQs, visible-content and schema alignment, reliable sourcing where claims need support.
- **Copy/grammar/trust/legal-risk wording:** clarity, grammar, claim strength, guarantees, pricing/risk wording, disclaimers, contact/company/support signals.
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

Define the target site/project, audit mode, allowed actions, forbidden actions, routes/pages, devices/viewports, forms/tools, output path, artifact policy, and approval gates. Use `templates/site-audit/audit-scope-template.md` when a scope is not already explicit.

Stop before execution if the request implies submit/auth/payment/admin actions, real personal data, screenshots/videos/traces/raw HAR, private URLs, or server/deploy/secrets/database access without approval.

### Phase 2 - Source And Context Read

For repository audits, read the relevant project instructions, knowledge files, source files, and prior audit reports before judging. For live audits, read the approved scope, route/profile definitions, sanitized summaries, and relevant Vibe Coding browser-safety documents.

### Phase 3 - Audit Plan

Map the approved scope to audit dimensions and evidence sources. State what will be automated, what requires human/browser judgment, and what is out of scope.

### Phase 4 - Execution

Collect only approved evidence. Keep findings tied to locations. Do not change code during an audit unless the user has approved a separate fix task.

### Phase 5 - Report

Use `templates/site-audit/report-template.md`. The report must be a `.md` file with Russian decision-maker sections and a separate English technical section. Include a Russian executive summary, a Russian complete list of all findings, Russian method and limitations, English technical evidence and finding details, safety/boundary notes, stop conditions, and prioritized next fix batches.

### Phase 6 - Fix Prompt Planning

When fixes are requested, translate findings into scoped Code Agent prompts using `prompt-writing-standard`. Each fix prompt must preserve the original audit evidence, regression shield, and acceptance criteria. High-risk actions remain separately approval-gated.

### Phase 7 - Regression Check

After fixes, run a post-fix regression audit against the original finding IDs and acceptance criteria. Report fixed, partially fixed, not fixed, new regression, or not retested with evidence.

---

## 7. Safety Boundaries

The site audit skill must never authorize these without separate explicit approval:

- production-changing actions, deploys, server operations, SSH/SCP, process restarts, database work, or secrets changes;
- reading, printing, storing, or committing secrets, tokens, `.env` values, passwords, cookies, local storage, auth headers, raw request bodies, or raw response bodies;
- real personal data, client data, payment data, contact-message sending, account creation, login/logout, refunds, deletes, settings changes, or uploads;
- auth, admin, billing, payment, account-management, or destructive flows;
- screenshots, videos, traces, raw HAR, private URLs, broad crawling, scraping, or rate-heavy checks by default;
- bypassing robots, rate limits, auth controls, paywalls, private endpoints, or anti-abuse systems;
- changing application code, product repositories, dependencies, deployment config, or infrastructure as part of the audit itself.

If a secret, credential, private user data, auth/session material, or payment data appears in evidence, stop the audit, do not quote the value, and report the exposure at a high level.

---

## 8. Connections To Other Skills

- `research-protocol` Section 4 supplies external-source verification and critical review for strategic audit methodology or high-reversal-cost recommendations.
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
2. **Mixing audit with action.** Read-only audit, non-submit inspection, and submit/payment/admin actions are separate modes.
3. **Treating Lighthouse as complete audit.** Automated scores are signals; they do not replace UX, trust, content, accessibility meaning, or mobile judgment.
4. **SEO spam or manipulative AI-search tactics.** Do not recommend keyword stuffing, hidden content, fake freshness, fake reviews, misleading schema, or content made primarily for ranking systems.
5. **Product-specific assumptions in the universal skill.** Product context belongs in scope files and reports, not in this reusable workflow.
6. **Changing code during audit.** An audit observes and reports. Fixes require a separate scoped task.
7. **Unsupported visual claims.** Do not claim layout, color, mobile, or interaction proof without approved visual/browser evidence.
8. **Unsafe artifact expansion.** Do not add screenshots, traces, HAR, cookies, or private session artifacts because they would be convenient.

---

## 10. Quick Reference

| Step | Output |
|---|---|
| Scope gate | Audit mode, allowed/forbidden actions, routes, devices, forms/tools, artifacts, approval gates |
| Context read | Project/source/live-summary context actually inspected |
| Plan | Dimensions, evidence sources, automated vs human/browser judgment, out-of-scope items |
| Execute | Approved evidence only, no code changes, no fabricated browser proof |
| Report | Bilingual Markdown report with Russian decision-maker sections and English technical findings with location, evidence, impact, severity, recommendation, and status |
| Fix planning | Separate scoped prompts with regression shield and approval gates |
| Regression | Finding-by-finding retest with evidence and stop conditions |
