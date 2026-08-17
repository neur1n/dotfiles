---
name: phased-development
description: Use ONLY when the user requests phased development or repository instructions require it. Bootstrap, adapt, or operate the project workflow across sessions.
compatibility: opencode
metadata:
  category: development-workflow
---

# Phased Development

Use this skill only in one of these modes:

- **Bootstrap:** create the proposed workflow in a new, unmanaged workspace
  after the user explicitly requests it.
- **Adapt:** register an existing workflow after the user explicitly adopts
  this workflow; preserve existing governance files by default.
- **Operate:** resume and execute work in an established workflow.

Do not bootstrap or create governance merely because this skill is available.
Do not silently migrate existing governance. Ask when the repository does not
fit the workflow's registered authority model.

The workflow operates on the current execution frontier identified by
`project.json` and the registered state digest. If more than one active
frontier exists or the governing frontier is ambiguous, stop and ask which one
controls the current work. Do not silently merge or choose between frontiers.

## Authority Boundary

The user or an explicitly designated external authority governs workflow
administration. The workflow does not use its own project records to authorize
its installation, bootstrap, adaptation, migration, configuration, repair,
update, or removal.

Workflow administration uses transient `.project/.setup/` records and direct
user approval. It must not consume canonical project issue, plan, decision, or
review IDs. The final registry, binding instructions, and approved scaffold may
be committed as user-approved configuration, but no project review is required
to authorize the workflow itself.

The workflow governs registered project work and project authority: outcomes,
development scope, technical decisions, compatibility, gates, releases,
implementation evidence, and normal project reviews. If administration
discovers one of those effects, separate it from the administrative operation
and record it through the normal project workflow. Updating the global skill is
not a target project event; changing project policy or technical authority
because of it is.

Workflow administration may create transient coordination, snapshots, and
handoffs under `.project/.setup/`. These records use no canonical IDs, are
ignored by Git, and are deleted after successful or abandoned administration
unless the user explicitly opts to retain them outside the canonical workflow.

Project-review evidence has a separate transient cache under
`.project/.review/<review-id>/`. Candidate manifests, frozen payloads,
generated review packets, and machine reports belong there rather than beside
the tracked review record. The cache is ignored by Git and follows the
project-candidate lifecycle below; it is not workflow-administration state.

## Core Contracts

Use these meanings when creating or interpreting records:

| Record | Authority | Default lifecycle |
|---|---|---|
| `project.json` | Discovery paths, roles, and workflow format; never project decisions | active |
| `AGENTS.md` | Workflow policy, binding instructions, and project-specific rules | active |
| `STATE.md` | Derived current position and session navigation; never authority | derived |
| Roadmap | Outcomes, phases, assumptions, and promotion gates | proposed -> active -> completed, superseded, or cancelled |
| Plan | Authorized execution scope and sequencing for the active workstream | proposed -> approved -> active -> completed or superseded |
| Issue | Local executable work, dependencies, acceptance criteria, and evidence | proposed -> ready -> in_progress -> closed; `blocked` may interrupt |
| Decision | Durable technical or process choice, rationale, impact, and supersession | proposed -> accepted, rejected, or superseded |
| Review | Human judgment about registered project work and an exact candidate | pending -> approved, rejected, or superseded |

## Roles

Keep responsibilities distinct even when one person holds multiple roles:

- **Agent:** researches, implements authorized work, runs checks, prepares the
  review packet, and verifies candidate and commit identities.
- **Authorized operator:** controls candidate staging and the code commit.
- **Reviewer:** inspects the exact candidate and gives the substantive review
  disposition.
- **Human authority:** decides scope, contract, policy, phase, release, or Gate
  changes when those decisions are not delegated by policy.

The authorized operator, reviewer, and human authority may be the same person.
Record the responsibilities separately without requiring separate identities.
The agent must not stage, commit, switch branches, or claim human approval.

Record content is authoritative for its concern. Mutable metadata lives in
record frontmatter; do not duplicate status or verdict fields in the body.
`STATE.md` and `project.json` route agents to records; they do not override
them. Stable IDs and filenames do not encode mutable status.

A material roadmap change to outcomes, phases, assumptions, gates, or release
scope creates a new roadmap ID with `supersedes` pointing to the prior roadmap.
Obtain the required authority review before switching `project.json.roadmap` to
the successor, then mark the prior roadmap `superseded`. Minor editorial fixes
that do not change authority may remain in place.

When a record requires review, its `review` metadata points to the review ID or
path. The review points back to the target record. Keep both links
synchronized; do not rely on an index to discover a mandatory review.

Local issues are the default execution record even when a remote tracker
exists. An issue may record an external ID and explicitly declared remote
authority for priority, assignment, or public status, but agents must not
assume remote access or infer an external transition that they cannot verify.

For every record, use the corresponding file in `skeleton/` as the starting
contract and template. Read only the skeleton needed for the current operation.

## Bootstrap

Use Bootstrap only after the user explicitly asks to establish this workflow in
a workspace with no authoritative project workflow.

