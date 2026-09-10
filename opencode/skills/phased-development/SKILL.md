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
  advisory review, inspects outputs, proposes semantic commit messages, and
  verifies Git identity read-only.
- **Human:** reviews plans and implementations, confirms scope, controls
  staging, records tree IDs, gives dispositions, and commits.

The agent must not stage, unstage, update the index, run `git write-tree`,
commit, amend, push, or alter branches, tags, refs, or history.

## Record History

Use Git and the canonical record that owns a fact as the default history. Keep
`project.json`, `STATE.md`, and indexes focused on discovery or navigation; do
not use them as historical snapshot stores or copy canonical acceptance
evidence into them. Put durable choices, scope history, implementation
evidence, and review verdicts in the owning decision, plan, issue, or review.
Add a project-specific snapshot only for a stated retention or query need, with
its authority, retention, and read path defined by the project.

## Layout

Keep governance under `.project/`, except for the root discovery pointer:

```text
.project/
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
tests. The root `AGENTS.md` only loads this skill. Independent repository
instructions may remain there, but must not define or complete this workflow.

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

## Context Selection

Choose the context target before reading workflow records. An artifact, path,
identifier, workstream, or scope explicitly named by the human is the target
for that request. Use `project.json` and `STATE.md` to find the default
frontier only when no target is named. A request for current project status,
session resumption, or a project-wide next step selects that default frontier
and reads `project.json` and `STATE.md`. Selecting another target does not
update the persisted frontier.

For questions, exploration, and design discussion, start from the explicit
target and read only what is needed to answer; do not load the execution
frontier by default. For implementation, read `project.json`, `STATE.md`, Git
state, affected code, and any plan or issue that governs the request. For a
governance change or session resumption, read `project.json`, `STATE.md`, Git
state, and the selected governance records; read code only when needed to
verify a claim. Do not also read the manifest's plan when an explicit target
belongs to another workstream unless a concrete coordination or authority
conflict requires it. Read a roadmap only for a roadmap-owned concern, such as
an outcome, phase, gate, resource assumption, or cross-workstream coordination.

Treat references and dependencies as candidates, not required reading. Query an
optional index only when it can resolve the current target or answer the
current request, and inspect only matching entries. Do not enumerate record
directories or traverse unrelated workstreams or transitive references by
default. Historical records, including closed issues, completed or superseded
plans, superseded decisions, past reviews, old roadmaps, and Git history, are
also excluded by default. Read one when the human names it or a concrete need
for its content exists, such as authority, evidence, provenance, regression,
audit, rollback, or reconciliation. Accepted decisions and current versioned
contracts remain authority when applicable.

Stop reading when the available evidence is sufficient. For a large file,
locate relevant sections before reading them, and do not reread ranges already
in context. Prefer compact routing or status results over full record content.

## Work Loop

Use this loop for implementation and governance transitions after selecting the
context above:

1. Confirm that the selected workstream has human-approved executable scope.
2. Before drafting or revising a plan, read and follow `skeleton/plan.md`, then
   run the exact-tree review. The human commits the approved plan and its
   governance before implementation begins.
3. Implement the approved scope, run applicable checks, inspect relevant
   output, inventory every changed path, and propose candidate scope.
4. Run the exact-tree review for the implementation.

Use an issue only when executable, deferred, blocked, or cross-session work
benefits from separate tracking. Use a decision for a durable technical or
process choice.

`STATE.md` is a bounded, replace-in-place navigation snapshot for one selected
execution frontier, not authority, an event log, or a second issue index. It
must not grow with project history. When creating or reconciling it, read and
follow `skeleton/state.md`; keep durable status, evidence, rationale, review
inventories, and completed history in their canonical records and Git.

## Exact-Tree Review

1. The agent proposes scope, acceptance criteria, checks, risks, and
   limitations.
2. The human confirms scope, stages the complete candidate, runs `git
   write-tree`, and records the base commit, tree ID, and staged paths.
3. The human reviews, approves, requests changes, rejects, or abandons the
   candidate. Candidate-content changes require a new tree ID and renewed
   review.
4. Before an approved commit, the agent verifies read-only that the base and
   index still match the reviewed candidate and proposes a semantic commit
   message. The human commits.
5. The agent verifies the committed tree, records the commit and disposition in
   the durable review, updates the smallest correct set of records, and
   reconciles `STATE.md`. The human commits governance.

When this kernel does not cover an exceptional transition, ask the human rather
than inventing policy or approval.
