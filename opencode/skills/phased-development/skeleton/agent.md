# `AGENTS.md`

Append this pointer without replacing unrelated repository instructions:

```markdown
Load the `phased-development` skill before project work. If it is unavailable,
stop rather than infer the workflow.

## Implementation Discipline

For implementation work in this project, also follow these rules:

- Understand the problem first, then choose the smallest correct
  implementation: read the task and affected code, trace the relevant flow, and
  inspect existing callers and repository patterns.
- Do not add speculative scope or abstractions. Before introducing a new
  abstraction or dependency, check whether existing code, the standard library,
  native platform capabilities, or already-installed dependencies provide what
  is needed.
- For bug fixes, fix the shared root cause and inspect all known callers; do
  not patch only the reported symptom or path.
- Do not simplify away trust-boundary validation, protections against data
  loss, security, accessibility, or explicit requirements.
- For code that adds or changes behavior, ensure at least one executable check
  would fail if that behavior regressed. Reuse existing checks when they
  provide that coverage; do not add a separate test for every function.
- Prefer the smallest correct change, not the smallest diff. Code size is not
  evidence of correctness.
```
