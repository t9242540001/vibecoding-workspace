# Site Audit Report Template
<!--
  @file:        templates/site-audit/report-template.md
  @description: Reusable structured report format for website audits
  @updated:     2026-05-22
  @version:     1.0
-->

# Site Audit Report: [Project / Site]

## Summary

- Audit date:
- Auditor:
- Audit mode:
- Target URL/repository:
- Overall result:
- Highest severity:
- Stop conditions encountered:

## Scope

### In Scope

- Routes/pages:
- Devices/viewports:
- Forms/tools:
- Audit dimensions:
- Approved artifacts:

### Out Of Scope

- Routes/pages:
- Devices/viewports:
- Forms/tools:
- Actions:
- Artifacts:

## Method

- Source/context read:
- Automated checks run:
- Manual/browser observations:
- Sanitized summaries reviewed:
- Limits of evidence:

## Evidence Inventory

| Evidence ID | Type | Location | Captured by | Notes |
|---|---|---|---|---|
| E-001 |  |  |  |  |

## Findings

| ID | Severity | Category | Location | Evidence | Impact | Recommendation | Status |
|---|---|---|---|---|---|---|---|
| F-001 |  |  |  |  |  |  | open |

## Severity Definitions

| Severity | Definition |
|---|---|
| Critical | Blocks a primary user path, exposes secrets/PII, creates auth/payment/admin risk, causes legal/compliance risk, or makes the site unusable. |
| High | Strongly damages task completion, accessibility, trust, SEO discoverability, conversion, or safe decision-making. |
| Medium | Creates meaningful friction, confusion, quality loss, or ranking/measurement weakness without blocking the path. |
| Low | Local polish issue or minor inconsistency with limited user impact. |
| Observation | Useful non-defect signal, opportunity, unknown, or future check that does not currently justify a fix by itself. |

## Prioritized Recommendations

1. [Finding ID] - [Action] - [Reason]
2. [Finding ID] - [Action] - [Reason]
3. [Finding ID] - [Action] - [Reason]

## Safe-Boundary Notes

- Production form submit:
- Auth/admin/payment/account flows:
- Real personal data:
- Secrets/deploy/server/database actions:
- Screenshots/videos/traces/raw HAR/cookies/storage/auth headers:
- Code changes during audit:

## Stop Conditions

| Condition | Encountered? | Evidence / Decision |
|---|---:|---|
| Scope drift |  |  |
| Secret/credential exposure |  |  |
| Real personal/client/payment data |  |  |
| Unapproved submit/auth/payment/admin action needed |  |  |
| Deploy/server/database/secrets action needed |  |  |
| Required evidence outside artifact policy |  |  |

## Next Fix Prompts

| Prompt | Findings addressed | Scope | Approval needed? |
|---|---|---|---|
|  |  |  |  |

