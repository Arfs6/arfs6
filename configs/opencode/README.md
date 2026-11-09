# OpenCode configuration

This directory contains my OpenCode 2 configuration. It is shared between WSL
and native Ubuntu through the `arfs6` dotfiles repository.

The configuration is designed for learning first: `mentor` is the default
agent, `implementer` is available when I explicitly want code written, and
small read-only subagents handle planning, debugging, review, and technical
writing.

## Files

- `opencode.jsonc`: global server/runtime configuration, default agent, model,
  and fallback permissions.
- `tui.jsonc`: TUI keybindings and attention notifications.
- `agents/`: the two primary agents and four subagents.
- `commands/`: reusable `/learn`, `/implement`, `/plan`, `/debug`, `/review`,
  and `/docs` commands.
- `skills/`: concise references for Git, Python, Go, Lua, JavaScript, Zig, HTML,
  and CSS.
- `AGENTS.md`: the main teaching, accessibility, review, debugging, and
  completion-report rules.
- `LEARNING.md`: my learning ledger. It records demonstrated understanding, not
  things an agent once explained.
- `README.md`: this document.

## Modes and agents

### Primary agents

- `mentor`: the default. It teaches, asks questions, reviews my attempts, and
  gives hints. It cannot edit files, run shell commands, or invoke the
  implementer.
- `implementer`: implementation mode. It writes code, explains the design, runs
  verification, and leaves a follow-up exercise.

### Subagents

- `planner`: read-only planning and task breakdown.
- `debugger`: evidence-based diagnosis without editing files.
- `reviewer`: read-only code review with severity labels.
- `tech-writer`: documentation-only edits.

Primary agents know these subagents and may invoke them deliberately. Both
primary prompts list them explicitly.

### Switching modes

In the TUI, press `<leader>a` (`ctrl+x`, then `a`) to open the agent list. The
leader key is `ctrl+x`.

You can also use:

- `/learn` to start a learning-mode session.
- `/implement` to start an implementation-mode session.
- `/plan`, `/debug`, `/review`, and `/docs` to invoke the matching subagent.

### Per-repository default

A project can set its own default agent with `.opencode/opencode.json`:

```json
{
  "$schema": "https://opencode.ai/config.json",
  "default_agent": "implementer"
}
```

For example, `upstat` uses implementation mode by default, but I can still
switch to `mentor` when I want to learn.

## Model

The default model is `opencode/big-pickle`, a free OpenCode model. To use a
different model for one session, use `/models` or `opencode run --model`.

## Web UI on OpenCode 2

OpenCode 2 no longer provides the old `opencode web` subcommand. The working
workflow is the background service plus a one-time browser link:

```bash
opencode service status
opencode pair
```

Open the printed URL in the browser. The link is one-time; run `opencode pair`
again if it expires or the browser is unavailable.

The background service is normally started automatically. Manage it with:

```bash
opencode service start
opencode service status
opencode service stop
opencode service restart
```

`opencode serve` starts a separate v2 API and web server. Do not run it while
the background service is already using the same database: the current version
can fail with `UNIQUE constraint failed: migration.id`. Use `opencode pair`
for the normal web workflow, and back up the database before any attempt to
repair migrations.

## Notifications

### Web notifications

The web UI has built-in notifications for:

- permission requests, enabled by default;
- questions, enabled by default;
- errors, disabled by default;
- agent completion, disabled by default.

The web UI only notifies when the session tab is open and the browser window is
not focused. Allow notifications when the browser asks. If notifications do
not appear:

1. Confirm the session tab is still open.
2. Confirm the browser site permission is allowed.
3. Confirm the notification settings in the OpenCode web settings.
4. Confirm the browser is not focused on the session tab.

`opencode pair` uses `http://127.0.0.1`, which browsers treat as a secure
context for notification permissions.

### TUI attention

`tui.jsonc` enables `attention` with sound and desktop notifications. The TUI
requests attention for questions, permissions, session errors, and completed
sessions, and normally only when the terminal is blurred. This is the built-in
TUI behaviour; it does not separate completion from input requests. Set
`attention.enabled` to `false` if completion sounds are distracting.

TUI desktop notifications depend on the terminal and on tmux configuration.
Sound on WSL uses WSLg PulseAudio. If sound fails, check `paplay` and the WSLg
PulseAudio socket.

## TUI navigation

The important default keybindings are:

- `ctrl+p`: command palette.
- `<leader>a`: agent list.
- `tab`: cycle agents.
- `<leader>m`: model list.
- `<leader>n`: new session.
- `<leader>l`: session list.
- `<leader>c`: compact session.
- `<leader>e`: open editor.
- `escape`: interrupt the current response.
- `ctrl+g` or `home`: jump to the first message.
- `ctrl+alt+g` or `end`: jump to the last message.

`opencode mini` starts the minimal interactive interface if the full TUI is too
noisy for the current task.

## Skills

Skills are loaded on demand by the `skill` tool. They are intentionally short:

- `git`: safe workflow and commit message format.
- `python`: environments, types, tests, and common verification.
- `go`: modules, errors, context, concurrency, and tests.
- `lua`: scope, tables, modules, and tests.
- `javascript`: package managers, modules, async code, and tests.
- `zig`: builds, allocators, error unions, and memory ownership.
- `html`: semantic structure, forms, media, and screen-reader navigation.
- `css`: accessibility, responsive layout, focus, contrast, and motion.

## Permissions

The global fallback asks before edits and shell commands. Agent permissions
override that fallback:

- `mentor`: no edits, no shell commands, no implementer subagent.
- `implementer`: edits and shell commands allowed.
- `planner`: read-only.
- `debugger`: read-only, but may run non-destructive diagnostic commands.
- `reviewer`: read-only, with only a few Git commands allowed.
- `tech-writer`: documentation files only.

These are guardrails, not a security boundary. Review diffs and commands before
approving them.

OpenCode 2 names the direct shell tool `shell`. The configuration and v2 docs
still use the legacy `bash` permission key, which OpenCode maps to the `shell`
tool. Agents are told to call `shell` directly and to use `execute` only for the
Code Mode tools listed in its catalog.

## Commit messages

Use this format for manual commits:

```text
type(area): brief summary

Explain what changed and why.
```

For example:

```text
feat(opencode): add mentor and implementer modes
```

The automatic dotfiles sync uses the same format when it asks OpenCode for a
commit message. `./sync.sh --message "..."` overrides the generated message.

## Installation and updates

These files are linked into `~/.config/opencode` by the repository-level
`setup.sh`. After editing them, run:

```bash
./setup.sh --no-timer
```

Then review and sync:

```bash
./sync.sh --dry-run
./sync.sh
```

`setup.sh` backs up replaced files under
`~/.local/state/arfs6/backups/<timestamp>/`.

## Verification and troubleshooting

Useful commands:

```bash
opencode --version
opencode debug config
opencode debug agents
opencode models
opencode service status
opencode pair
```

`opencode debug config` shows the merged configuration for the current
directory. `opencode debug agents` shows the discovered primary and subagent
definitions. Run both from the repository you are working in.

The v2 documentation still mentions `opencode web` in places, but the installed
v2.2.6 binary exposes `opencode serve` and `opencode pair` instead. Trust the
binary help for the installed version:

```bash
opencode --help
opencode run --help
```

## Limitations

- TUI attention does not distinguish input requests from completed sessions.
- Web notifications require an open session tab and browser permission.
- The `opencode serve` migration race is unresolved; use `opencode pair`.
- TUI desktop notifications may depend on tmux and the terminal emulator.
- The v1 plugin dependency in the old `package.json` is not needed for this
  configuration. No custom plugin is used.
