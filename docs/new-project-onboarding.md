# New Project Onboarding

Use this procedure when connecting a new product repository to the Vibe Coding workflow.

The goal is to make the first connection repeatable: GitHub remains the source of truth, Codex Desktop works from a local clone, and project knowledge is initialized without committing raw notes or secrets.

## 1. GitHub Access Check

Before cloning or editing anything:

1. Confirm the GitHub repository exists.
2. Confirm ChatGPT and the GitHub connector can access the repository.
3. Confirm the repository default branch, usually `main`.
4. Confirm the available permission level:
   - read access is enough for inspection;
   - write access is required for commits and pushes;
   - admin or maintain permissions may be required later for branch protection.

If the connector cannot access the repository, connect or authorize GitHub first, then repeat this check.

## 2. Local Clone For Codex Desktop

Clone the repository with GitHub Desktop.

Prefer a simple local path:

```text
C:\Projects\<repo-name>
```

Avoid OneDrive paths for active development when possible. Sync folders can create file locks, delayed updates, and confusing Git state.

## 3. Open In Codex Desktop

In Codex Desktop:

1. Select `File -> Open Folder...`.
2. Choose the local repository folder.
3. Run:

```powershell
git --version
git status --short
```

Confirm Git is available and the repository status is understood before making changes.

## 4. Local `_inbox/` And `_local/` Workflow

Use `_inbox/` only as a local temporary input buffer.

Allowed use:

- create `_inbox/` locally;
- place source documents, exported notes, screenshots, or temporary handoff files there;
- read from `_inbox/` while converting facts into structured project knowledge.

Use `_local/` for local-only project materials that should not be committed to GitHub.

Recommended `_local/` subfolders:

- `_local/inbox/`;
- `_local/research/`;
- `_local/exports/`;
- `_local/screenshots/`;
- `_local/drafts/`.

Required safeguards:

- `_inbox/` must be ignored by Git;
- `_local/` must be ignored by Git;
- Codex must not inspect `_local/` unless explicitly instructed;
- never commit raw source notes if they contain operational details or sensitive values;
- never commit secrets, tokens, real passwords, private keys, `.env` files, or credentials.

If `_inbox/` is accidentally tracked, run:

```powershell
git rm --cached -r _inbox
```

Then confirm it is ignored before continuing.

## 5. Initial Inventory

Do an inventory pass before modifying code.

Inspect:

- `README.md`;
- application structure;
- environment examples such as `.env.example`;
- dependency files;
- GitHub workflows;
- key entrypoints;
- deployment or infrastructure notes if they already exist.

Do not modify code during the inventory pass. Record durable findings in project knowledge during the knowledge initialization step.

## 6. Knowledge Initialization

Use `templates/product-repo/` from this workspace as the structure reference.

### Audit-First Rule

If the target product repository already has any of these:

- `CLAUDE.md`;
- `AGENTS.md`;
- `knowledge/`;
- `.codex/`;
- docs with project rules.

Then do not initialize or overwrite knowledge immediately.

Instead:

1. Run inventory/audit only.
2. List existing files.
3. Compare existing structure with `templates/product-repo/`.
4. Identify gaps.
5. Propose a migration plan.
6. Only after approval or explicit task scope, perform targeted changes.

Never rely only on GitHub search to decide whether files exist. Check paths directly through the local filesystem or Git.

Existing knowledge must be preserved unless migration is explicitly approved.

If existing docs contain secrets, sanitize only the sensitive values while preserving useful knowledge.

Create or update these product repository files:

- `AGENTS.md`;
- `CLAUDE.md` or equivalent main project context file;
- `knowledge/`;
- `knowledge/INDEX.md`;
- `knowledge/infrastructure.md`;
- `knowledge/architecture.md`;
- `knowledge/rules.md`;
- `knowledge/decisions.md`;
- `knowledge/roadmap.md`;
- `.codex/instructions.md`.

Convert source documents into structured knowledge. Do not copy raw source notes directly into the repository.

Mark unverified facts as `needs verification`.

Do not commit secrets, tokens, real passwords, private keys, `.env` files, credentials, or raw source notes.

## 7. First Task Cycle

Run one small safe task after the repository is connected and knowledge files are initialized.

The first task should:

- have narrow scope;
- avoid production changes;
- avoid dependency swaps unless explicitly required;
- include a clear verification command when possible.

Codex commits and pushes only when changed files match the approved task scope.

After the push, ChatGPT verifies the GitHub result: branch, commit, pull request state if applicable, and any visible checks.

## 8. After A Successful Cycle

After the first safe cycle works:

1. Decide whether the product should use direct commits, feature branches, or pull requests.
2. Decide branch protection rules and required checks.
3. Document the deploy and rollback process for that product before production work.
4. Keep product-specific decisions in the product repository, not in this shared workspace.

The product is ready for normal work only after GitHub access, local Codex Desktop workflow, project knowledge, and the first verified task cycle are all working.
