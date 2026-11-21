# OpenCode configuration

This directory contains my OpenCode 2 configuration, shared between WSL and
native Ubuntu through the `arfs6` dotfiles repository. The setup is
learning-first: `mentor` is the global default; this repository defaults to
`build`.

## Layout

- `opencode.jsonc`: model, formatter, MCP servers, experimental settings,
  ordered permissions, and hard policies.
- `cli.json`: leader key, command palette, permission prompt, and attention
  settings.
- `agents/`: `mentor`, `build`, `plan`, `debugger`, `reviewer`, and
  `tech-writer`.
- `commands/`: `/learn`, `/build`, `/implement`, `/plan`, `/debug`, `/review`,
  `/docs`, and `/ledger`.
- `skills/`: short hand-written references and the vendored `playwright-cli`
  skill.
- `AGENTS.md`: global teaching, accessibility, review, debugging, permission,
  and completion rules.
- `LEARNING.md`: learning ledger. It records demonstrated understanding.

Plans are stored centrally under `~/.opencode/plans/<project_name>/<title>.md`.
The `plan` agent creates and edits files there and in
`~/.local/share/opencode/plans/<project_name>/<title>.md`, and may move files
between those directories. It moves a completed plan to the archive only after
every step is executed. The repository does not keep plan files.

## Agents and commands

### Primary agents

- `mentor`: teaches with hints and questions. It may edit only `LEARNING.md`;
  no other edits, shell commands, or `build` calls.
- `build`: implements changes. It explains the plan and risk before editing,
  reviews material changes with `reviewer`, runs checks, and reports results.

### Subagents

- `plan`: read-only on project files; writes plans only under the two plan
  trees; can also be a primary agent.
- `debugger`: evidence-based diagnosis without editing.
- `reviewer`: read-only review with severity labels and verification evidence.
- `tech-writer`: documentation-only edits; never `LEARNING.md`, agent, command,
  or skill definitions.

Press `<leader>a` (`ctrl+x`, then `a`) for the agent list, or `tab` to cycle.
Commands: `/learn`, `/build`, `/implement` (alias of `/build`), `/plan`,
`/debug`, `/review`, `/docs`, and `/ledger`.

A project can override the default in `.opencode/opencode.json`:

```json
{
  "$schema": "https://opencode.ai/config.json",
  "default_agent": "build"
}
```

## Model, UI, and notifications

The default model is `opencode/big-pickle`. Use `/models` or `opencode run
--model` for one session.

OpenCode 2 uses the background service and a one-time browser link:

```bash
opencode service status
opencode pair
```

Open the printed URL. Run `opencode pair` again if it expires. Manage the
service with `opencode service start|status|stop|restart`. Do not run
`opencode serve` while the service uses the same database; use `opencode pair`.

Web notification categories are browser-profile settings: permission requests
and questions are enabled by default; errors and completion are not. The tab
must be open and unfocused. `127.0.0.1` is a secure context.

`cli.json` enables TUI attention notifications and sounds at volume `0.4` with
`opencode.default`. Override individual events under `attention.sounds` if
needed. Desktop notifications depend on the terminal and tmux; WSL sound uses
WSLg PulseAudio.

Keybindings: `ctrl+p` palette, `<leader>a` agents, `tab` cycle agents,
`<leader>m` models, `<leader>n` new session, `<leader>l` sessions, `<leader>c`
compact, `<leader>e` editor, `escape` interrupt, `ctrl+g`/`home` first message,
`ctrl+alt+g`/`end` last message. `opencode mini` starts a minimal TUI.

## Skills

Hand-written skills cover Git, Python, Go, Lua, JavaScript, Zig, HTML, CSS,
Marp, and Playwright CLI. They are loaded on demand by the `skill` tool.

`playwright-cli` is vendored unchanged from `@playwright/cli` 0.1.24, including
its `references/` files. Check drift with:

```bash
diff -r "$(npm root -g)/@playwright/cli/skills/playwright-cli" \
  configs/opencode/skills/playwright-cli
```

Keep the directory name; OpenCode derives the skill ID from the path.

## Permissions

`opencode.jsonc` uses one ordered `permissions` array. The last matching rule
wins: broad defaults first, narrow exceptions later. Routine work is allowed;
effectful work asks; diffs are reviewed afterward.

- Outside-project paths ask first except `~/.config/opencode/*`, plan storage,
  and `/tmp/*`.
- Reads are allowed except secret-bearing files, which ask.
- Shell commands are allowed until an effectful prefix asks: destructive file
  operations, Git history rewrites and remote operations, GitHub and Docker
  mutations, publishes, remote execution, process/service control, package
  managers, and nested shells.
- Edits are allowed except secret-bearing files. Subagents run without prompts
  but keep their own restrictions.
- MCP tools are not covered by the generic rules unless a `<server>_<tool>`
  action names them. Playwright tools are therefore allowed for every agent;
  `mentor` limits its use by instruction.
- `policies` hard-deny `sudo`, `mkfs`, `shutdown`, and `reboot`.

Agent edits are append-only overrides: `mentor` may edit only `LEARNING.md` and
may invoke `plan`, `debugger`, `reviewer`, and `tech-writer`; `build` may edit
and invoke subagents; `plan` may create, edit, and move files only in the two
plan directories; `debugger` cannot edit; `reviewer` allows only read-only Git
commands; `tech-writer` allows Markdown, MDX, and text files but not agent,
command, skill, or ledger files.

Use the v2 `shell` action. Agents call `shell` directly and reserve `execute`
for Code Mode tools in its catalog.

## Change review and commits

Every material change-set is reviewed before completion. The editing agent
invokes `reviewer` on the working-tree diff and addresses or reports findings.
`tech-writer` cannot spawn subagents, so its caller reviews its diffs. Trivial
changes get a documented self-review. `/review` requests a manual review.

Commit messages use `type(area): brief summary`, followed by why the change was
made. `./sync.sh --message "..."` overrides the generated message.

## Installation and verification

`setup.sh` links these files into `~/.config/opencode` and creates the two
central plan roots. After editing:

```bash
./setup.sh --no-timer
./sync.sh --dry-run
./sync.sh
```

Useful checks:

```bash
opencode --version
opencode debug config --standalone
opencode debug agents --standalone
opencode models
opencode service status
opencode pair
```

`--standalone` reads the files without contacting the background service. The
running service must be restarted to use changed configuration.

## Limitations

- Web notifications require an open tab, browser permission, and manual
  enabling for some categories.
- The `opencode serve` migration race is unresolved; use `opencode pair`.
- Desktop notifications depend on the terminal and tmux.
- Formatters run only when their executable or project dependency exists.
- Playwright MCP uses `@playwright/mcp@latest` through `npx`, so it needs
  network access on first start and can change versions.
- No custom plugin is used.
