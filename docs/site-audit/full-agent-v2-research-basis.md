# Site Audit Full Agent V2 Research Basis

<!--
  @file:        docs/site-audit/full-agent-v2-research-basis.md
  @description: Internal research basis for the full universal website audit agent upgrade
  @updated:     2026-05-23
  @version:     1.0
-->

## Purpose

This document records the internal research basis for upgrading `site-audit` from a read-only-first website audit protocol into a full universal website audit agent protocol.

It is not exhaustive. It separates durable platform guidance, established UX and content guidance, and emerging industry practices so later batches can encode operational rules without pretending all sources have the same authority.

The clarified model is:

approved scope -> audit action -> sanitized evidence -> complete bilingual report -> separately approved fix or follow-up batch.

The hard prohibition is not on audit capability. The hard prohibition is on modifying product code, product data, configuration, infrastructure, accounts, payments, or production state during an audit, and on disclosing sensitive data in reports.

## Source Notes

### Authoritative Platform Guidance

Use these as primary durable sources for technical, accessibility, search, structured-data, privacy, and payment-boundary rules:

- W3C Web Content Accessibility Guidelines 2.2 and WAI guidance.
- Google Search Central SEO Starter Guide, helpful people-first content guidance, and structured data guidelines.
- Schema.org documentation for structured data vocabulary and entity modeling.
- Browser vendor documentation for DevTools, Lighthouse-style signals, Core Web Vitals, console/network diagnostics, and browser compatibility.
- OWASP Web Security Testing Guide and OWASP Application Security Verification Standard for non-destructive web security assessment boundaries.
- Payment provider sandbox/test-mode documentation for providers used by the audited product.
- Platform terms and robots/rate-limit guidance for live checks, crawling, and automation boundaries.

### Established UX, Content, And Conversion Guidance

Use these as stable professional guidance, not as strict scoring formulas:

- Nielsen Norman Group usability heuristics, forms guidance, trust guidance, and content usability guidance.
- Plain-language and readability guidance for user-facing content.
- Accessibility testing practice that combines automated checks with human judgment.
- Conversion-rate and landing-page audit practice focused on offer clarity, objection handling, CTA clarity, trust, and user path continuity.

### Emerging Industry Practices

Use these as practices to verify and label, not as settled standards:

- AEO/GEO guidance for answerability, entity clarity, and machine-readable content.
- AI search and answer-engine behavior analysis.
- Agentic commerce readiness: service/action clarity, stable deep links, structured data, pricing clarity, stock/availability clarity where relevant, policies, limitations, and trust signals.
- AI assistant recommendation readiness: whether an assistant can accurately explain who the service is for, what it does, when it is unsuitable, and how to start safely.

External URLs were not re-verified during this batch. Later implementation batches should verify exact current source URLs before adding direct citations or source links to templates, skills, or public-facing reports.

## Full Website Audit Capability Model

A full audit agent can evaluate a site through these capability layers when the approved scope, tools, accounts, and artifact policy support them:

1. Static repository audit: source, content, metadata, routing, tests, and public configuration inside the repository.
2. Live HTTP audit: status codes, redirects, headers, public assets, public routes, robots/sitemap signals, and public API route availability.
3. Browser visual audit: rendered pages, viewports, layout, media, typography, overlap, console/network summaries, and interaction states.
4. Interactive user-flow audit: non-destructive flows using synthetic data and documented stop conditions.
5. Auth/account audit: login, registration, account states, permissions, recovery, and profile flows using approved test accounts only.
6. Payment path audit: pricing, checkout, payment states, error handling, receipts, and cancellation through sandbox/test mode or explicit stop-before-charge boundaries.
7. Admin/access-boundary audit: non-destructive permission and access-boundary checks using approved test roles.
8. API/server-route/SSE audit: route connectivity, streamed events, public contract behavior, timeout/error surfaces, and client integration evidence.
9. Marketing, sales, and target-audience usefulness audit.
10. SEO/AEO/GEO audit.
11. AI and agentic-commerce readiness audit.
12. Security, privacy, and sensitive-data exposure audit.
13. Post-fix regression audit.

Missing tooling, credentials, accounts, or sandbox payment mode is an audit limitation to report. It is not a reason to remove the capability from the universal model.

## Audit Action Versus Product Modification

Audit action means collecting evidence inside an approved scope. Product modification means changing code, content, configuration, data, accounts, payments, infrastructure, or production state.

Allowed audit actions can include reading source files, opening approved routes, using approved browser profiles, entering synthetic data, logging in with test accounts, checking sandbox payment boundaries, inspecting public API connectivity, and verifying admin boundaries non-destructively.

Forbidden during audit unless a separate fix task is approved:

- editing product repositories or shared runtime configuration;
- changing deployed infrastructure, server processes, databases, secrets, DNS, or CI/CD;
- mutating real accounts, real payments, real customer records, production settings, or private data;
- turning an audit finding directly into a code fix in the same audit run.

The report may recommend fixes and next batches. The fix happens later through a separate scoped prompt with its own regression shield and checks.

## Sensitive Data Handling

Sensitive material includes personal data, credentials, passwords, API keys, tokens, cookies, auth headers, session material, private URLs, raw request or response bodies, billing/payment data, legal-case data, medical data, account data, and private client data.

