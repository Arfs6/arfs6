---
name: go
description: Go workflows for modules, formatting, tests, errors, context, concurrency, and resource cleanup. Use when writing or reviewing Go.
compatibility: opencode
---

# Go

## When to use me

Use this skill for Go implementation, review, testing, or debugging.

## Discover the project first

- Read `go.mod` and `go.sum`.
- Check the `Makefile` or CI for the supported Go version and commands.
- Inspect existing package boundaries before adding abstractions.

## Common verification

```bash
gofmt -w path/to/file.go
go test ./...
go test ./path/to/package -run TestName -v
go vet ./...
```

Run `go build ./...` when the change affects compilation or packages.

## Live debugger workflow

Use a debugger-backed MCP tool only after the Go debug adapter is available and
verified. For Go, the normal adapter is Delve (`dlv dap`). A typical proof must
cover:

1. Launch or attach to a small Go target.
2. Set a breakpoint at a known source line.
3. Continue until that breakpoint.
4. Step over, into, and out of a function.
5. Inspect local variables and stack state.
6. Stop the debugger and verify cleanup.

Prefer `go build -gcflags="all=-N -l" -o <binary> <target>` or package-specific
commands when optimization or inlining would hide the source behavior. Do not
claim a live debug check succeeded until the debugger reports the stopped
location and observed state. If the MCP server, Delve, or DAP adapter is
missing, remain in diagnosis mode: use tests, logs, stack traces, and focused
commands rather than silently changing or installing dependencies.

## Code guidance

- Return errors; wrap them with context when the caller needs it.
- Keep error checks close to the call.
- Use `context.Context` for cancellation and deadlines in blocking work.
- Use `defer` for cleanup and `defer` plus named returns when recovery changes
  them.
- Start goroutines only with a clear lifecycle and shutdown path.
- Protect shared mutable state or prefer ownership transfer.
- Keep interfaces small and define them where they are used.
- Do not add comments unless the user asks.

## Review checklist

- Are all errors handled?
- Can a goroutine leak?
- Are channels closed by the correct owner?
- Is context cancellation respected?
- Are tests deterministic and race-free?
- Is the zero value useful?

## Teaching mode

Ask the learner to explain who owns each goroutine and channel before writing
concurrent code.
