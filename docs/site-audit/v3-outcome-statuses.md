# Site Audit V3 Outcome Statuses
<!--
  @file:        docs/site-audit/v3-outcome-statuses.md
  @description: Human-readable outcome status contract for Site Audit V3
  @updated:     2026-05-25
  @version:     1.0
-->

## Why This Registry Exists

The outcome status registry prevents a useful but incomplete audit from being reported as a full live/browser audit. V3 status must describe what evidence actually exists, not what the audit intended to check.

## Status Table

| Status | Meaning | Blocks Full Audit |
|---|---|---|
| `blocked_at_preflight` | Required scope, tooling, access, or safety prerequisites are missing before execution. | yes |
| `partial_static_audit` | Only static repository/source or supplied static evidence was inspected. | yes |
| `partial_audit_with_unavailable_layers` | Some layers ran, but requested layers were unavailable or unsafe. | yes |
| `full_live_browser_audit_completed` | Declared full scope passed preflight and required live/browser/flow evidence exists. | no |
| `post_fix_regression_completed` | Prior findings were retested with required evidence. | no |
| `post_fix_regression_partial` | Some regression checks ran, but others lacked prerequisites or evidence. | yes |

## Transition Rules

Preflight produces the first gate decision:

- `blocked_at_preflight` when required scope, approval, access, or tooling is missing.
- `partial_static_audit` when static-only fallback is the only safe supported layer.
- `partial_audit_with_unavailable_layers` when some layers can run but requested layers remain unavailable.
- `full_live_browser_audit_completed` only after preflight passes full live/browser readiness and the report contains matching evidence for the declared full scope.

Post-fix work uses regression statuses only after a separate fix batch exists and prior finding IDs are retested.

## Correct Downgrades

- DNS fails or the live URL is unreachable: use `blocked_at_preflight` or a partial static status if static scope is approved.
- Browser automation is unavailable: live/browser completion is not allowed; use a partial status.
- Test accounts are missing for auth scope: auth is an unavailable layer and the final status is partial.
- Sandbox payment is missing: payment-path audit stops before charge or is unavailable; final status is partial.

## Forbidden Labels

- Do not write "full audit complete" for a source-only review.
- Do not write "browser checked" when no `browser_rendered` evidence exists.
- Do not write "flow completed" when no approved synthetic flow transcript exists.
- Do not write "all issues fixed" when regression did not retest every targeted finding.

## Aggregator Enforcement Rule

The aggregator must compare the preflight decision, unavailable-layer register, evidence table, and final status. If the status overstates evidence, the aggregator downgrades the status before completion and records the reason in the final report.

