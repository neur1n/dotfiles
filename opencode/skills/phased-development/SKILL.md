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
  advisory review, maintains governance records, inspects outputs, proposes
  semantic commit messages, and performs read-only Git inspection.
- **Human:** reviews governance and implementation, confirms or changes scope,
  controls Git operations that alter repository state, and provides review
  feedback or authorization.

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

When work is intentionally deferred or simplified, record its ceiling and an
observable trigger for reconsideration in the owning governance record. Without
a trigger, treat it as an active risk or unresolved scope question.

## Layout

Use this layout for a new scaffold. When adapting an existing repository,
preserve canonical governance records in their established locations and map
them in `project.json` rather than creating duplicates. Keep `.project/` as the
discovery entry point and the root `AGENTS.md` as the pointer:

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

Create directories when first needed; do not add placeholders. Put new
governance tooling under `.project/script/`, separate from application code and
product tests; preserve existing canonical tooling locations. The generated
root `AGENTS.md` must load this skill. It may also contain project-specific
coding instructions, but must not replace or duplicate this skill.

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

1. Establish executable scope through the applicable governance process and
   human authorization.
2. Before drafting or revising a plan, read and follow `skeleton/plan.md`.
3. Use governance maintenance for governance changes.
4. Implement the authorized code scope, run applicable checks, inspect relevant
   output, inventory every changed path, and report the candidate scope.
5. Use implementation review for implementation changes.
6. After the human supplies review feedback or authorization, make only the
   corresponding governance updates.

Use an issue only when executable, deferred, blocked, or cross-session work
benefits from separate tracking. Use a decision for a durable technical or
process choice.

`STATE.md` is a bounded, replace-in-place navigation snapshot for one selected
execution frontier, not authority, an event log, or a second issue index. It
must not grow with project history. When creating or reconciling it, read and
follow `skeleton/state.md`; keep durable status, evidence, rationale, review
inventories, and completed history in their canonical records and Git.

## Governance Maintenance

Use this process for governance maintenance.

1. The agent prepares or revises governance and identifies the affected records
   and relevant evidence for human review.
2. The human reviews the result and provides feedback or authorizes a
   transition.
3. When feedback requires further work, the agent revises the content and
   identifies the resulting change for review again.
4. When the human authorizes a transition, the agent performs the corresponding
   governance maintenance and proposes a semantic commit message.
5. An authorization applies only to the reviewed scope and transition.
   Unrelated changes are not included silently.

## Implementation Review

Use this process for implementation changes.

1. The agent finishes the implementation, runs applicable checks, inspects
   relevant output, inventories changed paths, and reports scope, acceptance
   criteria, checks, risks, and limitations.
2. The human stages the intended implementation candidate, excluding pending
   governance changes, and runs `git write-tree`.
3. The human gives the agent the candidate tree ID.
4. The agent inspects that exact tree read-only and obtains its relevant base
   from Git state when possible. It checks changed paths against the reported
   implementation scope; if the base or candidate cannot be identified
   unambiguously, it asks the human rather than assuming one. If the staged
   scope is wrong, the human corrects it and supplies a new tree ID. The agent
   may record the tree ID in the appropriate governance record. The human
   reviews the candidate and provides feedback or authorization.
5. If the staged candidate changes after the tree ID was supplied, the human
   supplies a new tree ID. The agent treats the new identity as a new review
   round.
6. When the human authorizes the code transition, the agent provides a semantic
   code commit message. The human commits the candidate and may provide its
   hash. Otherwise, the agent locates the commit read-only, asking the human
   for its hash if it cannot identify the commit unambiguously.
7. The agent verifies read-only that the committed tree corresponds to the
   reviewed candidate, updates the relevant governance using the supplied
   evidence and decision, and provides a corresponding governance commit
   message. The human reviews, stages, and commits those governance updates
   separately.

A human may commit a candidate before final review feedback when external
testing requires it. That commit provides Git provenance but does not by itself
authorize governance maintenance. Later human feedback determines the next
transition. If the committed content differs from the supplied tree ID, it is a
different candidate and requires a new tree ID.

When this kernel does not cover an exceptional transition, ask the human rather
than inventing policy or approval.
