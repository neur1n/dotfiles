# Decision Skeleton

## Contract

The decision records one durable technical or process choice, alternatives,
rationale, impact, and supersession. It is not an issue or implementation log.
Its default lifecycle is `proposed`, `accepted`, `rejected`, `superseded`.
Accepted decisions are not silently edited; a later decision names the earlier
ID in `supersedes`.

## Skeleton

```markdown
---
id: DECISION-0001
status: proposed
date: <date>
supersedes: none
review: none
---

# Decision: <short title>

## Context

<Problem or choice requiring a durable decision>

## Options Considered

1. <option and tradeoff>

## Decision

<Chosen option>

## Rationale

<Why this option was selected>

## Consequences

- <compatibility, migration, operational, or scope impact>

## Affected Records And Consumers

- <path, ID, or consumer>
```
