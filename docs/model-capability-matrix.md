# Model Capability Matrix

## Purpose

This matrix helps choose the right provider/model for agent runner tasks based on cost, quality, speed, context, modality, compatibility, and current smoke status.

It is a working matrix for runner decisions, not a complete model catalog.

## Selection Principle

- Use the cheapest adequate model for repeatable smoke tests.
- Use stronger models only when acceptance criteria require quality or reasoning.
- Do not treat all OpenAI-compatible APIs as behaviorally identical.
- Do not use untested models in production-like workflows.
- Keep model choice explicit in workflow inputs or documented runner profiles.

## Current Provider Status

| Provider | Secret | Region / Base URL | Smoke status | Notes |
|---|---|---|---|---|
| OpenAI | `OPENAI_API_KEY` | OpenAI Platform API | Blocked by API quota/billing in current runner test | Reference/high-quality provider; billing separate from ChatGPT subscription. |
| DeepSeek | `DEEPSEEK_API_KEY` | `https://api.deepseek.com` | Passed | First cheap smoke provider; `deepseek-v4-flash` passed with thinking disabled and docs-only PR runner passed end-to-end. |
| Qwen / Alibaba Model Studio | `DASHSCOPE_API_KEY` | Singapore / international: `https://dashscope-intl.aliyuncs.com/compatible-mode/v1` | Passed | `qwen-plus` passed; many model families exist and some may require activation. |
| Gemini | `GEMINI_API_KEY` | Google Gemini API | Text smoke passed for selected models | Free/low-cost fallback candidate; `gemini-2.5-flash` and `gemini-2.5-flash-lite` passed `core-text`; media use still requires synthetic fixtures. |

## Initial Model Matrix

| Provider | Model | Status | Best initial use | Avoid / not yet for | Notes |
|---|---|---|---|---|---|
| OpenAI | GPT-5.5 or current reference model | Reference, API quota not yet available | final review, high-risk reasoning, reference comparisons | cheap smoke loops until API billing is configured | ChatGPT subscription does not provide API quota. |
| DeepSeek | `deepseek-v4-flash` | Smoke and docs-only PR runner passed | cheap provider smoke, docs-only runner tests, low-risk text/code checks | final strategic/product decisions without review | Use non-thinking mode for deterministic smoke and docs runner loops. |
| DeepSeek | `deepseek-v4-pro` | Core-text smoke passed | harder text/code checks, stronger reasoning experiments | default cheap smoke until code fixtures are measured | Validate on real code fixtures before default use. |
| Qwen | `qwen-plus` | Smoke passed | text/code smoke, general docs/text tasks, comparison against DeepSeek | multimodal tasks without separate fixtures | Singapore / international endpoint is the current working default. |
| Qwen | Qwen Coder family | Candidate, activation/model choice pending | future code-focused runner checks | immediate default runner before smoke test | Needs exact model name and activation check. |
| Qwen | Qwen VL / vision family | Candidate, activation/model choice pending | future image/document/UI artifact interpretation | use with real personal data or unreviewed screenshots | Needs synthetic fixtures and artifact rules. |
| Qwen | Qwen Omni / audio-video family | Future candidate | future audio/video workflows if needed | current docs/code runner | Defer until product need exists. |
| Qwen | Qwen Math / specialized families | Future candidate | specialized evals if product needs them | general runner default | Activate/test only when needed. |
| Gemini | `gemini-2.5-flash` | Core-text smoke passed; media fixtures still required | small text, e2e-text, image/audio/video/document experiments | image/audio/video/product workflows before modality fixtures | Text smoke passed; media use still requires synthetic fixtures. |
| Gemini | `gemini-2.5-flash-lite` | Core-text smoke passed | cheapest small tasks and repeatable smoke experiments | stronger reasoning or high-risk review | Free-tier limits must be checked before routine use. |
| Gemini | `gemini-2.5-pro` | Candidate, not yet smoke-tested in workspace | stronger/reference experiments when free/tier limits allow | cheap smoke default | Use only after provider/model smoke. |
| Gemini | Gemini image candidate | Future candidate | future image generation experiments | current docs/code runner or use without policy | Requires synthetic fixtures and separate workflow rules. |
| Gemini | Gemini audio candidate | Future candidate | future audio understanding workflows | use with real personal data or unreviewed recordings | Requires synthetic fixtures and separate workflow rules. |
| Gemini | Gemini video candidate | Future candidate | future video understanding workflows | use with real personal data or unreviewed recordings | Requires synthetic fixtures and separate workflow rules. |

