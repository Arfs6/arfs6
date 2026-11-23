---
name: tdd
description: Test-driven development with a red-green loop. Use when the user asks to build a feature or fix a bug test-first, mentions red-green-refactor, or wants integration tests.
compatibility: opencode
---

# Test-driven development

Red → green is one loop per behavior. In `mentor`, the user writes each test
and implementation while you ask the next question and review the result. In
`build`, you write them and explain what each cycle proves.

Before the first test, agree the seams with the user. A seam is a public
boundary where behavior can be observed without reaching into internals. Put
the seams in the active record's `## Scope` or `## Decisions needed`, with one
line each on what the seam catches and what it misses. Ask `plan` to update the
record, or have the user write it. If the interface shape itself is unclear,
record that as a decision instead of guessing.

A test worth keeping:

- exercises a public interface, not private code or internal state;
- reads like a specification of user-visible behavior;
- gets its expected value from an independent source such as a worked example,
  a spec, or a literal, not from a copy of the implementation's logic;
- survives a refactor that keeps behavior unchanged.

Avoid:

- implementation-coupled tests that break when internals change but behavior
  does not;
- tautological tests that recompute the expected value the same way the code
  does;
- horizontal slicing, meaning all tests first and all code afterwards. Work in
  vertical slices: one test, one implementation, then the next test.

## Rules of the loop

1. Red: write one failing test at one agreed seam and run it. Confirm the
   failure is the behavior you intend to add.
2. Green: write only enough code to pass that test. Run the project's test
   command and report the actual result.
3. Refactor after green but before the reviewer pass, then rerun the project's
   test command. Any cleanup after the reviewer pass needs a fresh review of
   the new diff.

Use the project's existing vocabulary for test names when `AGENTS.md`, the
README, or domain docs define it. Do not weaken or delete a failing test to
get green.
