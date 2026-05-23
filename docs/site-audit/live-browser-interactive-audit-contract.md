# Live Browser Interactive Audit Contract
<!--
  @file:        docs/site-audit/live-browser-interactive-audit-contract.md
  @description: Safe evidence contract for live, browser, interactive, auth, payment, admin, and API route website audits
  @updated:     2026-05-23
  @version:     1.0
-->

## Purpose

This contract defines how a full website audit may collect live HTTP, browser visual, interactive, auth/account, payment-path, admin/access-boundary, API/server-route, and SSE evidence without modifying product code, deployed configuration, infrastructure, real product data, accounts, payments, secrets, or production state.

The model is:

approved scope contract -> allowed audit action -> sanitized evidence -> report limitation or finding -> separate approved fix or follow-up batch.

Missing credentials, tooling, test accounts, sandbox payment mode, browser access, or artifact approval is a report limitation. It is not a permanent block on the audit methodology.

## 1. Required Scope Contract Before Execution

Before any live or browser action, the audit scope must define:

- target project, repository, site URL or route labels, and environment label;
- enabled audit layers;
- approved routes, pages, endpoints, route/profile pairs, and user flows;
- allowed actions and forbidden actions;
- browser/viewports, if browser visual evidence is enabled;
- forms, tools, generation flows, uploads, and submit boundaries;
- synthetic test data rules;
- approved test account role labels and credential source references;
- payment-path policy: sandbox/test mode, provider test instruments, or stop-before-charge point;
- admin/access-boundary policy: approved roles and non-destructive checks;
- API/server-route/SSE policy: approved routes/endpoints and safe response-summary limits;
- screenshot, artifact, retention, and redaction policy;
- stop conditions;
- report path and required outputs;
- unavailable prerequisites and how they should be reported.

If a requested layer lacks the required scope details, stop before executing that layer and report it as unavailable.

## 2. Allowed Evidence Layers

| Layer | Allowed evidence | Required boundary |
|---|---|---|
| Live HTTP checks | Status, redirects, public headers, robots/sitemap, public assets, public links, route availability, safe metadata. | Approved routes only, rate limits respected, no server or config changes. |
| Browser visual checks | Rendered content, viewport observations, layout notes, visible states, media, high-level console/network summaries, browser visual evidence, screenshots when approved. | Approved route/profile pairs, no arbitrary browser commands, no fabricated visual claims. |
| Interactive user-flow checks | Clicks, typing, reversible submissions, validation states, generated/tool result observations with synthetic data. | Synthetic data only, documented stop-before points, no unapproved state change. |
| Auth/account checks | Login, registration, recovery, profile, role, permission, session-state observations using approved test accounts. | Role labels only in reports, no credential disclosure, no real account mutation. |
| Payment-path checks | Pricing, checkout continuity, sandbox/test payment states, validation errors, receipts, cancellation, stop-before-charge evidence. | Sandbox/test mode or explicit stop-before-charge mode, no real charge/refund/saved-payment/billing mutation. |
| Admin/access-boundary checks | Unauthenticated blocked states, lower-role denial, restricted UI visibility, safe server denial summaries. | Non-destructive checks only, no create/delete/export/refund/settings mutation. |
| API/server-route/SSE checks | Connectivity, status, safe response-shape summaries, stream start/stop behavior, timeouts, retry/error surfaces, client integration evidence. | Observation only, no environment, feature-flag, server, deploy, or secrets changes. |

## 3. Test Data Rules

Use synthetic data that cannot be confused with a real person, client, legal matter, medical matter, payment instrument, or production record.

Synthetic data may include:

- names such as `Test User Audit`;
- emails under approved test domains or reserved examples, such as `audit-test@example.com`;
- phone numbers from reserved/example ranges when needed;
- fake addresses clearly labeled as test data;
- tool input text that says it is synthetic audit data;
- sandbox payment instruments from the payment provider's test documentation when the provider and mode are approved.

Do not use:

- real personal data;
- real client, legal-case, medical, financial, or business-confidential data;
- real payment card, bank, invoice, billing, or tax data;
- real production credentials;
- copied production records;
- real contact-message content that would reach staff or users unless separately approved as a reversible test scenario.

