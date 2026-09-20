#!/usr/bin/env bash
# Scaffold a repo's .github/ISSUE_TEMPLATE from this honeypot:
#   - the default trio (devops, scripts, docs) + config
#   - the hierarchy (feature, task)
#   - one epic per src/* folder
#   - a PULL_REQUEST_TEMPLATE.md
#   - manual ensure-epics / sync-labels callers
#
# Run once per repo, then forget it. Re-run with --force after adding folders.
#
# usage: scripts/scaffold-issue-templates.sh <repo-path> [--dry-run] [--force]
set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "${HERE}/.." && pwd)"
TPL="${ROOT}/templates"

TARGET=""
DRY=0
FORCE=0
for arg in "$@"; do
  case "$arg" in
    --dry-run) DRY=1 ;;
    --force) FORCE=1 ;;
    *) TARGET="$arg" ;;
  esac
done
TARGET="${TARGET:-$PWD}"

if [[ ! -d "$TARGET" ]]; then
  echo "not a directory: ${TARGET}" >&2
  exit 1
fi

IT="${TARGET}/.github/ISSUE_TEMPLATE"
WF="${TARGET}/.github/workflows"

copy() {
  local src="$1" dst="$2"
  if (( DRY )); then
    echo "would copy $(basename "$dst") -> ${dst}"
    return
  fi
  mkdir -p "$(dirname "$dst")"
  cp "$src" "$dst"
  echo "copied $(basename "$dst")"
}

for f in config devops scripts docs feature task; do
  copy "${TPL}/ISSUE_TEMPLATE/${f}.yml" "${IT}/${f}.yml"
done
copy "${TPL}/PULL_REQUEST_TEMPLATE.md" "${TARGET}/.github/PULL_REQUEST_TEMPLATE.md"

if [[ -d "${TARGET}/src" ]]; then
  while IFS= read -r dir; do
    name="$(basename "$dir")"
    file="${IT}/${name}.yml"
    if [[ -e "$file" && $FORCE -eq 0 ]]; then
      echo "skip (exists) ${name}.yml"
      continue
    fi
    title="📁 $(printf '%s%s' "$(printf '%s' "${name:0:1}" | tr '[:lower:]' '[:upper:]')" "${name:1}")"
    if (( DRY )); then
      echo "would generate ${name}.yml (${title})"
      continue
    fi
    cat >"$file" <<EOF
name: "${title} (epic)"
description: "Epic — owns src/${name}/."
title: "${title}"
labels: ["epic"]
body:
  - type: markdown
    attributes:
      value: |
        ## Epic — \`src/${name}/\`
        One epic per folder/domain. Consolidates related issues and is **never closed**.
  - type: textarea
    id: owns
    attributes:
      label: What this epic owns
      description: The scope — what belongs in \`src/${name}/\` and what does not.
    validations:
      required: false
  - type: textarea
    id: features
    attributes:
      label: Expected features
      description: Features you expect under this epic. Each becomes a sub-issue via the Feature template.
    validations:
      required: false
EOF
    echo "generated ${name}.yml"
  done < <(find "${TARGET}/src" -mindepth 1 -maxdepth 1 -type d | sort)
fi

write_caller() {
  local name="$1" reusable="$2"
  local file="${WF}/${name}.yml"
  if [[ -e "$file" && $FORCE -eq 0 ]]; then
    echo "skip (exists) ${name}.yml"
    return
  fi
  if (( DRY )); then
    echo "would write workflow ${name}.yml"
    return
  fi
  mkdir -p "$WF"
  cat >"$file" <<EOF
name: ${name}

on:
  workflow_dispatch:

permissions:
  contents: read
  issues: write

jobs:
  run:
    uses: skibiribab/.github/.github/workflows/${reusable}@main
EOF
  echo "wrote workflow ${name}.yml"
}

write_caller ensure-epics ensure-epics.yml
write_caller sync-labels sync-labels.yml

echo "done. review ${IT} and ${WF}"
