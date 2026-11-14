---
name: marp
description: Create, format, preview, and compile Markdown presentations with Marp.
compatibility: opencode
---

# Marp

## When to use me

Use this skill when creating or compiling a presentation from Markdown with
[Marp](https://marp.app/).

## Minimal presentation

Start a presentation with Marp front matter. Separate slides with a line
containing three hyphens.

```markdown
---
marp: true
theme: default
paginate: true
---

# Title

Short subtitle

---

## Another slide

- Keep the slide focused.
- Use fenced code blocks for source excerpts.
```

## Syntax

- `---` separates slides.
- `<!-- _class: lead -->` applies a class to the current slide.
- `<!-- _paginate: false -->` hides the page number on the current slide.
- `<!-- theme: default -->` selects a theme.
- `<!-- fit -->` asks Marp to fit overflowing text.
- Use fenced blocks such as ```` ```go ```` or ```` ```json ```` for code.
- Use normal Markdown headings, lists, links, emphasis, and tables.

Prefer short slides and readable code excerpts. Do not use images when the
source text itself is the requested content.

## Compile

With a globally installed Marp CLI:

```bash
marp presentation.md --html
marp presentation.md --pdf
marp presentation.md --pptx
marp --preview presentation.md
```

Without a global install, use the package runner:

```bash
npx @marp-team/marp-cli presentation.md --html
npx @marp-team/marp-cli presentation.md --pdf
npx @marp-team/marp-cli presentation.md --pptx
```

The input is Markdown. `--html`, `--pdf`, and `--pptx` select the output
format; `--preview` starts a local preview server. Add `-o output.ext` when a
specific output path is needed.

## Verification

Before sharing a deck, preview it and compile the intended output format. Check
that each slide has one clear purpose, code blocks fit without clipping, and
the source contains no accidental image references or unclosed fences.
