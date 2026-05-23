# Marketing, AI, And Agentic Readiness Standard
<!--
  @file:        docs/site-audit/marketing-ai-agentic-readiness-standard.md
  @description: Reusable standard for auditing marketing, target-audience usefulness, SEO/AEO/GEO, AI readability, and agentic-commerce readiness
  @updated:     2026-05-24
  @version:     1.0
-->

## Purpose

This standard defines how site audits evaluate whether a website helps its intended audience, search systems, AI assistants, and future service-selection agents understand the offer and route users to the right next step.

It applies to public websites, landing pages, SaaS/product pages, service pages, forms, tools, pricing pages, FAQ pages, policy pages, and scoped product UI surfaces. It is methodology only. It does not authorize product code changes, live deploys, server work, secrets work, real audits without scope, or manipulative SEO/AI-search tactics.

## Core Rule

Marketing, target-audience usefulness, SEO/AEO/GEO, and AI/agentic-commerce readiness are related but separate audit areas.

- Marketing/sales effectiveness checks whether the page can convert an appropriate human user.
- Target-audience usefulness checks whether the page helps the intended audience make a real decision.
- SEO/AEO/GEO checks whether the page is findable, answerable, structured, and people-first.
- AI/agentic-commerce readiness checks whether assistants and service-selection agents can understand, recommend, compare, and route the service accurately and safely.

Do not collapse all four areas into SEO. Do not create duplicate findings when one evidence item has one root cause; instead assign the primary category and link related impacts.

## Evidence Sources

Use only approved audit evidence:

- visible page content;
- page source and rendered metadata;
- schema.org / JSON-LD that is visible in source or approved summaries;
- sitemap, robots, canonical, and stable URL signals;
- service, tool, product, pricing, terms, policy, and FAQ pages;
- internal links and deep links;
- supplied sanitized browser summaries;
- browser observations, screenshots, console summaries, network summaries, or Lighthouse-style signals only when the audit scope approved and actually captured them;
- repository source files when static audit is in scope.

Findings must state the route, section, file, selector, viewport, or artifact where evidence appeared. If evidence is missing, mark it as `Unknown` and name the next approved check.

## Marketing / Sales / Target Audience Usefulness

Audit whether the site helps the intended audience decide and act.

Check:

- target audience clarity: who the site is for, who it is not for, and whether examples match that audience;
- user pain and job-to-be-done clarity: the user problem, trigger situation, and desired outcome are concrete;
- first-viewport value proposition: what is offered, why it matters, and what the user can do next are visible without hunting;
- service/tool usefulness: pages, calculators, generators, forms, comparisons, or examples answer real decision questions for the intended audience;
- offer clarity and differentiation: deliverables, scope, timing, geography, eligibility, limitations, and alternatives are understandable;
- pricing/tariff clarity: costs, plan differences, included work, exclusions, payment timing, refund/no-refund terms, and no-guarantee conditions are visible where relevant;
- conversion path clarity: the user can understand the sequence from interest to action, including what happens after a CTA;
- CTA relevance: primary and secondary CTAs match user readiness and page intent;
- objections and trust gaps: proof, reviews, credentials, guarantees, policies, risk explanations, contact/support/company signals, and objection handling fit the decision risk;
- content usefulness and decision support: the page answers practical questions instead of using generic promotional copy;
- claimed value versus actual behavior: tool/page behavior, forms, outputs, pricing, or limits match the promise.

Default severity guidance:

- High when a primary audience cannot understand the offer, pricing, trust basis, or primary CTA on a main conversion route.
- Medium when the issue creates decision friction but does not block the main path.
- Low for local wording or proof gaps with limited effect.
- Observation for useful future enhancements without current evidence of user harm.

## SEO / AEO / GEO

Audit whether content is useful for people first and clear enough for search, answer, and generative discovery systems.

Check:

- people-first content: pages serve real user decisions, not ranking manipulation;
- answerability: important user questions have direct, truthful, visible answers;
- entity clarity: organization, product, service, location, audience, roles, terms, and policies are unambiguous;
- headings and page structure: headings match page purpose and help humans and machines understand sections;
- internal links and stable URLs: important services, tools, pricing, terms, FAQ, contact, and policy pages have durable destinations;
- metadata and snippets: titles, descriptions, canonical signals, and visible summaries align with page content;
- FAQ/direct-answer sections: used where they answer real questions, not as keyword filler;
- sources or support for high-stakes claims: legal, financial, medical, safety, or regulated claims have appropriate support or caution;
- structured data quality: schema is valid where inspectable, complete enough for its purpose, and aligned with visible content.

