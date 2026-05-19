# External Skills Registry

<!--
  @file:        skills/external/REGISTRY.md
  @description: Catalog of 9 external skills surveyed from the May 2026 video review; entry point for selective integration
  @updated:     2026-05-19
  @version:     1.0
-->

## Why this file exists

A walkthrough video (May 2026) surveyed 9 production-grade skills from Anthropic, Vercel, shadcn, and the community that are widely used in the agent-skills ecosystem. This registry catalogs them so we can selectively pull what helps our work without losing track of which we've reviewed and rejected.

**Scope:** survey + analysis only. No skill is installed by this file. Installation happens per-skill, by explicit decision, into `skills/external/<name>/` (see *Integration model* below).

**Cross-reference to our pain map (see `standards/VIBECODER_STANDARDS.md` and the project chat for the A–H map):**
- **G** — universality / module reuse default
- **H** — visual / design quality

External skills that close G or H are top priority. Others are noted with their respective applicability windows.

---

## Integration model

Each external skill, when adopted, lives at `skills/external/<name>/` inside this workspace. They sync to product repos via the existing `scripts/sync-skills.sh` mechanism (the script copies the whole `skills/` tree, which automatically includes `external/`).

Our own 6 skills (`prompt-writing-standard`, `knowledge-structure`, `code-markup-standard`, `bug-hunting`, `research-protocol`, `skill-writing-standard`) stay at the top level of `skills/` and remain editable by us. External skills under `skills/external/` are treated as upstream — we do not edit their bodies, only update by re-pulling from source. If we need to adjust behavior, we wrap them with our own skill that references them.

The `external/` separation prevents the failure mode where a workspace update accidentally overwrites our edits to a third-party skill, or a third-party update overwrites our customizations.

---

## The 9 skills from the video — full catalog

### Design and interfaces (closes pain H, partially G)

#### 1. frontend-design — Anthropic

- **Source:** https://github.com/anthropics/skills (folder: `skills/frontend-design/`)
- **Direct file:** https://github.com/anthropics/skills/blob/main/skills/frontend-design/SKILL.md
- **What it does:** instructs Claude to make BOLD aesthetic choices instead of generic "AI slop" defaults. Covers typography, color/theme, motion, spatial composition. Strong on uniqueness, avoids the homogenized neural-design look.
- **Closes from map:** **H** directly.
- **Priority:** **High — install soon.**
- **Notes:** Frequently updated. Targets web UIs (HTML/CSS, React). Pair with `web-design-guidelines` (Vercel) for technical correctness on Next.js.

#### 2. web-design-guidelines — Vercel

- **Source:** https://github.com/vercel-labs/agent-skills (folder: `skills/web-design-guidelines/`)
- **What it does:** audits UI code against 100+ rules covering accessibility, focus handling, forms, animation, performance, UX. Built on 10 years of Vercel engineering practice.
- **Closes from map:** **H** for web projects + partially **G** (best practices = canonical patterns to reuse).
- **Priority:** **High for web projects** (Yurassistent), **medium for everything else.**
- **Notes:** complements (does not replace) Anthropic's `frontend-design`. The two work together: Anthropic skill sets the aesthetic direction, Vercel skill enforces the technical rigor.

#### 3. shadcn (UI Kit awareness and audit) — shadcn-ui

- **Source:** https://github.com/shadcn-ui/ui (folder: `skills/shadcn/`)
- **Direct file:** https://github.com/shadcn-ui/ui/blob/main/skills/shadcn/SKILL.md
- **What it does:** reads `components.json` from the project, sees which UI components are already installed, knows which icon library is in use, knows registered aliases. Generates code with correct imports. Prevents duplicate component creation.
- **Closes from map:** **G directly** — this is the technological embodiment of the universality principle for UI. Not a theoretical "reuse what exists" rule but a working mechanism that physically prevents duplicate buttons.
- **Priority:** **Highest** — most direct hit on pain G out of all 9.
- **Notes:** requires shadcn/ui in the project (Next.js / React). Companion skill from third party for post-hoc audits: https://github.com/mattbx/shadcn-skills.

### Code discipline and development workflow

#### 4. superpowers — obra (Jesse Vincent)

- **Source:** https://github.com/obra/superpowers
- **Marketplace:** https://github.com/obra/superpowers-marketplace
- **Install:** `/plugin marketplace add obra/superpowers-marketplace` then `/plugin install superpowers@superpowers-marketplace`
- **What it does:** 20+ skills enforcing engineering discipline. Pipeline: brainstorming → write-plan → execute-plan → TDD → review. Includes slash commands `/superpowers:brainstorm`, `/superpowers:write-plan`, `/superpowers:execute-plan`. Forces tests to be written before code; if Claude forgets a test, the skill makes it start over.
- **Closes from map:** partially **A** (forces full feature thinking), **C** (brainstorm phase surfaces edge cases), **D** (TDD = real verification).
- **Priority:** **Requires analysis** — significant overlap with our `prompt-writing-standard` (Steps 7, 8a, 9). May replace parts, may layer on top.
- **Notes:** 170K+ GitHub stars, Anthropic-validated, multi-platform (Claude Code, Cursor, Codex). The TDD-enforcement piece is the most novel for us.

#### 5. react-best-practices — Vercel

- **Source:** https://github.com/vercel-labs/agent-skills (folder: `skills/react-best-practices/`)
- **Direct file:** https://github.com/vercel-labs/agent-skills/blob/main/skills/react-best-practices/SKILL.md
- **What it does:** 70 rules across 8 categories for React/Next.js performance optimization, ordered by impact. Concrete code examples. Activates on React-related tasks.
- **Closes from map:** **H** for the React/Next.js subset.
- **Priority:** **By project** — applies only to ЮрАссистент (Next.js front). For non-React projects (Whatscan, productcenter-moderator, deepvest) — irrelevant.
- **Notes:** also worth knowing — separate `next-best-practices` skill at https://github.com/vercel-labs/next-skills.

