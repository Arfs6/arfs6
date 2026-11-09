---
name: css
description: Accessible responsive CSS with focus states, contrast, motion preferences, logical properties, and maintainable selectors. Use when writing or reviewing CSS.
compatibility: opencode
---

# CSS

## When to use me

Use this skill for layout, responsive design, focus styles, colour, motion, or
CSS maintainability.

## Accessibility

- Keep visible focus indicators; never remove them without an accessible
  replacement.
- Maintain readable text contrast.
- Respect `prefers-reduced-motion` for non-essential animation.
- Do not convey meaning through colour alone.
- Keep touch targets large enough.
- Test zoom and narrow viewports, not only desktop widths.

## Layout

- Prefer layout systems such as grid and flexbox over absolute positioning.
- Use logical properties such as `margin-inline` and `padding-block` when the
  project supports them.
- Avoid fixed heights that break when text wraps or grows.
- Use relative units where they support resizing and zoom.

## Maintainability

- Follow the project's naming convention.
- Keep selectors shallow.
- Avoid `!important` unless there is a documented reason.
- Group related declarations and keep custom properties meaningful.
- Do not duplicate existing design tokens.

## Review checklist

- Is focus visible?
- Is contrast adequate?
- Does the layout survive text zoom and narrow screens?
- Is motion optional?
- Are selectors and tokens consistent with the project?
- Is meaning conveyed without colour alone?

## Teaching mode

Ask the learner to describe the layout in text at narrow and wide widths before
writing CSS.
