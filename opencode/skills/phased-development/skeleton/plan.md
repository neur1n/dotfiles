# Plan

## Contract

An approved plan is authoritative for one bounded active workstream's
executable scope and sequence. It may coordinate multiple issues only when they
share one objective and require one coordination sequence and plan review. Its
size may reflect the current workstream's complexity, but it must not become a
phase history, issue index, or append-only evidence log. There is no universal
line budget.

Keep record ownership distinct:

- the plan owns cross-issue scope, sequence, coordination, plan-level risks,
  and verification;
- issues own local implementation, acceptance criteria, blockers, and detailed
  evidence;
- decisions own durable technical or process choices;
- the roadmap owns outcomes, phases, and promotion gates; and
- reviews own candidate identity, findings, verdicts, and authorized
  transitions.

Reference those records instead of copying their content. Do not append issue
implementation details, per-commit results, or review history to preserve
context.

The default lifecycle is `proposed -> approved -> active -> completed`, with
`superseded` available when a successor replaces the plan. Revise a plan in
place only while its objective, workstream boundary, and approval basis remain
the same. Use a separate plan when work can be scoped, authorized, executed,
and reviewed independently; a different objective, owner, execution sequence,
or plan-review boundary is a split signal, not an automatic rule. Use a
successor when the governing objective or sequence materially changes. Do not
remove approved scope merely to shorten an authoritative plan; complete or
supersede it at a clean boundary.

Fill `Completion Evidence` only with the plan-level outcome and links needed to
close or supersede the plan, not an event-by-event or issue-by-issue history.

## Skeleton

```markdown
---
id: PLAN-0001
status: proposed
roadmap: ROADMAP-0001
phase: phase-1-<slug>
issue: []
review: none
---

# Plan: <name>

## Objective

<Result this plan will produce>

## Scope

- Included: <work>
- Excluded: <work>

## Step

1. <implementation step>

## Affected File Or Interface

- <path or interface>

## Risk And Reversibility

- <risk and recovery>

## Verification

- <mechanical check>

## Completion Evidence

- <plan-level outcome and links, filled at completion>
```
