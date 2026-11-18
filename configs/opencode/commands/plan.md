---
description: Create a read-only implementation plan
agent: plan
subagent: true
---

Create an implementation plan for:

$ARGUMENTS

Inspect the repository first. Always write the plan to
`~/.opencode/plans/<project_name>/<title>.md`.

Begin with a short outline of numbered points ("Step 1 do x, Step 2 do y,
Step 3 do z"). Then expand each point with the ways to do it, the trade-offs,
how it affects other parts of the system, files involved, risks, assumptions,
and verification. Make the last step an archive step: move the plan to
`~/.local/share/opencode/plans/<project_name>/<title>.md` only when every step
has been executed; otherwise keep it at the active path. Include the goal, the
user's priorities, and any focused question needed before work starts.
