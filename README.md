# .github

Default community health files for **skibiribab** — the honeypot of issue templates shared by every repo in the account.

GitHub reads issue templates only from `.github/ISSUE_TEMPLATE/` (flat), so the two groups are separated by filename prefix.

## 🪜 Hierarchy — how to parent

| Template | Label | Level |
| --- | --- | --- |
| `01-epic.yml` | `epic` | 1 — folder / domain |
| `02-feature.yml` | `feature` | 2 — feature |
| `03-task.yml` | `task` | 3 — task |

**Rule:** `epic → feature → task`. Every **feature** is a sub-issue of an epic; every **task** is a sub-issue of a feature.

Example: `🎨 UI` (epic) → `login page` (feature) → `build form` (task).

## 📦 Default issues — exist on every repo

| Template | Labels | Area |
| --- | --- | --- |
| `10-devops.yml` | `epic` + `default` | `.github/` + `Dockerfile` — linting, CI, deploy, usage |
| `11-scripts.yml` | `epic` + `default` | `scripts/` — code automation |
| `12-docs.yml` | `epic` + `default` | `docs/` — documentation |

The **`default`** label marks issues that must exist on every repo and must **not** be deleted.

## 🏷️ Labels

`epic` · `feature` · `task` · `default` — created in this repo and in every repo where the templates are used.