If sensitive material is encountered:

- stop the risky evidence path;
- do not quote, print, store, screenshot, or commit the value;
- report the class of exposure in anonymized form;
- include the location at the safest useful granularity;
- state the impact and recommended remediation path without reproducing the sensitive value.

Example report wording: "A credential-like token was visible in a public browser artifact on the checkout route. The value is omitted. Treat as High or Critical depending on exposure scope and rotate if confirmed."

## Live HTTP And Browser Evidence

Live evidence is valid when the scope names the target, routes, devices, interaction profiles, artifact policy, and stop conditions.

HTTP evidence can include public status codes, redirects, response headers, safe metadata, public asset availability, public link status, robots and sitemap availability, and high-level API route behavior.

Browser evidence can include rendered content, viewport observations, console error summaries, network failure summaries, public metadata, visible structured data, screenshots or videos only when approved, and interaction-state observations.

Do not fabricate evidence. If a browser, viewport, console log, network trace, Lighthouse-style run, screenshot, or flow recording was not captured or supplied through an approved artifact, mark that check as unavailable or unknown.

## Interactive Flow Testing With Synthetic Data

Interactive flows are auditable when the action is reversible, non-destructive, and scoped. Use synthetic data that cannot be mistaken for a real user, client, payment, or legal/medical record.

For each flow, record:

- route and starting state;
- synthetic data policy;
- allowed clicks, typing, uploads, and submissions;
- stop-before points;
- expected evidence;
- sensitive-data and state-change stop conditions.

If the flow needs real data or a real customer account, stop and record the limitation. Do not downgrade the capability model; record that the current audit could not execute that layer.

## Auth, Payment, Admin, API, And SSE Testing

Auth and account testing requires approved test accounts, approved roles, and a credential-handling rule that prevents credentials from entering reports.

Payment testing requires sandbox/test mode, provider test cards or test instruments, or an explicit stop-before-charge boundary. Real charges, refunds, saved payment methods, and live billing changes are not audit actions unless separately approved as a reversible scenario.

Admin and access-boundary testing uses non-destructive checks: whether unauthenticated users are blocked, whether lower roles cannot view restricted pages, whether UI controls are hidden or disabled correctly, and whether server responses avoid sensitive disclosure. Do not create, delete, refund, export, or mutate production records during audit.

API, route, and SSE checks are audit evidence, not configuration changes. Valid checks include connectivity, status, response shape at a safe summary level, public contract mismatch, timeout behavior, stream start/stop behavior, retry/error states, and client-visible failures. Do not change environment variables, server config, feature flags, credentials, or deployment settings to make the route work during an audit.

## Marketing, Sales, And Target-Audience Usefulness

The full audit must evaluate whether the site helps its intended audience decide and act.

Check:

- value proposition clarity: what the product/service does and why it matters;
- target audience fit: who it is for, who it is not for, and whether examples match that audience;
- offer clarity: pricing, deliverables, limitations, timing, geography, eligibility, and next step;
- trust and objection handling: proof, credentials, reviews, policies, risk explanations, guarantees, support, company/contact signals;
- CTA and conversion path: whether the primary action is visible, understandable, safe, and continuous;
- usefulness of information and tools: whether pages, calculators, forms, comparisons, FAQs, and examples answer real decision questions.

Marketing findings still require evidence: route, section, observed text, missing information, user impact, and recommended next action.

## AI, AEO, GEO, And Agentic-Commerce Readiness

The audit should evaluate whether humans and AI assistants can understand, recommend, and act on the service accurately.

Check:

- answerability: pages answer concrete user questions directly and truthfully;
- entity clarity: organization, service, product, location, audience, terms, and roles are unambiguous;
- machine-readable structured data: schema aligns with visible content and does not mislead;
- service, tool, and action clarity: what can be done, by whom, with what inputs, and with what outcome;
- stable URLs and deep links: important services, offers, docs, policies, and actions have stable public destinations;
- pricing, offer, and limitation clarity: costs, constraints, risks, eligibility, and exclusions are clear;
- assistant recommendation readiness: an AI assistant can accurately summarize fit, benefits, limitations, next step, and when not to recommend the service;
- agentic shopping or service-selection readiness where relevant: product/service identifiers, variants, availability, delivery terms, return/cancellation terms, payment boundaries, contact/escalation paths, and policy clarity are present.

Do not recommend manipulative search or AI tactics: hidden content, fake freshness, fake reviews, fabricated authority, misleading schema, doorway pages, or generic content created only to influence ranking systems.

## Report Requirements

The full audit report must be a Markdown file.

Required structure:

- Russian decision-maker sections: executive summary, all findings, priorities, limitations, stop conditions, and next batches.
- English technical section: evidence inventory, route/file details, reproduction notes, technical risk, acceptance criteria, and fix prompt direction.
- All findings included, not only top findings.
- Every finding includes evidence, impact, severity, recommendation, and status.
- Limitations state which audit layers were unavailable and why.
- Stop conditions state whether any occurred; sensitive values are never disclosed.
- Next batches translate findings into scoped follow-up work, with approval needs called out.

YurAssistent may be used later as a product pilot target. It is not a universal methodology source.
