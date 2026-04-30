---
name: code-markup-standard
description: Standard for marking up code files and knowledge files — file headers, function documentation, region comments, inline operational tags, and RULE comments. Use this skill whenever writing or modifying a prompt that creates or edits code files, and whenever creating or updating knowledge/*.md files. Referenced by prompt-writing-standard and knowledge-structure skills.
---

# Code Markup Standard
<!--
  @file:        skills/code-markup-standard/SKILL.md
  @description: Standard for code and knowledge file markup
  @version:     1.1
  @updated:     2026-04-30
-->

---

## 1. Why This Exists

Markup serves three purposes, in this order of priority:

1. **Regression protection** — `RULE:` comments next to vulnerable code make the Code Agent see the rule on every future edit, preventing the same mistake twice.
2. **Grep-friendly navigation** — operational tags (`@rule`, `@bug`, `@todo`, `@cost`…) allow a single `grep -r` to map critical spots across the project.
3. **Structural clarity** — file headers, function docs, region comments make files readable in one pass.

Markup is not about bureaucracy — it's about giving future sessions (of the Code Agent, or yourself) the context they need without re-reading everything.

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

Every code file gets a header **at the top of the file** with at most three fields:

- `@file` — path relative to repo root
- `@description` — one line, what this file does
- `@rule` — CRITICAL rule at file level that must not be violated (optional — include only if such a rule exists)

That's it. No `@lastModified`, no `@dependencies`, no `@author`. Git tracks these better.

**`@rule` in the file header is about the file as a whole** — violation breaks the entire file's contract. For rules about specific lines or blocks, use inline `RULE:` comments (Section 8).

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
- `@rule: description` — prohibition. Code Agent treats as hard constraint. Use for localized rules; file-wide rules go in the header.
- `@important: description` — critical behavioral detail, not a prohibition.

**Task tracking tags:**
- `@todo: description` — task to implement later
- `@bug: description` — known problem, not yet fixed

**Operational awareness tags:**
- `@cost: description` — cost of an API call or expensive operation (e.g. `@cost: Claude Vision ~$0.01 per image`)
- `@side-effect: description` — non-obvious side effect (DB write, notification, file creation, email send)
- `@external-api: name` — calls an external service (flag for rate limits, outages, monitoring)
- `@rate-limit: description` — rate-limited operation (e.g. `@rate-limit: 60 req/min per user`)
- `@pii: description` — handles personal or sensitive data (requires extra care for logging, storage, transmission)

**Tags are opt-in by relevance, not mandatory.** Use them where they help future sessions — don't fill files with ceremonial tags.

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

## 9. Rules Hierarchy — Three Places, One Source of Truth

Project rules can appear in three places:

| Place | Role | Relationship |
|---|---|---|
| Main project context file (`CLAUDE.md` or equivalent) — Critical rules list | High-level pointers, max 5, most severe only | Points to `knowledge/rules.md` for full list |
| `knowledge/rules.md` | **Source of truth** — complete registry of all project rules | Authoritative. All rules live here. |
| `@rule` in code | Operational marker next to code | Mirror of an entry from `rules.md` |

**Iron rule:** a rule cannot exist only in code. Every `@rule` in code must correspond to an entry in `knowledge/rules.md`. When you add a new `@rule` to code — add the same rule to `rules.md` in the same prompt. When you remove a rule from `rules.md` — clean up corresponding `@rule` markers in code.

This prevents the drift where code comments say one thing and documentation says another.

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

**Why `@updated` is retained here but not in code:** knowledge files are not always tied to git commits as cleanly as code — they may be updated from multiple directions (Code Agent, direct edits, migration scripts). The `@updated` date in the header is the explicit signal of freshness for future sessions reading `INDEX.md`.

`@lines` is retained because `knowledge-structure` Section 6 enforces the 200-line limit explicitly — the count is part of the file's self-description.

---

## 12. Migration of Existing Files

When touching an old file that uses a previous version of this standard:

- If the file is being modified for another reason anyway — bring it up to current standard as part of the same prompt.
- If the file is not being touched — leave it. Do not create prompts whose sole purpose is re-marking old files, unless the markup gap is actively causing problems.
- The current standard version is tracked in this skill's header (`@version`). Files don't need to declare which version of the standard they follow — the repo uses whatever this skill's current version says.

---

## 13. How Other Skills Reference This

- **`prompt-writing-standard`** — Step 6b (Read code files) and Section 3 (Prompt Template) reference this skill for markup rules of any file being created or modified.
- **`knowledge-structure`** — Section 6 (File Format Standard) references Section 11 of this skill for the knowledge header format.

When a prompt creates or modifies files — this skill must be read alongside `prompt-writing-standard`.
