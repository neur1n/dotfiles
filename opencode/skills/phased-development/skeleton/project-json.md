# `project.json` Skeleton

## Contract

`project.json` is the stable discovery manifest for the workflow. It
registers paths, roles, and the persisted manifest format. It is not an index of
records and cannot override record frontmatter or canonical content.

Required properties:

- `format_version`: persisted manifest format, starting at integer `1`;
- `workflow`: `phased-development`;
- `project`: human-readable project identifier;
- `state`: path to the derived state digest;
- `roadmap`: path to the current roadmap;
- `plan`: path to the current or proposed plan, or `null` when no plan exists; and
- `issue_directory`, `decision_directory`, and `review_directory`: local record
  directories.

Optional properties may register an external tracker or a custom project-defined
collection. Such properties must state the external or custom source of truth;
they do not create an index.

## Skeleton

```json
{
  "format_version": 1,
  "workflow": "phased-development",
  "project": "<project-name>",
  "state": ".project/STATE.md",
  "roadmap": ".project/roadmap/ROADMAP-0001.md",
  "plan": null,
  "issue_directory": ".project/issue",
  "decision_directory": ".project/decision",
  "review_directory": ".project/review"
}
```

Add an `external_issue_tracker` object only when its URL, identifier format,
authority, and verification procedure are known.
