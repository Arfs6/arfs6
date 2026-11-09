---
name: zig
description: Zig workflows for build steps, formatting, tests, allocators, error unions, and explicit memory ownership. Use when writing or reviewing Zig.
compatibility: opencode
---

# Zig

## When to use me

Use this skill for Zig implementation, review, testing, or debugging.

## Discover the project first

- Read `build.zig` and `build.zig.zon`.
- Check the supported Zig version; Zig APIs change between releases.
- Find the project's build and test steps.

## Common verification

```bash
zig fmt path/to/file.zig
zig build test
zig build
```

Use the project's declared steps when they differ.

## Code guidance

- Choose an allocator deliberately and pass it explicitly.
- Free every allocation on every successful and failing path.
- Use `defer` for unconditional cleanup and `errdefer` for failure-only
  cleanup.
- Handle error unions explicitly; do not ignore errors.
- Prefer slices and explicit lengths over pointer arithmetic.
- Avoid undefined behaviour and uninitialised memory.
- Keep ownership clear: which function allocates, which frees, and for how
  long a value is valid.
- Do not add comments unless the user asks.

## Review checklist

- Is every allocation freed?
- Are `defer` and `errdefer` used correctly?
- Are error unions propagated or handled?
- Is aliasing safe?
- Are integer conversions explicit?
- Are tests run for both success and failure paths?

## Teaching mode

Ask the learner to state the owner and lifetime of each pointer or allocation
before writing the implementation.
