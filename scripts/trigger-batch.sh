#!/usr/bin/env bash
#
# trigger-batch.sh — fire a Claude Code Routine to execute a batch series.
#
# Usage:
#   trigger-batch.sh <batch_id>
#
# Examples:
#   trigger-batch.sh batch-2026-05-08-reviews-ui-components
#   trigger-batch.sh batch-2026-05-12-design-system-finish
#
# Required environment variables (set once in ~/.bashrc / ~/.zshrc):
#   ROUTINE_API_URL    — full trigger URL of the Routine in claude.ai/code/routines.
#                        Get it from the Routine page → API trigger settings.
#   ROUTINE_API_TOKEN  — Bearer token for the same Routine. Generated alongside the URL.
#
# Optional:
#   ROUTINE_DRY_RUN=1  — print the curl command without sending it. Useful for verification.
#
# Required headers (per https://platform.claude.com/docs/en/api/claude-code/routines-fire):
#   - Authorization: Bearer ${ROUTINE_API_TOKEN}
#   - anthropic-version: 2023-06-01
#   - anthropic-beta: experimental-cc-routine-2026-04-01   ← without this the API returns
#                                                           404 not_found_error even with a
#                                                           valid URL + token.
#   - Content-Type: application/json
#
# Long-form rationale and source of truth:
#   docs/batch-execution-guide.md → "Step C — Trigger The Routine"
#   standards/batch-execution-standard.md
#
# What this script does NOT do:
#   - It does not validate that the batch_id exists in any product repo. The Routine
#     itself does that and reports back via Telegram. If you mistype the id, the
#     Routine will Telegram-error and stop without touching code.
#   - It does not pick which product the batch runs against. That is determined by
#     which Routine the URL/token point at. One Routine per product.

set -euo pipefail

if [[ $# -lt 1 || -z "${1:-}" ]]; then
  echo "Usage: $(basename "$0") <batch_id>" >&2
  echo "Example: $(basename "$0") batch-2026-05-08-reviews-ui-components" >&2
  exit 2
fi

BATCH_ID="$1"

if [[ -z "${ROUTINE_API_URL:-}" ]]; then
  echo "ERROR: ROUTINE_API_URL is not set. Add it to ~/.bashrc:" >&2
  echo "  export ROUTINE_API_URL='https://...'" >&2
  exit 3
fi

if [[ -z "${ROUTINE_API_TOKEN:-}" ]]; then
  echo "ERROR: ROUTINE_API_TOKEN is not set. Add it to ~/.bashrc:" >&2
  echo "  export ROUTINE_API_TOKEN='...'" >&2
  exit 3
fi

# Build the JSON body. jq would be cleaner but we keep zero deps.
# batch_id is a controlled string (we set it ourselves), so simple interpolation is safe.
BODY="{\"text\":\"${BATCH_ID}\"}"

if [[ "${ROUTINE_DRY_RUN:-0}" == "1" ]]; then
  echo "[dry-run] Would POST to: ${ROUTINE_API_URL}"
  echo "[dry-run] Body: ${BODY}"
  echo "[dry-run] Auth header: Bearer <hidden>"
  echo "[dry-run] anthropic-version: 2023-06-01"
  echo "[dry-run] anthropic-beta: experimental-cc-routine-2026-04-01"
  exit 0
fi

echo "Triggering batch '${BATCH_ID}'..."

# -s silent, -S still show errors, -w writes status code at end on its own line.
HTTP_OUTPUT=$(curl -sS -w '\n__HTTP_STATUS__:%{http_code}' \
  -X POST "${ROUTINE_API_URL}" \
  -H "Authorization: Bearer ${ROUTINE_API_TOKEN}" \
  -H "anthropic-version: 2023-06-01" \
  -H "anthropic-beta: experimental-cc-routine-2026-04-01" \
  -H "Content-Type: application/json" \
  -d "${BODY}")

HTTP_STATUS=$(printf '%s\n' "${HTTP_OUTPUT}" | sed -n 's/^__HTTP_STATUS__://p' | tail -n 1)
HTTP_BODY=$(printf '%s\n' "${HTTP_OUTPUT}" | sed '/^__HTTP_STATUS__:/d')

echo "HTTP ${HTTP_STATUS}"
if [[ -n "${HTTP_BODY}" ]]; then
  echo "Response body:"
  echo "${HTTP_BODY}"
fi

case "${HTTP_STATUS}" in
  2*)
    echo "OK — Routine accepted the trigger. Watch Telegram for batch progress."
    exit 0
    ;;
  401|403)
    echo "ERROR: auth failed. Check ROUTINE_API_TOKEN value and that it matches ROUTINE_API_URL." >&2
    exit 4
    ;;
  404)
    echo "ERROR: 404 from API. Most likely cause: missing 'anthropic-beta: experimental-cc-routine-2026-04-01' header (this script sends it by default — check your local copy is up to date). Other possible cause: ROUTINE_API_URL points at a deleted/regenerated Routine." >&2
    exit 5
    ;;
  *)
    echo "ERROR: unexpected HTTP status. See response body above." >&2
    exit 6
    ;;
esac
