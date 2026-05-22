# Pain Map A–H

<!--
  @file:        docs/pain-map.md
  @description: Single source of truth for the workspace pain map (A–H) and which skills/standards close each entry
  @updated:     2026-05-22
  @version:     1.0
-->

## Purpose

This file is the single navigation point for the workspace **pain map** — the eight recurring failure modes that the workspace skills and standards exist to prevent. Before this file existed, the map lived only in chat memory and was referenced from `skills/external/REGISTRY.md` and `workspace-index.md` Skills Migration Status without a central definition. This file is that definition.

The map is updated when a new pain is identified or when an existing pain gets a closing skill.

## Closure status

| Pain | Short name | Status | Primary closer | Partial closers |
|---|---|---|---|---|
| **A** | _requires definition by Vasily_ | Pending content | — | Touched by `universality-discipline`, `anti-hedging-language`, `real-path-verification`, `forward-thinking-discipline`, `series-design-discipline` |
| **B** | _requires definition by Vasily_ | Pending content | — | Touched by `universality-discipline`, `real-path-verification`, `forward-thinking-discipline` |
| **C** | _requires definition by Vasily_ | ✅ Closed | `forward-thinking-discipline` (priority 10) | `anti-hedging-language`, `real-path-verification`, `series-design-discipline` |
| **D** | Real-path verification gap | ✅ Closed | `real-path-verification` (priority 9) | `anti-hedging-language`, `forward-thinking-discipline` |
| **E** | Multi-prompt series drift | ✅ Closed | `series-design-discipline` (priority 11) — Series Charter as cross-prompt namespace | `universality-discipline` (partial via shared registry) |
| **F** | Hedging language as silent deferral | ✅ Closed | `anti-hedging-language` (priority 8) | — |
| **G** | Universality / module reuse default | ✅ Closed | `universality-discipline` (priority 7) | `series-design-discipline` (partial — series-level reuse via Charter Dependency map); `shadcn` external skill candidate (highest priority in `skills/external/REGISTRY.md`) |
| **H** | Visual / design quality | Pending content + external skill adoption | — | External candidates in `skills/external/REGISTRY.md`: `frontend-design` (Anthropic), `web-design-guidelines` (Vercel), `react-best-practices` (Vercel), `canvas-design` (Anthropic). All catalogued, none adopted yet. |

## Source of evidence

The closure status above is derived from observable repository state:

- `workspace-index.md` Skills Migration Status table — each skill's row states `closes pain map X; partially Y, Z`. This is the authoritative source.
- `skills/external/REGISTRY.md` — defines pains G and H by name and lists external skill candidates that would close them.
- Skills themselves (`skills/<name>/SKILL.md`) — each new skill (priorities 7–11) was born with explicit pain-map closure intent stated in its header.

If `workspace-index.md` and this file disagree, `workspace-index.md` is the source of truth and this file is updated to match.

## Pending pains — what's needed

Three pains (**A**, **B**, **H**) remain as letter-only references in the existing record. To unblock them:

- **A and B** — short names and trigger descriptions need to be provided by Vasily. These letters are referenced in five skill rows as "partially closes A" / "partially closes B", meaning multiple skills already touch them — but until A and B are defined by content, no primary closer can be designed for them. **Action:** in the next session that returns to pain-map work, Vasily provides the short name and 1–2 sentence definition for A and B. Then this file's table is updated, and `skills/BACKLOG.md` is checked for candidate skills that match those definitions.
- **H** — short name is known (visual/design quality from `skills/external/REGISTRY.md`). What's pending is **adoption decision**: which of the four external candidates (`frontend-design`, `web-design-guidelines`, `react-best-practices`, `canvas-design`) gets installed first, and whether one is enough or several are needed. **Action:** decision is gated on the first design-output task arriving in any product repository. The REGISTRY.md `Decision log` table tracks this.

These three items are recorded in `skills/BACKLOG.md` as follow-up work, so they survive across sessions.

## How this map is used

When a recurring failure pattern appears in product work or chat sessions:

1. Check if it matches an existing pain entry above. If yes — apply the primary closer skill; no new skill is needed.
2. If it doesn't match any entry but recurs at least twice — propose it as a new pain. Each new pain entry needs: letter (next available), short name, trigger description, and a candidate primary closer (existing skill if one fits, or `skills/BACKLOG.md` entry if a new skill is needed).
3. New pain entries are added to this file, then cross-referenced in `workspace-index.md` Skills Migration Status (for the new primary closer skill, if any) and `skills/external/REGISTRY.md` (if external skill candidates apply).

## Update procedure

When updating this file:

- A skill closes a pain → move that pain row from `Pending` to `✅ Closed` status, fill the `Primary closer` cell with the skill name and priority.
- A skill partially closes a pain → add the skill name to the `Partial closers` cell (do not change Status).
- A new pain is identified → add a new row with next available letter; if Vasily approves, the new letter goes into the workspace lexicon.
- A pain becomes obsolete (the underlying failure mode no longer occurs because the architecture changed) → annotate the row with `[obsolete]` and a one-line reason; do not delete.

Increment `@version` per `knowledge-structure` conventions: minor for content additions, major for structural rewrites of this file.