1. Inspect repository instructions, existing planning files, Git state, and the
   requested project objective. If authoritative governance exists, stop and
   use Adapt instead.
2. Create `.project/.gitignore` with `.setup/` and `.review/`, then use
   `.project/.setup/` for the administrative operation. Read
   `skeleton/setup.md` for its transient record shape. Prepare the proposed
   scaffold without committing it:

   ```text
   AGENTS.md
   .project/
     .gitignore
     project.json
     STATE.md
     roadmap/ROADMAP-0001.md
     plan/PLAN-0001.md       # when initial work is specified
     issue/ISSUE-0001.md       # when initial work is specified
     decision/                 # create on demand
     review/                   # create on demand
   ```

   Do not create a policy directory. Put the default workflow policy in
   `AGENTS.md`. Do not create empty placeholder records.
 3. Read the relevant skeleton files from `skeleton/` and make the generated
    records consistent with one another. Set `format_version` in
    `project.json`. If no initial work is specified, omit the plan and issue
    records, set `project.json.plan` to `null`, and use `none` for the current
    plan and issue in `STATE.md`. If initial work is specified, create proposed
    plan and issue records, point `project.json.plan` to the proposed plan, and
    link the current paths from `STATE.md`; neither is approved by workflow
    administration alone.
 4. Freeze the proposed scaffold as an administrative candidate under
    `.project/.setup/`. Use the setup record for direct user inspection; do not
    create a canonical review record or consume a project review ID.
 5. Wait for the user's direct acceptance. A recommendation, silence, or agent
    review is not acceptance. If the user requests changes, replace the setup
    candidate and record the new administrative state there.
 6. After acceptance, formalize the exact approved scaffold according to the
    user's Git and project-history policy. A plan or issue remains `proposed`
    until its own project authorization rules are satisfied. Remove
    `.project/.setup/` and its contents after successful formalization. Setup
    acceptance does not activate the roadmap or authorize project work. Future
    sessions use Operate; they do not repeat setup unless workflow authority
    changes.

If administration includes specified initial project work, create its normal
roadmap, plan, and issue records separately from `.project/.setup/`. Do not use
those records to describe the setup operation itself.

Bootstrap defaults are risk-based: small authorized work may proceed directly;
substantial work needs an approved plan before execution; authority, breaking
compatibility, phase, release, and policy changes require explicit human
review.

## Adapt

Use Adapt only after the user explicitly adopts this workflow or
repository instructions require it. Existing governance alone is not permission
to create the registry or modify instructions.

1. Preserve existing canonical records and paths. Do not move, rename, or
   rewrite them merely to match `.project/`.
2. Create or update `.project/.gitignore` with `.setup/` and `.review/`.
   Create `.project/project.json` as the skill's discovery entry point if
   absent. Register existing manifests, state digests, roadmaps, plans, issues,
   decisions, reviews, and external references by path or URL.
3. Create `.project/STATE.md` only when no equivalent digest exists. Otherwise
   register the existing digest and leave it authoritative for its scope.
 4. Add or extend `AGENTS.md` so future sessions read the registry and follow
    the registered authority model. Substitute registered paths into the
    binding; do not hard-code `.project/STATE.md` when the manifest points
    elsewhere. Preserve unrelated repository instructions.
5. Use local issue records for executable scope and evidence unless a remote
   tracker is explicitly verified as reliably available to the agent.

Use `.project/.setup/` for path mapping, migration notes, snapshots, and
handoffs. Physical migration into `.project/` is workflow administration and
does not create a canonical migration issue, plan, or review. Obtain direct
user approval before formalizing it, then remove `.project/.setup/`.

If migration also changes a project outcome, technical decision, compatibility
boundary, gate, release decision, or project policy, separate that effect and
record it as normal project work with the applicable durable review.

If the registry does not identify one current execution frontier, or if
authorities conflict, stop and report the ambiguity instead of inventing a
translation.

## Operate

When operating registered project work, skip absent layers and read in this
order:

1. Root `AGENTS.md` and other applicable repository instructions.
2. `.project/project.json` or the registered equivalent.
3. The manifest's `state` path as navigation only.
4. The current roadmap and active plan.
5. The active local issue and any resolved dependencies.
6. Referenced decisions, reviews, and project-specific records.
7. Current code, Git state, and required external reality checks.

Do not read all historical records by default. Read only records referenced by
the active work, required to resolve a dependency or contradiction, or
requested for historical context. Do not create a missing digest, issue,
decision, review, or index merely because this skill is loaded. Create a record
only when the workflow or current work requires it.

When maintaining the workflow itself, use `.project/.setup/` rather than
creating a project issue or review. Clean up abandoned setup records before
resuming ordinary project work.

Before editing, verify that the issue is `ready` or `in_progress`, its
dependencies are resolved, and the requested scope is authorized by the active
plan. Preserve partial authorization at the task or deliverable level.

Move an issue from `proposed` to `ready` only when its scope and acceptance
criteria are complete, its plan and dependencies are known, and the work is
authorized. Substantial work requires an approved plan review first. Small work
may use explicit user or project authorization. The agent may record this
transition but may not invent a required human authorization.

