---
name: research
description: Investigate a question against primary sources and save cited findings as Markdown. Use for web research, current documentation, API facts, or delegated reading.
compatibility: opencode
---

# Research

Goal: an answer a reader can verify, with every factual claim traced to the
source that owns it.

Use a fresh context for the reading. In `build`, launch a `general` subagent for
web research or an `explore` subagent for codebase questions, give it a
self-contained prompt, then check its citations yourself. In `mentor`, use web
search and guide the user through judging sources; do not write project files.
If web search reports no provider, ask the user to connect one with `/connect`
or `opencode auth login <provider>` instead of answering from memory.

## Method

1. Prefer primary sources: official documentation, specifications, source code,
   and first-party APIs. A blog post or summary can point to a source, but it
   is not the evidence.
2. Follow each claim to the page, file, or API response that owns it. Record
   the URL or path and the date you read it. Separate facts from inference.
3. Note what you could not verify. Do not fill gaps with plausible guesses.

## Output

In `build`, write one Markdown file. Use the repository's existing notes
convention if it has one; otherwise create `docs/research/<topic>.md` and tell
the user where it is. Start with the question, then a short answer, then
findings with inline source links, then open questions. In `mentor`, coach the
user through that structure and let them write the file; do not edit project
files yourself.

Keep central work records in `~/.opencode/records`; this file is the research
result, not a record. In `build`, link it from an active record when the
research supports current work. In `mentor`, ask the user to add the link or
offer a `build` pass.
