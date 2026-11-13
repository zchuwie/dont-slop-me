# Copy and Code Hygiene Reference

Standards for anti-slop copy, comment sanitation, design contracts, and telegraphic communication for AI coding agents.

## Caveman + Ponytail Output Discipline

AI agents frequently inflate responses with conversational pleasantries, hedging disclaimers, and unnecessary code narration. The Caveman + Ponytail discipline enforces maximum information density with minimal token cost.

### Core Output Rules

- **Zero conversational preamble:** Never start responses with "Sure!", "Certainly!", "I can help you with that", or "Great question!".
- **Zero post-code narration:** Do not restate what the code does line by line unless the user explicitly requested a tutorial.
- **Surgical diffs only:** Emit compact diffs or single-block replacements instead of reprinting 200+ lines of unchanged source.
- **Audit schema:** Format every finding as `file:line | violation | fix` followed by a single-line gate verdict.

## The 5-Line Design Contract

Before writing any new component, page, or complex layout, declare a 5-line design contract. This aligns domain requirements without speculative over-engineering.

```text
1. Codebase Fit: [Stack detected, manifest packages used, existing tokens referenced]
2. Domain Tier & Palette: [Dense SaaS | Editorial/Marketing | Playful Consumer], [1 accent token], [no pure black/white]
3. Typography: [Header font / Body font], tabular-nums for numeric columns
4. Dials: ENERGY [1-5] | RHYTHM [1-5] | MOTION [1-5] | Focal Point: [target element] | Cadence: [steady/varied]
5. State Coverage: Loading: [skeleton/spinner], Empty: [illustration/text], Error: [retry banner], Success: [inline badge]
```

### Domain Calibration Tiers

Calibrate density, typography, and motion to the product domain:

#### 1. Dense SaaS

- **Target products:** Dashboards, analytics platforms, developer tooling, financial tables.
- **Characteristics:** 12px to 14px compact typography, high information density, muted 1px borders, subtle hover lifts, strict `tabular-nums` alignment on tables and metrics.
- **Dials:** ENERGY 2 | RHYTHM 2 | MOTION 1.

#### 2. Editorial / Marketing

- **Target products:** Blogs, documentation sites, brand landing pages, product announcements.
- **Characteristics:** High typographic contrast (bold display header + legible text body), generous whitespace, narrative pacing, curated visual focal points.
- **Dials:** ENERGY 4 | RHYTHM 4 | MOTION 3.

#### 3. Playful Consumer

- **Target products:** Mobile apps, community tools, educational platforms, personal productivity.
- **Characteristics:** Friendly geometry, tactile spring micro-presses (`scale(0.97)`), warm tinted neutral canvases, celebratory milestone feedback.
- **Dials:** ENERGY 5 | RHYTHM 3 | MOTION 4.

## Fast Path for Micro-Edits

When executing targeted bug fixes, single-line adjustments, or localized refactors touching under 20 lines:

- Skip the 5-line Design Contract.
- Skip conversational greetings and post-mortems.
- Emit the surgical code change directly.
- Skip the audit gate summary unless an audit was specifically requested.

## Anti-Slop Copywriting Standards

AI models default to vague marketing adjectives, corporate jargon, and passive padding. Enforce concrete, user-action language.

### Forbidden Words and Phrases

The following terms signal AI-generated filler and must be eliminated from all UI copy, commit messages, and documentation:

- **Inflated buzzwords:** supercharge, seamless, seamlessly, unlock, elevate, empower, revolutionize, game-changer, cutting-edge, state-of-the-art.
- **Academic and literary cliches:** delve, tapestry, testament, beacon, foster, resonate, paramount, symphony.
- **Corporate filler:** leverage, streamline, synergy, holistically, robust, scalable architecture.
- **Conversational scaffolding:** in conclusion, it is worth noting, look no further, without further ado, let us dive in.

### Slop vs Direct Copy Matrix

| Slop Pattern | Direct Alternative | Rationale |
| :--- | :--- | :--- |
| "Supercharge your team's workflow with seamless sync." | "Sync database records in real time." | Concrete technical utility replaces vague buzzwords. |
| "Unlock the power of next-generation analytics." | "Filter query performance by endpoint." | Actionable capability replaces marketing hyperbole. |
| "A testament to cutting-edge craft and design." | "Built with accessible contrast and native dialogs." | Measurable engineering standard replaces subjective boast. |
| "Delve into your data with our powerful tools." | "Search logs by timestamp and status code." | Clear command replaces literary filler. |

## Code Comment Hygiene

Code comments cost tokens on every read. Obvious comments obscure logic and degrade context windows.

### Prohibited Comments

- **Echo comments:** Comments that simply narrate code statements:
  ```typescript
  // BAD: Narrates standard assignment
  // Set count to zero
  let count = 0;

  // BAD: Narrates standard conditional
  // Check if user is authenticated
  if (!isAuthenticated) return null;
  ```

- **Dead code:** Commented-out code blocks left behind. Rely on git history.
- **ASCII dividers:** Large decorative separators (such as `// ============ HELPERS ============`).
- **Generated banners:** Headers like `// Created by Assistant on 2026-11-13`.

### Permitted Comments

Reserve comments exclusively for non-obvious constraints:

- **Browser and engine bugs:** Documenting workarounds for browser-specific quirks.
- **Mathematical invariants:** Explaining non-obvious physics algorithms or coordinate formulas.
- **External protocol requirements:** Explaining quirky schema mandates from legacy external APIs.
- **Security trust boundaries:** Rationale for sanitization methods or token validation logic.

## Standard Audit Gate Format

When auditing a codebase or reviewing pull requests:

1. List violations in single-line rows:
   ```text
   src/views/Dashboard.tsx:42 | echo-comment | `// set state` echoes hook call -> remove comment
   src/components/Banner.tsx:15 | slop-copy | "Supercharge your work" -> replace with "Export reports to CSV"
   src/styles/theme.css:88 | hardcoded-color | Pure black `#000000` found -> replace with `#0f172a`
   ```

2. Conclude with a single-line gate verdict:
   ```text
   GATE: PASS
   ```
   or
   ```text
   GATE: FAIL (3 issues detected)
   ```
