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
