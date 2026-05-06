# Real Staging Browser Workflow Design

## Purpose And Scope

This document proposes a future real staging browser workflow.

It is design-only. It does not create workflow YAML, connect real staging, add credentials, run browser automation, or approve implementation.

The scope is to define approval gates, high-level workflow shape, sanitization, stop conditions, artifact policy, credential handling, model policy, future acceptance criteria, and open questions.

The intended handoff is: approved browser route/interactions -> sanitized summary JSON -> validator -> Qwen/DeepSeek staging-summary analysis -> human review.

## Current Prerequisite Chain

The verified chain is:

1. Core model smoke.
2. E2E text fixtures.
3. E2E fixture matrix.
4. Sanitized staging summary contract.
5. Sanitized summary validator.
6. Staging-summary analysis with Qwen/DeepSeek.
7. Browser automation handoff contract.
8. Synthetic browser observations.
9. Synthetic browser summary generator.
10. Synthetic generator required run set passed.

The synthetic milestone matters because it proved the handoff without real staging exposure:

- synthetic observations became sanitized summary JSON;
- validation passed before model analysis;
- Qwen `qwen/qwen-plus` and DeepSeek `deepseek/deepseek-v4-flash` produced expected outcomes;
- `landing-success` returned `passed: true`;
- `landing-missing-cta` returned `passed: false`.

## Non-Goals

This step does not:

- implement a workflow;
- connect real staging;
- add credentials or secret values;
- execute browser automation;
- add browser scripts;
- collect screenshots, videos, traces, or raw HAR;
- collect cookies, tokens, auth headers, raw request bodies, or raw response bodies;
- approve real staging access.

## Required Approval Gates

Implementation is blocked until Vasily explicitly approves:

- route scope: approved route labels, route purpose, and auth requirement;
- staging access: whether GitHub Actions may reach staging and under what protection;
- credentials handling: whether credentials are needed, where secrets live, and who may trigger runs;
- sanitization: required summary fields, redaction rules, and strict forbidden-pattern behavior;
- stop conditions: when automation must stop and how sanitized stop reports are produced;
- artifact retention: artifact types, retention duration, and download access;
- model analysis provider choice: first provider set and whether one or both models must run.

## Proposed Future Workflow Shape

The first real staging workflow should:

1. Be manual-only.
2. Accept an approved route label, not an arbitrary URL.
3. Accept an approved interaction profile, not arbitrary browser commands.
4. Validate route and interaction against approved lists.
5. Run browser automation only after route/interaction validation.
6. Visit only the approved route.
7. Perform only approved interactions.
8. Collect allowed observations only.
9. Produce sanitized summary JSON.
10. Run the sanitized summary validator.
11. Stop before model calls if validation fails.
12. Run model analysis only after validation passes.
13. Use Qwen/DeepSeek only for the first text-analysis flow.
14. Upload sanitized summaries and reports only.
15. Avoid commits, pushes, PRs, and repository file changes.

Approved route and interaction lists should be fixed by configuration or workflow design, not free-form user input.

## Sanitization Rules

Allowed summary content:

- sanitized page title;
- route label, not full private URL;
- visible text snippets after redaction;
- interaction labels;
- high-level console and network error summaries after redaction;
- accessibility and performance notes;
- browser and viewport labels;
- acceptance criteria evidence.

The browser runner must remove or avoid:

- full private URLs by default;
- query strings;
- tokens and identifiers;
- emails and phone numbers;
- cookies and headers;
- raw request and response bodies;
- local paths;
- server IPs and private endpoints unless explicitly approved.

Screenshots, videos, traces, and raw HAR are forbidden by default.

## Stop Conditions

Browser automation must stop if:

- login/auth is required and not approved;
- payment or billing flow appears;
- real personal data appears;
- private client data appears;
- secrets, cookies, or tokens are detected;
- screenshots, videos, traces, or raw HAR are required but not approved;
- route or interaction scope is unclear;
- staging URL or credentials are missing or unclear;
- sanitization cannot confidently remove sensitive material.

Stop reports must be minimal and sanitized.

## Safe Artifact Policy

Allowed artifacts:

- sanitized summary JSON;
- validation report JSON;
- model request metadata without secrets;
- parsed model report JSON;
- short markdown summary.

Forbidden artifacts by default:

- cookies, auth headers, bearer tokens, API keys, passwords, and session dumps;
- raw HAR, raw request bodies, and raw response bodies;
- screenshots, videos, and traces;
- real personal data, private client data, and billing/payment data;
- full private URLs, private endpoints, server IPs, and local paths.

Retention should be short by default.

## Credential Handling Principles

Credentials, if later approved, must live only in GitHub Secrets or approved environment-scoped secrets.

The workflow must not print credentials, write them into summaries, copy them into docs/config examples, include them in artifacts, or expose them through browser traces.

The first design should prefer a public/no-auth staging route if available.

Auth-required routes need separate approval for secret names, environment protection, trigger permissions, masking, failure behavior, and artifact review.

## Model Analysis Policy

Validation must pass before any model call.

The first real staging text-analysis workflow may use only:

- Qwen `qwen/qwen-plus`;
- DeepSeek `deepseek/deepseek-v4-flash`.

Gemini remains excluded from the first real staging browser workflow.

Models receive only sanitized summary JSON, acceptance criteria, and the report schema.

Model reports must use strict JSON fields: `passed`, `score`, `summary`, `matched_criteria`, `missing_criteria`, `issues`, and `recommendation`.

## Future Implementation Acceptance Criteria

A future implementation prompt should require:

- manual-only trigger with approved route labels and interaction profiles only;
- no arbitrary URL or browser command input;
- sanitized summary JSON output and validator pass before model analysis;
- Qwen `qwen/qwen-plus` and DeepSeek `deepseek/deepseek-v4-flash` only, with Gemini excluded;
- sanitized summaries and reports only as short-retention artifacts;
- no screenshots, videos, traces, raw HAR, cookies, tokens, auth headers, raw request bodies, or raw response bodies by default;
- no credentials printed in logs;
- no repository file changes, commits, pushes, or PRs;
- stop conditions implemented and tested with safe cases.

## Open Questions For Vasily

- Which route labels are approved for the first workflow?
- Is a public/no-auth route available, or is auth required?
- If auth is needed, which environment and secret names are approved?
- Who may trigger the workflow, and which interaction profile is safe first?
- Are any state-changing interactions allowed?
- What artifact retention period should be used?
- Should Qwen, DeepSeek, or both run on every summary?
- What score or issue severity blocks acceptance?
- Who reviews model reports before a staging/product decision?
- What stop-condition text should appear in logs?
- When, if ever, can screenshots, videos, traces, or raw HAR be separately approved?

## Implementation Boundary

This document does not approve implementation.

The next step is design review and explicit approval of route scope, staging access, credentials handling, sanitization, artifact retention, stop conditions, and model provider choice.

Only after those approvals should a separate implementation prompt create a real staging browser workflow.
