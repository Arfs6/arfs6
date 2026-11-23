---
name: grilling
description: Stress-test a plan, decision, or idea with rounds of focused questions. Use when the user asks to be grilled or wants their thinking challenged before implementation.
compatibility: opencode
---

# Grilling

Goal: a shared understanding in which every branch of the decision has been
tested, not a document produced quickly.

Model the decisions as a tree. The frontier is every decision whose
prerequisites are settled: the questions you can ask now without guessing at
answers you have not heard. Ask the whole frontier in one round, numbered,
each with your recommended answer. Word each question so "yes" accepts that
answer. Wait for the user's replies before the next round; each answer
reshapes the tree and reveals the next frontier.

```text
Q1. <title>: <question and the choices that matter>
Recommended: <your answer and one reason>
```

Finding facts is your job, not the user's. Use web search and read-only tools
you are allowed to use. In `build`, dispatch a fresh-context `explore` or
`general` subagent for the legwork and keep asking the rest of the frontier
while it runs. In `mentor`, use `plan` or `debugger` for read-only
investigation. If a tool is unavailable in the current mode, say so and ask
for a `build` pass. Never ask the user for a fact you can look up.

Decisions belong to the user. Record each settled decision with an ID in the
active record's `## Decisions needed`; use `plan` to update the record. Stop
when the frontier is empty and the user confirms the shared understanding. Do
not act on the plan before that confirmation. In `mentor`, offer `build` as the
next step.
