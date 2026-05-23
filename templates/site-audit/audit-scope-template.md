# Site Audit Scope Template
<!--
  @file:        templates/site-audit/audit-scope-template.md
  @description: Reusable scope definition template for website audits
  @updated:     2026-05-23
  @version:     1.1
-->

## 1. Target

- Project:
- Repository:
- Site URL:
- Environment: public production / public staging / local / other:
- Audit owner:
- Report path:

## 2. Enabled Audit Layers

Select all approved layers. A full audit may combine layers when the routes, data/accounts, artifact policy, and stop conditions are explicit.

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

Unavailable layers and reason:

## 3. Allowed Actions

- Pages/routes may be opened:
- Source files may be read:
- Public metadata may be inspected:
- Console/network summaries may be inspected:
- Interactions allowed:
- Synthetic test data may be submitted:
- Test accounts/roles may be used:
- Payment-path boundary: sandbox/test mode / stop-before-charge / not approved:
- Admin/access-boundary checks allowed:
- API/server-route/SSE checks allowed:
- Automated checks allowed:
- Artifacts allowed:

## 4. Forbidden Actions

- Product code/content/config/infrastructure modification:
- Production form submit or real contact-message sending:
- Real auth/admin/payment/account changes:
- Real payment/refund/billing/saved-payment mutation:
- Destructive admin/account actions:
- Real personal data:
- Uploads:
- Secrets/deploy/server/database actions:
- Screenshots/videos/traces/raw HAR/cookies/storage/auth headers:
- Broad crawling or rate-heavy checks:
- Sensitive data disclosure in reports:
- Other:

## 5. Routes And Pages

| Route/Page | URL or path | Purpose | Priority | Notes |
|---|---|---|---|---|
|  |  |  |  |  |

## 6. Devices And Viewports

| Device/Viewport | Required? | Notes |
|---|---:|---|
| Desktop default |  |  |
| 320px mobile |  |  |
| 360-390px mobile |  |  |
| 414px mobile |  |  |
| Tablet |  |  |

## 7. Forms And Tools

| Form/Tool | Route | Allowed interaction | Submit allowed? | Test data policy |
|---|---|---|---:|---|
|  |  |  | No | Synthetic only |

## 8. Test Data, Accounts, And Payment/Admin Boundaries

- Synthetic data policy:
- Approved test accounts:
- Approved test roles:
- Credential handling rule:
- Payment sandbox/test mode:
- Payment stop-before-charge point:
- Admin non-destructive boundary:
- Reversible synthetic data cleanup expectation:

## 9. Artifact Policy

| Artifact type | Allowed? | Redaction/retention notes |
|---|---:|---|
| Markdown report | Yes |  |
| Sanitized summary JSON |  |  |
| Screenshots | No |  |
| Videos/traces/raw HAR | No |  |
| Console/network summaries |  | High-level only |
| Sensitive exposure notes |  | Exposure type and safe location only |

## 10. Required Outputs

- [ ] Summary
- [ ] Scope and method
- [ ] Enabled audit layers
- [ ] Evidence inventory
- [ ] Findings table
- [ ] Severity definitions
- [ ] Prioritized recommendations
- [ ] Out-of-scope items
- [ ] Stop conditions
- [ ] Next fix prompts

## 11. Approval Gates

Stop and ask before:

- opening a route not listed above;
- submitting any form or sending any message outside the allowed synthetic/test boundary;
- logging in, using admin, account, billing, or payment flows outside the approved test-account or sandbox/stop-before-charge boundary;
- collecting screenshots, videos, traces, raw HAR, cookies, storage, or auth headers;
- using real personal, client, payment, or credential data;
- running deploy, server, database, secrets, SSH, or SCP actions;
- changing product code during the audit.

## 12. Sensitive Data Reporting Rule

If secrets, credentials, personal data, payment data, cookies, tokens, auth/session material, or private payloads appear, stop the risky evidence path. The report may include only exposure type, safe location class, impact, and remediation path. Do not quote, screenshot, store, or commit raw sensitive values.
