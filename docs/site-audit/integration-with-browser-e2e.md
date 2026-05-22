# Site Audit Integration With Browser/E2E
<!--
  @file:        docs/site-audit/integration-with-browser-e2e.md
  @description: Integration review between the site-audit system and existing browser/E2E safety infrastructure
  @updated:     2026-05-22
  @version:     1.0
-->

## Purpose

This document explains how the reusable `site-audit` system fits with the existing Vibe Coding browser/E2E summary infrastructure.

The decision is conservative: browser/E2E remains the lower-level evidence producer, and site-audit remains the higher-level audit, report, severity, and follow-up-prompt workflow. Site-audit may consume approved sanitized browser summaries, but it does not expand browser actions, routes, artifacts, or model inputs.

## Existing Browser/E2E Concepts

| Concept | Current repository source | Meaning |
|---|---|---|
| Approved route labels | `configs/real-staging-approved-routes.json` | Browser runs select a known route label, not an arbitrary URL. |
| Approved interaction profiles | `configs/real-staging-interaction-profiles.json` | Browser actions are fixed profiles, not free-form commands. |
| Sanitized summary JSON | `configs/e2e-staging-summary-contract.json` | Browser/session observations are reduced to model-safe text fields. |
| Browser handoff contract | `configs/browser-automation-handoff-contract.json` and `docs/browser-automation-handoff-contract.md` | Future browser runners must produce sanitized summaries and never send raw session artifacts to model analysis. |
| Validator before model analysis | `docs/e2e-staging-summary-validator.md` | Required fields, types, visible text, acceptance criteria, sanitization notes, and forbidden patterns are checked before model calls. |
| Model report schema | `docs/e2e-staging-summary-contract.md` | Model output uses `passed`, `score`, `summary`, `matched_criteria`, `missing_criteria`, `issues`, and `recommendation`. |
| Real public browser MVP | `docs/real-public-browser-summary-mvp.md` | A public no-auth route/profile flow already proved sanitized summaries without raw browser artifacts. |
| Real staging design | `docs/real-staging-browser-workflow-design.md` | Real staging remains design-only until route scope, staging access, credentials, sanitization, stop conditions, artifacts, and model policy are approved. |

## How Site-Audit Reuses Browser/E2E

Site-audit reuses these concepts directly:

- route labels instead of arbitrary URLs when browser evidence is used;
- interaction profile IDs instead of arbitrary browser commands;
- sanitized summary JSON as the default browser evidence format;
- validator and forbidden-pattern scan before model analysis;
- short-retention sanitized artifacts only;
- explicit stop conditions for auth, payments, private data, secrets, raw artifacts, unclear scope, and missing approval;
- model analysis inputs limited to sanitized summaries, acceptance criteria, and report schema.

Browser/E2E evidence can populate the site-audit report sections this way:

| Browser/E2E output | Site-audit report use |
|---|---|
| `route_label` | Scope, evidence inventory, finding location. |
| `page_title` and `visible_text` | UX, SEO, AEO/GEO, copy/trust, and CTA evidence. |
| `interactions` | Method and limits of evidence. |
| `acceptance_criteria` | Method, findings, and post-fix regression criteria. |
| `console_errors` | Technical frontend health evidence. |
| `network_errors` | Technical frontend health, security/privacy, and reliability evidence. |
| `accessibility_notes` | Accessibility signals requiring manual judgment before stronger claims. |
| `performance_notes` | Performance signals, not complete performance proof. |
| `browser` and `viewport` | Responsive/mobile or browser-specific evidence when supplied. |
| `sanitization_notes` | Safe-boundary notes and artifact policy proof. |

## Where Site-Audit Is Higher-Level

Browser/E2E answers whether approved observations and acceptance criteria passed for a route/profile. Site-audit adds:

