# Prompt 03 — Update universal standards

## CONTEXT
Project: vibecoding-workspace
Repository: github.com/t9242540001/vibecoding-workspace
Affected files:
- standards/VIBECODER_STANDARDS.md

Current state:
The universal standards still describe the Code Agent workflow as Code Agent → Git → Vasily deploy, while the intended universal model for all current and future projects is Code Agent → agent branch → CI/build/test gates → auto-merge → main → GitHub Actions deploy → health/E2E checks → report. The standards also describe knowledge as a flat knowledge/*.md set; the knowledge-structure skill is being updated to support a scalable folder + ADR structure.

## TASK
Update only the relevant parts of standards/VIBECODER_STANDARDS.md so the universal operating model matches the new approved direction:

1. Git/deploy model for all projects:
   Vasily → AI model / orchestrator → Code Agent → agent branch → CI/build/test gates → auto-merge → main → GitHub Actions deploy → health/E2E checks → report.
2. Code Agent still works only through the repository. It does not receive unrestricted SSH/root/server access. Deploy happens through pre-approved CI/CD workflows and secrets.
3. Large tasks are split into small sequential prompts to preserve quality, verification, rollback points, and context stability. In Autonomous Batch Mode, no confirmation is required between prompts after the batch plan is approved.
4. Safe error policy:
   - safe error inside current scope → fix within current step;
   - critical error / stop condition → stop, record reason, report for operational fix;
   - all checks pass → push agent branch and let CI/CD continue.
5. Knowledge structure summary should point to the updated knowledge-structure skill: small projects may use flat knowledge/*.md; larger projects may use thematic folders, router/sub-indexes, runbooks, and ADR files.
6. Do not weaken the Regression Shield, prompt-writing-standard, Prompt Readiness Gate, or content preservation rules.

## REGRESSION SHIELD — DO NOT TOUCH
Files not to modify:
- skills/**
- standards/batch-execution-standard.md
- templates/**
- docs/**
- README.md

Within standards/VIBECODER_STANDARDS.md:
- Only edit sections directly related to Code Agent workflow, Git/deploy, large task execution, and project knowledge structure.
- Do not edit unrelated SEO, UX, security, external services, virtual team roster, caching, or diagnostic content.
- Do not simplify, rephrase, or reorganize unrelated paragraphs.
- Do not remove existing critical safety principles.

Critical rules for this project:
- RULE: This standard applies to all current and future projects, so wording must be universal and not YurAssistent-specific.
- RULE: Autonomous mode increases speed only inside a safe corridor; it must not imply unrestricted server access.
- RULE: Quality gates remain mandatory; automation removes waiting, not verification.

## ACCEPTANCE CRITERIA
[ ] Universal architecture reflects agent branch → CI/build/test gates → auto-merge → main → GitHub Actions deploy → health/E2E checks → report.
[ ] Standards state deploy is through pre-approved CI/CD, not unrestricted Code Agent server access.
[ ] Large task wording supports Autonomous Batch Mode without per-prompt confirmation after batch approval.
[ ] Safe error policy is documented.
[ ] Knowledge section points to flat structure for small projects and folder/ADR/runbook structure for larger projects.
[ ] Regression Shield, prompt-writing-standard, Prompt Readiness Gate, and content preservation rules remain in force.
[ ] No unrelated sections were edited.
[ ] Modified file header/version updated if project convention requires it.
[ ] Code Agent reports changed sections and confirms scope was respected.
