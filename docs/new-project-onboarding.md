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

## 6.5. Skill Sync Setup

Connect the new project to the shared skill library in this workspace. Without this step Claude Code in the new project will not see the custom skills (`prompt-writing-standard`, `bug-hunting`, `code-markup-standard`, `knowledge-structure`, `research-protocol`, `skill-writing-standard`) and will work without the standards they enforce.

### Why this step exists

Claude Code on the web does not register skills from disk as slash-commands (Anthropic issues #47929, #50669, #48696). The workaround: a SessionStart hook copies the skills repo into the project's `.claude/skills/` folder on every session start, and `CLAUDE.md` instructs Claude Code to read the relevant `SKILL.md` by path when a task matches a skill's trigger.

The canonical sync script lives in this workspace at `scripts/sync-skills.sh`. New projects copy it verbatim into their own `.claude/hooks/`. When the canonical version changes, projects pick up the update on the next routine sync — no per-project script edits.

### Files added to the product repository

Three files plus two `.gitignore` rules. Adapt only paths and project-specific text in `CLAUDE.md`; the script and the settings hook are copied as-is.

1. `.claude/hooks/sync-skills.sh` — copy of `scripts/sync-skills.sh` from this workspace. Make it executable (`chmod +x`).

2. `.claude/settings.json` — SessionStart hook wiring. If the file already exists with other settings, merge rather than overwrite:

   ```json
   {
     "hooks": {
       "SessionStart": [
         {
           "matcher": "startup|resume",
           "hooks": [
             {
               "type": "command",
               "command": "\"$CLAUDE_PROJECT_DIR\"/.claude/hooks/sync-skills.sh"
             }
           ]
         }
       ]
     }
   }
   ```

3. A `## Custom Skills` block appended to `CLAUDE.md`. This block tells Claude Code which skills exist and when to read each one. The trigger phrasing must match the `description` field of each skill in `skills/<name>/SKILL.md` — keep the wording aligned when skills evolve.

   ```markdown
   ## Custom Skills

   Custom skills are synced to $CLAUDE_PROJECT_DIR/.claude/skills/ at session start
   via SessionStart hook (source: vibecoding-workspace/skills/).

   Available skills and their triggers:

   - prompt-writing-standard — MANDATORY before writing any Claude Code prompt.
     Read: .claude/skills/prompt-writing-standard/SKILL.md

   - bug-hunting — when a bug fix has failed twice with the same approach, or
     when the same bug keeps coming back.
     Read: .claude/skills/bug-hunting/SKILL.md

   - code-markup-standard — MANDATORY when creating or modifying any code file
     or knowledge file (file headers, RULE comments, region tags).
     Read: .claude/skills/code-markup-standard/SKILL.md

   - knowledge-structure — MANDATORY when creating, restructuring, or
     non-trivially editing any knowledge/*.md file.
     Read: .claude/skills/knowledge-structure/SKILL.md

   - research-protocol — for T3 strategic decisions (architecture, stack choice,
     long-term consequences).
     Read: .claude/skills/research-protocol/SKILL.md

   - skill-writing-standard — when creating or modifying any skill in
     vibecoding-workspace/skills/.
     Read: .claude/skills/skill-writing-standard/SKILL.md

   When a task matches a skill's trigger, Read the relevant SKILL.md FIRST and
   follow the protocol described inside. These are not optional guidelines —
   they are mandatory protocols for their declared triggers.
   ```

### `.gitignore` rules

Add to the product repository's `.gitignore`:

```text
.claude/skills/
.claude/settings.local.json
```

`hooks/` and `settings.json` ARE committed (they define how the project syncs skills — part of the project's contract). `skills/` is NOT committed (it is rebuilt on every session from the canonical source). `settings.local.json` is per-developer state and must never be committed.

If `.gitignore` already blocks `.claude/` wholesale, rewrite the rule to whitelist `hooks/` and `settings.json` while keeping `skills/` and `settings.local.json` blocked. The JCK-AUTO repository is the reference for this pattern.

### Verification

After committing the three files and the `.gitignore` change:

1. Open a fresh Claude Code session in the new project.
2. The session start banner should include a line from the hook: `sync-skills: N skill(s) synced to ...`.
3. Ask Claude Code: "Read CLAUDE.md and confirm you see the Custom Skills section. Then read `.claude/skills/prompt-writing-standard/SKILL.md` and summarize section 2 in one paragraph."

If both succeed, the sync is working. If the hook does not fire, check `.claude/settings.json` syntax and that `sync-skills.sh` has execute permissions.

### When skills evolve in the workspace

No per-project action needed. The next time any session starts in the project, the hook pulls the latest `vibecoding-workspace/skills/` and rebuilds `.claude/skills/`. The `CLAUDE.md` block only needs updating if a skill is added, removed, or its description changes substantially.

## 6.6. Codex Runner Setup

Set up a repo-scoped Codex runner before the first long-running batch or autonomous Codex task.

Reference policy:

- `docs/codex-autonomous-runner-policy.md`
- `docs/codex-runner-operator-guide.md`
- `docs/codex-isolated-runner-setup.md`

Each product repository should define:

- a project command router, such as `<project> status`, `<project> pull`, `<project> batch <batch_id>`, and `<project> checkpoint <batch_id> "<commit message>"`;
- a hardened Codex runner launcher that runs inside the repo-scoped workspace;
- a batch auto-checkpoint launcher;
- a trusted checkpoint wrapper that validates changed files, blocks high-risk paths, rejects deletes by default, commits, and pushes through the normal branch policy.

The runner may use:

```text
codex --sandbox workspace-write --ask-for-approval never
```

only when the external runner boundary limits access to the target repository and required tooling.

Do not use broad host-level approval bypass on the main Windows desktop environment.

The product `AGENTS.md` should include the Autonomous Runner Rule from `templates/product-repo/AGENTS.md`.

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
