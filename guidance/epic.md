# 📁 Epic — level 1 (guidance)

An **epic** is a **folder/domain parent**. It consolidates every related issue and is **never closed**.

> This is **guidance**, not an issue template. Epics are usually created by the [`ensure-epics`](../.github/workflows/ensure-epics.yml) workflow or the [scaffold script](../scripts/scaffold-issue-templates.sh), one per major folder.

## Rules

- One epic per folder/domain (e.g. `src/food/`, `scripts/`, `docs/`).
- Every **feature** is a sub-issue of an epic.
- Never close an epic — it is the domain's permanent home.
- Title shape: `📁 <Folder>` for folder epics; `🐳 DevOps` / `⚙️ Scripts` / `📚 Docs` are the default epics on every repo.

## Example

```text
📁 Food            (epic)
└── ⭐ Diet plan    (feature)
    └── 🔨 Build weekly buy list (task)
```text

## Create

- Via the issue chooser: pick the folder epic (e.g. **Food**), or
- Recreate all missing epics manually: run the **Ensure epics** workflow (`workflow_dispatch`), or
- Locally: `scripts/ensure-epics.sh` against the repo.
