# Marketing, AI, And Agentic Readiness Checklist
<!--
  @file:        templates/site-audit/marketing-ai-agentic-checklist.md
  @description: Reusable checklist for marketing, target-audience usefulness, SEO/AEO/GEO, AI readability, and agentic-commerce readiness audits
  @updated:     2026-05-24
  @version:     1.0
-->

Use this checklist with `docs/site-audit/marketing-ai-agentic-readiness-standard.md` after the audit scope approves marketing/sales, target-audience usefulness, SEO/AEO/GEO, or AI/agentic-commerce readiness checks.

Do not run a live audit, browser action, form submission, auth, payment, admin, deploy, server, database, secrets, or production-changing action from this checklist alone.

## 1. Target Audience

- [ ] Intended audience is visible or inferable from approved evidence.
- [ ] Audience segments are specific enough to judge fit.
- [ ] Page states who the service/tool is not for where misuse risk exists.
- [ ] Examples, testimonials, cases, and language match the intended audience.
- [ ] Missing or ambiguous audience evidence is recorded as `Unknown`.

## 2. User Problem And Value Proposition

- [ ] First viewport explains what the site offers.
- [ ] First viewport explains why the offer matters to the target audience.
- [ ] User pain, job-to-be-done, trigger situation, or desired outcome is concrete.
- [ ] Claims are specific and supported by visible evidence where risk is meaningful.
- [ ] Claimed value matches actual page/tool/form behavior.

## 3. Offer And Sales Path

- [ ] Offer, deliverables, scope, timing, geography, and eligibility are clear.
- [ ] Pricing, tariff, plan, or quote path is clear where relevant.
- [ ] Limitations, exclusions, refund/no-refund terms, and no-guarantee conditions are visible where relevant.
- [ ] User can understand the path from interest to next action.
- [ ] Alternatives or differentiation are explained where comparison is likely.

## 4. Content Usefulness

- [ ] Content answers practical decision questions for the intended audience.
- [ ] Pages/tools/forms provide useful details, not only promotional statements.
- [ ] FAQ or direct-answer content exists where users would predictably ask questions.
- [ ] High-stakes claims include support, qualifications, or caution.
- [ ] Content avoids generic AI-like filler that does not help user decisions.

## 5. Trust And Objections

- [ ] Company/operator identity is clear.
- [ ] Contact, support, policy, or escalation paths are visible where relevant.
- [ ] Proof signals are credible and not fake, unverifiable, or misleading.
- [ ] Common objections, risks, guarantees, disclaimers, and safety limits are handled.
- [ ] Trust gaps are tied to route/section evidence and user impact.

## 6. Conversion And CTA

- [ ] Primary CTA matches the page intent and user readiness.
- [ ] Secondary CTA supports users who need more information.
- [ ] CTA copy makes the next step and consequence understandable.
- [ ] Primary path remains continuous across relevant sections/routes.
- [ ] Conversion friction, dead ends, or unsafe pressure tactics are recorded.

## 7. SEO / AEO / GEO

- [ ] Content is people-first and useful to the target audience.
- [ ] Titles, descriptions, headings, canonicals, and visible summaries align.
- [ ] Important user questions have direct, truthful answers.
- [ ] Entity clarity covers organization, service/tool/product, audience, location, and policies where relevant.
- [ ] Internal links and stable URLs support discovery of services, pricing, FAQ, terms, policies, and contact paths.
- [ ] Recommendations avoid keyword stuffing, hidden content, fake freshness, fake reviews, doorway pages, and misleading schema.

## 8. AI Assistant Readability

- [ ] An AI assistant could accurately summarize who operates the site.
- [ ] An AI assistant could accurately summarize what is offered.
- [ ] An AI assistant could identify who should and should not use the service.
- [ ] An AI assistant could describe benefits, limitations, pricing path, and next step without inventing facts.
- [ ] Unsafe recommendation risk is recorded for legal, financial, medical, safety, or other high-stakes contexts.

## 9. Agentic-Commerce / Service-Selection Readiness

- [ ] Important services, tools, products, actions, pricing, FAQ, terms, and policies have stable URLs or deep links.
- [ ] Service/action entry points are visible and explain required inputs and expected outputs.
- [ ] Offer, pricing, availability, eligibility, limitations, refund/cancellation, and support boundaries are parseable from visible content.
- [ ] A selection or shopping agent could compare the offer with alternatives without hallucinating missing details.
- [ ] State-changing actions have clear user confirmation points.
- [ ] Emerging-practice findings are labeled as such and not overstated as hard platform requirements.

## 10. Structured Data And Machine Readability

- [ ] Schema.org / JSON-LD is inspected only when source or approved summaries provide it.
- [ ] Structured data type and properties fit the visible page purpose.
- [ ] Structured data matches visible content.
- [ ] Ratings, reviews, prices, availability, services, policies, and claims are not fabricated or hidden.
- [ ] Schema opportunity without current impact is treated as `Observation` unless escalation factors apply.

## 11. High-Stakes Safety And Limitations

- [ ] Legal, financial, medical, safety, tax, insurance, employment, immigration, or regulated claims are identified.
- [ ] Qualifications, jurisdiction, service boundaries, guarantees, and disclaimers are clear where needed.
- [ ] The site does not imply automated high-stakes decisions without appropriate user confirmation or professional boundary.
- [ ] Missing support for strong claims is recorded with severity based on user harm.
- [ ] Sensitive data, real payments, real personal data, account mutation, and production-changing actions remain forbidden unless separately approved.

## 12. Required Findings And Evidence

For each finding, record:

- [ ] Finding ID.
- [ ] Primary category.
- [ ] Severity.
- [ ] Location: route, file, selector, section, viewport, or artifact.
- [ ] Evidence using `Observed:`, `Inferred risk:`, and `Unknown:` where needed.
- [ ] Impact on conversion, trust, target-audience usefulness, SEO/AEO/GEO, AI readability, agentic routing, or safety.
- [ ] Recommendation or follow-up prompt direction.
- [ ] Status.

Prefer these primary categories where applicable:

- `Marketing/sales effectiveness`
- `Target-audience usefulness`
- `SEO`
- `AEO/GEO/AI-friendly content`
- `AI/agentic-commerce readiness`

