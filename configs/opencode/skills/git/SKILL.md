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

## Branch creation workflow

Whenever new work starts on a branch:

1. Fetch the remote first: `git fetch --all --prune`. Fetching refreshes
   remote-tracking refs such as `origin/main`; it does not update a checked-out
   local `main` branch.
2. Identify the intended base branch and verify whether it is `main`, another
   repository branch, or a remote-tracking branch such as `origin/main`.
3. Ensure the local base is current without discarding local work. Prefer
   `git pull --ff-only` on the base branch when it is safe and the repository
   tracks the intended remote. If `git pull` would merge unexpectedly, rebase,
   or require recovery, stop and explain the alternatives.
4. Create the branch explicitly from the updated base, for example
   `git switch -c <branch-name> origin/main` only after confirming
   `origin/main` is the intended base.
5. If the worktree is dirty, the local base is diverged, HEAD is detached, or
   the remote/base is missing, do not guess. Inspect and ask before using
   commands that could overwrite work or rewrite history.

This applies to every agent. Do not create a branch from stale local `HEAD`.
Fetch first, then verify or update the intended local base branch, or create the
branch explicitly from the freshly fetched remote-tracking ref.

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
