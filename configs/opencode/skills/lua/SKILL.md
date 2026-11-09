---
name: lua
description: Lua workflows for modules, tables, metatables, local scope, formatting, and testing. Use when writing or reviewing Lua.
compatibility: opencode
---

# Lua

## When to use me

Use this skill for Lua implementation, review, testing, or debugging.

## Discover the project first

- Find the runtime and version: Lua, LuaJIT, Neovim, or a game engine.
- Read the project's formatting and lint configuration.
- Check whether the project uses `require`, a plugin loader, or a custom module
  system.

## Common verification

Use only the tools present in the project:

```bash
stylua --check .
luacheck .
lua path/to/test.lua
```

For Neovim configuration, check the Neovim version and use its Lua runtime
instead of assuming a standalone interpreter.

## Code guidance

- Keep variables `local` unless a global is required by the environment.
- Remember that tables are references; copy explicitly when ownership matters.
- Remember that array indices start at 1.
- Use `pairs` for unordered tables and `ipairs` for sequence traversal.
- Use metatables deliberately and document the contract in the prompt or tests,
  not with code comments.
- Close resources explicitly when the runtime does not provide a scope guard.
- Avoid hidden global state.

## Review checklist

- Are all variables local?
- Is table mutation shared unexpectedly?
- Are nil values handled without crashing?
- Are module boundaries clear?
- Are errors returned, raised, or logged consistently?

## Teaching mode

Ask the learner to draw the table references in text: which names point to the
same table and which are copies.
