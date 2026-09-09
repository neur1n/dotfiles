# `project.json`

## Contract

`project.json` is the stable discovery manifest for the workflow. It points to
governance entry points and stable project-defined interfaces; it is not an
index of records, a state digest, or an authority/history ledger.

Keep historical snapshots, acceptance evidence, and changing rationale in the
owning canonical record or Git. Put only paths, IDs, and other metadata needed
to discover those records here; reference canonical content rather than copying
it. Indexes, when present, are navigation projections and do not replace their
canonical records. Project-specific properties are allowed when they serve a
stable discovery need and their source of truth is defined by the project.

```json
{
  "format_version": 1,
  "workflow": "phased-development",
  "project": "<project-name>",
  "state": ".project/STATE.md",
  "roadmap": ".project/roadmap/ROADMAP-0001.md",
  "plan": null
}
```
