---
name: dontslopme-ui
version: 0.2.0
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
- Never use harsh pure black (`#000000`) or pure white (`#ffffff`); use tinted slates, off-whites, and deep charcoals.
- Limit palettes to 2-3 core neutral tones and at most 1 intentional accent.
- Avoid diffuse glows and stacked glassmorphism (`backdrop-blur` on every container).
- Give surfaces a grounded physical plane rather than floating soft shadows everywhere.

### 2. Geometry and Concentric Radii

Use shape and geometry to communicate interactive affordances:

- Reserve rounded pill shapes for primary tags or special callouts, not every container.
- Enforce concentric radii for nested containers: `inner_radius = max(0, outer_radius - padding)`.
- Establish consistent radius scales (for example: 6px inputs, 10px cards, 16px dialogs).
- Avoid sterile defaults: ensure adequate contrast, visual rhythm, and clear typography.

### 3. Tactile Motion and Animation Budgets

Animations must feel physical and responsive, not mechanical:

- Use spring physics or snappy cubic-bezier curves instead of linear easings.
- Micro-interactions must complete in under 150ms; dropdowns in 150-250ms; modal reveals in 200-300ms.
- Never allow animations to exceed 400ms.
- Respect accessibility: always provide `prefers-reduced-motion` fallbacks.

### 4. Native Platform Primitives First

Rely on native primitives before introducing heavy component dependencies:

- Use standard HTML5 elements (`<dialog>`, `<details>`, `<input type="date">`, `popover`).
- Use native CSS grid and flexbox instead of bloated third-party layout wrappers.
- On iOS and Android, leverage standard SwiftUI and Flutter platform widgets.

## JIT Reference Routing

Load deep UI references only when the task requires them:

- 20 AI design slop indicators to ban & 20 ways to unslop UI: read `references/anti-slop-checklist.md`.
- 20 principles of UX & animation + 20 tactile animation mechanics: read `references/ux-and-motion-spec.md`.

## Telegraphic UI Audit Format

Report UI defects as dense, single-line bullets:

```text
path/to/component.ext:line | violation | concise fix
GATE: PASS / FAIL
```
