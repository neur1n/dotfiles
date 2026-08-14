# Issue Skeleton

## Contract

The local issue is the agent-readable execution record, even when an external
tracker exists. It owns local scope, dependencies, acceptance criteria, and
evidence. Its default lifecycle is `proposed`, `ready`, `in_progress`, `blocked`,
`closed`. An external ID is a reference, not proof of remote availability.

## Skeleton

```markdown
---
id: ISSUE-0001
status: proposed
priority: <priority>
roadmap: ROADMAP-0001
phase: phase-1-<slug>
plan: PLAN-0001
blocked_by: []
external_id: none
review_required: false
review: none
---

# Issue: <short title>

## Intended Result

<Observable result>

## Scope

- Included: <work>
- Excluded: <deferred work>

## Acceptance Criteria

- <criterion>

## Verification Evidence

- <command, result, environment, and candidate identity>

## Deviations And Deferred Work

- <deviation or none>
```
