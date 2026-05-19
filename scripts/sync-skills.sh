#!/usr/bin/env bash
#
# sync-skills.sh — pull vibecoding-workspace skills into the current
# product repository's .claude/skills/ folder, called from a SessionStart
# hook in .claude/settings.json.
#
# Why this exists:
#   Claude Code on the web does not register skills from disk as
#   slash-commands (known bug: Anthropic issues #47929, #50669, #48696).
#   This hook copies SKILL.md files into .claude/skills/ at session start
#   so Claude Code can read them by path, which works around the bug.
#
# Single source of truth:
#   The canonical version of this script lives at
#   t9242540001/vibecoding-workspace:scripts/sync-skills.sh
#   New projects copy it verbatim into their own .claude/hooks/ during
#   onboarding (see docs/new-project-onboarding.md § Skill Sync Setup).
#   When the canonical version changes, projects pick up the update on
#   the next routine sync — no per-project script edits.
#
# Usage:
#   Wired into .claude/settings.json as a SessionStart hook:
#     {
#       "hooks": {
#         "SessionStart": [
#           {
#             "matcher": "startup|resume",
#             "hooks": [
#               { "type": "command",
#                 "command": "\"$CLAUDE_PROJECT_DIR\"/.claude/hooks/sync-skills.sh" }
#             ]
#           }
#         ]
#       }
#     }
#
# Environment variables expected by Claude Code at hook time:
#   CLAUDE_PROJECT_DIR — absolute path to the product repo root
#
# What this script does:
#   1. Clones (or pulls) vibecoding-workspace into ~/agent-base/
#      — a developer-machine-wide cache shared by all projects.
#   2. Refreshes .claude/skills/ in the current project from the cache.
#   3. Prints a short confirmation line.
#
# What this script does NOT do:
#   - Does not modify anything outside .claude/skills/ in the project.
#   - Does not commit anything. .claude/skills/ stays gitignored per
#     project (see .gitignore guidance in onboarding).
#   - Does not authenticate. The skills repo is public; HTTPS clone
#     works without credentials.
#   - Does not handle conflicts. .claude/skills/ is rebuilt on every
#     run — any local edits there are overwritten by design (skills
#     are read-only consumers in product repos).
#
# Behavior notes:
#   - First-ever run on a developer machine: full clone of
#     vibecoding-workspace into ~/agent-base/ (~10MB, one-time).
#   - Subsequent runs: `git pull --quiet origin main`, typically <1s.
#   - Offline mode: if network is unavailable on second+ run, the
#     existing cache is used — sync degrades to read-stale, never
#     blocks session start. First-ever clone in offline mode fails
#     loudly so the developer knows skills are missing.

set -uo pipefail

SKILLS_REPO="$HOME/agent-base"
SKILLS_REMOTE="https://github.com/t9242540001/vibecoding-workspace.git"
TARGET="$CLAUDE_PROJECT_DIR/.claude/skills"

if [[ -z "${CLAUDE_PROJECT_DIR:-}" ]]; then
  echo "sync-skills: ERROR — CLAUDE_PROJECT_DIR is unset, cannot determine target." >&2
  exit 1
fi

if [[ -d "$SKILLS_REPO/.git" ]]; then
  # Pull is best-effort. If offline, fall through to the copy step
  # with whatever is already cached locally.
  git -C "$SKILLS_REPO" pull --quiet origin main || \
    echo "sync-skills: pull failed (offline?) — using cached skills." >&2
else
  # First-ever clone. This MUST succeed — without skills the
  # workflow is broken. Fail loudly.
  if ! git clone --depth 1 --quiet "$SKILLS_REMOTE" "$SKILLS_REPO"; then
    echo "sync-skills: ERROR — initial clone failed. Check network and access to $SKILLS_REMOTE." >&2
    exit 2
  fi
fi

if [[ ! -d "$SKILLS_REPO/skills" ]]; then
  echo "sync-skills: ERROR — $SKILLS_REPO/skills not found after clone/pull. Workspace structure may have changed." >&2
  exit 3
fi

mkdir -p "$(dirname "$TARGET")"
rm -rf "$TARGET"
cp -r "$SKILLS_REPO/skills" "$TARGET"

echo "sync-skills: $(ls -1 "$TARGET" 2>/dev/null | grep -v '^BACKLOG' | wc -l) skill(s) synced to $TARGET"
