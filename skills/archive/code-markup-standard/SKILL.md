---
name: code-markup-standard
description: Standard for marking up code files and knowledge files — file headers, function documentation, region comments, inline operational tags, and RULE comments. Use this skill whenever writing or modifying a prompt that creates or edits code files, and whenever creating or updating knowledge/*.md files. Referenced by prompt-writing-standard, knowledge-structure, and universality-discipline skills.
---

# Code Markup Standard
<!--
  @file:        skills/code-markup-standard/SKILL.md
  @description: Standard for code and knowledge file markup
  @version:     1.3
  @updated:     2026-05-19
-->

---

## 1. Why This Exists

Markup serves three purposes, in this order of priority:

1. **Regression protection** — `RULE:` comments next to vulnerable code make Claude Code see the rule on every future edit, preventing the same mistake twice.
2. **Grep-friendly navigation** — operational tags (`@rule`, `@bug`, `@todo`, `@cost`, `@universal`…) allow a single `grep -r` to map critical spots across the project.
3. **Structural clarity** — file headers, function docs, region comments make files readable in one pass.

Markup is not about bureaucracy — it's about giving future sessions (of Claude Code, or yourself) the context they need without re-reading everything.

**No duplication of git:** never add `@lastModified`, `@author`, `@dependencies` to code file headers. Git already tracks modification time and authorship with second-level accuracy; import statements already list dependencies. Duplicating this in comments creates a second source of truth that silently drifts.

---

## 2. Adaptive Markup — Three Levels by File Size

A 15-line utility and a 200-line module deserve different treatment. Full markup on a tiny file adds more metadata than code — that's overhead, not clarity.

### Level 1 — Small files (< 30 lines)
- File header with only `@file`, `@description`, and `@rule` (if applicable)
- No region comments, no JSDoc, no inline tags — unless a RULE is genuinely needed

### Level 2 — Medium files (30–100 lines)
- File header (as above)
- Function documentation on every exported function (JSDoc / docstring / godoc / rustdoc — see Section 3)
- RULE comments where regression-prone code exists
- Inline tags optional, add where genuinely useful

### Level 3 — Large files (100–200 lines)
- All of the above
- Region comments to divide the file into logical sections (Section 6)
- Inline operational tags (`@section`, `@todo`, `@bug`, `@cost`, etc.) as needed

**Hard limit:** 200 lines maximum per file (from `knowledge-structure` Section 6 for knowledge files, and from `prompt-writing-standard` Section 4 for code files). Beyond 200 — split the file, don't shrink the markup.

---

## 3. Language-Specific Equivalents

The same concepts apply across languages; only the syntax changes.

### File header

**TypeScript / JavaScript:**
```typescript
/**
 * @file        filename.ts
 * @description One line — what this file does
 * @rule        CRITICAL rule that must not be violated — consequence
 */
```

**Python:**
```python
"""
@file        filename.py
@description One line — what this file does
@rule        CRITICAL rule that must not be violated — consequence
"""
```

**Go:**
```go
// @file        filename.go
// @description One line — what this file does
// @rule        CRITICAL rule that must not be violated — consequence
```

**Rust:**
```rust
//! @file        filename.rs
//! @description One line — what this file does
//! @rule        CRITICAL rule that must not be violated — consequence
```

**YAML / Dockerfile / shell scripts / nginx.conf:**
```yaml
# @file        docker-compose.yml
# @description One line — what this file does
# @rule        CRITICAL rule that must not be violated — consequence
```

**SQL migrations:**
```sql
-- @file        migrations/2026_04_14_add_user_index.sql
-- @description Adds index on users.email for login query performance
```

### Function documentation

**TypeScript / JavaScript — JSDoc:**
```typescript
/**
 * Brief description of what the function does
 * @section section-name
 * @input type and meaning of input
 * @output type and meaning of result
 * @important critical behavioral details
 */
export function myFunction() {}
```

**Python — docstring:**
```python
def my_function(arg: str) -> bool:
    """Brief description of what the function does.

    @section: section-name
    @important: critical behavioral details

    Args:
        arg: type and meaning of input

    Returns:
        type and meaning of result
    """
