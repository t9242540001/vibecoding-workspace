# Site Audit Report: Example Orchard Tools
<!--
  @file:        examples/site-audit/sanitized-audit-report-example.md
  @description: Synthetic sanitized site-audit report example using fake data only
  @updated:     2026-05-22
  @version:     1.0
-->

## Synthetic Example Notice

This file is synthetic only. Project name, URL, routes, evidence IDs, findings, and prompts are fake. It contains no real client data, credentials, secrets, private URLs, production artifacts, or product-specific content.

## Summary

- Audit date: 2026-05-22
- Auditor: Code Agent
- Audit mode: read-only live public audit from supplied sanitized summaries
- Target URL/repository: `https://example.invalid/orchard-tools`
- Overall result: issues found in CTA clarity, accessibility labels, structured data alignment, and mobile text density
- Highest severity: High
- Stop conditions encountered: none

## Scope

### In Scope

- Routes/pages:
  - `example-home` -> `https://example.invalid/orchard-tools/`
  - `example-pricing` -> `https://example.invalid/orchard-tools/pricing`
  - `example-support` -> `https://example.invalid/orchard-tools/support`
- Devices/viewports:
  - `desktop_default`
  - `mobile_390`
- Forms/tools:
  - newsletter signup form: inspect labels and visible validation hints only; submit not allowed
- Audit dimensions:
  - technical frontend health
  - UX/usability
  - accessibility
  - responsive/mobile
  - forms/tools
  - SEO
  - AEO/GEO/AI-friendly content
  - copy/trust/legal-risk wording
  - analytics/conversion
  - public UI security/privacy
- Approved artifacts:
  - sanitized summary JSON
  - validation report JSON
  - markdown audit report
  - source line references from fake example fixtures

### Out Of Scope

- Routes/pages:
  - account, billing, admin, upload, and checkout paths
- Devices/viewports:
  - screenshots and visual regression captures
- Forms/tools:
  - production submit, file upload, payment, login, account creation
- Actions:
  - clicks that send data, auth, payment, admin, destructive actions
- Artifacts:
  - screenshots, videos, traces, raw HAR, cookies, storage, auth headers, raw request bodies, raw response bodies

## Method

- Source/context read:
  - supplied fake audit scope
  - supplied fake sanitized summaries
  - `templates/site-audit/report-template.md`
  - `templates/site-audit/finding-taxonomy.md`
- Automated checks run:
  - fake summary schema validation: passed
  - fake forbidden-pattern scan: passed
- Manual/browser observations:
  - none beyond supplied sanitized summaries
- Sanitized summaries reviewed:
  - `E-001`
  - `E-002`
  - `E-003`
- Limits of evidence:
  - no screenshots or raw browser artifacts were captured
  - mobile layout findings are based on sanitized text and viewport labels only
  - form behavior was not submitted or tested past visible non-submit hints

## Evidence Inventory

| Evidence ID | Type | Location | Captured by | Notes |
|---|---|---|---|---|
| E-001 | sanitized_browser_summary | `example-home`, `mobile_390` | fake browser summary fixture | Visible text includes headline, feature snippets, and no clear primary CTA in first text segment. |
| E-002 | sanitized_browser_summary | `example-pricing`, `desktop_default` | fake browser summary fixture | Pricing page has table text and guarantee copy. |
| E-003 | sanitized_browser_summary | `example-support`, `desktop_default` | fake browser summary fixture | Newsletter field appears as "Email" placeholder only; no visible label in summary. |
| E-004 | validation_report_json | fake summary bundle | fake validator | Required fields present and forbidden-pattern scan passed. |

## Findings

