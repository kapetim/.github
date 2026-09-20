#!/usr/bin/env bash
# Ensure the standard labels exist (create or update, never delete).
#
# usage: [REPO=owner/name] bash scripts/sync-labels.sh
set -euo pipefail

REPO="${REPO:-${GITHUB_REPOSITORY:-}}"
if [[ -z "$REPO" ]]; then
  echo "REPO (owner/name) is required" >&2
  exit 1
fi

upsert() {
  local name="$1" color="$2" desc="$3"
  if gh api "repos/${REPO}/labels/${name}" >/dev/null 2>&1; then
    gh api -X PATCH "repos/${REPO}/labels/${name}" -f color="$color" -f description="$desc" >/dev/null
    echo "  updated ${name}"
  else
    gh api -X POST "repos/${REPO}/labels" -f name="$name" -f color="$color" -f description="$desc" >/dev/null
    echo "  created ${name}"
  fi
}

echo "Repo: ${REPO}"
upsert epic    6E2594 "Level 1 — folder/domain parent; never closed."
upsert feature 0E8A16 "Level 2 — a feature under an epic; holds tasks."
upsert task    1D76DB "Level 3 — a single narrow execution item under a feature."
upsert default FBCA04 "Default issue — must exist on every repo and must not be deleted."