- audit mode selection and scope gate;
- multi-dimensional review across technical health, UX, accessibility, responsive/mobile, forms/tools, SEO, AEO/GEO, copy/trust, design, conversion, and public UI security/privacy;
- severity taxonomy and escalation factors;
- duplicate grouping and finding IDs;
- safe-boundary notes;
- prioritized recommendations;
- next fix prompts;
- post-fix regression mapping to original finding IDs.

Site-audit must not claim more than the browser evidence supports. A text-only browser summary can support text, metadata, CTA, high-level console/network, link, and acceptance-criteria findings. It cannot prove visual layout, exact contrast, screenshot state, animation behavior, or full mobile layout unless approved visual/browser evidence exists.

## Contradiction Review

| Area | Existing browser/E2E rule | Site-audit rule | Decision |
|---|---|---|---|
| Route selection | Use approved route labels; no arbitrary URL input by default. | Use approved routes/pages and stop on scope drift. | Aligned. Site-audit consumes route labels when browser evidence is used. |
| Interaction selection | Use approved interaction profiles; no arbitrary browser commands. | Allowed actions are scoped and forbidden actions are explicit. | Aligned. Site-audit cannot invent browser commands. |
| Sanitization | Sanitized summary JSON must pass validation before model analysis. | Browser evidence must be approved, sanitized, and labeled. | Aligned. Site-audit report cites summaries as evidence, not raw sessions. |
| Raw artifacts | Cookies, auth headers, raw HAR, screenshots/videos/traces, request/response bodies, private data, and local paths are forbidden by default. | Same artifacts are forbidden without separate explicit approval. | Aligned. No default expansion. |
| Screenshots | Forbidden by default in browser/E2E. | Allowed only if separately approved and actually captured. | Aligned. Visual claims otherwise become unknown or human judgment within stated limits. |
| Forms and submit actions | No form submission, auth, payment, account, upload, or destructive actions without approval. | Read-only, non-submit, and submit/action modes are separate. | Aligned. Site-audit preserves approval gates. |
| Model inputs | Models receive sanitized summary, acceptance criteria, and schema. | Model analysis must not receive unsanitized artifacts. | Aligned. Site-audit can add report schema, not raw browser data. |
| Model providers | Current first real public flow allows Qwen/DeepSeek and excludes Gemini. | Site-audit skill does not mandate providers. | No conflict. Provider policy remains owned by browser/E2E workflow scope. |
| Public route registry | Existing registry currently contains a product-specific public route. | Shared site-audit artifacts must remain universal. | No conflict. Product routes stay in configs or product scopes; shared site-audit docs do not create product-specific routes. |
| Real staging | Design-only until separate approvals. | Site-audit does not authorize staging access or credentials. | Aligned. No staging expansion. |

No contradiction requires rewriting existing browser/E2E documents.

## Future Route And Profile Rules

Future browser route/profile additions that feed site-audit reports must follow these rules:

1. Add a route label to the approved route registry or product-specific equivalent; do not accept arbitrary URL input.
2. Add an interaction profile with explicit allowed actions, forbidden actions, risk level, test intent, result type, and acceptance criteria.
3. Keep read-only, non-submit, and submit/action flows separate.
4. Require sanitized summary validation and forbidden-pattern scan before model analysis.
5. Preserve short-retention sanitized artifacts only.
6. Forbid screenshots, videos, traces, raw HAR, cookies, storage, auth headers, raw request/response bodies, private URLs, server IPs, private endpoints, and local paths by default.
7. Require separate explicit approval for auth, payment, admin, account, upload, destructive, submit, credentials, staging access, private data, or raw/visual artifacts.
8. Label evidence limits in the site-audit report; do not turn automated signals into complete proof.

## Final Integration Decision

The site-audit system is compatible with the existing browser/E2E infrastructure.

Browser/E2E remains the controlled observation layer. Site-audit consumes its sanitized outputs, applies broader audit judgment and severity rules, and produces reports and fix prompts. The integration preserves approved route/profile discipline, sanitized summaries before model analysis, no arbitrary URLs by default, no unapproved high-risk actions, and no raw private artifacts by default.
