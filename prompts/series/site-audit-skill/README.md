# Site Audit Pilot Prompt Package

<!--
  @file:        prompts/series/site-audit-skill/README.md
  @description: Usage notes for the reusable site-audit pilot prompt package
  @updated:     2026-05-22
-->

## Purpose

This package prepares a reusable prompt for the first safe public no-auth website audit pilot in a product repository.

It creates the audit prompt shape only. It does not run a live audit, browser automation, deployment, server action, dependency installation, or product-code change.

## Files

| File | Role |
|---|---|
| `pilot-public-site-audit-prompt.md` | Reusable Code Agent prompt template for scoped public no-auth site audit pilots. |
| `pilot-scope-example.md` | Synthetic example showing how to fill target, routes, viewports, forms/tools, actions, artifacts, and report path. |
| `series-plan.md` | Historical multi-batch plan for creating the universal site-audit system. |

## When To Use

Use this package when a product repository needs a first scoped audit of public no-auth pages and the user has approved:

- target project and repository;
- public URL;
- allowed pages or route labels;
- audit mode;
- allowed actions;
- forbidden actions;
- viewport checks;
- form/tool inspection limits;
- artifact policy;
- report path.

## When Not To Use

Do not use this package for:

- auth, admin, payment, account, billing, upload, logout, destructive, or production-changing flows without separate explicit approval;
- production form submission or contact-message sending;
- real personal, client, payment, credential, cookie, storage, token, or `.env` data;
- deploy, server, database, SSH, SCP, process-management, production config, or secrets work;
- dependency installation;
- broad crawling, scraping, arbitrary URLs, arbitrary browser commands, or rate-heavy checks;
- screenshots, videos, traces, raw HAR, cookies, storage, auth headers, raw request bodies, or raw response bodies unless the audit scope separately approves the exact artifact type;
- product-code fixes during the audit.

## Connection To `site-audit`

The prompt package operationalizes:

- `skills/site-audit/SKILL.md` for audit modes, workflow, evidence, severity, safety boundaries, and anti-patterns;
- `docs/site-audit/agentic-audit-pipeline.md` for scope gate, read order, safe evidence collection, reporting, validation, and stop conditions;
- `docs/site-audit/validation-gates.md` for report acceptance gates;
- `templates/site-audit/report-template.md` for the required report structure;
- `templates/site-audit/finding-taxonomy.md` and `configs/site-audit-severity-taxonomy.json` for categories, severity, and evidence requirements;
- `configs/site-audit-default-scope.json` for default allowed and forbidden policy.

## Safe Launch Procedure

1. Copy the template content into a product-specific prompt path approved for that repository.
2. Replace every placeholder with concrete scope data.
3. Confirm the selected audit mode is exactly one mode from `skills/site-audit/SKILL.md`.
4. Confirm route/page scope uses approved public no-auth URLs or approved route labels.
5. Confirm form/tool rows say whether interaction is read-only, non-submit only, or separately approved.
6. Confirm the artifact policy forbids raw browser/session artifacts by default.
7. Confirm the checks do not install dependencies, deploy, access servers, read secrets, or change product code.
8. Run the prompt only after the user has approved the final scope.

## Required User Approval Gates

Separate explicit approval is required before:

- opening any route outside the approved list;
- submitting a form, sending a message, uploading a file, or changing state;
- logging in, logging out, using auth, admin, account, billing, or payment flows;
- using real personal, client, payment, billing, credential, cookie, storage, token, or private user data;
- collecting screenshots, videos, traces, raw HAR, cookies, storage state, auth headers, raw request bodies, or raw response bodies;
- running browser automation beyond named route labels, interaction profiles, viewports, and artifact policy;
- installing dependencies;
- touching deploy, server, database, SSH, SCP, process management, production config, or secrets;
- changing product code.

## Adapting For A Product Repository

In the product repository:

- keep project-specific URLs, routes, report paths, and knowledge references inside the filled prompt or product repo;
- use the product repository's `AGENTS.md`, main context file, and knowledge files as required reads;
- place the final report in the product repository path approved by the user;
- keep shared methodology references pointed to this workspace's `skills/site-audit`, `docs/site-audit`, `templates/site-audit`, and `configs/site-audit` artifacts;
- convert findings into separate fix prompts only after the audit report is complete and the user approves the fix scope.
