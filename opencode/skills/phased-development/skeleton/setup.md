# Workflow Administration Skeleton

## Contract

This record is transient workflow-administration state. It coordinates
installation, Bootstrap, Adapt, migration, configuration, repair, update, or
removal without creating canonical project IDs. Store it under
`.project/.setup/`, exclude that directory with `.project/.gitignore`, and delete
it after successful or abandoned administration unless the user explicitly opts
to retain it outside the canonical workflow.

Direct user approval governs the requested administrative transition. Do not
represent the record as a project review or human verdict in the canonical review
collection.

## Skeleton

```markdown
# Workflow Administration

- Operation: <bootstrap|adapt|migration|configuration|repair|update|removal>
- Status: <in_progress|awaiting_user|accepted|abandoned>
- Workspace: <path>
- Started: <date>
- Base: <revision, source path, or EMPTY_TREE>
- Candidate payload: `.project/.setup/candidate/`
- Candidate manifest: `.project/.setup/candidate.json`

## Requested Result

<What the user asked the workflow administration to establish or change>

## Administrative Changes

- <registry, binding, path, or workflow change>

## Project Effects Separated

- <project roadmap, technical, compatibility, release, or policy effect>
- <none>

## Verification

- <checks and results>

## User Approval

- Decision: <pending|accepted|rejected>
- Date: <date or pending>
- Notes: <direct user instruction or none>

## Cleanup

- Remove `.project/.setup/` after acceptance or abandonment.
- Retain only explicitly requested material outside canonical project governance.
```