When a form or generation tool requires data that cannot be safely synthesized, stop that flow and report the missing test-data prerequisite.

## 4. Test Account Rules

Auth/account and admin/access-boundary audits require approved test accounts or test roles. The scope must list role labels, not passwords.

Allowed account references:

- `anonymous visitor`;
- `test user`;
- `test paid user`;
- `test support user`;
- `test admin read-only`;
- product-specific role labels approved in the product scope.

Credential handling rule:

- store no passwords, tokens, cookies, storage state, auth headers, or secret values in shared templates, reports, prompts, commits, logs, screenshots, or artifacts;
- refer only to an approved credential source, such as `GitHub environment secret name`, `password manager item`, or `manual operator entry`;
- do not print or summarize credential values;
- stop if credential material appears in model input, logs, reports, or artifacts.

If test accounts are missing, expired, role-mismatched, or unsafe to use, report the affected auth/account or admin/access-boundary layer as unavailable with the needed prerequisite.

## 5. Form, Tool, And Generation Submission Rules

Form filling, tool use, and generation submission are allowed audit actions only when the scope names:

- route or tool;
- allowed fields;
- synthetic input data;
- whether submit is allowed;
- expected reversible state;
- stop-before point;
- expected evidence;
- cleanup expectation if reversible synthetic data is created.

For production contact forms, lead forms, order forms, support forms, uploads, account creation, settings changes, or notifications, the default is stop-before-submit unless the scope separately approves the exact submit action, data, stop conditions, and artifact policy.

Generated outputs may be inspected when they are produced from approved synthetic input. Do not use real client documents, legal cases, medical records, personal files, or private business material.

## 6. Payment-Path Boundaries

Payment-path testing must use one of these policies:

- `sandbox/test mode`: approved provider test mode and test instruments are available;
- `stop-before-charge mode`: pricing and checkout path are inspected up to the explicit charge boundary, then stopped;
- `not approved`: payment path is not executed and is reported as unavailable.

Forbidden without separate explicit approval:

- real charge;
- refund;
- saved payment method creation, update, or deletion;
- billing-plan change;
- subscription creation/cancellation on a real account;
- real invoice, bank, tax, or billing data use.

If sandbox/test mode is absent or cannot be verified, use stop-before-charge mode only if the scope defines the exact stop point. Otherwise report the payment-path layer as unavailable.

## 7. Admin/Access-Boundary Boundaries

Admin/access-boundary checks are non-destructive evidence collection.

Allowed examples:

- confirm unauthenticated users are redirected or denied;
- confirm lower roles cannot view restricted pages;
- confirm restricted controls are absent, disabled, or blocked;
- confirm server responses deny unauthorized access without sensitive disclosure;
- compare role-visible navigation and safe status summaries.

Forbidden examples:

- create, edit, delete, export, refund, approve, reject, publish, ban, invite, or impersonate production records/users;
- change settings, permissions, feature flags, content, product data, or configuration;
- access private records beyond the minimum visible denial evidence;
- bypass auth, rate limits, paywalls, or anti-abuse controls.

If the only way to prove a boundary is destructive or exposes private data, stop and report the limitation.

## 8. Screenshot And Artifact Rules

Allowed by default:

- Markdown audit report;
- sanitized summary JSON;
- validation report JSON;
- high-level console/network summaries after redaction;
- synthetic interaction notes;
- safe API status and response-shape summaries;
- anonymized sensitive exposure notes;
- source line references and secret-free command excerpts.

Requires explicit scope approval:

- screenshots;
- videos;
- traces;
- raw HAR;
- upload test artifacts;
- private route labels;
- sandbox payment artifacts;
- test account use.

Forbidden unless separately approved and sanitized before model analysis or reporting:

- cookies;
- local storage;
- session storage;
- storage state;
- auth headers;
- bearer tokens;
- passwords;
- raw request bodies;
- raw response bodies;
- full private URLs;
- payment data;
- private client data.

