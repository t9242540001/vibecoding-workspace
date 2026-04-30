# Work Tracks

Use these tracks to keep workspace process work separate from product repository work.

## Track A - Workspace / Vibecoding

Repository: `t9242540001/vibecoding-workspace`

Purpose:

- standards;
- skills;
- templates;
- onboarding;
- workflow;
- tools;
- automation rules.

Changes here affect the development system.

Use this track for universal process improvements, reusable prompt templates, shared workflow documentation, and workspace operating rules.

## Track B - Product Repositories

Examples:

- `t9242540001/yurassistent`

Purpose:

- product-specific code;
- product knowledge;
- product deploy and rollback notes;
- product tasks;
- product-specific decisions.

Product facts must stay in product repositories.

## Routing Rules

- Universal process improvements go to `vibecoding-workspace`.
- Product-specific facts and decisions go to that product's `knowledge/`.
- If a product reveals a process problem, record the process fix in the workspace first.
- Do not mix product facts into workspace standards.
- Do not turn one product's exception into a universal rule without a deliberate decision.
