# Roadmap Skeleton

## Contract

The roadmap is authoritative for project outcomes, phases, assumptions, and
promotion gates. It does not contain implementation evidence or replace the
active plan. Its default lifecycle is `proposed`, `active`, `completed`,
`superseded`, or `cancelled`. A material revision creates a new roadmap ID with
`supersedes` pointing to the prior roadmap; accepted roadmaps are not silently
rewritten.

## Skeleton

```markdown
---
id: ROADMAP-0001
status: proposed
project: <project-name>
supersedes: none
review: none
---

# Roadmap: <project-name>

## Outcome

<What the project must deliver and why>

## Success Criteria

- <observable project-level result>

## Phases

### Phase 1: <name>

- Objective: <phase outcome>
- Gate: <condition required before promotion>
- Dependencies: none
- Status: proposed

## Assumptions

- <management, resource, compatibility, or scope assumption>
```