Screenshots are allowed only when the scope states what may be captured, what must be redacted, where artifacts may be stored, retention period, and whether screenshots may be cited in reports. If screenshots were not captured or supplied, visual claims must be limited to observed browser text/summary evidence or marked unknown.

## 9. Redaction And Anonymization Rules

Reports and model inputs must never include raw sensitive values.

When sensitive material appears, stop that evidence path and report only:

- exposure type;
- safe location class;
- impact;
- recommended remediation path;
- whether the value was omitted.

Redact or omit:

- secrets, API keys, tokens, passwords, cookies, auth headers, session material;
- personal data, private client data, legal-case data, medical data, payment data, billing data;
- raw private URLs, query strings with identifiers, request bodies, response bodies;
- screenshots or artifacts containing sensitive values unless a separate redaction workflow is approved.

Use anonymized wording such as: `A credential-like value was visible in a public browser artifact on the checkout route. The raw value is omitted.`

## 10. Evidence IDs And Artifact Naming

Use stable IDs so findings, evidence, and follow-up prompts can be traced.

Evidence IDs:

- `E-001`, `E-002`, `E-003` for report-level evidence inventory;
- include type, layer, route/profile, viewport, captured-by, timestamp or run label, artifact path or summary reference, redaction status, and notes;
- do not include secret values or private URLs in the ID or filename.

Finding IDs:

- `F-001`, `F-002`, `F-003`;
- each finding cites one or more evidence IDs.

Recommended artifact naming:

- `audit-{project_slug}-{run_label}-report.md`;
- `audit-{project_slug}-{run_label}-sanitized-summary-{route_label}-{profile_id}.json`;
- `audit-{project_slug}-{run_label}-validation-report.json`;
- `audit-{project_slug}-{run_label}-screenshot-{route_label}-{viewport_label}-redacted.png` when screenshots are approved;
- `audit-{project_slug}-{run_label}-stop-report.md` for sanitized stop reports.

Use route labels and viewport labels, not private full URLs.

## 11. Stop Conditions

Stop the affected evidence path and report when any condition appears:

- scope omits required route, profile, test data, account, artifact policy, stop point, or approval;
- secret, credential, token, cookie, auth header, session material, or private key is visible;
- real personal, client, legal-case, medical, payment, billing, or private user data appears;
- unapproved submit, upload, contact-message, auth, payment, admin, account, logout, destructive, or settings-change action is required;
- real charge, refund, saved payment mutation, billing change, destructive admin action, irreversible account mutation, or production data mutation is required;
- browser automation needs arbitrary URLs or arbitrary browser commands;
- screenshots, videos, traces, raw HAR, raw storage, raw headers, or raw payloads are required without approval;
- broad crawling, scraping, rate-heavy checks, anti-abuse bypass, paywall bypass, or private endpoint probing would be needed;
- server, deploy, database, secrets, SSH, SCP, process-management, environment, feature-flag, or production config action is required;
- evidence cannot be sanitized confidently;
- validation failure cannot be fixed inside the approved report/template scope.

Stop reports must be minimal and sanitized. Do not quote the sensitive value that caused the stop.

## 12. Missing Prerequisite Reporting

When a needed credential, account, route, sandbox mode, browser tooling, screenshot approval, or artifact policy is missing, report:

- requested audit layer;
- missing prerequisite;
- affected routes or flows by safe label;
- evidence that was still collected, if any;
- exact next approval or input needed;
- whether Batch or follow-up work can proceed without that layer.

Use wording like:

`Payment-path audit was not executed. Missing prerequisite: sandbox/test mode or explicit stop-before-charge point. Static pricing and visible checkout entry points were reviewed; no charge flow evidence was collected.`

## 13. Non-Modification Rule

Audit execution must not change product code, product content, application data, deployed configuration, infrastructure, server processes, database state, secrets, credentials, real accounts, real payments, billing state, DNS, CI/CD, or production settings.

Reversible synthetic data created inside an approved audit flow is allowed only when the scope explicitly approves the flow and cleanup expectation. Fixes and product changes belong in separate scoped prompts or batches.