```

**Go — godoc:**
```go
// MyFunction does X.
//
// @section section-name
// @important critical behavioral details
//
// Input: type and meaning of input
// Output: type and meaning of result
func MyFunction(arg string) bool {}
```

**Rust — rustdoc:**
```rust
/// Brief description of what the function does.
///
/// # @section section-name
/// # @important critical behavioral details
///
/// # Arguments
/// * `arg` — type and meaning of input
///
/// # Returns
/// type and meaning of result
pub fn my_function(arg: &str) -> bool {}
```

---

## 4. File Header — Minimal Set

Every code file gets a header **at the top of the file** with at most four fields:

- `@file` — path relative to repo root
- `@description` — one line, what this file does
- `@rule` — CRITICAL rule at file level that must not be violated (optional — include only if such a rule exists)
- `@universal` — pointer to the registry entry if this file implements a registered universal (optional — include only if this file's primary purpose is to implement a unit listed in `knowledge/universals/*.md`)

That's it. No `@lastModified`, no `@dependencies`, no `@author`. Git tracks these better.

**`@rule` in the file header is about the file as a whole** — violation breaks the entire file's contract. For rules about specific lines or blocks, use inline `RULE:` comments (Section 8).

**`@universal` in the file header is about the file as a whole** — the file's primary purpose is to implement a registered universal. Example: `src/components/ui/Button.tsx` carries `@universal: knowledge/universals/components.md#PrimaryButton`. This makes the universal-to-code link visible from the code side (the registry already knows where the code lives via its `Lives at` column). For universals that are blocks or functions inside a larger non-universal file, use the inline `@universal` tag (Section 7) instead of the file-level header field.

---

## 5. Function Documentation

Every **exported** function gets documentation. Internal helpers — only when non-obvious.

Required elements (syntax varies by language, see Section 3):
- Brief description — what the function does (not how)
- `@section` — which logical section of the file it belongs to (relevant in large files with regions)
- Input — type and meaning of arguments
- Output — type and meaning of return value
- `@important` — critical behavioral details, non-obvious side effects, order dependencies

Documentation on internal helpers is optional. Documentation on exports is not.

---

## 6. Region Comments — Large Files Only

For files ≥100 lines, divide into logical sections using region comments. Use ASCII separators, not Unicode box-drawing — ASCII is portable across terminals, diff viewers, and grep output.

```
// === TYPES ==============================================================
// === CONSTANTS ==========================================================
// === HELPERS ============================================================
// === MAIN LOGIC =========================================================
// === EXPORTS ============================================================
```

Region labels are in CAPS, padded with `=` to a consistent column (around 72 chars), for easy visual scanning.

For Python, use `#` instead of `//`. For SQL — `--`. For YAML/shell — `#`. The separator style stays the same.

---

## 7. Inline Operational Tags — Grep-Friendly

Tags are single-line markers placed inline where they apply. They are not prose — they are anchors for `grep -r` across the project.

**Navigation tag:**
- `@section: name` — marks the start of a logical block inside a file. Complements region comments for grep-based navigation.

**Severity tags:**
- `@rule: description` — prohibition. Claude Code treats as hard constraint. Use for localized rules; file-wide rules go in the header.
- `@important: description` — critical behavioral detail, not a prohibition.

**Task tracking tags:**
- `@todo: description (→ knowledge/roadmap/tasks/2026-05-20-refactor-auth.md)` — task to implement later. **Mandatory link to a roadmap task file.** A bare `@todo:` without a roadmap link is the code-level form of silent deferral (per skill `anti-hedging-language` Section 5 Step 4): the comment will be forgotten and the work lost. If the task is too small to deserve a roadmap entry — resolve it in the current prompt, do not write `@todo:`. See skill `anti-hedging-language` Section 7. The path shown is an example, not a literal — substitute the actual roadmap task filename in the format `YYYY-MM-DD-slug.md`.
- `@bug: description` — known problem, not yet fixed

**Operational awareness tags:**
- `@cost: description` — cost of an API call or expensive operation (e.g. `@cost: Claude Vision ~$0.01 per image`)
- `@side-effect: description` — non-obvious side effect (DB write, notification, file creation, email send)
- `@external-api: name` — calls an external service (flag for rate limits, outages, monitoring)
- `@rate-limit: description` — rate-limited operation (e.g. `@rate-limit: 60 req/min per user`)
- `@pii: description` — handles personal or sensitive data (requires extra care for logging, storage, transmission)

**Universal-traceability tag:**
- `@universal: <link>` — marks code that implements (or is part of) a registered universal. The link points to the entry in `knowledge/universals/<file>.md`. Two placement modes:
  - **In the file header** (Section 4) — when the entire file's primary purpose is to implement a registered universal. Example: `@universal: knowledge/universals/components.md#PrimaryButton` in `src/components/ui/Button.tsx`.
  - **Inline above a block or function** — when the universal is a specific function, class, or block inside a larger non-universal file. Example: `@universal: knowledge/universals/tools.md#APIErrorWrapper` placed above the exported function that implements that universal.

The tag is required for every code unit that corresponds to a registry entry. Missing the tag makes the universal invisible from the code side; future sessions won't know the file participates in the universals discipline.

**Verification-status tags:**
- `@verified-by: <scenario-or-link>` — marks code that has passed real-path verification (per skill `real-path-verification` Section 7). The link points to the scenario name in the REAL-PATH VERIFICATION block of the prompt that introduced the code, or to a `knowledge/roadmap/tasks/<task>.md#verification-log` entry where the verification was recorded. Two placement modes:
  - Inline above the function or block that was verified
  - In the file header when the entire file's logic was end-to-end verified
- `@pending-verification` — marks code that is `coded` but not yet `verified` (per skill `real-path-verification` Section 7 — the three states `coded` / `pending-verification` / `verified`). Lifespan: until verification closes or the task is closed by other means. Lingering `@pending-verification` tags in code older than ~30 days are an integrity-check signal (per `knowledge-structure` Section 13) — the verification handoff is stale and should be revisited.

Both tags are added by Claude Code when the prompt creates or modifies runtime behavior in scope of `real-path-verification`. They are not retroactive — old code does not get marked unless it's being touched anyway.

**Tags are opt-in by relevance, not mandatory** — *except* `@rule`, `@universal`, `RULE:` anchors, and `@todo:` tags, which are mandatory in the following sense: `@rule` / `@universal` / `RULE:` are mandatory **when the conditions apply** (rule exists, universal is registered, recurrence-prone bug was fixed); `@todo:` is mandatory **in its link form** — wherever `@todo:` appears, the roadmap link is required, not the tag itself. Use the other tags where they help future sessions — don't fill files with ceremonial tags.

---

## 8. RULE Comments vs @rule Header — Different Scope

These look similar but solve different problems:

| | Scope | When to use |
|---|---|---|
| `@rule` in file header | File-wide invariant | Rule applies to the file as a whole. Violation = file is fundamentally broken. |
| `@rule:` inline tag | Local prohibition | Rule applies to a specific block or area. Violation = that part is broken, other parts may be fine. |
| `RULE:` comment block | Anti-regression anchor | Placed directly next to vulnerable code after a bug recurs. Violation = the specific bug comes back. |

Example of a `RULE:` anti-regression anchor:
```typescript
// RULE: load_dotenv() MUST be called FIRST — before any imports from src/
// Violation breaks all routes. See main.py line 1.
load_dotenv()
```

No conflict between the three — they have different scopes. All three can coexist in one file.

**When to escalate to `RULE:` anchor:** if the same error recurs after a fix, add a `RULE:` comment next to the vulnerable code. The anchor is placed in response to pain, not pre-emptively.

---

## 9. Rules and Universals Hierarchy — Three Places, One Source of Truth

Both project rules and project universals follow the same architectural pattern: a single source of truth in knowledge, mirrored by operational markers in code.

### Rules hierarchy

Project rules can appear in three places:

| Place | Role | Relationship |
|---|---|---|
| `CLAUDE.md` — Critical rules list | High-level pointers, max 5, most severe only | Points to `knowledge/rules/` for full list |
| `knowledge/rules/` | **Source of truth** — complete registry of all project rules | Authoritative. All rules live here. |
| `@rule` in code | Operational marker next to code | Mirror of an entry from `rules/` |

**Iron rule:** a rule cannot exist only in code. Every `@rule` in code must correspond to an entry in `knowledge/rules/`. When you add a new `@rule` to code — add the same rule to `rules/` in the same prompt. When you remove a rule from `rules/` — clean up corresponding `@rule` markers in code.

This prevents the drift where code comments say one thing and documentation says another.

### Universals hierarchy

The same architectural pattern applies to universals:

| Place | Role | Relationship |
|---|---|---|
| `knowledge/universals/*.md` | **Source of truth** — complete registry of reusable units | Authoritative. All universals live here. |
| `@universal` tag in code (header or inline) | Operational marker next to the code that implements the universal | Mirror of an entry from `universals/*.md` |

**Iron rule:** a universal cannot exist only in code. Every `@universal` tag in code must correspond to an entry in `knowledge/universals/<file>.md`. When you add a new universal — add the entry to `universals/` and the `@universal` tag to the file in the same prompt. When you remove an entry from `universals/` (by Vasily's explicit command, per `universality-discipline` Section 5) — clean up corresponding `@universal` tags in code.

The reverse drift is also forbidden: an entry in `universals/<file>.md` whose `Lives at` column points at a file that lacks an `@universal` tag is broken. The integrity check in `knowledge-structure` Section 13 surfaces this mismatch.

---

## 10. Dead Code

Delete it. Do not comment it out.

Git history preserves it if you ever need it back. Commented-out code in active files is noise — it confuses grep, confuses readers, and tempts people to uncomment stale logic.

---

## 11. Knowledge File Header Standard

Every `knowledge/*.md` file starts with:
```
<!--
  @file:        knowledge/[filename].md
  @project:     [Project Name]
  @description: [one line — what this file contains]
  @updated:     YYYY-MM-DD
  @version:     N.N
  @lines:       [actual line count]
-->
```

**Why `@updated` is retained here but not in code:** knowledge files are not always tied to git commits as cleanly as code — they may be updated from multiple directions (Claude Code, direct edits, migration scripts). The `@updated` date in the header is the explicit signal of freshness for future sessions reading `INDEX.md`.

`@lines` is retained because `knowledge-structure` Section 6 enforces the 200-line limit explicitly — the count is part of the file's self-description.

---

## 12. Migration of Existing Files

When touching an old file that uses a previous version of this standard:

- If the file is being modified for another reason anyway — bring it up to current standard as part of the same prompt.
- If the file is not being touched — leave it. Do not create prompts whose sole purpose is re-marking old files, unless the markup gap is actively causing problems.
- The current standard version is tracked in this skill's header (`@version`). Files don't need to declare which version of the standard they follow — the repo uses whatever this skill's current version says.

**Special case for `@universal`:** during the Bootstrap procedure for an existing project's universals registry (per `universality-discipline` Section 5 and `knowledge-structure` Section 15), every file that ends up registered in `knowledge/universals/*.md` gets its `@universal` tag added in the same Bootstrap operation. This avoids a state where the registry knows the file but the file does not know it's a universal.

---

## 13. How Other Skills Reference This

- **`prompt-writing-standard`** — Step 6b (Read code files) and Section 3 (Prompt Template) reference this skill for markup rules of any file being created or modified.
- **`knowledge-structure`** — Section 6 (File Format Standard) references Section 11 of this skill for the knowledge header format.
- **`universality-discipline`** — Section 9 (Connections to Other Skills) references this skill for the `@universal` tag, both as a file-header field (Section 4) and as an inline operational tag (Section 7), plus the bilateral integrity rule in Section 9 (Rules and Universals Hierarchy).
- **`anti-hedging-language`** — Section 7 references Section 7 of this skill for the `@todo:` tag rule. A bare `@todo:` without a roadmap link is the code-level shape of the silent deferral that `anti-hedging-language` addresses.
- **`real-path-verification`** — Section 10 "Application in Existing Processes" references Section 7 of this skill for the two new inline tags `@verified-by` and `@pending-verification`. Both tags mirror the three states of verification lifecycle (`coded` / `pending-verification` / `verified`) defined in `real-path-verification` Section 7.

When a prompt creates or modifies files — this skill must be read alongside `prompt-writing-standard`.
