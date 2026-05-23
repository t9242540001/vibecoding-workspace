# Site Audit Test Data And Access Template
<!--
  @file:        templates/site-audit/test-data-and-access-template.md
  @description: Safe template for describing audit test data, test account roles, and access references without storing secrets
  @updated:     2026-05-23
  @version:     1.0
-->

Use this template together with `templates/site-audit/full-audit-scope-template.md` when an audit needs synthetic data, test accounts, auth/account checks, payment-path checks, admin boundary checks, API/server-route/SSE checks, or form/tool submissions.

Do not store passwords, tokens, API keys, cookies, auth headers, storage state, payment data, or real personal/client data in this file.

## 1. Audit Context

- Project:
- Environment label:
- Audit run label:
- Related scope file:
- Report path:
- Prepared by:
- Date:

## 2. Access Source Reference Rule

Access values are not stored here.

Allowed references:

- password manager item label;
- GitHub Actions secret name;
- approved environment secret name;
- manual operator entry;
- product repository instruction that names where access is obtained without showing values.

Forbidden:

- password values;
- tokens or API keys;
- cookies, local storage, session storage, storage state, auth headers;
- raw one-time codes or recovery codes;
- private URLs with tokens;
- payment card, bank, billing, invoice, or tax data;
- real personal/client data.

## 3. Test Account Role Labels

List role labels, not credential or access values.

| Role label | Purpose | Environment | Access source reference | Allowed flows | Forbidden actions | Notes |
|---|---|---|---|---|---|---|
| anonymous visitor | Public no-auth checks |  | none |  | auth-only routes |  |
| test user | Standard auth/account checks |  |  |  | real profile/payment changes |  |
| test paid user | Entitlement checks |  |  |  | billing mutation |  |
| test admin read-only | Admin boundary checks |  |  | non-destructive access checks | create/delete/export/refund/settings changes |  |

Missing test account reporting:

- Missing role:
- Affected audit layer:
- Affected route/flow:
- Needed prerequisite:
- Report limitation wording:

## 4. Synthetic Data Sets

Use values that are visibly synthetic and safe.

| Data label | Example value | Use | Allowed? | Notes |
|---|---|---|---:|---|
| Test name | Test User Audit | Name fields | Yes | Clearly synthetic |
| Test email | audit-test@example.com | Email fields | Yes | Reserved example domain |
| Test message | Synthetic audit message. Do not process as a real request. | Message/tool fields | Yes | Declares test status |
| Test company | Audit Example LLC | Organization fields | Yes | Clearly synthetic |
| Test address | 123 Example Street, Test City | Address fields | Yes | Use only when address is required |

Product-specific synthetic data:

| Field | Synthetic value | Reason needed | Stop condition |
|---|---|---|---|
|  |  |  |  |

## 5. Forbidden Real Data

Do not use:

- real names, emails, phone numbers, addresses, or identifiers;
- real client, customer, case, lead, medical, legal, financial, or private business data;
- real uploaded documents or images;
- real payment card, bank, billing, invoice, or tax data;
- real credentials or credential-like values;
- copied production records;
- real messages that would cause staff, users, customers, or external services to act.

If the flow requires forbidden real data, stop and report the missing safe test-data prerequisite.

## 6. Forms, Tools, And Generation Data

| Flow/tool | Route | Data set | Fill allowed? | Submit/generate allowed? | Stop-before point | Expected evidence |
|---|---|---|---:|---:|---|---|
|  |  |  |  | No |  |  |

Default rule:

- Filling with synthetic data may be approved.
- Submit/generate requires explicit route, data, artifact, and stop-condition approval.
- Production contact messages, lead creation, uploads, account creation, settings changes, and notifications default to stop-before-submit.

## 7. Payment Sandbox Or Stop-Before-Charge Policy

Select one:

- [ ] Payment path not approved.
- [ ] Sandbox/test mode approved.
- [ ] Stop-before-charge mode approved.

Payment provider:

Approved mode:

Provider test instrument source reference, not value:

Stop-before-charge point:

Allowed evidence:

- pricing visibility;
- checkout continuity;
- validation/error states;
- sandbox/test payment state;
- receipt/cancellation state in test mode;
- stop-before-charge note.

Forbidden:

- real charge;
- refund;
- saved payment method mutation;
- live subscription or billing change;
- real payment/bank/billing/tax data;
- storing payment test instrument values in this file unless the provider explicitly documents them as public test values and the scope approves quoting them.

Missing payment prerequisite reporting:

| Missing prerequisite | Affected route/flow | Report limitation wording |
|---|---|---|
|  |  |  |

## 8. Admin Non-Destructive Action List

Approved non-destructive admin boundary checks:

- [ ] anonymous user blocked from admin route;
- [ ] lower role denied restricted route;
- [ ] restricted UI hidden or disabled;
- [ ] server returns safe denial status/summary;
- [ ] read-only role can view only approved safe areas;
- [ ] no sensitive private data is copied into report.

Forbidden admin actions:

- create;
- edit;
- delete;
- export;
- refund;
- approve/reject;
- publish/unpublish;
- invite/remove user;
- impersonate;
- settings change;
- permission change;
- production data mutation.

Stop if proving the boundary requires a forbidden action or private data exposure.

## 9. API, Route, And SSE Test Data

| Route/endpoint label | Auth role label | Synthetic input | Allowed evidence | Forbidden evidence |
|---|---|---|---|---|
|  |  |  | status and safe response shape | raw payloads, headers, tokens |

Allowed:

- status code;
- timeout/error summary;
- response-shape summary;
- stream start/stop summary;
- client-visible failure evidence.

Forbidden:

- raw sensitive request bodies;
- raw response bodies;
- auth headers;
- cookies;
- tokens;
- server, deploy, environment, feature-flag, or secrets changes.

## 10. Redaction Rules

Before model analysis, report writing, or artifact retention:

- replace URLs with route labels when private or tokenized;
- remove query strings with identifiers;
- omit access and credential values completely;
- redact emails and phone numbers unless they are approved synthetic examples;
- summarize console/network errors without headers, cookies, tokens, request bodies, or response bodies;
- omit screenshots or media containing sensitive values unless a separate redaction workflow is approved;
- report sensitive findings by exposure type, safe location class, impact, and remediation path only.

Required wording for omitted sensitive value:

`Raw value omitted. Reported by exposure class only.`

## 11. Missing Prerequisite Reporting

When a prerequisite is missing, do not invent data and do not downgrade the universal audit model. Report the limitation.

| Missing item | Affected layer | Affected route/flow | Safe next step |
|---|---|---|---|
| test account | auth/account |  | approve role label and access source reference |
| sandbox payment mode | payment-path |  | approve sandbox/test mode or stop-before-charge point |
| screenshot approval | browser visual |  | approve artifact policy and redaction rule |
| synthetic data set | interactive user-flow |  | approve safe synthetic data |

## 12. Stop Conditions

Stop the affected evidence path if:

- a credential value, access value, token, cookie, auth header, storage state, or secret appears;
- real personal/client/payment/private data is needed or encountered;
- the approved access source is missing or unclear;
- a test account has the wrong role or contains real user data;
- a real payment, refund, billing mutation, destructive admin action, or irreversible state change is required;
- a form/tool cannot be tested with synthetic data;
- artifact redaction cannot be performed confidently.

Stop report wording:

- Affected layer:
- Route/flow:
- Reason:
- Raw sensitive value omitted? Yes / No:
- Needed prerequisite:
