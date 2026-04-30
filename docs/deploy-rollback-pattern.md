# Deploy And Rollback Pattern

This document records the workspace-level placeholder pattern for future product repositories. It does not define a real server, domain, credential, or deployment target.

## Deploy

- Source of truth: GitHub repository.
- Deployment source: `main` branch, unless a product repository explicitly documents another safe policy.
- Pre-deploy checks: `<verification command placeholders>`
- Deploy command: `<deploy command placeholder>`
- Post-deploy check: `<health check placeholder>`

## Rollback

- Rollback trigger: `<rollback trigger placeholder>`
- Rollback target: `<previous known-good version placeholder>`
- Rollback command: `<rollback command placeholder>`
- Post-rollback check: `<health check placeholder>`

## Product Repository Rule

Each product repository should document its real deploy and rollback commands in `knowledge/infrastructure.md` before production use.
