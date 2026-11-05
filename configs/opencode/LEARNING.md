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
- Kafka-backed observability playground: learn Kafka basics by sending
  OpenTelemetry spans from the app to an observer program.

## Concepts

| Topic | Status | Evidence | Last checked | Next step |
| --- | --- | --- | --- | --- |
| Neovim LSP auto-start | learning | Guided through PATH checks and `vim.lsp.enable` | 2026-11-03 | Explain the startup flow without help |
| Treesitter parser auto-install | learning | Saw `auto_install` install a TOML parser on open | 2026-11-03 | Add a parser manually and explain how it is found |
| OpenTelemetry HTTP tracing | learning | Correctly predicted that removing the client transport splits one trace into two; read a three-span tree | 2026-11-04 | Explain how `traceparent` connects spans without help |
| Kafka fundamentals (topic, partition, offset, consumer group) | new | Asked how to use Kafka as transport for an observability program | 2026-11-04 | Explain why ordering is per-partition and how a consumer group splits partitions |
| Kafka Go producer/consumer | new | — | 2026-11-04 | Write a minimal producer and consumer against a local broker |
| Observability pipeline (SDK → exporter → backend) | learning | Has used an OTel TracerProvider with a stdout exporter | 2026-11-04 | Explain the path of a span from handler to observer |

## Session log

- 2026-11-03: Set up global LSPs and Treesitter auto-install; reviewed
  configuration and verified startup behavior. No independent practice
  yet.
- 2026-11-04: Committed the Go OpenTelemetry HTTP playground and
  reviewed real trace output; correctly predicted the effect of removing
  client instrumentation.
- 2026-11-04: Planned a Kafka-backed observability playground;
  identified Kafka, consumer groups, and custom OTel exporters as
  learning topics. No code written yet.
- 2026-11-04: Set up Kafka 4.4.0 KRaft in the native Docker image and
  verified a 3-partition topic, key-to-partition hashing, and
  consumer-group assignment with kcat. Awaiting the user's own
  explanation of the observed behaviour.