| ID | Severity | Category | Location | Evidence | Impact | Recommendation | Status |
|---|---|---|---|---|---|---|---|
| F-001 | High | UX/usability | `example-home`, first viewport text | Observed: `E-001` includes product explanation but no clear primary next-step text in the first captured segment. Inferred risk: new visitors may not know how to start evaluating the tool. | Reduces task clarity and conversion for first-time visitors. | Add a clear primary CTA near the opening value statement and verify with an approved CTA-presence profile. | open |
| F-002 | High | Accessibility | `example-support`, newsletter form | Observed: `E-003` exposes an email placeholder but no visible label in the sanitized form text. Unknown: accessible name was not inspected through a DOM or accessibility tree. | Users relying on labels or assistive technology may have trouble understanding the field. | Inspect the form markup in a scoped follow-up and add a persistent visible or programmatic label if missing. | open |
| F-003 | Medium | SEO | `example-pricing`, structured data signal | Observed: fake metadata summary says `Product` schema includes "free setup" while visible pricing copy says "setup fee may apply". | Search result signals may be misleading if schema contradicts visible content. | Align structured data with visible pricing terms or remove the unsupported property. | open |
| F-004 | Medium | Responsive/mobile | `example-home`, `mobile_390` | Observed: `E-001` contains a long uninterrupted feature paragraph in the mobile text capture. Unknown: visual wrapping and actual layout were not captured. | Mobile readers may face dense scanning friction. | Review mobile layout with an approved visual or browser profile before making a visual claim; consider shorter bullets if confirmed. | open |
| F-005 | Low | Copy/trust/legal-risk wording | `example-pricing` | Observed: `E-002` includes "best results guaranteed" without visible conditions in the captured text. | Claim may reduce trust if users cannot see limits or conditions. | Add concise conditions near the guarantee or soften the claim to match actual policy. | open |
| F-006 | Observation | Analytics/conversion | all in-scope routes | Unknown: public instrumentation was not inspected in the supplied sanitized summaries. | No defect proven; conversion measurement may need separate review. | Add an approved static or sanitized browser check if instrumentation verification becomes necessary. | open |

## Severity Definitions

| Severity | Definition |
|---|---|
| Critical | Blocks a primary user path, exposes secrets/PII, creates auth/payment/admin risk, causes legal/compliance risk, or makes the site unusable. |
| High | Strongly damages task completion, accessibility, trust, SEO discoverability, conversion, or safe decision-making. |
| Medium | Creates meaningful friction, confusion, quality loss, or ranking/measurement weakness without blocking the path. |
| Low | Local polish issue or minor inconsistency with limited user impact. |
| Observation | Useful non-defect signal, opportunity, unknown, or future check that does not currently justify a fix by itself. |

## Prioritized Recommendations

1. F-001 - Add a visible primary CTA and retest with an approved route/profile pair - strongest conversion and user-path risk.
2. F-002 - Verify and fix the newsletter field label - likely accessibility and form-completion risk.
3. F-003 - Align structured data with visible pricing terms - prevents misleading SEO/AEO signals.
4. F-004 - Retest mobile visual layout with approved evidence before making design changes - current evidence is text-only.

## Safe-Boundary Notes

- Production form submit: not performed.
- Auth/admin/payment/account flows: not accessed.
- Real personal data: not used.
- Secrets/deploy/server/database actions: not used.
- Screenshots/videos/traces/raw HAR/cookies/storage/auth headers: not collected.
- Code changes during audit: none.

## Stop Conditions

| Condition | Encountered? | Evidence / Decision |
|---|---:|---|
| Scope drift | No | Routes stayed within fake approved route labels. |
| Secret/credential exposure | No | Fake forbidden-pattern scan in `E-004` passed. |
| Real personal/client/payment data | No | Synthetic example data only. |
| Unapproved submit/auth/payment/admin action needed | No | Newsletter form was not submitted. |
| Deploy/server/database/secrets action needed | No | Audit report only. |
| Required evidence outside artifact policy | No | Browser-only visual questions were marked unknown. |

## Next Fix Prompts

| Prompt | Findings addressed | Scope | Approval needed? |
|---|---|---|---|
| Add homepage CTA clarity | F-001 | Edit fake homepage hero copy and CTA component; run static checks and approved CTA-presence retest. | Browser retest requires approved route/profile. |
| Verify and fix newsletter label | F-002 | Inspect fake form markup; add visible or programmatic label if missing; run accessibility checks. | No submit approval needed if non-submit only. |
| Align pricing structured data | F-003 | Compare fake pricing copy and schema; update schema to match visible content. | No browser approval needed for static source audit. |
| Mobile text-density follow-up | F-004 | Run approved mobile visual/browser inspection before changing layout. | Visual evidence approval required if screenshots are needed. |
