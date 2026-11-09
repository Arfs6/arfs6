---
name: html
description: Accessible semantic HTML for documents, forms, navigation, headings, media, and screen-reader navigation. Use when writing or reviewing HTML.
compatibility: opencode
---

# HTML

## When to use me

Use this skill for HTML structure, accessibility, forms, navigation, or
document semantics.

## Structure

- Use one main page heading and a logical heading order.
- Use landmarks such as `header`, `nav`, `main`, `aside`, and `footer`.
- Prefer native elements: `button`, `a`, `input`, `label`, `details`, and
  `dialog` before custom widgets.
- Keep the DOM order meaningful because screen readers and keyboard users
  follow it.
- Declare the page language with `lang`.

## Forms

- Give every input a visible `label`.
- Associate labels with controls using `for` and `id`.
- Group related controls with `fieldset` and `legend`.
- Provide clear error text and instructions.
- Do not use placeholder text as the only label.

## Media and links

- Provide useful alternative text for meaningful images.
- Use empty `alt` text for decorative images.
- Make link text describe the destination.
- Add captions or transcripts for time-based media.

## ARIA

- Use ARIA only when native HTML cannot express the behaviour.
- Do not add redundant roles to native elements.
- Keep keyboard interaction and focus management consistent with the widget
  pattern.

## Review checklist

- Is the heading order logical?
- Is every control labelled?
- Does the page work with a keyboard alone?
- Is the reading order the same as the visual order?
- Are errors announced and associated with the right field?

## Teaching mode

Ask the learner to describe the page as a outline of headings and landmarks
before writing markup.
