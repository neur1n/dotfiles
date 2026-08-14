# Review Skeleton

## Contract

The review records a human judgment about an exact target and candidate. Use one
record type: `plan`, `acceptance`, or `authority-change`. A review must
identify the target, candidate digest when content is reviewed, reviewer,
approval provenance, verdict, conditions, and authorized transition.

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
candidate_digest: <digest or none>
candidate_manifest: <path or none>
candidate_payload: <archive-or-snapshot-path or none>
base_revision: <revision or EMPTY_TREE>
reviewed_scope: []
reviewer: <human role or identity>
approval_provenance: <event, URL, signature, or recorded user decision>
date: <date>
verdict: pending
---

# Review: <type> for <target>

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

- <condition, owner, blocking status, and evidence required>

## Requested Transition

<Exact transition authorized by the verdict>

## Verdict Rationale

<Reason for the frontmatter verdict>

## Follow-up Issues

- <ID or none>
```

The candidate payload and manifest are stored beside this review record and are
excluded from the reviewed scope. `.project/.setup/` is always excluded. The
payload preserves the exact bytes and
relevant metadata for every non-deleted entry; deleted entries are applied against
the recorded base. The manifest's canonical JSON body is UTF-8, has
lexicographically sorted keys, no insignificant whitespace, normalized unique
POSIX-relative paths, and sorted path entries. It contains `format_version`,
`base_revision`, `scope`, and `entries`. Each entry uses
`kind: file|symlink|deleted`, relevant mode or symlink target, and a lowercase
SHA-256 content hash; deleted paths have no content hash. Compute
`candidate_digest` over that body without the digest field. The review's base,
scope, manifest path, payload path, and digest must exactly match the manifest or
evidence. Reconstruct and compare it immediately before formalization. A mismatch
or changed base creates a new candidate and invalidates this review.

Candidate manifest shape:

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
