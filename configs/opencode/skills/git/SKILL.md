---
name: git
description: Safe Git workflow, repository inspection, staging, diffs, history, and consistent commit messages. Use when preparing commits, reviewing changes, or recovering repository state.
compatibility: opencode
---

# Git

## When to use me

Use this skill when inspecting repository state, preparing a commit, reviewing
a diff, or explaining Git behaviour.

## Commit message format

Use this structure unless the repository already has a stronger convention:

```text
type(area): brief summary

Explain what changed and why. Add enough detail for a future reader to
understand the change without opening the diff.
```

Recommended types:

- `feat`: new behaviour
- `fix`: bug fix
- `docs`: documentation only
- `refactor`: structure change without behaviour change
- `test`: tests only
- `chore`: maintenance
- `style`: formatting only
- `perf`: performance
- `build`: build system or dependencies
- `ci`: continuous integration

Use a file name, component, or area for `area`. Keep the summary under 72
characters. Write the summary in the imperative mood.

## Inspection workflow

1. Run `git status --short --branch`.
2. Run `git diff` for unstaged changes and `git diff --cached` for staged
   changes.
3. Run `git log --oneline -10` to match the repository's existing style.
4. Read the surrounding files before judging a change.
5. Stage only the intended files.

## Safety rules

- Never discard unstaged changes with `git checkout --` or `git restore`
  unless the user explicitly asks.
- Never rewrite published history, force-push, amend, or create an empty commit
  without explicit permission.
- Do not commit secrets, credentials, tokens, or unrelated files.
- Inspect `git status` and `git diff` before every commit.
- Do not commit unless the user asks.

## Teaching mode

Explain the difference between the working tree, index, and commit. Let the
learner write the commands and predict the result before running them.
