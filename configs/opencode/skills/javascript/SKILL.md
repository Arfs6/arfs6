---
name: javascript
description: JavaScript workflows for package managers, modules, async code, testing, linting, and browser or Node.js boundaries. Use when writing or reviewing JavaScript.
compatibility: opencode
---

# JavaScript

## When to use me

Use this skill for JavaScript implementation, review, testing, or debugging.

## Discover the project first

- Read `package.json` and the lockfile.
- Use the package manager indicated by the lockfile: npm, pnpm, yarn, or Bun.
- Check whether the project uses ES modules or CommonJS.
- Read the configured scripts before inventing commands.
- Confirm whether the target is the browser, Node.js, or both.

## Common verification

```bash
npm test
npm run lint
npm run build
```

Substitute the project's package manager and script names. Prefer focused test
files while iterating.

## Code guidance

- Use `const` by default and `let` when reassignment is necessary.
- Handle promise rejections; do not leave floating promises.
- Use `async`/`await` consistently within a code path.
- Avoid mutating shared objects unless the project expects it.
- Validate data at boundaries such as network input and storage.
- Do not rely on implicit type coercion.
- Keep browser-only APIs out of server code and vice versa.

## Review checklist

- Are errors and rejections handled?
- Is cancellation or cleanup needed?
- Are module boundaries respected?
- Are browser and server assumptions separated?
- Are tests deterministic?
- Does the change match the project's existing style?

## Teaching mode

Ask the learner to trace the order of asynchronous operations before running
the code.