#### 6. Postgres / database best practices

Three credible candidates here — the video did not name an exact author. Listed in order of suitability for our stack:

- **6a. supabase/agent-skills** — https://github.com/supabase/agent-skills (skill: `postgres-best-practices`)
  Postgres performance + schema design + RLS guidelines from Supabase engineering. Wide coverage.
- **6b. timescale/pg-aiguide** — https://github.com/timescale/pg-aiguide
  Postgres skills + MCP server for semantic search over the official Postgres manual. Adds a live documentation source.
- **6c. neondatabase/postgres-skills** — https://github.com/neondatabase/postgres-skills
  Vendor-agnostic, contributor list includes PostgreSQL core team members and Neon co-founder.

- **Closes from map:** not from the map directly — closes a category of database-related errors that recur in our backend projects.
- **Priority:** **By project, not urgent now.** Applies to productcenter-moderator, ЮрАссистент, deepvest (all use Postgres). Decide which of 6a/6b/6c at adoption time based on whether we want vendor-neutral (6c), Supabase-flavored (6a), or with MCP doc search (6b).

### Advanced infrastructure

#### 7. mcp-builder — Anthropic

- **Source:** https://github.com/anthropics/skills (folder: `skills/mcp-builder/`)
- **What it does:** guidance for creating high-quality MCP servers — the bridge between Claude and external APIs / internal systems. Covers spec, implementation patterns, testing.
- **Closes from map:** not from the map — enables building new MCP servers.
- **Priority:** **Long-term.** We already have `vds-files-mcp` and `JCK AUTO MCP`. Future MCPs (Magic Defender, anything else) would benefit.
- **Notes:** matches video's description of "MCP Builder for advanced users — talks to external APIs and internal systems".

#### 8. canvas-design — Anthropic

- **Source:** https://github.com/anthropics/skills (folder: `skills/canvas-design/`)
- **What it does:** generates vector design (infographics, banners, SVG logos, covers) by writing code. Custom corporate fonts can be loaded.
- **Closes from map:** **H** for vector-output artifacts (logos, banners, social cards, in-game icons for Magic Defender).
- **Priority:** **High for design-output tasks** — install when first design-output task appears.

#### 9. Vercel skills infrastructure (agent-skills as a whole)

- **Source:** https://github.com/vercel-labs/agent-skills
- **What it does:** the *repository* itself is the "Vercel skills" the video describes — a single source of agent-skill metadata that works identically across Cursor and Claude. One folder, one set of rules, no per-tool configuration drift.
- **Closes from map:** not from the map directly — addresses cross-tool configuration consistency.
- **Priority:** **Compare with our `sync-skills.sh`.** They solve overlapping problems (single source of skill truth). Possible outcomes: their approach better → adopt theirs and retire ours; theirs has limitations for our chat-driven flow → keep ours. Decision after side-by-side.

---

## Other Anthropic skills not from the video, worth knowing

`anthropics/skills` ships 17 skills total. Beyond the four from the video (`frontend-design`, `canvas-design`, `mcp-builder`, plus `skill-creator` we already use conceptually), these are also live:

- `algorithmic-art` — generative art
- `brand-guidelines` — apply brand colors and typography to artifacts
- `claude-api` — helper for working with the Claude API
- `doc-coauthoring` — collaborative document editing patterns
- `docx`, `pdf`, `pptx`, `xlsx` — document creation skills (we already use the equivalents through our system)
- `internal-comms` — status reports, newsletters, FAQs
- `slack-gif-creator` — animated GIFs for Slack
- `theme-factory` — design tokens / theme generation
- `web-artifacts-builder` — complex Claude.ai HTML artifacts using React + Tailwind + shadcn
- `webapp-testing` — Playwright-based web app testing

Not catalogued in detail here. Worth a separate pass when we have time.

---

## Curated lists for ongoing discovery

When evaluating future skills beyond this initial 9, use these community catalogs:

- https://github.com/travisvn/awesome-claude-skills — curated list, frequent updates
- https://github.com/BehiSecc/awesome-claude-skills — alternative curated list
- https://github.com/ComposioHQ/awesome-claude-skills — 1000+ production-ready skills

---

## Status of each entry — decision log

| # | Skill | Source | Reviewed | Decision |
|---|-------|--------|----------|----------|
| 1 | frontend-design | anthropics/skills | 2026-05-19 | Recommended: install soon |
| 2 | web-design-guidelines | vercel-labs/agent-skills | 2026-05-19 | Recommended: install for web projects |
| 3 | shadcn | shadcn-ui/ui | 2026-05-19 | **Highest priority** — closes G |
| 4 | superpowers | obra/superpowers | 2026-05-19 | Pending analysis vs our prompt-writing-standard |
| 5 | react-best-practices | vercel-labs/agent-skills | 2026-05-19 | By project (Next.js only) |
| 6 | postgres (3 candidates) | supabase / timescale / neon | 2026-05-19 | By project, choose candidate at adoption |
| 7 | mcp-builder | anthropics/skills | 2026-05-19 | Long-term |
| 8 | canvas-design | anthropics/skills | 2026-05-19 | Install on first design-output task |
| 9 | vercel-labs/agent-skills (infra) | vercel-labs | 2026-05-19 | Pending comparison with our sync-skills.sh |

Update this table whenever a decision changes or a skill moves to `skills/external/<name>/`.