## Task-To-Model Defaults

| Task type | Default model now | Backup / comparison | Reason |
|---|---|---|---|
| Provider connectivity smoke | DeepSeek `deepseek-v4-flash` and Qwen `qwen-plus` | none | Both already passed provider smoke. |
| Docs-only runner smoke | DeepSeek `deepseek-v4-flash` | Qwen `qwen-plus` | cheap, fast, already connected, and passed end-to-end PR loop. |
| Low-risk text/code validation | DeepSeek `deepseek-v4-flash` | Qwen `qwen-plus` | enough for runner mechanics. |
| Harder code/reasoning experiment | DeepSeek `deepseek-v4-pro` after code fixtures | OpenAI reference when API quota exists | core-text smoke passed, but real code fixtures are still required before default use. |
| Browser/E2E staging text analysis | Qwen `qwen-plus` or DeepSeek `deepseek-v4-flash` / `deepseek-v4-pro` after fixture matrix | Gemini `gemini-2.5-flash` experimental | required synthetic fixture matrix passed for Qwen and DeepSeek; next step is sanitized staging summary validation before real staging. |
| Image/document/multimodal checks | Gemini `gemini-2.5-flash` after media fixture smoke | Qwen VL family after activation and fixture design | Gemini text smoke passed, but media fixture smoke is still required. |
| Audio understanding | Gemini `gemini-2.5-flash` after audio fixture smoke | Qwen audio family after activation | Gemini text smoke passed, but audio fixture smoke is still required. |
| Video understanding | Gemini `gemini-2.5-flash` after video fixture smoke | Qwen video family after activation | Gemini text smoke passed, but video fixture smoke is still required. |
| Image generation | Gemini image candidate after policy and fixture design | Qwen image generation candidate after activation | generation workflows need separate safety rules. |
| Final high-risk product decision | OpenAI reference or human/orchestrator review | DeepSeek/Qwen as comparison only | quality and accountability matter more than token cost. |

## Required Smoke Before Use

- Every new model must pass provider/model smoke before use in a runner.
- Smoke must verify auth, endpoint, model name, response parser, usage metadata if available, and artifact behavior.
- For multimodal models, smoke must use synthetic fixtures only.
- Media models must pass fixture-based smoke for their modality before use in product or staging workflows.
- Text smoke success for a multimodal model does not approve image, audio, or video use.
- Browser/E2E text analysis must pass synthetic fixture smoke before real staging summaries are analyzed.
- Real Browser/E2E staging summaries must satisfy the sanitized staging summary contract before model analysis.
- Smoke success does not mean the model is approved for high-risk decisions.

## Model Comparison Rules

- Compare models on task acceptance criteria, not vibes.
- Track at least: pass/fail, cost, latency, output parseability, context limits, tool compatibility, and artifact safety.
- Prefer small deterministic test prompts first.
- Do not expand model matrix faster than tests can validate.

## Near-Term Next Steps

1. Add this matrix to workspace navigation. Done.
2. Build docs-only PR runner using selected low-cost provider. Done with DeepSeek `deepseek-v4-flash`.
3. Create universal model profiles config. Done.
4. Add provider model smoke matrix workflow. Done.
5. Run `core-text` smoke package. Done.
6. Select exact Qwen Coder model available in Singapore / international region.
7. Design Browser/E2E staging text-analysis fixture. Done.
8. Run Browser/E2E text fixture smoke for `basic-success` and `missing-cta`. Done with Qwen `qwen-plus`.
9. Run E2E text fixture matrix across Qwen, DeepSeek, and Gemini. Done with required models passed and Gemini experimental failed.
10. Rerun E2E text fixture matrix with `failure_policy: required-only`. Done.
11. Add sanitized staging summary contract. Done.
12. Create sanitized staging summary example using fake data. Done.
13. Add validator workflow. Done.
14. Add manual staging-summary analysis workflow. Done.
15. Run staging-summary analysis on fake sanitized summary with Qwen and DeepSeek. Done.
16. Add browser automation handoff contract. Done.
17. Create synthetic browser runner summary generator.
18. Connect real browser automation only after staging access and sanitization rules are approved.
19. Design synthetic fixtures for image, audio, video, and multimodal document workflows.
20. Add media smoke workflows only after fixture rules are ready.
