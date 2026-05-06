# E2E Staging Summary Analysis

## Purpose

This workflow analyzes validated sanitized staging summaries with approved text models.

## Current Status

- manual workflow added;
- works on repository JSON summaries;
- uses Qwen or DeepSeek;
- fake sanitized summary analysis passed with `qwen/qwen-plus`;
- fake sanitized summary analysis passed with `deepseek/deepseek-v4-flash`;
- not connected to real staging;
- no browser automation.

## Input

- summary path;
- contract path;
- model id;
- strict forbidden scan.

## Validation Before Model Call

- required fields are checked;
- field types are checked;
- visible text must be present;
- acceptance criteria must be present;
- sanitization notes must be present;
- forbidden patterns are scanned;
- the model call is skipped if validation fails.

## Model Policy

Allowed models:

- `qwen/qwen-plus`
- `deepseek/deepseek-v4-flash`
- `deepseek/deepseek-v4-pro`

Gemini remains experimental and is not allowed in this first analysis workflow.

## Output

- `validation-report.json`
- `request.json`
- `raw-response.json`
- `parsed-report.json`
- `summary.md`

## Safety Boundaries

- no real staging access;
- no browser automation;
- no screenshots/raw HAR;
- no cookies/tokens/secrets;
- no `_local/`;
- no `.codex/config.toml`.

## Next Steps

1. Run analysis on fake sanitized summary with Qwen. Done.
2. Run analysis on fake sanitized summary with DeepSeek. Done.
3. Add browser automation handoff contract. Done.
4. Create synthetic browser runner summary generator.
