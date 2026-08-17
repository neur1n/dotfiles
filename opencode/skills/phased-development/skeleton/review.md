# Review Skeleton

## Contract

The review records a human judgment about an exact target and candidate. Use
one record type: `plan`, `acceptance`, or `authority-change`. A review must
identify the target, candidate backend and identity when content is reviewed,
reviewer, approval provenance, verdict, conditions, and authorized transition.
The `REVIEW-*.md` file is the durable human-facing record; generated candidate
evidence is transient cache material under `.project/.review/<review-id>/`.

Default statuses are `pending`, `approved`, `rejected`, and `superseded`.
Default plan/authority verdicts are `approve`, `approve_with_conditions`,
`revise`, and `reject`. Default acceptance verdicts are `accept`,
`accept_with_tracked_issues`, and `rework`.

## Skeleton

```markdown
---
id: REVIEW-0001
status: pending
type: <plan|acceptance|authority-change>
target: <path or ID>
candidate_backend: <git-tree-v1|snapshot-v1|none>
repository: <path or stable identifier>
branch: <name or none>
base_revision: <base commit or EMPTY_TREE>
candidate_tree: <tree ID or none>
candidate_digest: <digest or none>
reviewed_scope: []
reviewer: <human role or identity>
approval_provenance: <event, URL, signature, or recorded user decision>
date: <date>
verdict: pending
formalized_commit: <revision, pending, or none>
---

# Review: <type> for <target>

## Candidate Identity

<Backend, repository, branch, base revision, tree ID or snapshot digest, and scope>

## Approved Scope

<What was reviewed and authorized>

## Governing Authorities

- <roadmap, plan, decision, policy, or issue>

## Automated Evidence

- <command, result, environment, and candidate identity>

## Human Judgment

- Inspect or test: <procedure>
- Expected: <observable success>
- Failure: <observable failure>
- Why automation is insufficient: <limitation>

## Deviations And Conditions

- <condition, responsible role or person, blocking status, and evidence required>

## Requested Transition

<Exact transition authorized by the verdict>

## Verdict Rationale

<Reason for the frontmatter verdict>

## Follow-up Issues

- <ID or none>
```

While this review is pending, store generated candidate evidence in the ignored
cache `.project/.review/<review-id>/`:

```text
.project/.review/<review-id>/
  packet.md             # generated reviewer packet
  checks/               # optional command output and reports
  candidate.json        # snapshot-v1 only
  candidate/            # snapshot-v1 only
```

For `git-tree-v1`, the tree ID and staged scope identify the candidate; no
payload or candidate manifest is required. For `snapshot-v1`, the payload
preserves the exact bytes and relevant metadata for every non-deleted entry;
deleted entries are applied against the recorded base. The snapshot manifest's
canonical JSON body is UTF-8, has lexicographically sorted keys, no
insignificant whitespace, normalized unique POSIX-relative paths, and sorted
path entries. It contains `format_version`, `base_revision`, `scope`, and
`entries`. Each entry uses `kind: file|symlink|deleted`, relevant mode or
symlink target, and a lowercase SHA-256 content hash; deleted paths have no
content hash. Compute `candidate_digest` over that body without the digest
field. The review's base, scope, and tree ID or digest must exactly match the
candidate evidence. The cache path is derived from the review ID rather than
persisted as a durable file reference. Reconstruct and compare the candidate
immediately before formalization. A mismatch or changed base creates a new
candidate and invalidates this review.

The compact JSON rule applies only to snapshot `candidate.json`, which is
machine evidence, not to the human-facing review Markdown. Keep the cache until
a review is rejected, superseded, or abandoned without a pending resubmission,
or until an approved transition has been formalized and verified. Then delete
the cache by default. Retain only this review record with its candidate
identity, evidence, verdict, conditions, and `formalized_commit`; if byte-level
audit retention is required, archive the cache outside the canonical project
workflow and record that explicit choice.

Snapshot candidate manifest shape (the actual `candidate.json` is compact):

```json
{
  "base_revision": "<revision-or-EMPTY_TREE>",
  "candidate_digest": "<digest-of-body-without-this-field>",
  "entries": [
    {
      "kind": "file",
      "mode": "100644",
      "path": "<sorted-relative-path>",
      "sha256": "<lowercase-hex-digest>"
    }
  ],
  "format_version": 1,
  "scope": ["<sorted-relative-path>"]
}
```
