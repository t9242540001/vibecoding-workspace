# Branch Protection Plan

## Purpose

Protect `main` after bootstrap so accidental direct pushes are less likely.

The target workflow is for Codex and other Code Agent work to use branches and pull requests instead of direct pushes to `main`.

## When To Enable

Enable branch protection only after:

- the first successful product-repository task cycle is complete;
- knowledge migration is stable;
- at least one verification or check path exists.

Until then, the workspace remains in bootstrap mode.

## Recommended GitHub Settings

For `main`:

- require a pull request before merge;
- require status checks when checks exist;
- disallow force pushes;
- disallow deletions;
- require conversation resolution if PR reviews are used;
- keep the admin bypass decision explicit;
- do not require code owner reviews until `CODEOWNERS` exists.

## Branch Naming

- Workspace tasks: `workspace/<short-task>`
- Product tasks: `product/<repo>/<short-task>`
- Repair tasks: `repair/<short-task>`
- Agent tasks: `agent/<short-task>` or `codex/<short-task>`

## PR Workflow

- One task = one branch = one PR.
- PR body must include scope, verification, changed files, and risks.
- Merge only after checks and review pass, or after explicit human approval.

## Rollback

Prefer a revert commit over force push.

Production rollback rules live in the product repository `knowledge/infrastructure.md`.
