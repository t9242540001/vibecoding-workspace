# Synthetic Browser Summary Generator

## Purpose

This workflow rehearses browser-runner handoff without real browser automation or staging access.

## Current Status

- synthetic only;
- no real browser;
- no real staging;
- no credentials;
- generates sanitized summary JSON;
- validates generated summary;
- validates generated summary before model analysis;
- can optionally analyze with Qwen/DeepSeek;
- required synthetic generator run set passed.

## Inputs

- observation id;
- model id;
- run analysis;
- strict forbidden scan.

## Synthetic Observations

- `configs/synthetic-browser-observations.json`
- `landing-success`
- `landing-missing-cta`

## Generated Summary

The generated summary must match `configs/e2e-staging-summary-contract.json`.

## Handoff Chain

1. Synthetic browser observation.
2. Sanitized summary generation.
3. Validator logic.
4. Optional Qwen/DeepSeek analysis.
5. Artifact review.

## Current Results

- `qwen/qwen-plus` passed both required observations with expected outcomes:
  - `landing-success`: expected `passed: true`, model returned `passed: true`;
  - `landing-missing-cta`: expected `passed: false`, model returned `passed: false`.
- `deepseek/deepseek-v4-flash` passed both required observations with expected outcomes:
  - `landing-success`: expected `passed: true`, model returned `passed: true`;
  - `landing-missing-cta`: expected `passed: false`, model returned `passed: false`.
- Validation passed before model analysis.

## Safety Boundaries

- no real staging URL;
- no browser automation;
- no cookies/tokens/headers;
- no screenshots/videos/traces/raw HAR;
- no personal/client/payment data;
- no `_local/`;
- no `.codex/config.toml`.

## Next Steps

1. Run `landing-success` with Qwen. Done.
2. Run `landing-missing-cta` with Qwen. Done.
3. Run both with DeepSeek. Done.
4. Record results. Done.
5. Design-only planning for a real staging browser workflow.
