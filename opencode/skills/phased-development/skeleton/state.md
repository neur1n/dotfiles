# `STATE.md`

## Contract

`STATE.md` is a bounded, replace-in-place navigation snapshot. It selects one
current execution frontier and points to canonical records; it does not retain
project history or duplicate issue, decision, review, test, or Git evidence.

Keep the objective to one to three sentences, the last completed list to one to
three meaningful transitions, and the next action to exactly one item. Include
only blockers and pending human actions that affect that next action, normally
no more than five of each, and no more than eight direct authority links.

The digest should normally fit within roughly 80 lines. Treat that size as a
review signal rather than a hard correctness limit. If more space appears
necessary, first move durable detail to its canonical record, remove stale
content, and check whether multiple execution frontiers need human selection.

## Skeleton

```markdown
# Current Project State

> Derived navigation only. Reconcile against canonical records before acting.

- Status: <status>
- Last reconciled: <date>
- Roadmap: <path>
- Current phase: <phase or none>
- Current plan: <path or none>
- Current issue: <path or none>

## Current Objective

<Current outcome>

## Last Completed

- <one to three recent meaningful transitions, or none>

## Next Action

- <one concrete action>

## Blockers

- <only blockers affecting the next action, or none>

## Pending Human Actions

- <only actions affecting the next action, or none>

## Relevant Authorities

- <direct path or ID needed for the current frontier, or none>
```
