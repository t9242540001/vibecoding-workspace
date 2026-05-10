#!/usr/bin/env bash
#
# routine — per-project wrapper around trigger-batch.sh.
#
# Allows multiple products to coexist on one developer machine without
# sharing or swapping ROUTINE_API_URL/ROUTINE_API_TOKEN environment vars.
# Each project has a config file at ~/.config/routines/<project>.env which
# this wrapper loads in an isolated subshell before invoking trigger-batch.
#
# Usage:
#   routine <project> <batch_id>
#
# Examples:
#   routine jck batch-2026-05-10-rate-limit-gate-fix
#   routine aks batch-2026-05-10-knowledge-update
#
# Required setup (one-time per machine):
#   See docs/routine-launcher-setup.md in vibecoding-workspace.
#   In short:
#     1. Create ~/.config/routines/<project>.env per project with
#        ROUTINE_API_URL and ROUTINE_API_TOKEN inside (chmod 600).
#     2. Install this script as ~/bin/routine (chmod +x).
#     3. Keep trigger-batch.sh installed as ~/bin/trigger-batch — this
#        wrapper invokes it under the hood.
#
# What this wrapper does:
#   - Validates that a config file exists for the given <project>.
#   - Loads ROUTINE_API_URL and ROUTINE_API_TOKEN from the project config
#     in an isolated subshell — env vars do NOT leak into the parent shell.
#   - Invokes trigger-batch with the given <batch_id>.
#   - Captures HTTP status and session_id from the response.
#   - Appends a log line to ~/.local/state/routines/trigger.log for audit.
#
# What this wrapper does NOT do:
#   - Does not validate the batch_id format. trigger-batch and the Routine
#     itself handle that.
#   - Does not store any secrets in the script body. All credentials live
#     in the per-project config files outside this script.
#   - Does not protect against double-firing the same Routine. The Anthropic
#     Routine API queues or rejects parallel runs server-side.
#   - Does not pick which project to use automatically. The project name
#     is always explicit in the command — eliminates the "ran in the wrong
#     project" failure mode that occurred during initial setup.
#
# Why per-project configs vs global env vars:
#   When multiple products are managed from the same machine, sharing
#   ROUTINE_API_URL/TOKEN across them is unsafe: a value set for product A
#   silently routes a batch trigger to product A's Routine even when the
#   developer intended product B. This failure mode happened during initial
#   setup (a six-hour bug hunt traced to that exact scenario). Per-project
#   config files plus an explicit <project> argument make it physically
#   impossible to mis-route a batch.
#
# Long-form rationale and setup steps:
#   docs/routine-launcher-setup.md

set -uo pipefail
# Note: -e is intentionally NOT set. trigger-batch can return non-zero
# (auth failure, 404, etc.) and we want to log those events. With -e the
# script would die before the logging block runs — defeating the purpose
# of having a launcher with an audit trail.

if [[ $# -ne 2 ]]; then
  echo "Usage: $(basename "$0") <project> <batch_id>" >&2
  echo "" >&2
  echo "Available projects:" >&2
  if [[ -d "$HOME/.config/routines" ]]; then
    ls "$HOME/.config/routines"/*.env 2>/dev/null \
      | sed 's|.*/||;s|\.env$||;s|^|  |' >&2 \
      || echo "  (none yet — see docs/routine-launcher-setup.md)" >&2
  else
    echo "  (no ~/.config/routines/ — see docs/routine-launcher-setup.md)" >&2
  fi
  exit 2
fi

PROJECT="$1"
BATCH_ID="$2"
CONFIG_FILE="$HOME/.config/routines/${PROJECT}.env"

if [[ ! -f "$CONFIG_FILE" ]]; then
  echo "ERROR: no config for project '$PROJECT' at $CONFIG_FILE" >&2
  echo "" >&2
  echo "Available projects:" >&2
  ls "$HOME/.config/routines"/*.env 2>/dev/null \
    | sed 's|.*/||;s|\.env$||;s|^|  |' >&2 \
    || echo "  (none yet — see docs/routine-launcher-setup.md)" >&2
  exit 3
fi

# Run trigger-batch in an isolated subshell. ROUTINE_API_URL and
# ROUTINE_API_TOKEN exist only between `(` and `)` — they cannot leak
# into the user's shell or into the wrapper code below.
OUTPUT="$(
  set -a
  # shellcheck source=/dev/null
  source "$CONFIG_FILE"
  set +a
  trigger-batch "$BATCH_ID" 2>&1
)" && EXIT_CODE=0 || EXIT_CODE=$?

# Echo trigger-batch output back to the user
echo "$OUTPUT"

# Audit log — written regardless of success or failure
LOG_DIR="$HOME/.local/state/routines"
LOG_FILE="$LOG_DIR/trigger.log"
mkdir -p "$LOG_DIR"

TS="$(date -u +%Y-%m-%dT%H:%M:%SZ)"
SESSION_ID="$(echo "$OUTPUT" | grep -oE 'session_[a-zA-Z0-9]+' | head -1)"
HTTP_CODE="$(echo "$OUTPUT" | grep -oE 'HTTP [0-9]+' | head -1 | awk '{print $2}')"

printf '%s\t%s\t%s\t%s\t%s\n' \
  "$TS" "$PROJECT" "$BATCH_ID" \
  "${HTTP_CODE:-?}" "${SESSION_ID:-none}" \
  >> "$LOG_FILE"

exit $EXIT_CODE
