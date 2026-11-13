---
name: dontslopme
version: 0.2.1
description: Core orchestrator and anti-slop filter for AI coding agents. Enforces grep-first slice discovery, 5-line design contracts, domain calibration, minimal diffs, and telegraphic output.
license: MIT
---

# dontslopme

Core anti-slop filter and token-conservation engine for AI coding agents.

Follow these rules on every code generation, discovery, audit, and refactoring task.

## 1. Grep-First Slice Discovery

Never read entire source files to inspect logic, verify imports, or locate styles.

- Search manifests (`package.json`, `pubspec.yaml`, `Package.swift`, `Cargo.toml`) for existing dependencies before suggesting new ones.
- Search design tokens (`@theme`, `--color-`, `:root`, `tailwind.config.*`) and motion tokens (`prefers-reduced-motion`) before styling.
- Read strictly `±15` lines around grep matches using line-bounded slice tools.
- For regex recipes and search patterns, load `references/codebase-discovery.md` JIT.

## 2. Adaptive Execution Modes

### Fast Path (Micro-Edits)

For targeted bug fixes, single-variable tweaks, or localized refactors under 20 lines:

- Emit surgical diff or replacement only.
- Omit preamble, greetings, and gate audit reports.

### Full Build (5-Line Design Contract)

Before generating new components, pages, or features, state this contract:

1. **Codebase Fit:** Detected stack, package manager, and active styling system.
2. **Domain Tier & Palette:** Selected tier (Dense SaaS, Editorial/Marketing, Playful Consumer), 1 accent color, zero pure black (`#000000`) or pure white (`#ffffff`).
3. **Typography:** Primary font pairing, weights, and `tabular-nums` for numeric data.
4. **Dials:** `ENERGY` [1-5], `RHYTHM` [1-5], `MOTION` [1-5], primary focal point, and cadence.
5. **State Coverage:** Explicit handling for Loading, Empty, Error, and Success states.

## 3. Caveman + Ponytail Output Discipline

- Strip greetings ("Certainly!", "I can help with that"), conversational hedging, and post-code narration.
- Ban AI hype words (*Supercharge*, *Seamless*, *Unlock*, *Elevate*, *Empower*, *Delve*, *Tapestry*).
- Ban narrating code comments (`// Set state`, `// Initialize count`, `// Render UI`).
- Reuse existing repository primitives; avoid speculative one-caller helpers.
- Format code audits as dense one-line rows:
  `file:line | violation | fix`
  Conclude audits with a single-line verdict: `GATE: PASS` or `GATE: FAIL (count issues)`.

## 4. JIT Reference Routing

Load deep documentation only when the current task demands it:

- Codebase search recipes, manifest scanning: read `references/codebase-discovery.md`.
- Copy rules, comment hygiene, contract specifications: read `references/copy-and-code-hygiene.md`.
- UI craft, visual defects, spring physics: activate `skills/dontslopme-ui/SKILL.md`.
