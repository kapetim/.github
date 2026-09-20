#!/usr/bin/env bash
# Ensure one epic issue exists per major folder (plus the default trio).
# Idempotent: running it again only creates what is missing.
#
# usage: [REPO=owner/name] bash scripts/ensure-epics.sh [--dry-run]
set -euo pipefail

REPO="${REPO:-${GITHUB_REPOSITORY:-}}"
DRY_RUN=0
[[ "${1:-}" == "--dry-run" ]] && DRY_RUN=1

if [[ -z "$REPO" ]]; then
  echo "REPO (owner/name) is required" >&2
  exit 1
fi

cap_first() {
  printf '%s%s\n' "$(printf '%s' "${1:0:1}" | tr '[:lower:]' '[:upper:]')" "${1:1}"
}

declare -a TITLES=("🐳 DevOps" "⚙️ Scripts" "📚 Docs")

if [[ -d src ]]; then
  while IFS= read -r dir; do
    TITLES+=("📁 $(cap_first "$(basename "$dir")")")
  done < <(find src -mindepth 1 -maxdepth 1 -type d 2>/dev/null | sort)
fi

echo "Repo: ${REPO}"
echo "Expected epics: ${#TITLES[@]}"

existing="$(gh issue list --repo "$REPO" --state all --label epic --limit 500 --json title --jq '.[].title' 2>/dev/null || true)"

created=0
for title in "${TITLES[@]}"; do
  if grep -qxF "$title" <<<"$existing"; then
    echo "  ok      ${title}"
    continue
  fi
  if (( DRY_RUN )); then
    echo "  create? ${title}"
    continue
  fi
  gh issue create --repo "$REPO" --title "$title" --label epic \
    --body "Folder/default epic. One epic per domain; consolidates related issues and is **never closed**. Children are features; features hold tasks." >/dev/null
  echo "  created ${title}"
  created=$((created + 1))
done

echo "Created: ${created}"
