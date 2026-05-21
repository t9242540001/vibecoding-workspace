#!/usr/bin/env bash
set -euo pipefail

REPO="$HOME/codex-runners/vibecoding-workspace"
CODEX_RUNNER="$HOME/codex-runners/run-vcw-codex-hardened.sh"

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <batch_id>" >&2
  exit 2
fi

BATCH_ID="$1"
BATCH_DIR="$REPO/prompts/queue/$BATCH_ID"
TASK_FILE="/tmp/${BATCH_ID}.codex-task.txt"

cd "$REPO"

git fetch origin
git pull --ff-only origin main

if [ ! -f "$BATCH_DIR/manifest.json" ]; then
  echo "ERROR: batch manifest not found: $BATCH_DIR/manifest.json" >&2
  exit 1
fi

cat > "$TASK_FILE" <<EOF
??????? Codex batch $BATCH_ID ?? standards/codex-batch-execution-standard.md.
?? ????????? Claude Routines.
?? ???????? deploy/server/secrets actions ??? ?????????? ?????????????.
????? ?????????? ?????????? ? ?????? ??????? ?????: ?????????? ?????, ????????, stop conditions.
EOF

"$CODEX_RUNNER" exec-file "$TASK_FILE"

cd "$REPO"

echo
echo "=== Git status after Codex ==="
git status --short --branch

if git diff --quiet && [ -z "$(git ls-files --others --exclude-standard)" ]; then
  echo "No changes to checkpoint."
  exit 0
fi

echo
echo "=== Running trusted checkpoint outside Codex sandbox ==="
scripts/codex-trusted-checkpoint.sh "$BATCH_ID" "Auto checkpoint after Codex batch"

echo
echo "=== Final status ==="
git status --short --branch
