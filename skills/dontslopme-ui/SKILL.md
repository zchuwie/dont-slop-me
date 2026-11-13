---
name: dontslopme-ui
description: UI craft and motion skill for AI coding agents. Enforces design restraint, purposeful color palettes, tactile spring physics, accessible contrast, and native platform components over generic AI slop.
license: MIT
---

# dontslopme-ui

Visual craft, component discipline, and tactile motion skill for AI coding agents.

Follow these rules whenever building, styling, or refactoring user interfaces across web, mobile, and desktop.

## Core UI Craft Principles

### 1. Intentional Color and Surfaces

Avoid default AI styling habits:

- Never use default blue-to-purple or cyan gradients as a fallback theme.
- Limit palettes to 2-3 core brand tones and at most 1 intentional accent.
- Avoid diffuse glows and stacked glassmorphism (`backdrop-blur` on every container).
- Give surfaces a grounded physical plane rather than floating soft shadows everywhere.

### 2. Form Follows Function (No Pill Soup)

Use shape and geometry to communicate interactive affordances:

- Reserve rounded pill shapes for primary tags or special callouts, not every container.
- Establish consistent radius scales (for example: 4px for inputs, 8px for cards).
- Avoid sterile defaults: ensure adequate contrast, visual rhythm, and clear typography.

### 3. Tactile Motion and Physics

Animations must feel physical and responsive, not mechanical:

- Use spring physics or snappy cubic-bezier curves instead of linear easings.
- Keep micro-interaction durations under 150ms and surface reveals under 300ms.
- Respect accessibility: always support `prefers-reduced-motion`.

### 4. Native Platform Primitives First

Rely on native primitives before introducing heavy component dependencies:

- Use standard HTML5 elements (`<dialog>`, `<details>`, `<input type="date">`).
- Use native CSS grid and flexbox instead of bloated third-party layout wrappers.
- On iOS and Android, leverage standard SwiftUI and Flutter platform widgets.

## JIT Reference Routing

Load deep UI references only when the task requires them:

- Visual defect catalog, styling anti-patterns, surface rules: read `references/anti-slop-checklist.md`.
- Easing curves, spring configs, framework tokens, reduced motion: read `references/ux-and-motion-spec.md`.

## Telegraphic UI Audit Format

Report UI defects as dense, single-line bullets:

```text
path/to/component.ext:line - [category] - defect description -> proposed surgical fix
```
