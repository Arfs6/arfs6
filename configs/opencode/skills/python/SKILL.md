---
name: python
description: Python workflows for environments, type hints, testing, formatting, and safe idiomatic code. Use when writing or reviewing Python.
compatibility: opencode
---

# Python

## When to use me

Use this skill for Python implementation, review, testing, or debugging.

## Discover the project first

- Read `pyproject.toml`, `requirements.txt`, `setup.cfg`, or `tox.ini`.
- Find the configured test runner and linter before inventing commands.
- Prefer the project's existing virtual environment or package manager.
- Check whether the project uses `src/` layout, packages, or scripts.

## Common verification

Use only the commands the project supports:

```bash
python -m pytest
python -m pytest path/to/test_file.py -k pattern
ruff check .
ruff format --check .
mypy .
```

## Code guidance

- Use type hints for public functions and non-obvious data.
- Use context managers for files, locks, and connections.
- Do not use mutable default arguments.
- Catch specific exceptions; do not swallow errors with bare `except`.
- Prefer small functions with clear inputs and outputs.
- Use `pathlib` for paths when the project already does.
- Keep side effects out of import time.

## Review checklist

- Are errors handled intentionally?
- Are resources closed on every path?
- Are types and return values consistent?
- Are tests focused on observable behaviour?
- Is the code idiomatic for the project's supported Python version?

## Teaching mode

Ask the learner to predict what a test will do before running it. Explain
tracebacks from the innermost relevant frame outward.
