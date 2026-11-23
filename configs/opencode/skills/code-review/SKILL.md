---
name: Two-axis code review
description: Review a diff since a fixed point on two axes, Standards and Spec. Use when the user asks for a deep review, a standards check, or a spec check of work since a commit, branch, or tag.
compatibility: opencode
---

# Two-axis code review

Review `git diff <fixed-point>...HEAD`. This needs the shell, so use it from
`build`, not `mentor`. The mandatory `reviewer` subagent still runs first; this
skill is the optional deeper pass.

Explain the axes to the user before starting: Standards asks whether the code
follows this repo's rules. Spec asks whether it does what was requested.

## 1. Pin the fixed point

Take the commit, branch, or tag from the user. If none was given, ask. Check it
with `git rev-parse <fixed-point>` and confirm the diff is not empty before
going further. Also note `git log <fixed-point>..HEAD --oneline`.

## 2. Find the sources

- Spec: a path the user gave, or a file under `docs/` or `specs/`.
  Use an issue reference from a commit message only when the user provides the
  issue content or a tracker tool is available. Otherwise ask. If the user says
  there is no spec, the Spec axis reports "no spec available".
- Standards: `CODING_STANDARDS.md`, `CONTRIBUTING.md`, and `AGENTS.md` when
  present. Repo rules win. Skip anything a linter or test already enforces.

## 3. Run two fresh subagents

Call two `reviewer` subagents directly from `build` in parallel. Each starts in
a fresh child session with a self-contained prompt containing the diff command,
the commit list, and its own sources. Do not ask a subagent to spawn another
subagent.

Standards prompt: check the diff against every standards file found and this
smell list: Mysterious Name, Duplicated Code, Feature Envy, Data Clumps,
Primitive Obsession, Repeated Switches, Shotgun Surgery, Divergent Change,
Speculative Generality, Message Chains, Middle Man, Refused Bequest. Cite the
rule or name the smell for each finding. Mark smells as judgement calls. Under
400 words.

Spec prompt: compare the diff with the spec. Report missing or partial
requirements, work that was not asked for, and requirements that look wrong.
Quote the spec line for each finding. Under 400 words. Skip this subagent when
there is no spec.

## 4. Report

Show the Standards report under `## Standards`. When a spec exists, show the
Spec report under `## Spec`. Keep them separate; do not merge or rank one above
the other. End with one line giving the count of findings and the worst issue in
each available axis. Tell the user what you did and why.
