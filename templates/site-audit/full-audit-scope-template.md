# Full Site Audit Scope Template
<!--
  @file:        templates/site-audit/full-audit-scope-template.md
  @description: Fillable scope contract template for complete safe website audits
  @updated:     2026-05-23
  @version:     1.0
-->

Use this template before a complete audit that may include static, live HTTP, browser visual, interactive, auth/account, payment-path, admin/access-boundary, API/server-route/SSE, marketing, SEO/AEO/GEO, AI/agentic-commerce, security/privacy, or post-fix regression layers.

Do not store secrets, passwords, tokens, cookies, private URLs, payment data, or real personal/client data in this file.

## 1. Project And Site Target

- Project:
- Repository:
- Site/domain:
- Environment: public production / public staging / private staging / local / other:
- Environment label:
- Audit owner:
- Audit run label:
- Report path:
- Prior report path, if post-fix regression:
- Product-specific knowledge files to read:

## 2. Enabled Audit Layers

Select approved layers and mark unavailable layers with a reason.

- [ ] Static repository audit
- [ ] Live HTTP audit
- [ ] Browser visual audit
- [ ] Interactive user-flow audit
- [ ] Auth/account audit
- [ ] Payment-path audit
- [ ] Admin/access-boundary audit
- [ ] API/server-route/SSE audit
- [ ] Marketing/sales/target-audience usefulness audit
- [ ] SEO/AEO/GEO audit
- [ ] AI/agentic-commerce readiness audit
- [ ] Security/privacy/sensitive-data exposure audit
- [ ] Post-fix regression audit

Unavailable layers and reasons:

| Layer | Reason | Needed prerequisite |
|---|---|---|
|  |  |  |

## 3. Allowed And Forbidden Actions

Allowed audit actions:

- [ ] Read approved repository files.
- [ ] Inspect approved public pages/routes.
- [ ] Run live HTTP checks on approved routes only.
- [ ] Review supplied sanitized browser summaries.
- [ ] Run approved browser visual checks.
- [ ] Capture screenshots only if approved in Section 12.
- [ ] Click approved controls inside scope.
- [ ] Type approved synthetic data inside scope.
- [ ] Submit reversible synthetic test data only where approved.
- [ ] Authenticate with approved test accounts.
- [ ] Inspect payment path in sandbox/test mode.
- [ ] Inspect payment path in stop-before-charge mode.
- [ ] Check admin/access boundaries non-destructively.
- [ ] Check approved API/server-route/SSE behavior with safe summaries.
- [ ] Run report validation checks.

Forbidden actions:

- product code, content, configuration, dependency, infrastructure, deploy, server, database, secrets, SSH, SCP, DNS, CI/CD, environment, or feature-flag changes;
- real payment, refund, saved-payment-method mutation, billing change, or real invoice/tax/bank data use;
- destructive admin action, production data export, real account mutation, settings change, irreversible state change;
- real personal, client, legal-case, medical, payment, credential, or private data use;
- arbitrary URLs, arbitrary browser commands, broad crawling, scraping, rate-heavy checks, bypassing auth/rate/paywall/anti-abuse boundaries;
- screenshots, videos, traces, raw HAR, cookies, storage, auth headers, raw request bodies, raw response bodies, or private URLs unless explicitly approved and sanitized.

## 4. Routes And Pages

Use route labels where possible. Do not include private tokens or sensitive query strings.

| Route label | URL/path or source | Environment | Auth required? | Priority | Required checks | Notes |
|---|---|---|---:|---|---|---|
|  |  |  | No |  |  |  |

## 5. User Flows

| Flow label | Start route | End condition | Allowed interactions | Submit allowed? | Synthetic data set | Stop-before point |
|---|---|---|---|---:|---|---|
|  |  |  |  | No |  |  |

## 6. Forms And Tools

| Form/tool/generator | Route | Fields allowed | Submit/generate allowed? | Test data policy | Expected evidence | Cleanup expectation |
|---|---|---|---:|---|---|---|
|  |  |  | No | Synthetic only |  |  |

## 7. Test Data

- Test data source file or inline description:
- Synthetic data naming convention:
- Allowed example domain or email pattern:
- Allowed phone/address pattern:
- Upload test files approved? Yes / No:
- Forbidden real data:
- Data cleanup expectation:

Synthetic examples:

| Data label | Value example | Purpose | Safe because |
|---|---|---|---|
| Name | Test User Audit | Form/account field | Clearly synthetic |
| Email | audit-test@example.com | Form/account field | Reserved example domain |
| Message | Synthetic audit message. Do not process as a real request. | Tool/form input | Declares test purpose |

## 8. Test Accounts

List role labels and credential source references only. Do not store credential values.

