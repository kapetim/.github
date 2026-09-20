# Contributing

This repo (`skibiribab/.github`) is the **account honeypot**: the default community health files and the shared automations for every repo in the account.

## Model — one source per repo

The account keeps a **small, fixed set of repos** (`0–9`). Each repo is the **single source** for its domain. If something doesn't fit, it is **appended to an existing repo**, not given a new one. Adding an 11th repo is a red flag.

## Issue hierarchy — `epic → feature → task`

| Level | Label | Shape |
| --- | --- | --- |
| 1 | `epic` | a folder/domain parent; consolidates related issues; **never closed** |
| 2 | `feature` | belongs to exactly one epic; holds tasks |
| 3 | `task` | a single narrow execution item under one feature |

- Every **feature** is a sub-issue of an epic; every **task** is a sub-issue of a feature.
- Link children with GitHub **sub-issues** (not just text). Use `gh issue create --parent <n>` or `gh issue edit <parent> --add-sub-issue <n>`.
- Guidance: [`guidance/epic.md`](guidance/epic.md) · [`guidance/feature.md`](guidance/feature.md) · [`guidance/task.md`](guidance/task.md).

## Labels

`epic` · `feature` · `task` · `default` — created in this repo and in every repo that uses the templates.

- The **`default`** label marks issues that must exist on every repo and must **not** be deleted.
- Labels are **per-repo**: the `sync-labels` action ensures they exist before templates are used.

## Defaults vs override

- GitHub inherits issue templates, `CONTRIBUTING`, `CODE_OF_CONDUCT`, `SECURITY`, `SUPPORT`, `FUNDING`, and `PULL_REQUEST_TEMPLATE` from this repo **unless a repo defines its own** copy.
- A repo-local `.github/ISSUE_TEMPLATE/` (even just `config.yml`) **disables all inherited issue templates** for that repo. Prefer this only when the repo runs the scaffold script so it gets the full set.

## Scaffolding a repo

```sh
# from a clone of this repo
./scripts/scaffold-issue-templates.sh /path/to/repo   # --dry-run first
```

It writes the default trio (`devops`, `scripts`, `docs`), the hierarchy (`feature`, `task`), one **epic per `src/*` folder**, and the manual `ensure-epics` / `sync-labels` callers.

## Pull requests

- Keep them small and linked to an issue (`Closes #…`).
- Fill the [PR template](.github/PULL_REQUEST_TEMPLATE.md); don't introduce secrets or personal data.
- Make sure the repo's checks pass locally before opening.