Reject recommendations that rely on keyword stuffing, hidden content, fake freshness, fake reviews, fabricated authority, doorway pages, misleading schema, or content created mainly for rankings or AI extraction.

## AI / Agentic-Commerce Readiness

Treat AI and agentic-commerce readiness as a first-class audit block separate from SEO/AEO/GEO.

Audit whether AI assistants and future service-selection or shopping agents can:

- understand who operates the site;
- understand what services, tools, products, or actions are offered;
- understand who the service is for and who it is not for;
- understand when to recommend the service and when not to recommend it;
- identify stable URLs and deep links for services, tools, pricing, FAQ, terms, policies, contact, and action entry points;
- parse offer, pricing, plan differences, limitations, eligibility, refund terms, no-guarantee conditions, and support boundaries;
- compare the service with alternatives without hallucinating missing facts;
- route a user to the right tool, form, checkout, booking, contact, account, or support action;
- understand input requirements and expected outputs for forms, tools, generators, or consultations;
- avoid unsafe recommendations in legal, financial, medical, safety, or other high-stakes contexts;
- use structured data that matches visible content;
- respect user confirmation points before submissions, purchases, account changes, or other state-changing actions.

Agentic-readiness findings must label emerging-practice risk honestly. Do not present future agentic-commerce conventions as hard platform requirements unless the audit cites a current authoritative requirement.

Default severity guidance:

- High when an assistant or selection agent could plausibly route users to an unsafe, wrong, or materially misleading action on a primary service path.
- Medium when missing structure, links, pricing, or limitations would likely cause poor recommendations or user confusion.
- Low when machine-readable improvement is local and human users can still decide safely.
- Observation for optional schema or deep-link enhancements without current user or safety impact.

## Structured Data And Machine Readability

Structured data is evidence only when actually inspected or supplied. Evaluate:

- syntax validity where validation output is available;
- type choice and property completeness for the page purpose;
- alignment with visible content;
- consistency between schema, metadata, headings, internal links, pricing, and policies;
- absence of misleading claims, fake reviews, hidden offers, hidden ratings, or unsupported availability;
- whether important services/tools/actions have stable visible pages, not only modal-only or script-only states.

A schema opportunity without evidence of current user harm is usually `Observation`. Escalate when schema contradicts visible content, creates misleading claims, or affects high-stakes decisions.

## High-Stakes Safety

For legal, financial, medical, safety, immigration, tax, insurance, credit, employment, or other high-stakes decisions:

- flag unclear scope, disclaimers, qualifications, jurisdiction, risk, guarantees, or no-guarantee language;
- require evidence for strong outcome claims;
- avoid recommending automated commitments or agentic actions without user confirmation;
- distinguish information, triage, recommendation, and professional service boundaries;
- report missing limits or unsafe wording as marketing/trust, target-audience usefulness, SEO/AEO/GEO, AI/agentic-readiness, or public UI safety findings depending on the primary impact.

## Anti-Patterns

Flag or reject:

- keyword stuffing;
- hidden content;
- misleading schema;
- AI-only content that is not useful to humans;
- fake reviews, fake proof, fake authority, or fake freshness;
- unclear operator, company identity, offer, pricing, limitations, or contact path;
- tools or actions hidden only inside modals with no stable page, link, or explanation;
- pricing or actions unclear to humans or agents;
- CTA paths that imply a result the site cannot safely deliver;
- unsafe high-stakes recommendation wording;
- schema or metadata that claims content, ratings, prices, services, or availability not visible on the page.

## Finding And Reporting Rules

Every finding must include:

- category: use `Marketing/sales effectiveness`, `Target-audience usefulness`, `SEO`, `AEO/GEO/AI-friendly content`, or `AI/agentic-commerce readiness` as the primary category where appropriate;
- location: route, source file, page section, selector, viewport, or artifact;
- evidence: observed content, missing content, metadata/schema signal, source line, sanitized browser summary, or explicit unknown;
- impact: conversion, trust, audience usefulness, findability, answerability, agentic routing, safety, or high-stakes decision risk;
- severity: `Critical`, `High`, `Medium`, `Low`, or `Observation`;
- recommendation: concrete next action or follow-up prompt direction.

Use `Observed:`, `Inferred risk:`, and `Unknown:` when a finding combines facts, risk, and missing evidence.

