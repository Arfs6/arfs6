---
name: Writing for agents
description: Write or edit AGENTS.md, skills, commands, and other documents an agent reads. Use when changing instructions or agent-facing docs in this config.
compatibility: opencode
---

# Writing for agents

Goal: instructions that are short, predictable, and easy to maintain.

- Put the action first. A pointer says what the material is and when to read it.
- Use one trigger per branch. Collapse synonyms; keep genuinely different cases.
- Inline what every branch needs. Move rarely used reference into a nearby file
  and point to it.
- Keep a concept's rules and caveats under one heading.
- State completion as a checkable condition, not a feeling.
- Prefer positive instructions. Use a prohibition only as a hard guardrail, and
  pair it with the behaviour you want.
- One rule, one source of truth. Do not restate facts the agent can look up.
- Delete lines that do not change behaviour. Shorter documents stay relevant.
- Explain unfamiliar terms in plain language when the user will read the doc.

When editing this config, keep the mentor and build roles distinct. Tell the
user what changed and why.
