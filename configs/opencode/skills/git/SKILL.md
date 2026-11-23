---
name: git
description: Safe Git workflow, repository inspection, staging, diffs, history, consistent commit messages, pull request bodies, and read-first GitHub CLI usage. Use when preparing commits, writing PRs, reviewing changes, or recovering repository state.
compatibility: opencode
---

# Git

## When to use me

Use this skill when inspecting repository state, preparing a commit, writing a
pull request body, using the GitHub CLI (`gh`), reviewing a diff, or explaining
Git behaviour. Inspection and evidence steps use the shell, so use this skill
from `build`, not `mentor`; a mentor explains the commands and lets the user
run them.

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

## Pull request body

Before drafting, check `.github/PULL_REQUEST_TEMPLATE.md` and any other PR
template under `.github/`; when one exists, follow it instead of the structure
below. Otherwise use this structure. Skip preambles and keep prose brief. Use
the vocabulary already present in `AGENTS.md`, the README, or the project's
domain docs; do not assume a glossary file exists.

```markdown
## Summary

<one short visual and one sentence explaining it>

## Evidence

- **Before:** <command and output, failing test, or screenshot>
- **After:** <command and output, passing test, or screenshot>

## Merge Danger

**Door:** <one-way or two-way>

**Blast Radius:** <one word>
```

### Summary

Pick the smallest view that makes the change clear: pseudocode for logic, a
call tree for control flow, a shallow file tree for layout, a `diff` for a
focused edit, or Mermaid for interactions. Put one short sentence beside the
visual and describe in words what it shows; a screen-reader user should not
need to see the diagram. Keep only the calls, files, states, or boundaries that
this change needs.

### Evidence

Show before and after with the exact command and its real output. Screenshots
are appropriate only when the change is visual and a browser is available.
Never invent a passing test or a screenshot; if a check could not run, say so.

### Merge Danger

A two-way door is cheap to reverse; a one-way door is hard to undo. Name the
door, then give the blast radius as one word such as `repository`, `consumers`,
`mobile`, or `layout`. Add prose only when the risk is not obvious.

## GitHub CLI (`gh`)

`gh` infers the repository from `git remote -v`. Before the first write
operation in a session, confirm the target with
`gh repo view --json nameWithOwner`. Never file issues or PRs into an upstream
repository you do not own. Before creating an issue or PR, inspect
`.github/ISSUE_TEMPLATE/`, `.github/PULL_REQUEST_TEMPLATE.md`, and any other
templates under `.github/`; use the repo's template, fields, and labels instead
of inventing your own.

Read-only commands are fine without extra approval: `gh issue view`,
`gh issue list`, `gh pr view`, `gh pr diff`, `gh pr checks`, `gh repo view`, and
`gh run view`. In this config `gh api` always prompts, including GET requests;
treat it as a write-equivalent and explain it first. Ask before every mutation:
`gh issue create|comment|edit|close`, `gh pr create|comment|edit|close|merge`,
labels, assignments, releases, and `gh auth` changes.

Useful read patterns:

- `gh pr view <number>` then `gh pr diff <number>` for the change itself.
- `gh issue view <number> --json number,title,body,labels,comments`.
- `gh pr checks <number>` for CI status.
- GitHub shares one number space for issues and PRs: try `gh pr view 42` first,
  then `gh issue view 42` if it is not a PR.
- Use a heredoc for multi-line issue or PR bodies.

Never put tokens in commands or store them in the repository. If `gh` reports
missing credentials, ask the user to authenticate rather than working around
it.

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
