# dont-slop-me

A lightweight, multi-skill anti-slop governance system for AI coding agents built on the open `agentskills.io` standard.

`dont-slop-me` stops AI-generated slop: generic visual cliches, conversational padding, inflated hype copy, narrating comments, speculative wrappers, and context-bloating file reads.

## One-Line Global Installation

Install globally across macOS, Linux, WSL, and Windows with a single command:

### Via `npx skills` (Recommended)

```bash
npx skills add zchuwie/dont-slop-me --global
```

### Via Bash (`curl`) - macOS, Linux, WSL

```bash
curl -fsSL https://raw.githubusercontent.com/zchuwie/dont-slop-me/main/install.sh | bash
```

### Via PowerShell (`irm`) - Windows

```powershell
irm https://raw.githubusercontent.com/zchuwie/dont-slop-me/main/install.ps1 | iex
```

The installer automatically detects and registers skills in:

- Open Agent Skills standard: `~/.agents/skills/`
- Cursor: `~/.cursor/rules`
- VS Code Continue / Copilot: `~/.continue/prompts`
- Windsurf: `~/.codeium/windsurf/memories`
- Claude Code: `~/.claude/skills`
- Gemini CLI: `~/.gemini/skills`
- Codex CLI: `~/.codex/skills`

For project-local installation or uninstallation:

```bash
./install.sh --project      # Install to local project
./install.sh --uninstall    # Remove installed skills
```

```powershell
.\install.ps1 -Project      # Install to local project
.\install.ps1 -Uninstall    # Remove installed skills
```

## Repository Architecture

```text
dont-slop-me/
├── LICENSE
├── README.md
├── VERSION
├── install.sh
├── install.ps1
└── skills/
    ├── dont-slop-me/
    │   ├── SKILL.md
    │   └── references/
    │       ├── codebase-discovery.md
    │       └── copy-and-code-hygiene.md
    └── dont-slop-me-ui/
        ├── SKILL.md
        └── references/
            ├── anti-slop-checklist.md
            └── ux-and-motion-spec.md
```

## Core Execution Discipline

Every agent running `dont-slop-me` adheres to three execution rules:

### 1. Grep-First Slice Discovery (Low Input Tokens)

Never read full source files to inspect logic or verify imports:

- Scan manifests (`package.json`, `pubspec.yaml`, `Package.swift`, `Cargo.toml`) for existing packages before suggesting additions.
- Search design tokens (`@theme`, `--color-`, `:root`, `tailwind.config.*`) and motion tokens (`prefers-reduced-motion`) before writing CSS.
- Read strictly `±15` lines around matches using line-range slice tools.

### 2. Adaptive Execution Modes

- **Fast Path (Micro-Edits):** For targeted bug fixes under 20 lines, emit surgical diffs immediately. Skip greetings, preambles, and gate reports.
- **Full Build (5-Line Design Contract):** Before generating new components or pages, declare the 5-line contract:
  1. Codebase Fit: detected stack and design token sources.
  2. Domain Tier & Palette: tier selection, 1 accent color, no pure black (`#000000`) or pure white (`#ffffff`).
  3. Typography: header/body pairing, `tabular-nums` for numbers.
  4. Dials: `ENERGY` [1-5], `RHYTHM` [1-5], `MOTION` [1-5], focal point, cadence.
  5. State Coverage: explicit states for Loading, Empty, Error, Success.

### 3. Caveman + Ponytail Output Discipline (Low Output Tokens)

- Strip greetings, pleasantries, and conversational transitions.
- Ban AI hype words (*Supercharge*, *Seamless*, *Unlock*, *Elevate*, *Empower*, *Delve*, *Tapestry*).
- Ban echo code comments (`// Set state`, `// Initialize count`).
- Format audits as single-line rows ending in a gate verdict:
  ```text
  file:line | violation | fix
  GATE: PASS / FAIL
  ```

## Domain Calibration Tiers

Calibrate density, typography, and motion to your product domain:

| Domain Tier | Density & Typography | Motion & Interaction | Dials |
| :--- | :--- | :--- | :--- |
| **Dense SaaS** | 12-14px compact type, high density, `tabular-nums` | Subtle hover lifts, snappy 120ms feedback | `E:2 R:2 M:1` |
| **Editorial / Marketing** | Expressive display headings, generous whitespace | Paced scroll reveals, curated focal points | `E:4 R:4 M:3` |
| **Playful Consumer** | Friendly geometry, warm off-white canvases | Tactile micro-presses (`scale(0.97)`), spring physics | `E:5 R:3 M:4` |

## Before and After Examples

### 1. UI Copy

- **Before (AI Slop):** *"Supercharge your team's workflow with seamless real-time collaboration."*
- **After (dont-slop-me):** *"Share workspaces and edit together in real time."*

### 2. Code Comments

```typescript
// BEFORE: Echo comments narrating standard statements
// set count to count plus one
const count = currentCount + 1;
// check if user exists
if (!user) {
  return null;
}

// AFTER: Self-documenting code, zero wasted tokens
const count = currentCount + 1;
if (!user) {
  return null;
}
```

### 3. Audit Gate Output

```text
src/components/Header.tsx:18 | echo-comment | `// render nav links` echoes map call -> remove line
src/views/Hero.tsx:28 | slop-copy | "Supercharge your work" -> replace with "Run builds in seconds"
src/styles/theme.css:42 | hardcoded-color | Pure black `#000000` found -> replace with `#0f172a`
GATE: FAIL (3 issues detected)
```

## Universal Portability

- **100% Pure Markdown Skills:** Zero Python or Node runtime dependencies.
- **Cross-Framework:** Language-agnostic across HTML/CSS, React, Next.js, Vue, Svelte, Astro, SwiftUI, Flutter, and React Native.
- **Cross-Agent:** Fully compatible with Cursor, Claude Code, VS Code Copilot/Continue, Windsurf, Gemini CLI, and Codex CLI.

## Versioning

`dont-slop-me` uses minor-focused SemVer (`0.1.0`, `0.2.0`, ...) during pre-1.0 development:

- **Pre-1.0 Minor Focus:** Structural iterations, rule updates, and reference additions increment the minor version (`0.1.0` -> `0.2.0`). Patch increments (`0.2.1`) are reserved for typographical, naming, or formatting fixes.
- **Root `VERSION` file:** Contains the active version string (`0.2.1`).
- **YAML Frontmatter:** Each `SKILL.md` specifies `version: 0.2.1`.
- **Git Tags:** Releases are tagged as `v0.1.0`, `v0.2.0`, `v0.2.1`, and so on.

## License

MIT License. See [LICENSE](LICENSE) for details.
