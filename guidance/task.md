# 🔨 Task — level 3 (guidance)

A **task** belongs to exactly one **feature** and is a **single, narrow execution item**. If it needs two outcomes, split it.

> Guidance, not a template. Create tasks with the **Task** issue form where available, then link them as sub-issues of the feature.

## Rules

- Exactly one feature parent — link it with a real **sub-issue** relationship.
- One narrow action.
- A concrete **Done when** signal.

## Example

```text
📁 Food               (epic)
└── ⭐ Diet plan       (feature)
    └── 🔨 Build weekly buy list  (task)   ← you are here
```text

## Create

1. Choose the **Task** form (title `🔨 …`).
2. Set the **Feature (parent)** field.
3. Add it as a sub-issue: `gh issue edit <feature> --add-sub-issue <task>`.
