# Learning Ledger

This file records demonstrated understanding. Agents read and update it
according to `AGENTS.md`.

## Rules

- `new` and `learning` entries may be added after I encounter a topic or
  ask about it.
- Only mark a topic `comfortable` or `teaching` after evidence: I
  explained it accurately in my own words, implemented it with little
  help, debugged it successfully, or reviewed related code correctly.
- One guided success is not mastery. Prefer `learning` until I have used
  the idea independently more than once.
- Do not mark something learned just because an agent explained it.
- Keep entries short. Link to files or notes when useful.
- Never use an entry to skip checking my understanding. Ask me to
  recall, predict, or apply the idea.

## Status key

- `new` — not studied yet
- `learning` — seen with guidance; needs practice
- `comfortable` — used independently
- `teaching` — can explain and teach it

## Current focus

- Neovim LSP and Treesitter configuration. Next check: explain how
  `vim.lsp.enable` starts a server and how Treesitter finds or installs a
  parser.

## Concepts

| Topic | Status | Evidence | Last checked | Next step |
| --- | --- | --- | --- | --- |
| Neovim LSP auto-start | learning | Guided through PATH checks and `vim.lsp.enable` | 2026-11-03 | Explain the startup flow without help |
| Treesitter parser auto-install | learning | Saw `auto_install` install a TOML parser on open | 2026-11-03 | Add a parser manually and explain how it is found |

## Session log

- 2026-11-03: Set up global LSPs and Treesitter auto-install; reviewed
  configuration and verified startup behavior. No independent practice
  yet.
