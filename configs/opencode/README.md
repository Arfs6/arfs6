# OpenCode configuration

This directory contains my OpenCode 2 configuration. It is shared between WSL
and native Ubuntu through the `arfs6` dotfiles repository.

The configuration is designed for learning first: `mentor` is the default
agent, `implementer` is available when I explicitly want code written, and
read-only subagents handle planning, debugging, review, and technical writing.
The `plan` agent can run as either a primary agent or a subagent.

## Files

- `opencode.jsonc`: global server/runtime configuration: default agent, model,
  formatter, experimental settings, ordered permissions, and hard policies.
- `cli.json`: terminal settings: keybindings, permission prompts, and attention
  notifications and sounds.
- `agents/`: two primary agents, three subagent-only agents, and the `plan`
  agent, which can run as either.
- `commands/`: reusable `/learn`, `/implement`, `/plan`, `/debug`, `/review`,
  `/docs`, and `/ledger` commands.
- `skills/`: concise references for Git, Python, Go, Lua, JavaScript, Zig, HTML,
  and CSS.
- `AGENTS.md`: the main teaching, accessibility, review, debugging, permission,
  and completion-report rules.
- `LEARNING.md`: my learning ledger. It records demonstrated understanding, not
  things an agent once explained.
- `README.md`: this document.

## Modes and agents

### Primary agents

- `mentor`: the default. It teaches, asks questions, reviews my attempts, and
  gives hints. It may edit only `LEARNING.md`; it cannot edit project files, run
  shell commands, or invoke `implementer`.
- `implementer`: implementation mode. It writes code, explains the design, runs
  verification, and leaves a follow-up exercise. Unless I explicitly ask it to
  proceed without discussion, it states the plan and waits for approval before
  changing files.

### Subagents

- `plan`: read-only planning and task breakdown. It can also run as a primary
  agent.
- `debugger`: evidence-based diagnosis without editing files. It stays inside
  the current project.
- `reviewer`: read-only code review with severity labels. It reports findings
  and does not fix them.
- `tech-writer`: documentation-only edits. It never edits the learning ledger
  or agent, command, and skill definitions.

Primary agents know these subagents and may invoke them deliberately. The
`plan` agent is read-only in both roles.

### Switching modes

In the TUI, press `<leader>a` (`ctrl+x`, then `a`) to open the agent list. The
leader key is `ctrl+x`.

You can also use:

- `/learn` to start a learning-mode session.
- `/implement` to start an implementation-mode session.
- `/plan`, `/debug`, `/review`, and `/docs` to invoke the matching subagent.
- `/ledger` to review the recent conversation and update `LEARNING.md` from
  demonstrated evidence.

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

`cli.json` enables `attention.notifications` and `attention.sound` with a
volume of `0.4` and the `opencode.default` sound pack. The TUI requests
attention for questions, permissions, session errors, completed sessions, and
finished subagents. Built-in sounds are used for each event. To override one
event, add a path under `attention.sounds` for `default`, `question`,
`permission`, `error`, `done`, or `subagent_done`; an unreadable file falls back
to the built-in sound.

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

`opencode.jsonc` uses one ordered `permissions` array. The last matching rule
wins, so broad defaults come first and narrow exceptions follow. The global
defaults ask before:

- reading secret-bearing files such as `.env`, SSH keys, cloud credentials,
  package-manager tokens, and Git credentials;
- editing files, running shell commands, and invoking subagents;
- accessing anything outside the active project.

Agent rules append after the global rules:

- `mentor`: edits only `LEARNING.md`; no shell commands; may invoke `plan`,
  `debugger`, `reviewer`, and `tech-writer`.
- `implementer`: edits and shell commands allowed, with repeated asks for
  destructive commands such as `rm`, `mv`, `dd`, history rewrites, `git push`,
  and package-manager changes.
- `plan`: read-only; shell commands ask.
- `debugger`: read-only, but may run diagnostic commands; it asks before
  destructive commands and stays inside the project.
- `reviewer`: read-only, with only a few Git inspection commands allowed.
- `tech-writer`: documentation files only; it cannot edit the learning ledger or
  agent, command, and skill definitions.

`policies` hard-deny `sudo`, `mkfs`, `shutdown`, and `reboot`. Policies run
after permissions and saved approvals, so an agent cannot override them with a
broad shell allow.

These are guardrails, not a security boundary. Review diffs and commands before
approving them. A saved approval is project-scoped and is not permission for
unrelated commands.

OpenCode 2 names the direct shell tool `shell`. The configuration uses the v2
`shell` action, not the legacy `bash` key. Agents are told to call `shell`
directly and to use `execute` only for the Code Mode tools listed in its
catalog.

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
opencode debug config --standalone
opencode debug agents --standalone
opencode models
opencode service status
opencode pair
```

`opencode debug config --standalone` shows the merged configuration for the
current directory without connecting to the background service.
`opencode debug agents --standalone` shows the discovered primary and subagent
definitions. The running service keeps the configuration it loaded at startup,
so without `--standalone` these commands can show stale settings. Restart the
service to apply changes to the active TUI.

The v2 documentation still mentions `opencode web` in places, but the installed
v2.2.6 binary exposes `opencode serve` and `opencode pair` instead. Trust the
binary help for the installed version:

```bash
opencode --help
opencode run --help
```

## Limitations

- Web notification categories are browser-profile settings. Permission requests
  and questions are enabled by default; errors and agent completion must be
  enabled manually in the web settings.
- Web notifications require an open session tab and browser permission.
- The `opencode serve` migration race is unresolved; use `opencode pair`.
- TUI desktop notifications may depend on tmux and the terminal emulator.
- The running service must be restarted to apply configuration changes. Use
  `--standalone` to validate the files without restarting it.
- Formatters run only when the built-in formatter's executable or project
  dependency is available.
- No custom plugin is used.
