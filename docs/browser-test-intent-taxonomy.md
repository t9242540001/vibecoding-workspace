# Browser Test Intent Taxonomy

## Purpose

The real public browser tool should support different testing intents without mixing them accidentally.

The same safe pipeline can serve multiple purposes:

approved route/profile -> browser observation -> sanitized summary -> validator -> optional model analysis -> sanitized reports.

Each profile should declare its intent so operators know whether a run is checking basic health, verifying exact acceptance criteria, auditing product quality, or preparing for higher-risk product journeys.

Do not mix intents in one profile unless the profile is explicitly designed and reviewed for that combined purpose.

## Current Implemented Intents

- `health_check`
- `acceptance_check`
- `content_audit`
- `link_check`

## Planned Or Future Intents

- `form_check`
- `dialogue_e2e`
- `document_result_review`

## `health_check`

Purpose:

- Verify that the route loads and produces a valid sanitized summary.

Typical result:

- works / does not work;
- technical errors;
- validation/forbidden scan status.

Current profile:

- `homepage-load-only`

Current status:

- implemented.

Risk level:

- low.

Browser actions:

- no clicks;
- no forms;
- no auth.

## `acceptance_check`

Purpose:

- Verify a specific expectation, such as CTA presence or required text.

Typical result:

- passed / failed;
- missing criteria;
- evidence from sanitized summary.

Current profile:

- `homepage-primary-cta-presence`

Current status:

- implemented for CTA presence.

Risk level:

- low while text-only.

Browser actions:

- no clicks;
- no forms;
- no auth.

## `content_audit`

Purpose:

- Analyze quality of page communication from a target audience perspective.

Typical result:

- product recommendations;
- clarity/offer/trust/SEO/mobile-readiness signals;
- human-review guidance.

Current profile:

- `homepage-content-audit-v1`

Current status:

- implemented.

Risk level:

- low while text-only.

Browser actions:

- no clicks;
- no forms;
- no auth;
- no screenshots.

## `link_check`

Purpose:

- Verify public links and contact-style links without entering data or submitting forms.

Typical result:

- working / broken links;
- unexpected redirects;
- unsafe/private/auth destinations;
- no form submission.

Current profile:

- `homepage-link-check-v1`

Current status:

- implemented for public homepage links.

Risk level:

- medium.

Browser actions:

- extracts sanitized link metadata from the loaded public page;
- checks public-looking HTTP/HTTPS links with safe status-only HEAD/GET requests;
- classifies contact links without opening them or sending messages;
- does not submit forms;
- does not login;
- does not follow private/auth/payment/logout links.

## `form_check`

Purpose:

- Verify public capture forms without submitting real personal data unless separately approved.

Typical result:

- form exists;
- fields are visible;
- validation works;
- submission safety is defined.

Current profile:

- none yet.

Current status:

- planned.

Risk level:

- medium/high.

Browser actions:

- may require typing synthetic data;
- submission must be separately approved;
- no real personal data.

## `dialogue_e2e`

Purpose:

- Verify a product dialogue flow, such as asking YurAssistent a task and receiving a response.

Typical result:

- scenario passed/failed;
- dialogue quality;
- tool behavior;
- failure points.

Current profile:

- none yet.

Current status:

- future approval-gated.

Risk level:

- high.

Browser actions:

- may require session, forms, typing, and app interaction;
- requires separate approval for credentials, data handling, route scope, stop conditions, and artifacts.

## `document_result_review`

Purpose:

- Evaluate the quality of generated legal/informational document output.

Typical result:

- output structure quality;
- completeness;
- consistency with user task;
- risks/limitations;
- improvement recommendations.

Current profile:

- none yet.

Current status:

- future approval-gated.

Risk level:

- high.

Browser actions:

- may depend on dialogue E2E and generated content;
- must avoid real personal/client/payment data.

## How To Choose Intent

Choose `health_check` when the question is "does this route load and summarize safely?"

Choose `acceptance_check` when the question is "does this page meet a specific observable criterion?"

Choose `content_audit` when the question is "how clear, compelling, and trustworthy is this page from a user perspective?"

Choose planned or future intents only after their route scope, browser actions, data handling, stop conditions, and artifact policy are approved.

## Safety Boundaries By Intent

Low-risk text-only intents can use route load, visible text, high-level console summaries, high-level network summaries, and derived text signals.

Medium-risk intents need approved profiles for their added behavior. Link checks require safe link extraction and redirect boundaries; form checks require separate approval for synthetic input and submission boundaries.

High-risk intents such as dialogue E2E and document result review need separate approval for session handling, credentials, synthetic task data, generated content handling, and artifact retention.

All intents must keep secrets, cookies, auth headers, raw request/response bodies, screenshots, traces, raw HAR, local paths, and personal/client/payment data out of default artifacts.

## Future Expansion Rule

Add a new intent or profile only when it names:

- test intent;
- route compatibility;
- allowed actions;
- forbidden actions;
- acceptance or review criteria;
- artifact policy;
- stop conditions;
- data safety boundaries.

Do not expand from text-only checks into clicks, forms, auth, dialogue flows, or document review without explicit approval.
