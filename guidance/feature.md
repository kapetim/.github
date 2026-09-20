# ⭐ Feature — level 2 (guidance)

A **feature** belongs to exactly one **epic** and holds **tasks**.

> Guidance, not a template. Create features with the **Feature** issue form where available, then link them as sub-issues of the epic.

## Rules

- Exactly one epic parent — link it with a real **sub-issue** relationship.
- Describe *what* the feature is and *why* it exists.
- State acceptance at the feature level.
- List the narrow tasks you expect — each becomes a task sub-issue.

## Example

```text
📁 Food               (epic)
└── ⭐ Diet plan       (feature)   ← you are here
    ├── 🔨 Build weekly buy list  (task)
    └── 🔨 Reconcile registry 1:1 (task)
```text

## Create

1. Choose the **Feature** form (title `⭐ …`).
2. Set the **Epic (parent)** field.
3. After creating, add it as a sub-issue: `gh issue edit <epic> --add-sub-issue <feature>`.
