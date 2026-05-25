# Site Audit V3 Evidence Registry
<!--
  @file:        docs/site-audit/v3-evidence-registry.md
  @description: Human-readable evidence class contract for Site Audit V3
  @updated:     2026-05-25
  @version:     1.0
-->

## Why Evidence Classes Exist

V3 agents use a shared evidence vocabulary so reports do not mix source facts, browser observations, expert judgment, unavailable layers, and sensitive exposure signals. Every finding must cite evidence by class and location.

## Classes That Can Support Full Live/Browser Status

The classes that can support a full live/browser claim are `http_public`, `browser_rendered`, `screenshot_sanitized`, `console_summary`, `network_summary`, `flow_transcript_synthetic`, `auth_test_account`, `payment_sandbox_or_stop_before_charge`, `admin_boundary_non_destructive`, `api_response_shape_summary`, and `performance_measurement` when they match the approved scope.

Static classes such as `static_source`, `repository_config`, `accessibility_manual_check`, `analytics_signal`, and `expert_assessment` can support findings, but they cannot prove full live/browser completion by themselves.

## Unavailable Layers

When a requested layer cannot run, agents record `unavailable_layer` with the layer name, reason, missing prerequisite, and next action. Unavailable layers must appear in the final report and usually downgrade the outcome status.

## Sensitive Exposure Reporting

Sensitive material is never quoted. Use `sensitive_exposure_class_only` and report only the exposure class, safest useful location, impact, and remediation path. Do not store secrets, credentials, tokens, cookies, raw HAR, request bodies, response bodies, payment data, or personal data.

## Agent Citation Rule

Every agent handoff cites evidence IDs in findings. A finding must distinguish observed fact, supporting evidence, inferred risk, impact, recommendation, confidence, and status. `expert_assessment` may explain judgment, but it must point to supporting evidence IDs.

## Aggregator Rejection Rule

The aggregator rejects or downgrades findings that lack observed fact, evidence ID, safe location, or role-appropriate support. Unsupported recommendations may be kept only as hypotheses or follow-up questions, never as final facts.