| Account role label | Environment | Credential source reference | Allowed routes/flows | Forbidden actions | Notes |
|---|---|---|---|---|---|
| anonymous visitor |  | none |  |  |  |
| test user |  |  |  |  |  |
| test admin read-only |  |  |  | destructive admin actions |  |

Credential handling rule:

- No passwords, tokens, cookies, storage state, auth headers, or secret values may be written into reports, prompts, logs, screenshots, artifacts, commits, or this scope file.

## 9. Payment Path Policy

Select one:

- [ ] Not approved.
- [ ] Sandbox/test mode approved.
- [ ] Stop-before-charge mode approved.

Payment provider:

Sandbox/test mode evidence allowed:

Provider test instrument source reference, not value:

Stop-before-charge point:

Forbidden payment actions:

- real charge;
- refund;
- saved payment method mutation;
- billing/subscription change;
- real payment, bank, tax, or invoice data use.

Missing payment prerequisite reporting rule:

## 10. Admin And Access Policy

Approved roles:

Allowed non-destructive checks:

- [ ] unauthenticated access blocked;
- [ ] lower-role restricted route denied;
- [ ] restricted UI absent or disabled;
- [ ] server denial summarized safely;
- [ ] role navigation compared without private data exposure.

Forbidden admin actions:

- create, edit, delete, export, refund, approve, reject, publish, ban, invite, impersonate, settings change, permission change, or production data mutation.

Stop if private data or destructive action is required:

## 11. API, Server Route, And SSE Checks

| Endpoint/route label | Method or stream type | Auth required? | Allowed evidence | Forbidden evidence | Stop condition |
|---|---|---:|---|---|---|
|  |  |  | status and safe response shape | raw payloads, headers, tokens |  |

Allowed:

- connectivity;
- status;
- safe response-shape summary;
- timeout/error surface;
- stream start/stop behavior;
- client integration evidence.

Forbidden:

- environment, server, deploy, feature-flag, credential, or secrets changes;
- raw sensitive request/response payloads.

## 12. Browser, Viewports, And Artifacts

Approved browsers:

Approved viewports:

| Viewport label | Width/height | Required? | Notes |
|---|---|---:|---|
| desktop |  |  |  |
| mobile-360 |  |  |  |
| mobile-390 |  |  |  |
| tablet |  |  |  |

Approved route/profile pairs:

| Route label | Profile ID | Allowed interactions | Artifact policy |
|---|---|---|---|
|  |  |  |  |

Artifacts:

| Artifact type | Allowed? | Redaction rule | Retention | Storage/report reference |
|---|---:|---|---|---|
| Markdown report | Yes | No secrets or real private data |  |  |
| Sanitized summary JSON |  | Pass validator/forbidden scan |  |  |
| Console/network summary |  | High-level only |  |  |
| Screenshots | No | Must be redacted if approved |  |  |
| Videos/traces/raw HAR | No | Requires separate approval |  |  |
| Cookies/storage/auth headers | No | Never report raw values |  |  |

## 13. Sensitive Data Redaction

Never report raw values for:

- secrets, credentials, passwords, API keys, tokens, cookies, auth headers, session material;
- personal data, private client data, legal-case data, medical data, payment data, billing data;
- raw private URLs, raw request bodies, raw response bodies.

When sensitive material appears, stop that evidence path and report only:

- exposure type;
- safe location class;
- impact;
- recommended remediation path;
- value omitted.

## 14. Stop Conditions

Stop before or during execution if:

- scope is ambiguous for a requested layer;
- a required route, account, test data set, sandbox mode, stop-before point, artifact policy, or approval is missing;
- sensitive data, credential material, cookies, auth/session material, or payment data appears;
- real personal/client data or private records are needed;
- unapproved submit, auth, payment, admin, upload, logout, destructive, account, contact-message, or settings-change action is required;
- screenshots, raw HAR, videos, traces, storage, headers, private URLs, or raw payloads are needed without approval;
- deploy, server, database, secrets, SSH, SCP, production config, or dependency install action is needed;
- evidence cannot be sanitized confidently.

## 15. Report Requirements

Report path:

Required output sections:

- [ ] Russian executive summary.
- [ ] Russian complete findings list.
- [ ] Russian method and limitations.
- [ ] English technical section.
- [ ] Evidence inventory with `E-001` style IDs.
- [ ] Findings with `F-001` style IDs.
- [ ] Safety and boundary notes.
- [ ] Stop conditions.
- [ ] Unavailable layers and missing prerequisites.
- [ ] Next fix batches or approval requests.

## 16. Approvals And Unavailable Prerequisites

Approved by:

Approval date:

Separate approvals still required:

| Item | Needed for | Owner | Status |
|---|---|---|---|
|  |  |  | missing |

Unavailable prerequisites to report as limitations:

| Prerequisite | Affected layer | Report wording |
|---|---|---|
|  |  |  |
