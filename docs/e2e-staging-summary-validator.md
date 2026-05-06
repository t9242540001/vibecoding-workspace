# E2E Staging Summary Validator

## Purpose

The validator checks sanitized staging summary JSON before any model analysis or real staging integration.

## What It Validates

- summary JSON is valid;
- required fields exist;
- required field types are correct;
- acceptance criteria are present;
- visible text is present;
- sanitization notes are present;
- forbidden/suspicious patterns are scanned.

## What It Blocks

- real URLs by default;
- cookies;
- auth headers;
- bearer tokens;
- API keys;
- passwords;
- session dumps;
- `.env`;
- local paths;
- private IPs/endpoints;
- personal emails;
- JWT-like tokens.

## Current Example

- `examples/e2e/sanitized-staging-summary-example.json`

## Current Workflow

- `.github/workflows/e2e-staging-summary-validator.yml`
- manual only
- no model calls
- no staging access
- no browser automation

## Next Steps

1. Run validator on the example.
2. Add staging-summary analysis workflow after validator passes.
3. Connect real browser automation only after staging access and sanitization rules are approved.