For small authorized work, make the change and record verification in the
issue. For substantial work, prepare the plan and obtain the required plan
review before execution. After implementation, record evidence and prepare
acceptance review when required. Do not close an issue without its acceptance
evidence.

Update the smallest correct set of records:

- implementation detail -> code and issue evidence;
- scope or sequencing -> plan and issue;
- durable choice -> decision and affected records;
- compatibility change -> affected specification or project record and
  consumers;
- gate or release change -> roadmap and required authority review;
- blocker or deferred discovery -> issue.

Reconcile the registered state digest after meaningful transitions and before
stopping substantial work. If it disagrees with a canonical record, the
canonical record wins.

## Human Review

An agent may research, plan, implement authorized work, verify automation, and
prepare review packets. It may not represent its own assessment as human
approval.

Human review is required before:

- accepting or superseding a durable decision;
- breaking compatibility or changing an accepted interface;
- changing roadmap scope, phase objectives, promotion gates, or policy;
- accepting a phase, release, or other authority-bearing transition; and
- executing substantial work when the active policy requires plan approval.

Use `skeleton/review.md` for plan, acceptance, or authority-change review of
registered project work. Use `skeleton/setup.md` for transient workflow
administration; it is not a project review record. Project review records must
name the target, scope, reviewer, approval provenance, verdict, conditions, and
exact transition authorized. Setup records use direct user approval as defined
by `skeleton/setup.md`.

For Git-backed work, read `reference/staged-tree-review.md` for the detailed
candidate-freeze procedure. The staged-tree identity is the default review
backend; the file-manifest snapshot remains available when Git cannot provide a
usable candidate identity.

## Candidate Identity

This procedure applies to registered project work and durable project reviews.
Workflow-administration candidates use `.project/.setup/` and direct user
approval instead; they do not enter the canonical review model.

Do not create a pre-review commit solely to freeze content. For the default
`git-tree-v1` backend, the reviewed candidate is identified by:

- the source repository and branch;
- the immutable base commit, or `EMPTY_TREE` for a root candidate;
- the approved path scope; and
- the tree ID produced from the complete staged candidate with `git write-tree`.

The authorized operator stages the candidate and records this identity. Staging
freezes the candidate for review; it does not imply acceptance. The agent
prepares the packet only after the identity is recorded and must not modify the
candidate while preparing it. Any candidate-content change creates a new tree
ID and requires the appropriate review again.

Immediately before the code commit, recompute the staged tree ID. After the
commit, verify that the commit parent is the recorded base and `HEAD^{tree}` is
the reviewed tree ID. A mismatch invalidates acceptance for the actual content.
The tree ID identifies content, not test results, human judgment, or Gate
success; record those separately. Governance-only edits are not part of the
implementation candidate and are committed through the governance transition.

For `git-tree-v1`, no candidate payload or manifest is required by default.
Keep the review packet, command output, and optional archive under the ignored
`.project/.review/<review-id>/` cache. For `snapshot-v1`, store the exact
payload and deterministic compact manifest in that cache, using the snapshot
contract in `skeleton/review.md`. Compact JSON applies only to that machine
manifest.

Keep transient candidate material while a review is pending and until an
approved transition has been formalized and verified. For a rejected,
superseded, or abandoned review, remove it once no resubmission or appeal
depends on it. Retain the tracked `REVIEW-*.md` record with its candidate
identity, evidence, verdict, conditions, and formalized commit. If long-term
byte-level retention is required, archive the material outside the canonical
workflow and record that explicit choice.

## Integrity And Handoff

Before closing governed work or advancing a gate, check applicable items:

- record metadata and referenced paths agree;
- dependencies and authorization boundaries are satisfied;
- evidence belongs to the reviewed candidate;
- required human verdicts have provenance and the exact target identity;
- deferred work has a local issue; and
- recorded status agrees with code and Git state.

Use the repository's health command if one exists; otherwise perform a small
equivalent check. A failed check blocks the governed transition.

## Optional Governance Tooling

A project may keep a reusable workflow-integrity validator under
`.project/script/` when repeated checks justify maintaining one. This tooling
is governance infrastructure, not application source and not a product test.
Run it separately from product tests and report the results separately. Do not
create a persistent validator merely because this skill is installed; one-off
checks may remain session-local or use external tooling. Generated validator
reports belong in the relevant transient `.project/.review/<review-id>/` or
`.project/.setup/` cache, not beside the script.

Create one temporary handoff only when substantial project work stops before a
clean record boundary. Include current issue and task, completed and remaining
work, decisions, blockers, pending human actions, modified files, candidate
identity, verification, and the first resume action. On resume, validate it
against canonical records and Git state, move durable facts into those records,
and retire the handoff.

For workflow administration, put the handoff under `.project/.setup/` instead.
Delete the setup directory after successful or abandoned administration unless
the user explicitly opts to retain its contents outside the canonical workflow.
