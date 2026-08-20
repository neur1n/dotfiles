---
name: phased-development
description: 'Use ONLY when the user asks to establish, adapt, or use phased development, or when `.project/project.json` declares `"workflow": "phased-development"`. Scaffold and operate a human-reviewed Git workflow across sessions.'
compatibility: opencode
metadata:
  category: development-workflow
---

# Phased Development

A Git repository is required. Use the files under `skeleton/` as defaults, then
follow explicit user instructions when the project needs something different.

## Authority

The human has final authority and may amend, stage, commit, or override
recommendations. State a concrete risk once when necessary, but do not obstruct
an explicit human action. An override does not delegate human-only Git
operations to the agent or permit fabricated approval or evidence.

- **Agent:** scaffolds, plans, implements, tests, inventories changes, performs
  advisory review, prepares review packets, inspects outputs, proposes semantic
  commit messages, and verifies Git identity read-only.
- **Human:** reviews plans and implementations, confirms scope, controls
  staging, records tree IDs, gives dispositions, and commits.

The agent must not stage, unstage, update the index, run `git write-tree`,
commit, amend, push, or alter branches, tags, refs, or history.

## Layout

Keep governance under `.project/`, except for the root discovery pointer:

```text
.project/
  .review/      # ignored temporary review material
  .setup/       # optional ignored setup scratch space
  decision/
  issue/
  plan/
  review/
  roadmap/
  script/       # optional governance tooling
  .gitignore
  project.json
  STATE.md
AGENTS.md
```

Create directories when first needed; do not add placeholders. Keep governance
tooling under `.project/script/`, separate from application code and product
tests. The root `AGENTS.md` only points to this skill, `project.json`, and
`STATE.md`.

## Setup

Set up new or existing repositories with the same general procedure:

1. Inspect repository instructions, existing governance, project intent, and
   Git state.
2. Use the skeletons as defaults and create or reconcile the complete scaffold
   in one pass according to the user's instruction. Preserve unrelated content.
3. For a new scaffold, create `.project/.gitignore`, `project.json`,
   `STATE.md`, an initial roadmap, and the root `AGENTS.md` pointer. Create
   other records only when needed.
4. Make reversible assumptions and report them together. Do not ask serial
   preference questions; ask only when an essential objective is missing or a
   choice would destructively overwrite existing authority.
5. Use `.project/.setup/` only when temporary setup notes are useful. It has no
   required schema or lifecycle.
6. Present the complete result, verification, assumptions, and risks. The human
   reviews, stages, and commits it.

## Work Loop

1. Read `project.json`, `STATE.md`, the current roadmap and plan, relevant
   local records, current code, and Git state.
2. Draft or revise the plan and run the exact-tree review. The human commits
   the approved plan and its governance before implementation begins.
3. Implement the approved scope, run applicable checks, inspect relevant
   output, inventory every changed path, and propose candidate scope.
4. Run the exact-tree review for the implementation.

Use an issue only when executable, deferred, blocked, or cross-session work
benefits from separate tracking. Use a decision for a durable technical or
process choice. `STATE.md` is derived navigation, not authority.

## Exact-Tree Review

1. The agent proposes scope, acceptance criteria, checks, risks, and
   limitations.
2. The human confirms scope, stages the complete candidate, runs `git
   write-tree`, and records the base commit, tree ID, and staged paths.
3. The agent prepares `.project/.review/<review-id>/packet.md` from that tree.
   The packet includes the check results, risks, unresolved questions, and how
   the human should inspect relevant output, including expected and failure
   signals.
4. The human approves, requests changes, rejects, or abandons the candidate.
   Candidate-content changes require a new tree ID and renewed review.
5. Before an approved commit, the agent verifies read-only that the base and
   index still match the reviewed candidate and proposes a semantic commit
   message. The human commits.
6. The agent verifies the committed tree, records the commit and disposition in
   the durable review, updates the smallest correct set of records, and
   reconciles `STATE.md`. The human commits governance. Remove the temporary
   packet when it is no longer needed.

When this kernel does not cover an exceptional transition, ask the human rather
than inventing policy or approval.
