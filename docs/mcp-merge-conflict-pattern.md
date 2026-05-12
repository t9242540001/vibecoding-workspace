# MCP Merge Conflict Pattern

<!--
  @file:        docs/mcp-merge-conflict-pattern.md
  @description: Failure mode and workaround for git merge conflicts when working through GitHub MCP
  @owner:       Claude (Anthropic)
  @updated:     2026-05-12
  @version:     1.0
-->

## Symptom

A planning chat is working on a `prep/*` branch through GitHub MCP. Between the moment the branch was created and the moment a PR is opened, **another chat (or another commit) lands on `main` and touches the same file the planning chat is editing**.

GitHub shows the PR as:

- Yellow warning at the top: **"This branch has conflicts that must be resolved"**
- Merge button is grayed out with tooltip: **"Merging is blocked due to failing merge requirements"**
- The conflicting file is listed with a `<<<<<<<` / `=======` / `>>>>>>>` conflict-marker view in the GitHub web editor.

The planning chat then tries to "fix" the conflict by **rewriting the file via `create_or_update_file`** — producing a clean file with no markers — and expects the conflict to clear.

It does not clear. Repeated rewrites do not clear it.

## Root Cause

Git's merge logic is **history-based, not content-based**. When GitHub computes whether a PR is mergeable, it performs a **3-way merge** between:

1. The **common ancestor** of the branch and `main` (the commit where the branch diverged).
2. The current tip of `main`.
3. The current tip of the branch.

If both `main` and the branch contain changes to the same lines **relative to the common ancestor**, git records a conflict — even when the branch's current content is byte-identical to what the merge would produce.

GitHub MCP's `create_or_update_file` creates a **single-parent commit** on the branch. It does not merge `main` into the branch. The common ancestor stays the same old commit, and every new rewrite produces yet another single-parent commit on top of the same diverged history. **The conflict persists by construction.**

The only operations that clear the conflict are:

- A **merge commit** with both `main` and the branch as parents (two-parent commit). The GitHub web editor's "Resolve conflicts" → "Mark as resolved" → "Commit merge" flow creates such a commit.
- A **fresh branch from current `main`** with the desired content reapplied. The new branch has no diverged history with `main`, so a fresh PR has no conflict.

GitHub MCP exposes Contents API (single-parent commits) but not Git Data API (multi-parent merge commits). The web editor's "Mark as resolved" button is not callable from MCP.

## Resolution Pattern

When the planning chat encounters this state, **do not** keep rewriting the file. The fix is:

1. **Read the current state of every file** the original PR was changing, from the stuck branch.
2. **Identify what landed on `main`** that conflicts — read the same files from `main`, diff in your head.
3. **Compute the final intended content** for each file (your changes + main's changes merged at the content level).
4. **Create a new branch from current `main`** with a clear name (e.g. `prep/<task>-v2`).
5. **Push the final content** of all affected files in a single `push_files` commit.
6. **Open a new PR** from `prep/<task>-v2` to `main`. The new PR has no diverged history; the merge button will be green.
7. **Close the stuck PR.** Delete the stuck branch.

The new PR is the "merge commit" semantically — it captures the integration of both lines of work. The stuck branch is abandoned; its content was already replayed onto the new branch.

## When To Use This Pattern Vs The Web Editor

- If the planning chat is the only entity touching the repository at this moment, opening the GitHub web editor and clicking through "Resolve conflicts" → "Mark as resolved" is faster (~30 seconds of human time).
- If the planning chat needs to do the resolution autonomously (no human at the keyboard), the **fresh-branch pattern** above is the only path through MCP.
- For batches of multiple files (more than ~3), the fresh-branch pattern is also easier on humans — the GitHub web editor resolves files one at a time and the user can lose track.

## Prevention

Before writing the first commit to a `prep/*` branch through MCP:

1. **Check `list_commits` on `main`** with `perPage: 5` to see the current tip.
2. **Read the file you intend to edit, from `main`**, immediately before composing the edit.
3. **Verify the SHA you pass to `create_or_update_file`** matches the version of the file you just read.

This does not prevent **parallel commits arriving during your work**, but it catches stale-base mistakes when your own session started from an old tip.

For parallel commits arriving mid-work: there is no MCP-side prevention. The fresh-branch pattern above is the recovery path. The cost of the recovery is one extra `push_files` call and one extra PR — acceptable, but worth knowing in advance instead of discovering after three failed rewrites.

## Incident Reference

This pattern was first identified during the 2026-05-12 batch-discipline session. The stuck PR was https://github.com/t9242540001/vibecoding-workspace/pull/3. After three attempts to rewrite `standards/batch-execution-standard.md` through MCP failed to clear the conflict, the fresh-branch pattern was applied as PR #4 (https://github.com/t9242540001/vibecoding-workspace/pull/4) and merged cleanly.

The root cause was diagnosed via `bug-hunting-universal.md` protocol (Stop & Frame → Reproduce → Investigate → Conclude) after the second failed rewrite — specifically the rule "two failed fixes with the same approach = stop and reframe."
