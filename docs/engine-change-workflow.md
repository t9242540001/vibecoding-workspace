# Engine Change Workflow

Complex existing systems are not changed from symptoms. They are changed from audited understanding, observable failure points, and end-to-end validation.

This workflow came from real product lessons and is intended as a universal workspace process.

## Purpose

This workflow exists for changing existing complex engines and pipelines safely and effectively.

It prevents:

- premature fixes before the current mechanism is understood;
- blind debugging without observable failure points;
- unverified AI-product behavior after implementation.

## When This Applies

Use this workflow when a task touches:

- an existing complex product mechanism;
- an engine or pipeline;
- prompt orchestration;
- an AI-call chain;
- OCR/upload flow;
- storage/logging/admin flow;
- generation or evaluation flow;
- multi-step UI flow;
- T3 changes to an existing system;
- a recurring bug where symptom-level fixes failed or may fail.

This does not apply to trivial copy changes, isolated typos, or narrow single-file changes with no engine or pipeline impact.

## Current Engine Audit

Implementation prompts are blocked until the current mechanism is understood.

The audit must identify:

- current architecture;
- existing attempts already present in code;
- logic that exists only at prompt level;
- logic that exists as reliable code/data flow;
- partial implementations;
- disconnected layers;
- real failure points;
- what should not be changed.

## Prompt-Level vs Code-Level Logic

Prompt-level intention can guide model behavior, but it is not enough when durable data flow or deterministic behavior is required.

Code-level or data-layer logic is needed when the system must reliably pass evidence, facts, context, modes, flags, or traceable decisions between stages.

## Failure Point Mapping

Map where the failure actually occurs before proposing a fix:

- input collection;
- OCR/upload handling;
- context assembly;
- prompt assembly;
- model call;
- parsing/extraction;
- generation;
- storage;
- admin/debug display;
- deploy/runtime configuration.

## Diagnostics And Safe Debug Trace

Any engine or pipeline change must answer: "How will we later see in logs/debug/admin surfaces that the new layer actually worked?"

Require one of:

1. update safe diagnostics/log metadata;
2. explicitly explain why existing diagnostics are enough;
3. create a separate follow-up prompt for diagnostics.

Safe trace examples:

- counts;
- flags;
- source labels;
- fields present/missing;
- truncation status;
- selected mode;
- source counts;
- step names;
- non-sensitive IDs.

Forbidden or default-unsafe diagnostics:

- raw personal data;
- full user documents;
- full prompt dumps;
- secrets;
- credentials;
- unredacted legal/medical/financial personal content;
- anything not needed to debug the specific layer.

## AI-Assisted E2E Testing Loop

Use this loop for AI-assisted end-to-end validation:

1. formulate hypothesis;
2. select fixture;
3. run scenario;
4. collect UI result and logs/debug trace;
5. compare expected vs actual by acceptance criteria, not exact text match;
6. propose the next narrow fix;
7. rerun after deploy or implementation.

The loop must include:

- test fixture;
- scenario;
- expected checks;
- actual result;
- screenshots/logs when safe;
- pass/fail;
- next action.

Candidate tools, without committing to one:

- Playwright;
- browser automation;
- MCP/browser tools;
- GitHub Actions e2e;
- staging environment;
- product-specific admin/debug surfaces.

## Safety Boundaries

- Use synthetic/test data by default.
- Do not use real personal data unless explicitly approved.
- Do not store secrets or raw credentials in fixtures.
- Redact or summarize sensitive logs.
- Avoid raw prompt/model input dumps by default.
- Do not run E2E against production if staging is available.
- If production is the only environment, use safe smoke scenarios and explicit approval.

## Definition Of Done

For complex engine/pipeline changes, done means:

- current engine was audited;
- existing attempts were identified;
- real failure point was mapped;
- prompt-level vs code/data-level gap was assessed;
- diagnostics/log/admin visibility was addressed or explicitly deferred;
- E2E validation need was assessed;
- follow-up prompts were created for diagnostics or E2E if needed;
- Vasily is asked only for strategic/product/legal/business choices, not routine technical approvals.

## Follow-Up Integration

This document should later be referenced from:

- `skills/prompt-writing-standard-universal.md`;
- `skills/research-protocol-universal.md`;
- `skills/bug-hunting-universal.md`;
- `standards/VIBECODER_STANDARDS.md`;
- `skills/BACKLOG.md` as a candidate future `e2e-testing-loop` skill.
