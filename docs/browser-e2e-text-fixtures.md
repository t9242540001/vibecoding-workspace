# Browser E2E Text Fixtures

## Purpose

This layer validates model-based Browser/E2E text analysis before real staging access or browser automation is connected.

## What This Is

- synthetic browser output;
- acceptance criteria;
- model-generated strict JSON report;
- safe fixture smoke before real staging.

## What This Is Not

- not real Browser/E2E automation yet;
- not real staging access yet;
- not screenshot/image/video analysis;
- not approval to use personal or production data.

## Current Fixtures

- `basic-success`
- `missing-cta`

## Current Workflow

- `.github/workflows/e2e-text-fixture-smoke.yml`
- manual only
- default model `qwen/qwen-plus`
- optional models:
  - `deepseek/deepseek-v4-flash`
  - `deepseek/deepseek-v4-pro`
  - `gemini/gemini-2.5-flash`

## Current Results

- `qwen/qwen-plus` passed both current synthetic fixtures:
  - `basic-success`: expected `passed: true`, model returned `passed: true`, score `1.0`;
  - `missing-cta`: expected `passed: false`, model returned `passed: false`, score `0.6`.

## Batch Matrix Workflow

- `.github/workflows/e2e-text-fixture-matrix.yml`
- manual only
- runs all current fixtures against the `e2e-text-fixtures` model package
- intended to compare Qwen, DeepSeek, and Gemini without one-by-one manual runs
- does not access real staging or run browser automation

## Report Contract

- `passed`
- `score`
- `summary`
- `matched_criteria`
- `missing_criteria`
- `issues`
- `recommendation`

## Safety Boundaries

- synthetic fixtures only by default;
- no real staging URLs;
- no secrets/cookies/tokens;
- no personal data;
- real staging text summaries must be sanitized.

## Next Steps

1. Run fixture smoke for `basic-success`. Done with `qwen/qwen-plus`.
2. Run fixture smoke for `missing-cta`. Done with `qwen/qwen-plus`.
3. Run E2E text fixture matrix across Qwen, DeepSeek, and Gemini.
4. Compare Qwen, DeepSeek, and Gemini outputs.
5. Add real staging text-summary fixture only after sanitization rules exist.
6. Add browser automation later.
7. Add screenshot/image/video fixtures only after media fixture rules exist.
