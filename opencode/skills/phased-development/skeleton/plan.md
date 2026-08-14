# Plan Skeleton

## Contract

The plan is authoritative for the active workstream's executable scope and
sequence. It must reference the roadmap and issue. Its default lifecycle is
`proposed`, `approved`, `active`, `completed`, `superseded`. Human plan review
is required for substantial work under the default bootstrap policy.

## Skeleton

```markdown
---
id: PLAN-0001
status: proposed
roadmap: ROADMAP-0001
phase: phase-1-<slug>
issue: ISSUE-0001
review: none
---

# Plan: <name>

## Objective

<What this plan will accomplish>

## Scope

### Included

- <included work>

### Excluded

- <deferred or prohibited work>

## Approach

1. <step>

## Affected Files And Interfaces

- <path or interface>

## Risks And Reversibility

- <risk and rollback>

## Verification

- <automated check>
- <human check, if required>

## Completion Evidence

- <filled after execution>
```
