# arfs6 dotfiles

Personal configurations and small scripts for the tools I use: shell, Neovim,
tmux, oh-my-posh, opencode, and a few utilities.

The repository is designed to be installed once and then kept up to date
automatically. Managed home files are symlinks into this repository, so editing
`~/.sh_aliases` (for example) edits the repository file directly. A systemd timer
commits and pushes those changes without prompting.

## Quick start

Requirements: `git`, `bash`, `rsync`, and systemd user services. `opencode` is
optional but is used to generate commit messages.

```bash
git clone git@github.com:arfs6/arfs6.git ~/repos/arfs6
cd ~/repos/arfs6
./setup.sh
```

On an existing machine whose current home files should become the repository
content, import them first:

```bash
./setup.sh --adopt
```

`setup.sh` safely backs up anything it replaces under
`~/.local/state/arfs6/backups/<timestamp>/`.

Options:

```text
--adopt             Import existing home files into the repo before linking
--interval PERIOD   hourly, daily, weekly, or none (default: daily)
--no-timer          Skip installing the systemd timer
--dry-run           Show what would happen without changing anything
```

No `sudo` is required. Everything is installed in the user's home directory and
runs as a systemd user service.

## Automatic sync

`./setup.sh` installs `arfs6-sync.timer`. Depending on the chosen interval, it
runs `scripts/sync.sh`, which:

1. Commits all repository changes.
2. Asks `opencode` for a short commit message (with a fallback if unavailable).
3. Rebases on the upstream branch and pushes.
4. Pulls remote changes back into the working tree, which updates the symlinked
   home files.

Because this is a user service, it runs while you are logged in. To let it run
when you are logged out, enable lingering once:

```bash
loginctl enable-linger "$USER"
```

Check the timer and logs with:

```bash
systemctl --user list-timers arfs6-sync.timer
journalctl --user -u arfs6-sync.service
```

If systemd user services are not available, `setup.sh` prints an equivalent cron
line instead.

## Manual use

```bash
./sync.sh                 # commit, pull, and push now
./sync.sh --dry-run       # show pending changes
./sync.sh --no-ai         # use the fallback commit message
./sync.sh --message "..." # provide a commit message
./sync.sh --no-push       # commit locally only
```

`setup.sh` also installs `~/.local/bin/arfs6-sync`, so `arfs6-sync` works from
any directory.

## Managed files

The mapping lives in [`dotfiles.manifest`](./dotfiles.manifest):

```text
configs/shells/.bashrc             -> ~/.bashrc
configs/shells/.zshrc              -> ~/.zshrc
configs/shells/.sh_aliases         -> ~/.sh_aliases
configs/shells/.sh_env             -> ~/.sh_env
configs/tmux/.tmux.conf            -> ~/.tmux.conf
configs/ohmyposh/arfs6.omp.json    -> ~/.poshthemes/arfs6.omp.json
configs/neovim/nvim                -> ~/.config/nvim
configs/opencode/opencode.jsonc    -> ~/.config/opencode/opencode.jsonc
configs/opencode/cli.json          -> ~/.config/opencode/cli.json
configs/opencode/AGENTS.md         -> ~/.config/opencode/AGENTS.md
configs/opencode/LEARNING.md       -> ~/.config/opencode/LEARNING.md
configs/opencode/README.md         -> ~/.config/opencode/README.md
configs/opencode/agents            -> ~/.config/opencode/agents
configs/opencode/commands          -> ~/.config/opencode/commands
configs/opencode/skills            -> ~/.config/opencode/skills
scripts/bash/clip.sh               -> ~/.local/bin/clip
scripts/bash/paste.sh              -> ~/.local/bin/paste
scripts/python/match.py            -> ~/.local/bin/match
scripts/python/battery_health.pyw  -> ~/.local/bin/battery_health.pyw
```

To add another file or directory, put it in this repository, add a line to
`dotfiles.manifest`, and run `./setup.sh` again. Existing links are left alone.

## Repository layout

```text
.
├── configs/          Tool configurations
│   ├── neovim/       Neovim configuration
│   ├── ohmyposh/     Prompt theme
│   ├── opencode/     opencode agents, commands, skills, and terminal settings
│   ├── shells/       bash, zsh, aliases, and environment
│   └── tmux/         tmux configuration
├── scripts/          Utility scripts and the sync implementation
├── dotfiles.manifest Repo path to home path mapping
├── setup.sh          Install links, command, and timer
└── sync.sh           Commit, pull, and push changes
```

## Removing the automatic sync

```bash
systemctl --user disable --now arfs6-sync.timer
```

Then remove the symlinks you no longer want and restore files from the backup
directory if needed.

## Links

- Website: <https://arfs6.me> or <https://arfs6.github.io>
- Email: arfs6.mail@gmail.com
- Mastodon: [arfs6@hachyderm.io](https://hachyderm.io/@arfs6)
- X: <https://twitter.com/arf_s6>
