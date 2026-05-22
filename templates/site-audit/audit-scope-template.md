# Site Audit Scope Template
<!--
  @file:        templates/site-audit/audit-scope-template.md
  @description: Reusable scope definition template for website audits
  @updated:     2026-05-22
  @version:     1.0
-->

## 1. Target

- Project:
- Repository:
- Site URL:
- Environment: public production / public staging / local / other:
- Audit owner:
- Report path:

## 2. Audit Mode

Select one:

- [ ] Static repository audit
- [ ] Read-only live public audit
- [ ] Non-submit form/tool audit
- [ ] Approved submit/auth/payment/admin audit
- [ ] Post-fix regression audit

Approval note for any submit/auth/payment/admin action:

## 3. Allowed Actions

- Pages/routes may be opened:
- Source files may be read:
- Public metadata may be inspected:
- Console/network summaries may be inspected:
- Non-submit interactions allowed:
- Automated checks allowed:
- Artifacts allowed:

## 4. Forbidden Actions

- Production form submit:
- Auth/admin/payment/account flows:
- Real personal data:
- Uploads/contact-message sending:
- Secrets/deploy/server/database actions:
- Screenshots/videos/traces/raw HAR/cookies/storage/auth headers:
- Broad crawling or rate-heavy checks:
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

## 8. Required Outputs

- [ ] Summary
- [ ] Scope and method
- [ ] Evidence inventory
- [ ] Findings table
- [ ] Severity definitions
- [ ] Prioritized recommendations
- [ ] Out-of-scope items
- [ ] Stop conditions
- [ ] Next fix prompts

## 9. Approval Gates

Stop and ask before:

- opening a route not listed above;
- submitting any form or sending any message;
- logging in, using admin, account, billing, or payment flows;
- collecting screenshots, videos, traces, raw HAR, cookies, storage, or auth headers;
- using real personal, client, payment, or credential data;
- running deploy, server, database, secrets, SSH, or SCP actions;
- changing product code during the audit.

