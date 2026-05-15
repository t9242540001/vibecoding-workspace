# Prompt 02 — Update knowledge structure

## CONTEXT
Project: vibecoding-workspace
Repository: github.com/t9242540001/vibecoding-workspace
Affected files:
- skills/knowledge-structure-universal.md

Current state:
skills/knowledge-structure-universal.md defines the living knowledge base as CLAUDE.md or equivalent → knowledge/INDEX.md → knowledge/*.md. It already contains strong Content Preservation rules in Section 9 and cross-linking rules in Section 11.5. The new operating model needs this skill to explicitly support a scalable wiki-like folder structure and separate ADR files for decisions, without weakening any rules about content preservation, anti-duplication, stale information, lifecycle, or INDEX integrity.

## TASK
Update skills/knowledge-structure-universal.md to describe the new scalable knowledge structure:

1. The flat knowledge/*.md structure remains valid for small projects.
2. Larger projects may use thematic folders under knowledge/, for example:
   - knowledge/rules/README.md, secrets.md, deploy.md, pii.md, prompts.md
   - knowledge/architecture/README.md, backend.md, frontend.md, prompt-pipeline.md, database.md
   - knowledge/infrastructure/README.md, deploy.md, rollback.md, github-actions.md, server-runtime.md
   - knowledge/decisions/README.md plus ADR-YYYY-MM-DD-short-title.md files
   - knowledge/runbooks/deploy.md, rollback.md, failed-automerge.md, failed-deploy.md, failed-health-check.md
3. decisions.md remains valid for small projects, but for larger projects the preferred structure is knowledge/decisions/ with one ADR per stable decision.
4. ADR file format must include: Status, Confidence, Scope, Context, Decision, Consequences, Rollback / Revisit Trigger, Links.
5. knowledge/INDEX.md becomes either a flat registry for small projects or a router to sub-indexes / folder README files for larger projects.
6. Cross-links continue to use markdown link syntax, not Obsidian-only wikilinks. The phrase "wiki-like" must mean navigable folder structure + markdown links + ADR files, not switching to unsupported [[wikilink]] syntax.
7. Preserve Section 9 Content Preservation Rule exactly in meaning and force. Do not weaken it. Do not rewrite it.

The update must be surgical: add or extend only the sections required to describe the new structure, preferably Section 5 Standard File Set, Section 6 File Format Standard, Section 7 decisions format / ADR equivalent, Section 11.5 Cross-Linking System, Section 13 INDEX Integrity Check, Section 14 reading sequence, and Section 15 creation procedure if needed.

## REGRESSION SHIELD — DO NOT TOUCH
Files not to modify:
- skills/prompt-writing-standard-universal.md
- standards/VIBECODER_STANDARDS.md
- standards/batch-execution-standard.md
- templates/**
- docs/**
- README.md

Within skills/knowledge-structure-universal.md:
- Do not edit Section 9 Content Preservation Rule except if absolutely required to add a pointer sentence outside the existing rule body. Prefer no edits to Section 9.
- Do not weaken Anti-Duplication, Stale Information, INDEX Integrity, Session Start Ritual, or cross-link integrity rules.
- Do not convert existing markdown link syntax to [[wikilinks]].
- Do not rewrite old examples unless the exact example is directly in the change scope.
- Do not delete decisions.md lifecycle; extend it with folder/ADR alternative for larger projects.

Critical rules for this project:
- RULE: Content preservation is the primary defense against broken-telephone drift. Violation changes standards silently.
- RULE: New knowledge structure must be additive and scalable, not a forced migration for every small project.
- RULE: Markdown links remain the universal cross-link format unless tooling changes are explicitly approved.

## ACCEPTANCE CRITERIA
[ ] The skill explicitly states flat knowledge/*.md remains valid for small projects.
[ ] The skill explicitly describes thematic knowledge folders for larger projects.
[ ] The skill explicitly describes knowledge/decisions/ with one ADR per stable decision as the preferred larger-project structure.
[ ] ADR format includes Status, Confidence, Scope, Context, Decision, Consequences, Rollback / Revisit Trigger, Links.
[ ] INDEX/router and sub-index/folder README behavior is described.
[ ] Cross-linking remains markdown-link based and explicitly does not switch to unsupported [[wikilinks]].
[ ] Section 9 Content Preservation Rule is unchanged in meaning and force.
[ ] Anti-duplication and INDEX integrity still apply across folders, sub-indexes, and ADR files.
[ ] Modified file header @updated date and @version updated if the project convention requires it.
[ ] No files outside the affected file were modified.
[ ] Code Agent reports changed sections and confirms no unrelated wording cleanup was performed.
