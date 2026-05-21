#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat >&2 <<'USAGE'
Usage:
  scripts/codex-trusted-checkpoint.sh <batch_id> <message>
  scripts/codex-trusted-checkpoint.sh --allow-deletes <batch_id> <message>
USAGE
}

fail() {
  printf 'ERROR: %s\n' "$*" >&2
  exit 1
}

allow_deletes=false

if [[ "${1:-}" == "--allow-deletes" ]]; then
  allow_deletes=true
  shift
fi

if [[ "$#" -ne 2 ]]; then
  usage
  exit 2
fi

batch_id="$1"
commit_message="$2"

[[ -n "$batch_id" ]] || fail "batch id is required"
[[ -n "$commit_message" ]] || fail "commit message is required"

git rev-parse --is-inside-work-tree >/dev/null 2>&1 || fail "not inside a Git work tree"

repo_root="$(git rev-parse --show-toplevel)"
cd "$repo_root"

mapfile -d '' changed_files < <(
  {
    git diff --name-only -z HEAD --
    git ls-files --others --exclude-standard -z
  } | sort -zu
)

if [[ "${#changed_files[@]}" -eq 0 ]]; then
  fail "no changes to commit"
fi

git diff --check

is_high_risk_path() {
  local path="$1"
  local lower
  lower="$(printf '%s' "$path" | tr '[:upper:]' '[:lower:]')"

  [[ "$lower" =~ (^|/)\.env(\.|$) ]] && return 0
  [[ "$lower" =~ (^|/)\.ssh(/|$) ]] && return 0
  [[ "$lower" =~ (^|/)secrets(/|$) ]] && return 0
  [[ "$lower" =~ secret|token|credential|password ]] && return 0
  [[ "$lower" =~ deploy|server|ssh|scp ]] && return 0

  return 1
}

printf 'Changed files:\n'
for path in "${changed_files[@]}"; do
  printf '  %s\n' "$path"

  if is_high_risk_path "$path"; then
    fail "high-risk path rejected: $path"
  fi
done

mapfile -d '' deleted_files < <(git diff --name-only -z --diff-filter=D HEAD --)

if [[ "${#deleted_files[@]}" -gt 0 && "$allow_deletes" != true ]]; then
  printf 'Deleted files rejected:\n' >&2
  for path in "${deleted_files[@]}"; do
    printf '  %s\n' "$path" >&2
  done
  fail "deleted files are blocked unless --allow-deletes is provided"
fi

git add -- "${changed_files[@]}" || fail "git add failed"

if git diff --cached --quiet; then
  fail "no staged changes after validation"
fi

git commit -m "[batch:${batch_id}] ${commit_message}" || fail "git commit failed"
commit_sha="$(git rev-parse HEAD)"

if git push origin HEAD; then
  push_status="pushed"
else
  push_status="failed"
  printf 'ERROR: git push origin HEAD failed\n' >&2
  exit 1
fi

printf '\nTrusted checkpoint complete.\n'
printf 'Commit: %s\n' "$commit_sha"
printf 'Push status: %s\n' "$push_status"
