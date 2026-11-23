---
description: Audit a work record, the whole repository, or a commit in a fresh context
agent: build
subagent: true
---

Audit the target matching:

$ARGUMENTS

You are running in a fresh child session. Do not rely on any previous
implementation conversation as evidence. Use this at the mandatory stop in an
execution checklist, before any commit, push, merge, archive, deployment, sync,
or other permanent change.

## 1. Resolve the target

- No `$ARGUMENTS`: derive the project name from the active working directory,
  then list `.md` files under `~/.opencode/records/<project_name>/` whose first
  heading is `# Record:`. If exactly one exists, use it; otherwise ask which
  record to audit.
- `$ARGUMENTS` is `.`, `repo`, or `--repo`: audit the whole repository at the
  current HEAD and working tree.
- `$ARGUMENTS` starts with `commit ` or is a commit reference: strip the word
  `commit` if present and trim whitespace. Accept only refs made of letters,
  digits, `.`, `_`, `/`, `^`, `~`, and `-` that do not start with `-`; reject
  anything else and ask for a simpler ref. Verify the ref as data with
  `git rev-parse --verify --end-of-options '<ref>^{commit}'` in single quotes so
  shell expansions cannot run. If it resolves, audit that commit. If nothing
  remains after stripping, ask for a reference. If verification fails, fall
  through to record search.
- `$ARGUMENTS` is a path to an existing `.md` file: use that record.
- Otherwise treat `$ARGUMENTS` as a literal fixed-string search phrase:
  discover `.md` files in both record roots, then run
  `grep -F -n -i -- '<phrase>' <files>` with the phrase in single quotes. Reject
  phrases containing a single quote or newline and ask for a simpler phrase.
  If discovery finds no files, say that no records exist and ask; never run
  `grep` without file operands. Do not turn the phrase into a regex and do not
  place it inside a shell block in this command.
- Only count matches in the `# Record:` title or in the `## Record header`
  block before `## Issue`. Prefer Source, Project, and Description matches.
  For example, `/audit issue #142` should find a record whose Source is
  `issue #142`.
- Use the single best match if there is one. If several match, ask which
  record. If none match, ask for a path or a clearer phrase.

## 2. Choose where findings go

- For a record target, append to that record.
- For a whole-repository audit, create
  `~/.opencode/records/<project_name>/repo-audit-<YYYY-MM-DD>.md`.
- For a commit audit, create
  `~/.opencode/records/<project_name>/commit-audit-<short-sha>.md`.

For a new record, use `# Record: repository audit — <project>` or
`# Record: commit <short-sha> — <subject>`, then `## Record header` with Source,
Project, Description, Status `audit`, and Fixed point. Add `## Issue` for what
was audited, `## Scope`, `## Audit findings`, and `## History`. These audit
records are a record variant: the solution, decision, and execution-checklist
sections used by implementation records are not applicable. If the file already
exists, append a new dated subsection instead of overwriting it.

## 3. Establish ground truth from Git

- Record target: current branch, status, diff against the fixed point, commit
  range, and the checks listed in the record when safe.
- Whole repository: `git rev-parse HEAD`, `git status --short --branch`,
  `git ls-files`, and `git ls-files --others --exclude-standard`. Review the
  tracked and untracked non-ignored text files in the repository. Skip
  generated, vendored, binary, and ignored files. If the repository is large,
  ask which directories to include.
- Commit target: `git show --stat --format=fuller '<sha>'`,
  `git diff '<sha>^' '<sha>'` for a normal commit, and `git diff '<sha>^1' '<sha>'`
  for a merge commit. Keep the verified ref in single quotes in every command.
  Say that a merge diff uses its first parent. If the commit has no parent, use
  `git show --format= '<sha>'` and say there is no parent diff.

## 4. Invoke the reviewer

Invoke `reviewer` with the diff or repository inventory, the target context,
and the scope. It is the mandatory review authority and runs with its own fresh
context; do not replace it with your own opinion.

## 5. Append findings

Find or create `## Audit findings`, then append an audit subsection containing:

- date, target identity (record, HEAD, or commit), fixed point, commit range or
  file inventory, and what was inspected;
- reviewer findings with severity labels;
- verified, partially verified, and unverified checks;
- decisions needed before follow-up;
- unchecked follow-up steps for the next execution pass.

## 6. Close out

- Set `Status` in `## Record header` to `audit`, or to `blocked` when a blocking
  finding needs a decision.
- Preserve prior checkboxes, decisions, audit notes, and history. Add a dated
  `## History` entry saying what was audited and where the findings were
  recorded.
- Briefly tell the user why the fresh context matters: the audit relied on Git,
  the target, and `reviewer`, not on implementation-session memory. Name the
  record you wrote. Do not fix findings in this command unless the user asks
  separately.
