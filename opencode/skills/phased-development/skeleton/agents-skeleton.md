# `AGENTS.md` Skeleton

## Contract

Root `AGENTS.md` binds agents to the repository's workflow. It contains policy
and project-specific rules, not a duplicate roadmap or state digest. Existing
instructions must be preserved when this skeleton is merged into them.

## Skeleton

```markdown
# Agent Operating Contract

Before editing registered project work:

1. Read the workflow manifest, normally `.project/project.json`.
2. Read the manifest's `state` path as navigation, never authority.
3. Read the manifest's `roadmap` path and its `plan` path when it is not `null`.
4. Read the assigned local issue and its dependencies, when one exists.
5. Read only referenced decisions, reviews, and project-specific records.
6. Check the worktree and current code before making assumptions.

Before workflow administration, read the existing manifest and resume or create
the transient `.project/.setup/` record instead of selecting a project issue.

## Authority

- Roadmap: outcomes, phases, assumptions, and promotion gates.
- Plan: authorized execution scope and sequencing.
- Issue: local executable scope, acceptance criteria, and evidence.
- Decision: accepted durable choices and supersession.
- Review: human verdicts about exact candidates and transitions.
- The registered state digest: derived navigation only.
- `project.json`: discovery paths and format only.

## Roles

- Agent: implements authorized work, runs checks, prepares review material, and
  verifies candidate and commit identities.
- Authorized operator: stages the candidate and commits the accepted code.
- Reviewer: inspects the exact candidate and records the substantive disposition.
- Human authority: decides scope, contract, policy, phase, release, or Gate
  changes when those decisions are not delegated by policy.

These responsibilities remain distinct even when one person holds multiple
roles. Do not require separate people unless project policy requires them.

## Rules

For registered project work:

- Work only on an issue with status `ready` or `in_progress`.
- Move `proposed` to `ready` only after scope, criteria, plan, dependencies,
  and required authorization are complete.
- Resolve dependencies before execution.
- Obtain required human review before crossing a governed transition.
- Do not create a pre-review commit solely to freeze a candidate.
- The agent must not stage, commit, switch branches, or claim human approval.
- For Git-backed reviews, the authorized operator records the base revision,
  staged scope, and tree ID before the agent prepares the review packet.
- Any candidate-content change creates a new tree ID and requires the applicable
  review again. Verify the committed tree ID before finalizing the review.
- Use `.project/.setup/` for workflow administration; do not consume project
  IDs for installation, migration, or workflow maintenance.
- Keep optional recurring workflow-integrity tooling under `.project/script/`,
  not application source or product-test directories.
- Run governance-integrity checks separately from product tests and report their
  results separately. Do not create persistent tooling merely because the
  workflow is installed.
- Keep generated candidate packets, reports, and snapshot manifests or payloads
  in the ignored `.project/.review/<review-id>/` cache and remove them according
  to the review lifecycle. Git-tree reviews do not require a snapshot payload.
- Update issue evidence and the registered state digest after meaningful
  transitions.
- Do not silently change an accepted decision or compatibility contract.

For workflow administration, use `.project/.setup/`, direct user approval, and
no project issue, plan, decision, or review IDs. Delete the setup directory
after the operation.
```

Append project-specific technical, security, language, testing, and ownership
rules below this binding without changing its authority definitions.
