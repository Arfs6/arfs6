---
description: Create or update a persistent work record and execution plan
agent: plan
subagent: true
---

Create or update a work record for:

$ARGUMENTS

Inspect the repository first. Always write the record to
`~/.opencode/records/<project_name>/<title>.md`. Treat it as a persistent
record, not a disposable plan.

Use this order:

1. `# Record: <source> — <title>` followed by `## Record header` with these
   fields: Source, Project, Description, Status, and Fixed point. Keep this
   header current as the record moves through planning, execution, audit,
   blocked, complete, or archived.
2. `## Issue` — source, what the issue is, requested outcome, "done when", and
   user priorities.
3. `## Scope` — in scope, out of scope, constraints, and dependencies.
4. `## Solution shape` — recommended approach, alternatives, trade-offs,
   affected files, risks, assumptions, and verification.
5. `## Decisions needed` — give each decision an ID, options, a recommendation,
   and a blank decision line until the user decides.
6. `## Execution checklist` — begin with a short numbered outline, then expand
   each step with what to do, why, files involved, and how to verify. If the
   outline has no stopping point, add a "Stop and audit" step immediately
   before the first commit, push, merge, archive, deployment, sync, or other
   permanent change; if it already has a stop, put the audit there only if that
   stop is before the first permanent change. Write it as
   "Stop and audit: pause and ask the user to run `/audit <record>`; wait for
   its findings and resolve blocking ones before any permanent change." Do not
   mark steps executed; `build` does that with a date and evidence.
7. `## Audit findings` — leave empty. Say that `/audit` starts a fresh child
   session, invokes `reviewer`, and appends findings here. `/audit repo` and
   `/audit <sha>` create separate audit records instead of using this section.
8. `## History` — add a dated entry for this creation or update.

When updating an existing record, preserve completed checkboxes, decisions,
audit findings, and history. Append new information instead of rewriting it.

Make the last step "Archive or refresh the record". A record is stale when all
steps and audit findings are complete, or when the user says the work is no
longer active, superseded, or abandoned. For a stale record, update the header
status and move it to
`~/.local/share/opencode/records/<project_name>/<title>.md`, then add a dated
`## History` entry with the reason and archive path. Otherwise keep it at the
active path.
