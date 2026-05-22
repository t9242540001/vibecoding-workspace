# Pilot Public Site Audit Scope Example

<!--
  @file:        prompts/series/site-audit-skill/pilot-scope-example.md
  @description: Synthetic filled scope example for the reusable public site audit pilot prompt
  @updated:     2026-05-22
-->

This is a synthetic example only. It uses fake project data and a reserved invalid URL. Do not treat it as an approved real audit scope.

## Target

- Project: Example Public Site
- Repository: `example/example-public-site`
- Public URL: `https://example.invalid`
- Environment: public production placeholder
- Audit owner: Example Owner
- Report path: `reports/site-audit/example-public-site-pilot.md`

## Mode

- Selected mode: read-only live public audit
- Non-submit form/tool audit: not approved in this example
- Submit/auth/payment/admin audit: not approved

## Routes

| Route/Page | URL or path | Purpose | Priority | Notes |
|---|---|---|---|---|
| home | `https://example.invalid/` | Review first viewport, navigation, public metadata, and primary CTA clarity. | High | Public no-auth page only. |
| pricing | `https://example.invalid/pricing` | Review offer clarity, trust wording, SEO headings, and public links. | Medium | Public no-auth page only. |

## Viewports

| Viewport | Required? | Notes |
|---|---:|---|
| Desktop 1440x900 | Yes | Public read-only observation or supplied sanitized summary. |
| Mobile 390x844 | Yes | Public read-only observation or supplied sanitized summary. |
| Mobile 320x720 | No | Use only if explicitly approved. |
| Tablet 768x1024 | No | Use only if explicitly approved. |

## Tools And Forms

| Form/Tool | Route | Allowed interaction | Submit allowed? | Test data policy |
|---|---|---|---:|---|
| Newsletter signup | home | Inspect labels, hints, required markers, disabled state, and privacy copy only. | No | No data entry. |
| Pricing calculator | pricing | Inspect visible fields and default client-side state only. | No | Synthetic placeholder values only if non-submit interaction is separately approved. |

## Allowed Actions

- Read the product repository instructions and approved public knowledge files.
- Open or inspect only the listed public no-auth routes.
- Inspect visible text, headings, links, public metadata, and public source where in scope.
- Review approved sanitized browser summaries if the user provides them.
- Record findings in the declared report path.
- Run report validation and repository-local checks that do not install dependencies or change product code.

## Forbidden Actions

- No production form submit or contact-message sending.
- No auth, admin, payment, billing, account, upload, logout, settings-change, or destructive flows.
- No real personal data, client data, payment data, credentials, cookies, storage, auth headers, tokens, or `.env` values.
- No deploy, server, database, SSH, SCP, process-management, production config, or secrets action.
- No dependency installation.
- No product-code changes during the audit.
- No arbitrary URLs, broad crawling, scraping, rate-heavy checks, or arbitrary browser commands.
- No screenshots, videos, traces, raw HAR, cookies, storage state, auth headers, raw request bodies, raw response bodies, private URLs, server IPs, or private endpoints.

## Artifact Policy

Allowed:

- Markdown audit report at `reports/site-audit/example-public-site-pilot.md`.
- Sanitized summary JSON supplied by an approved browser/E2E workflow.
- Command output excerpts with no secrets or private data.
- Source line references inside the approved repository scope.

Forbidden:

- Screenshots.
- Videos.
- Traces.
- Raw HAR.
- Cookies.
- Local storage or session storage.
- Storage state.
- Auth headers.
- Raw request or response bodies.
- Private URLs or private endpoints.
- Real user, client, payment, billing, or credential data.

## Report Path

`reports/site-audit/example-public-site-pilot.md`

## Checks

- `git status --short`
- `git diff --check`
- Report completeness check against `templates/site-audit/report-template.md`.
- Validation gate check against `docs/site-audit/validation-gates.md`.
