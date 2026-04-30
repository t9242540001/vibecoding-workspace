# Knowledge Repair Prompt

## CONTEXT

Project: `<project-name>`
Repository: `<owner>/<repo>`
Branch: `<branch>`

A previous knowledge migration may have compressed, overwritten, or removed useful project knowledge.

Allowed files:

- `<explicitly allowed knowledge file paths>`

## TASK

Repair the knowledge migration while preserving useful current facts.

Use Git history to compare the previous version and current version of the allowed knowledge files.

For each allowed file:

1. Identify knowledge that was removed, compressed, or moved incorrectly.
2. Restore lost useful knowledge into the proper knowledge file.
3. Keep useful current facts that were added after the bad migration.
4. Do not restore secrets, tokens, real passwords, private keys, `.env` values, credentials, or raw sensitive source notes.
5. Mark unverified facts as `needs verification`.
6. Update `knowledge/INDEX.md` when restored or reorganized knowledge changes the registry or section coverage.

Before committing, scan the changed files for sensitive values.

## REGRESSION SHIELD

- Modify only the explicitly allowed knowledge files.
- Do not modify code unless separately requested.
- Do not modify unrelated docs.
- Do not restore secrets or raw sensitive notes from history.
- Do not rewrite unrelated sections for style.
- Do not remove useful current facts.
- Do not stage, commit, or push unless the final changed files match the approved scope.

## ACCEPTANCE CRITERIA

- Previous and current versions were compared using Git history.
- Lost useful knowledge was restored to the proper knowledge files.
- Useful current facts were preserved.
- Unverified restored facts are marked `needs verification`.
- `knowledge/INDEX.md` is updated if needed.
- Changed files were scanned for sensitive values before commit.
- Only explicitly allowed knowledge files were modified.
- Final `git status --short` is reported.
