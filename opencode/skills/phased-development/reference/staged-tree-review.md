# Staged-Tree Review

This reference defines the Git-backed candidate routine used by
`phased-development`. It freezes a candidate for review without creating a
pre-review commit. The staged tree identifies the content; it does not
represent human acceptance.

## Roles

- **Agent:** implements authorized work, runs checks, prepares the packet, and
  verifies candidate and commit identities.
- **Authorized operator:** controls staging, the tree identity, and the code
  commit.
- **Reviewer:** inspects the exact candidate and records the substantive
  disposition.
- **Human authority:** decides scope, contract, policy, phase, release, or Gate
  changes when those decisions are not delegated by policy.

One person may hold several roles. The workflow separates responsibilities, not
necessarily people. The agent does not stage, commit, switch branches, or claim
human approval.

## Candidate Identity

For a Git-backed candidate, record all of the following in the review record:

- source repository path or stable identifier;
- current branch name for navigation;
- base commit, or `EMPTY_TREE` for a root candidate;
- approved implementation scope;
- exact staged path list; and
- the tree ID produced by `git write-tree`.

The tree ID is the hash of the complete staged index tree. It is the candidate
identity used for review and later compared with `HEAD^{tree}`. The branch name
is descriptive; the base commit and tree ID are authoritative.

The tree ID does not identify tests, external artifacts, runtime state, human
judgment, or Gate status. Record those as separate evidence and decisions.

## Routine

### 1. Confirm Scope And Baseline

Before implementation, confirm the approved plan, acceptance criteria, source
repository, branch, base commit, permitted paths, and required checks. Do not
switch branches during this routine. If the branch or base changes, stop and
start a new candidate.

If the repository has no usable base commit, use `EMPTY_TREE` with an explicit
root-commit rule or use the `snapshot-v1` backend. Do not invent a parent
commit.

### 2. Implement And Verify

The agent implements the authorized scope and runs the permitted tests and
checks. Changes remain unstaged during implementation.

Run formatting, code generation, migrations, and other commands that can alter
candidate files before freezing the candidate. Packet generation must not alter
the worktree or index.

### 3. Classify All Changes

The authorized operator reviews every modified, deleted, and untracked path,
including pre-existing staged paths. Classify each path as:

- included implementation content;
- excluded unrelated or concurrent work;
- excluded generated or temporary output;
- excluded secret or local-only material; or
- an explicit governance-only change for a later governance commit.

The candidate scope must be complete and must not silently absorb unrelated
staged work. Mutable review records, `.project/.review/`, and governance-only
drafts are excluded unless the approved scope explicitly says otherwise.

### 4. Prepare The Candidate Index

The normal index may be used only when it contains no unrelated staged changes.
If the worktree has unrelated staged work, do not unstage it merely to make
this review convenient. Use a temporary candidate index initialized from the
base, or obtain an explicit decision about the conflicting staged state.

An alternate index must be used consistently for staging, tree creation, and
the eventual code commit. Its location and cleanup belong to the transient
review cache, not the durable review record.

### 5. Stage The Candidate

Only the authorized operator stages the complete intended candidate. Verify the
staged scope and content before freezing it. Useful checks include:

```text
$ git status --short --untracked-files=all
$ git diff --cached --name-status
$ git diff --cached --check
$ git ls-files --stage
```

Staging is a candidate declaration. It is not approval and it is not a commit.

### 6. Freeze The Candidate Identity

With the intended candidate staged, create the Git tree object:

```text
git write-tree
```

Record the resulting tree ID together with the repository, branch, base commit,
scope, staged path list, checks already run, and known limitations. `git
write-tree` writes an immutable tree object; it does not commit the candidate
or prevent later index changes. If the index changes, the recorded identity no
longer describes the current candidate.

### 7. Prepare The Review Packet

After the operator records the candidate identity, the agent prepares the
packet under `.project/.review/<review-id>/`. For a Git-tree candidate, inspect
the exact tree rather than the mutable worktree:

```text
$ git diff <base-commit> <tree-id>
$ git diff --stat <base-commit> <tree-id>
$ git ls-tree -r --name-only <tree-id>
```

The packet should identify the candidate tree, acceptance criteria, relevant
diff, checks and environments, risks, limitations, missing evidence, and
questions requiring human judgment. Packet generation is read-only. If it
changes candidate content, return to implementation and create a new tree ID.

### 8. Perform The Substantive Review

The reviewer evaluates the exact recorded tree, the acceptance criteria, the
automated evidence, risks, and unresolved questions. The disposition may be
accepted, changes required, blocked, deferred risk, or rejected finding.

One substantive review is sufficient when the committed tree is later proven to
be identical to the reviewed tree and the parent is the recorded base.

### 9. Handle Findings

Code or test changes produce a revised staged candidate and a new tree ID. The
affected scope is reviewed again; broad changes may require a full review.

Missing evidence may leave the same tree pending if no candidate content
changes. Packet-only changes do not require a new candidate identity.

Contract ambiguity, scope changes, or an unexpected tree-ID change stop the
routine until the authorized human makes the required decision.

### 10. Confirm Acceptance Identity

After substantive acceptance and immediately before the code commit, the
authorized operator recomputes the staged tree ID. It must equal the recorded
reviewed tree ID. If it differs, acceptance does not apply to the current
content.

### 11. Commit The Code

The authorized operator commits the accepted staged tree. Governance drafts,
review packets, and ignored cache files must not be accidentally included in
the code commit.

Commit hooks must not silently rewrite accepted content. A hook that changes
the index or worktree requires identity verification and may require renewed
review.

### 12. Bind The Review To The Commit

After committing, the agent verifies mechanically:

```text
$ git rev-parse HEAD
$ git rev-parse HEAD^{tree}
$ git rev-parse HEAD^     # omit for a root commit
$ git diff-tree --no-commit-id --name-status -r HEAD
$ git status --short --untracked-files=all
```

The checks must establish that:

- `HEAD^{tree}` equals the accepted tree ID;
- the commit parent equals the recorded base, unless this is a root commit;
- the committed path set is the expected candidate scope; and
- remaining worktree changes are absent or explicitly explained.

A mismatch requires investigation and review of the actual committed content.
It is not silently repaired by changing the review record.

### 13. Finalize Governance

The durable review record records the code commit, reviewed tree ID, reviewer
disposition, checks, findings, limitations, and remaining evidence. Update
implementation status only for the accepted scope. Keep implementation,
evidence, review, and Gate status separate; implementation may be `DONE` while
runtime evidence remains `PROPOSED`.

The authorized operator then reviews and commits the governance changes. That
governance commit closes the development or review record; it does not by
itself accept a phase or Gate.

### 14. Clean Up Review Cache

After an accepted code commit is identity-verified, delete the transient
packet, reports, and any optional archive under
`.project/.review/<review-id>/`. Delete the same cache after a rejected,
superseded, or abandoned review when no resubmission or appeal depends on it.
Retain the durable `REVIEW-*.md` record.

If byte-level retention of a pre-commit candidate is required, archive it
outside the canonical review directory and record that explicit decision.

## Snapshot Fallback

Use `snapshot-v1` when the candidate is not represented by a usable Git tree,
when the source is not Git-backed, or when an independently reconstructible
pre-commit payload is required. Store its deterministic compact manifest and
exact payload under `.project/.review/<review-id>/` and follow the same review,
formalization, and cleanup lifecycle. The snapshot digest replaces the tree ID
as the candidate identity; the review responsibilities do not change.
