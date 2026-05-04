# Agent Runner Model Providers

## Purpose

This document defines which model providers the GitHub/cloud agent runner may use.

Cheap providers are needed for smoke tests and runner validation because repeated workflow runs should not depend on high-cost reference models when the goal is only to verify runner mechanics.

Provider choice affects cost, quality, compatibility, security, quota behavior, and what kinds of tasks can be safely delegated.

## Decision

- OpenAI API billing and quota are separate from a ChatGPT subscription, so OpenAI API calls may fail if API billing or quota is not configured.
- OpenAI remains the high-quality/reference provider.
- DeepSeek direct API is the first cheap provider to test for text/code runner smoke tests.
- Alibaba/Qwen is the second provider to connect, with separate treatment for text/code and future multimodal/browser/E2E support.
- Provider changes must be explicit and documented; do not silently swap models.

## Provider Order

1. OpenAI - reference/high-quality provider when API billing is available.
2. DeepSeek - first low-cost smoke-test provider.
3. Qwen / Alibaba Model Studio - second provider, especially valuable for broader model families and future multimodal tests.
4. Other routers/providers - later only after direct providers are understood.

## DeepSeek

Use direct DeepSeek API first, not a router.

- GitHub Secret: `DEEPSEEK_API_KEY`.
- Base URL: `https://api.deepseek.com`.
- Initial model candidates:
  - `deepseek-v4-flash` for cheap smoke tests;
  - `deepseek-v4-pro` for stronger checks if needed.
- Use for:
  - docs-only runner smoke tests;
  - low-risk text/code validation;
  - provider compatibility testing.
- Do not assume parity with GPT-5.5 for complex product decisions.

## Qwen / Alibaba Model Studio

- GitHub Secret: `DASHSCOPE_API_KEY`.
- OpenAI-compatible base URLs by region:
  - Singapore / international: `https://dashscope-intl.aliyuncs.com/compatible-mode/v1`
  - US Virginia: `https://dashscope-us.aliyuncs.com/compatible-mode/v1`
  - Beijing: `https://dashscope.aliyuncs.com/compatible-mode/v1`
- Region, account edition, endpoint, available models, and pricing must be checked before workflow use.
- Qwen should be connected after DeepSeek.
- Qwen is important not only for text, but also for code, vision/multimodal, audio/video/omni, math, and other specialized workflows where available.
- Use Qwen text/code first; multimodal/E2E usage requires separate safety and fixture design.

## Security Rules

- Provider API keys must live only in GitHub Secrets or environment-scoped secrets.
- Never commit provider keys, `.env` values, account IDs, billing details, private endpoints, staging URLs, or local paths.
- Do not print provider keys or raw secret values in logs.
- Do not include raw personal data in prompts, fixtures, model outputs, artifacts, or screenshots by default.
- Use separate low-limit keys/budgets for runner experiments where possible.
- Rotate keys if a workflow, artifact, log, or prompt accidentally exposes sensitive material.

## Cost Rules

- Cheap provider smoke tests are for runner mechanics, not final product-quality validation.
- Prefer the cheapest adequate model for repeatable smoke tests.
- Use stronger/more expensive models only when the acceptance criteria require it.
- Keep prompt and artifact sizes small.
- Track failures by provider: quota, auth, model not found, context limits, tool compatibility, output quality.

## Compatibility Rules

- OpenAI-compatible endpoint does not guarantee identical behavior.
- Before using a provider in a production-like runner, validate:
  - auth works;
  - model name works;
  - output can be parsed;
  - tool/action behavior is compatible;
  - retry/failure behavior is understood;
  - token/context limits are acceptable;
  - safety boundaries still hold.
- A provider smoke test must not update `main` directly.

## Runner Integration Plan

1. Document provider policy.
2. Add DeepSeek smoke workflow or provider profile.
3. Run docs-only smoke PR using DeepSeek.
4. Add Qwen text/code smoke workflow or provider profile.
5. Add E2E staging smoke provider selection.
6. Add multimodal/Qwen workflows only after synthetic fixtures and artifact safety rules are ready.

## Open Decisions

- whether to modify `openai/codex-action` configuration directly or use direct provider-specific smoke scripts first;
- exact DeepSeek model for first smoke run;
- Qwen region/account endpoint to use first;
- Qwen first text model and first multimodal model;
- whether provider selection should be workflow input or separate workflows;
- budget limits per provider;
- artifact and prompt retention rules for provider comparisons.
