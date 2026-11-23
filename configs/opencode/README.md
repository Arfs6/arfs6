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
- `commands/`: `/learn`, `/build`, `/implement`, `/plan`, `/audit`, `/debug`,
  `/review`, `/docs`, and `/ledger`.
- `skills/`: short hand-written references and the vendored `playwright-cli`
  skill.
- `AGENTS.md`: global teaching, accessibility, review, debugging, permission,
  and completion rules.
- `LEARNING.md`: learning ledger. It records demonstrated understanding.

Record files are persistent work records, stored centrally under
`~/.opencode/records/<project_name>/<title>.md`. Each begins with a searchable
header containing source, project, description, status, and fixed point. Records
then capture the issue, scope, solution shape, decisions, execution checkboxes,
audit findings, and history. Audit records are a shorter variant: header, issue,
scope, findings, and history. The `plan` agent creates, updates, and archives
records there and in `~/.local/share/opencode/records/<project_name>/<title>.md`;
`build` marks executed steps with a date and evidence. `/audit` runs in a fresh
child session, invokes `reviewer`, and can audit a record found by title,
source, or description, the whole repository, or a commit. Repository and
commit audits create a dedicated record under the active record root. Every
execution checklist has a stop-and-audit step before any commit or permanent
change. Stale records move to the archive instead of being deleted. The
repository does not keep work records.

## Agents and commands

### Primary agents

- `mentor`: learning-mode coach that guides you to become a better programmer
  while you write the code. It may edit only `LEARNING.md`; no other edits,
  shell commands, or `build` calls.
- `build`: implementation-mode engineer that does the work itself and explains
  each decision with the context needed to follow along. It states the plan and
  risks before editing, reviews material changes with `reviewer`, runs checks,
  and reports results.

### Subagents

- `plan`: read-only on project files; writes and archives persistent work
  records only under the two record trees; subagent only, callable by both
  primary agents.
- `debugger`: evidence-based diagnosis without editing.
- `reviewer`: read-only review with severity labels and verification evidence.
- `tech-writer`: documentation-only edits; never `LEARNING.md`, agent, command,
  or skill definitions. OpenCode's built-in `explore` and `general` are also
  available to `build` for fresh-context research legwork.

Press `<leader>a` (`ctrl+x`, then `a`) for the agent list, or `tab` to cycle.
Commands: `/learn`, `/build`, `/implement` (alias of `/build`), `/plan`,
`/audit`, `/debug`, `/review`, `/docs`, and `/ledger`. Use `/audit` for a record,
`/audit repo` for the whole repository, or `/audit <sha>` for one commit. It uses
a fresh child session and invokes `reviewer`, so `subagent_depth` is `2`.

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

Web search is enabled with `websearch.provider: "random"` and an allow
permission. Connect one provider before using it: `/connect` in the TUI, or
`opencode auth login <provider>` with `exa`, `firecrawl`, `parallel`, `tavily`,
or `tinyfish`. You can also set the matching `EXA_API_KEY`, `FIRECRAWL_API_KEY`,
`PARALLEL_API_KEY`, `TAVILY_API_KEY`, or `TINYFISH_API_KEY` before starting
OpenCode. Credentials stay outside this repository.

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
Marp, and Playwright CLI. The Git skill also covers PR bodies and read-first
`gh` usage. Six adapted skills add plain-language re-pitches (`wait-what`),
two-axis review (`code-review`), help writing agent docs
(`writing-for-agents`), primary-source research (`research`), red-green test
discipline (`tdd`), and decision interviews (`grilling`). They are loaded on
demand by the `skill` tool. The mandatory `reviewer` subagent stays the default
review authority; `code-review` is an optional deeper pass after it.

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

- Outside-project paths ask first except `~/.config/opencode/*`, record storage,
  and `/tmp/*`.
- Reads are allowed except secret-bearing files, which ask.
- Shell commands are allowed until an effectful prefix asks: destructive file
  operations, Git history rewrites and remote operations, GitHub and Docker
  mutations, publishes, remote execution, process/service control, package
  managers, and nested shells.
- Edits are allowed except secret-bearing files. Subagents use their own
  permission rules.
- MCP tools are not covered by the generic rules unless a `<server>_<tool>`
  action names them. Playwright tools are therefore allowed for every agent;
  `mentor` limits its use by instruction.
- `policies` hard-deny `sudo`, `mkfs`, `shutdown`, and `reboot`.

Agent edits are append-only overrides: `mentor` may edit only `LEARNING.md` and
may invoke `plan`, `debugger`, `reviewer`, and `tech-writer`; `build` may edit
and invoke subagents; `plan` may create, edit, and move files only in the two
record directories; `debugger` cannot edit; `reviewer` allows only read-only Git
commands; `tech-writer` allows Markdown, MDX, and text files but not agent,
command, skill, or ledger files.

Use the v2 `shell` action. Agents call `shell` directly and reserve `execute`
for Code Mode tools in its catalog.

## Change review and commits

Every material change-set is reviewed before completion. The calling agent
invokes `reviewer` on the working-tree diff and reports why, what it found, and
how the findings were handled. It also names any other subagents used and what
they reported. When a subagent such as `tech-writer` produces a diff, its caller
performs this review and reporting. Trivial changes get a documented
self-review. `/review` requests a manual review.

Commit messages use `type(area): brief summary`, followed by why the change was
made. `./sync.sh --message "..."` overrides the generated message.

## Installation and verification

`setup.sh` links these files into `~/.config/opencode` and creates the two
central record roots. After editing:

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

`--standalone` reads the files without contacting the background service.
Config changes reload automatically; use `/reload` to force a full reload.

## Limitations

- Web notifications require an open tab, browser permission, and manual
  enabling for some categories.
- The `opencode serve` migration race is unresolved; use `opencode pair`.
- Desktop notifications depend on the terminal and tmux.
- Formatters run only when their executable or project dependency exists.
- Playwright MCP uses `@playwright/mcp@latest` through `npx`, so it needs
  network access on first start and can change versions.
- No custom plugin is used.
