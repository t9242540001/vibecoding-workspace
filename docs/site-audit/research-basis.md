# Site Audit Research Basis

<!--
  @file:        docs/site-audit/research-basis.md
  @description: Research basis for the universal Vibe Coding site audit skill series
  @updated:     2026-05-22
  @version:     1.0
-->

## Purpose

This document defines the research basis for a universal website audit system for Vibe Coding.

The future `site-audit` skill must audit public websites, landing pages, product UIs, and safe no-auth flows across projects. It must not become a YurAssistent-specific checklist, a Lighthouse-only checklist, or an unrestricted browser automation procedure.

The audit model is:

approved scope -> safe observation -> structured evidence -> severity-rated findings -> human decision or approved follow-up prompt.

## Source Basis

The research basis combines official and durable public guidance with existing Vibe Coding browser-safety documents.

Verified external sources:

- W3C [WCAG 2.2 Quick Reference](https://www.w3.org/WAI/WCAG22/quickref/) for accessibility success criteria and techniques, especially perceivable, operable, understandable, and robust checks.
- Nielsen Norman Group [10 Usability Heuristics](https://www.nngroup.com/articles/ten-usability-heuristics/) for usability review principles: status visibility, user control, consistency, error prevention, recognition, efficiency, minimalist design, error recovery, and help.
- Chrome for Developers [Lighthouse overview](https://developer.chrome.com/docs/lighthouse/overview) for automated page-quality categories such as performance, accessibility, SEO, and related audits.
- Google Search Central [SEO Starter Guide](https://developers.google.com/search/docs/fundamentals/seo-starter-guide) for crawlability, page resources, useful content, headings, links, canonicalization, and user-oriented content.
- Google Search Central [Creating helpful, reliable, people-first content](https://developers.google.com/search/docs/fundamentals/creating-helpful-content) for AEO/GEO boundaries: answerable content is valid only when it remains helpful, reliable, and people-first rather than manipulative search-engine-first content.
- Google Search Central [General structured data guidelines](https://developers.google.com/search/docs/appearance/structured-data/sd-policies) for structured data quality: visible-content alignment, non-misleading markup, completeness, access, and rich-result eligibility limits.
- [Schema.org documentation](https://schema.org/docs/documents.html) for schema vocabulary, type hierarchy, data model, validator, and extension references.

Existing Vibe Coding sources:

- `docs/real-public-browser-summary-mvp.md`
- `docs/real-public-browser-content-audit-v1.md`
- `docs/real-public-browser-link-check-v1.md`
- `docs/browser-test-intent-taxonomy.md`
- `docs/real-staging-browser-workflow-design.md`
- `docs/browser-automation-handoff-contract.md`
- `docs/e2e-staging-summary-contract.md`
- `configs/browser-automation-handoff-contract.json`
- `configs/e2e-staging-summary-contract.json`

The existing Vibe Coding browser documents establish the safety envelope: approved route labels, approved interaction profiles, sanitized summaries, validation before model analysis, no arbitrary browser commands, no default screenshots/HAR/traces, and explicit approval gates for forms, auth, payments, private data, and higher-risk journeys.

## Audit Dimensions

### 1. Technical Frontend Health

Check:

- console errors and warnings that affect user-visible behavior;
- failed network requests, unexpected 4xx/5xx responses, blocked assets, and mixed content;
- broken public routes and public links;
- hydration and runtime failures;
- asset loading for fonts, images, scripts, CSS, icons, and media;
- browser compatibility signals that appear in console output, feature usage, or obvious fallback failure.

Automated evidence can include sanitized console summaries, high-level network summaries, link status checks, page-load status, and Lighthouse-style signals. Human/browser judgment is required when the effect is visual, intermittent, device-specific, or hidden behind interaction.

### 2. UX And Usability

Check:

- navigation clarity and expected next step;
- offer, product, or task clarity in the first viewport;
- visibility of system state for loading, progress, selected state, and submitted state;
- user control and freedom for cancellation, backtracking, undo, close, and escape actions;
- consistency of labels, controls, layout, and interaction patterns;
- error prevention before irreversible or high-cost actions;
- task completion paths for the primary audience.

NN/g heuristics are used as review principles, not as a rigid scorecard. The audit must name the affected user path and the evidence observed.

### 3. Accessibility

Use a practical WCAG 2.2 A/AA subset:

- meaningful page titles, headings, landmarks, labels, and link text;
- text alternatives for informative images and controls;
- keyboard navigation, focus order, visible focus, and no keyboard traps;
- color contrast for text and non-text UI where inspectable;
- reflow, resize text, mobile zoom, and orientation robustness;
- labels, instructions, error identification, error suggestions, and status messages;
- name, role, and value for controls when inspectable.

Automated tools can find many missing labels, contrast failures, heading-order issues, and ARIA problems. Human judgment remains required for meaning, sequence, focus usability, error-message usefulness, and whether a text alternative serves the same purpose as the visual content.

### 4. Responsive And Mobile

Check:

- common mobile widths such as 320, 360, 375, 390, 414, and tablet breakpoints when the approved audit scope allows viewport checks;
- layout reflow without horizontal scrolling for normal content;
- readable text without viewport-width font hacks;
- touch target size and spacing;
- sticky headers, cookie bars, chat widgets, and floating CTAs that do not obscure content;
- modals, dropdowns, nav menus, and accordions on mobile.

Text-only sanitized summaries can detect weak mobile-readiness signals. Visual proof needs browser viewport inspection and, if screenshots are required, separate explicit approval under the existing artifact policy.

### 5. Forms And Tools

Check:

- visible fields, labels, required markers, hints, and accepted formats;
- validation behavior before submission where non-submit interaction is approved;
- empty, loading, disabled, success, and error states;
- file upload boundaries and accepted types where visible;
- consent, terms, privacy, and data-use clarity;
- submit safety boundaries and post-submit side effects.

Read-only form inspection and non-submit interaction are separate from submission. Form submission, auth, payment, account creation, contact-message sending, destructive actions, or use of real personal data always require separate explicit approval.

### 6. SEO

Check:

- crawlability signals: indexability, robots/sitemap references where safely inspectable, and resource availability;
- titles and meta descriptions;
- heading structure and page topic clarity;
- canonical URLs and duplicate content signals;
- internal link structure and descriptive anchors;
- public link health;
- structured data presence, validity, completeness, and alignment with visible content;
- page experience signals that affect users: performance, intrusive layout shifts, mobile usability, and errors.

SEO recommendations must serve people first. The audit must not recommend manipulative keyword stuffing, fake freshness, misleading structured data, fake reviews, hidden content, or content created primarily to capture search traffic.

### 7. AEO/GEO/AI-Friendly Content

Check:

- clear answerable sections for real user questions;
- entity clarity: who the site is, what it offers, where it operates, and what terms mean;
- source and citation quality where factual, legal, medical, financial, or technical claims are made;
- alignment between visible content, structured data, headings, and internal links;
- concise summaries, definitions, FAQs, and comparison content only when useful to the target audience;
- absence of manipulative AI-search optimization.

The principle is answerability without deception. AEO/GEO improvements are valid when they make the site clearer for humans and machines. They are invalid when they fabricate authority, hide content, overproduce generic pages, or optimize against search systems instead of user needs.

### 8. Copy, Grammar, And Trust

Check:

- plain-language clarity for the target audience;
- grammar, spelling, punctuation, and terminology consistency;
- claim strength and evidence;
- promises, guarantees, pricing language, risk statements, and limitations;
- legal, medical, financial, or compliance disclaimers where relevant;
- contact, company, author, expert, policy, and support signals.

The audit must flag misleading promises, unverifiable claims, hidden limitations, missing disclaimers in high-risk domains, and trust gaps that prevent a real user from deciding safely.

### 9. Design And Visual Consistency

Check:

- typography hierarchy and readable scale;
- spacing rhythm and alignment;
- color use, semantic contrast, and state colors;
- component consistency for buttons, cards, forms, navigation, tables, and modals;
- visual hierarchy and scan path;
- obvious regressions, overlap, clipping, layout shifts, and broken media.

Text-only audits can identify only partial design signals. Visual consistency requires approved browser inspection and may require screenshots or manual review if the default artifact policy does not allow visual capture.

### 10. Analytics And Conversion

Check:

- primary CTA visibility and clarity;
- funnel clarity from first viewport to next safe step;
- event instrumentation presence only when safe to inspect from public code or sanitized summaries;
- no tracking secrets, tokens, or private identifiers in public UI or artifacts;
- conversion-blocking friction, dead ends, or trust gaps.

The audit can recommend instrumentation checks but must not inspect private analytics dashboards, credentials, or hidden tracking configurations without explicit approval.

### 11. Public UI Security And Privacy

Check:

- exposed secrets, tokens, API keys, credentials, debug output, internal paths, server IPs, or private endpoints in public UI, source, console, or sanitized network summaries;
- PII leakage in visible text, URLs, logs, form defaults, error messages, or artifacts;
- auth, payment, admin, logout, account-management, and destructive-action boundaries;
- unsafe form behavior or unexpected submission side effects;
- mixed content and insecure assets.

Security/privacy findings are severity escalators. The audit must stop if it encounters secrets, credentials, private client data, real personal data, payment data, or auth/session material beyond the approved scope.

## Automated Versus Human Or Browser Judgment

Automated or semi-automated checks are appropriate for:

- HTTP status and public route/link health;
- sanitized console and network summary counts;
- detectable accessibility issues such as missing labels, obvious contrast failures, heading anomalies, and ARIA misuse;
- Lighthouse-style performance, accessibility, SEO, and best-practice signals;
- structured data syntax and visible-content alignment checks where source is inspectable;
- title, description, canonical, robots, sitemap, heading, and link inventories;
- spelling and grammar suggestions;
- forbidden-pattern scans for secrets and sensitive data in permitted artifacts.

Human or browser judgment is required for:

- user goal fit, trust, claim quality, and domain risk;
- whether content is genuinely useful, reliable, and people-first;
- visual hierarchy, brand fit, spacing, layout, and interaction quality;
- keyboard-flow usefulness beyond static rule detection;
- mobile layout proof and sticky/overlay behavior;
- whether form validation helps a real user recover;
- whether a CTA, claim, or page flow is appropriate for the target audience;
- severity assignment when multiple dimensions interact.

## Severity Principles

Use severity to communicate user impact and risk, not personal taste.

| Severity | Meaning | Examples |
|---|---|---|
| Critical | Blocks a primary user path, exposes secrets/PII, causes auth/payment/admin risk, or creates legal/compliance risk. | Public API key leak, payment flow exposed, form submits real data unexpectedly, homepage cannot load. |
| High | Strongly damages task completion, accessibility, trust, SEO discoverability, or safe decision-making. | Primary CTA missing, keyboard trap, mobile layout unusable, misleading claim, structured data contradicts visible content. |
| Medium | Creates meaningful friction, confusion, quality loss, or ranking/measurement weakness without blocking the path. | Weak headings, inconsistent labels, missing loading state, several broken secondary links. |
| Low | Local polish issue or minor inconsistency with limited user impact. | Minor spacing inconsistency, one typo in non-critical copy, secondary icon alignment issue. |
| Observation | Observation useful for future work but not a defect. | Instrumentation not visible from public audit scope, optional schema type opportunity. |

Escalate severity when an issue affects vulnerable users, mobile users, new users, legal/financial/medical decisions, data submission, or a high-traffic conversion path.

## Safe Live-Audit Boundaries

Default allowed activities:

- read public no-auth pages;
- inspect visible text and public metadata;
- inspect public page source and safe high-level browser observations;
- run non-invasive public link checks under approved route/profile scope;
- run automated audits that do not submit data, authenticate, capture forbidden artifacts, or modify server state;
- produce sanitized summaries and findings.

Default disallowed activities without separate explicit approval:

- arbitrary URLs or arbitrary browser commands;
- login, auth, account creation, logout, admin, billing, or payment flows;
- form submission, contact-message sending, uploads, or use of real personal data;
- destructive actions or state-changing interactions;
- screenshots, videos, traces, raw HAR, cookies, local storage, auth headers, raw request bodies, raw response bodies;
- private staging access, credentials, secrets, tokens, or production server actions;
- broad crawling, scraping, rate-heavy checks, or activity that could look abusive;
- model analysis of unsanitized browser/session artifacts.

Read-only audit, non-submit form inspection, and submit/action flows must stay separate:

- Read-only audit: observe public pages, metadata, visible content, console/network summaries, and safe link status.
- Non-submit form inspection: inspect fields, labels, validation hints, and client-side validation only when approved; do not send data.
- Submit/action flows: any submission, upload, auth, payment, admin, account, or destructive action requires separate explicit approval with route, data, stop conditions, and artifact policy.

## What Must Never Be Done Without Explicit Approval

The site audit skill and its templates must never authorize:

- deploy, server, SSH, SCP, production process, database, or secrets actions;
- reading, printing, storing, or committing secret values;
- changing application code or product repositories as part of the audit itself;
- installing dependencies;
- unrestricted browser automation;
- using real personal/client/payment data;
- submitting forms, sending messages, uploading files, creating accounts, logging in, paying, refunding, deleting, or changing settings;
- collecting screenshots, videos, traces, raw HAR, cookies, storage state, auth headers, raw request/response bodies, or full private URLs by default;
- bypassing robots, rate limits, auth controls, paywalls, private endpoints, or anti-abuse systems;
- presenting automated scores as final truth without human review.

## Mapping To Existing Vibe Coding Skills

- `research-protocol`: supplies the T3 research flow, source verification, critical phase, and premortem that justified this series.
- `series-design-discipline`: supplies the shared Charter that keeps the multi-batch skill series coherent.
- `prompt-writing-standard`: governs each later prompt in the series and requires Context, Task, Regression Shield, and Acceptance Criteria.
- `skill-writing-standard`: governs the future `skills/site-audit/SKILL.md` structure, triggers, anti-patterns, and validation.
- `knowledge-structure`: informs whether future artifacts are reference documents, templates, standards, or record folders.
- `universality-discipline`: keeps audit templates reusable across projects rather than creating one-off site checklists.
- `anti-hedging-language`: requires findings to state evidence, unknowns, or approved deferrals clearly.
- `real-path-verification`: informs the split between safe local verification, browser-run evidence, and explicit handoff for production-side checks.
- `forward-thinking-discipline`: informs audit prompts that must name downstream effects before higher-risk actions are approved.

## Open Decisions

1. Whether the future site-audit skill should include a standard severity taxonomy exactly as written here or let product repositories override labels while preserving the same impact logic.
2. Whether the first pilot prompt should audit only one approved public homepage or include a second public no-auth page to test cross-page navigation findings.
3. Whether visual artifact capture should remain fully separate from the skill or be added as an optional approval-gated template after the text-only audit workflow is stable.
4. Which repository path should hold reusable audit templates: `templates/site-audit/`, `docs/site-audit/templates/`, or both with different roles.
