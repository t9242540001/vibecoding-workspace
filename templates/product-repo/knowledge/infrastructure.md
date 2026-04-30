# Infrastructure
<!--
  @file:        knowledge/infrastructure.md
  @project:     <project-name>
  @description: Environments, services, deployment, and environment variables
  @updated:     YYYY-MM-DD
  @version:     0.1
  @lines:       27
-->

## Environments

- Local: `<local setup>`
- Staging: `<staging setup>`
- Production: `<production setup>`

## External Services

- `<service name>`: `<purpose>`

## Deployment

- Target: `<deployment target>`
- Source branch: `<deployment source branch>`
- Pre-deploy check: `<pre-deploy verification command>`
- Command: `<deployment command>`
- Post-deploy check: `<post-deploy verification command>`
- Rollback trigger: `<rollback trigger>`
- Rollback command: `<rollback command>`
- Post-rollback check: `<post-rollback verification command>`

## Environment Variables

- `<VARIABLE_NAME>`: `<purpose>`

Secrets belong in `.env` or the deployment secret store, not in git.
