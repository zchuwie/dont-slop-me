# dontslopme

A lightweight, multi-skill anti-slop governance system for AI coding agents built on the open `agentskills.io` standard.

`dontslopme` prevents AI-generated code slop: generic aesthetic cliches, repetitive boilerplate, conversational filler, speculative abstractions, and context-bloating tool usage.

## Why dontslopme?

Most AI skill definitions suffer from context bloat: large monolithic prompt files inject thousands of tokens into every conversation turn before any code is inspected.

`dontslopme` enforces an extreme token-efficiency model:

- **Ultra-Compact Core:** Every `SKILL.md` is strictly under 115 lines (~450 tokens), loading minimal context into initial agent memory.
- **Just-In-Time (JIT) Progressive Disclosure:** Deep checklists, regex patterns, motion tokens, and few-shot diffs remain isolated in `references/*.md` and are loaded only when a task demands them.
- **Caveman + Ponytail Execution Discipline:** Agents are instructed to slice-read files (target `±15` lines), reuse native platform features, emit minimal diffs, and strip all conversational preamble.
- **Zero Runtime Dependencies:** Pure Markdown specification. Works without Node, Python, or shell runtime scripts.
- **Universal Portability:** Compatible with Cursor, Claude Code, VS Code Copilot/Continue, Windsurf, Gemini CLI, and Codex CLI across web, mobile, and backend codebases.

## Repository Architecture

```text
dontslopme/
├── LICENSE
├── README.md
├── VERSION
└── skills/
    ├── dontslopme/
    │   ├── SKILL.md
    │   └── references/
    │       ├── codebase-discovery.md
    │       └── copy-and-code-hygiene.md
    └── dontslopme-ui/
        ├── SKILL.md
        └── references/
            ├── anti-slop-checklist.md
            └── ux-and-motion-spec.md
```

## Skill Catalog

### 1. `dontslopme` (Core Orchestrator)

The base filter and token-conservation engine. It governs how coding agents read code, structure edits, and communicate with the user.

- **Primary role:** Enforce slice-read discovery, minimal diffs, native platform reuse, and telegraphic output.
- **Key references:**
  - `codebase-discovery.md`: Targeted grep recipes and `±15` line window extraction rules.
  - `copy-and-code-hygiene.md`: Forbidden AI copy cliches, comment hygiene, and telegraphic bullet standards.

### 2. `dontslopme-ui` (Craft & Motion)

The visual craft and interaction skill. It eliminates generic AI aesthetics in favor of intentional design, tactile physics, and accessible ergonomics.

- **Primary role:** Eliminate generic purple-cyan gradients, excessive glassmorphism, pill buttons, floating card soup, and robotic transitions.
- **Key references:**
  - `anti-slop-checklist.md`: Visual defect catalog covering color, elevation, surface texture, and layout.
  - `ux-and-motion-spec.md`: Spring curves, duration budgets, accessibility (`prefers-reduced-motion`), and micro-interaction states across CSS, Tailwind, Framer Motion, SwiftUI, and Flutter.

## Core Execution Discipline

Every agent running `dontslopme` adheres to three execution rules:

### 1. Slice-Read Only (Low Input Tokens)

Never read full source files to inspect a defect or verify an import. Agents must:

1. Run targeted `grep` or file search queries.
2. Read only the matching region (`±15` lines).
3. Expand context only when boundary conditions require it.

### 2. Minimal Diffs and Native Reuse (Low Code Tokens)

Do not reinvent what the platform provides. Agents must:

- Prioritize native HTML5 elements (`<dialog>`, `<details>`, `<input type="date">`) and standard CSS (`clamp()`, `min()`, `display: grid`) before pulling npm packages.
- Reuse existing component libraries and design tokens found in the target repository.
- Emit precise diffs or isolated replacements rather than rewriting entire files.

### 3. Telegraphic Output (Low Output Tokens)

Save tokens and time by stripping conversational fluff:

- Omit greetings, transitional pleasantries, and sign-offs ("Certainly!", "I hope this helps!").
- Report audit findings as dense one-line bullets: `file:line` + defect + recommended fix.
- Output clean code without narrative post-mortems.

## Installation & Setup

### Agent Skills Standard (`agentskills.io`)

Clone or link the repository into your global or project agent skills folder:

```bash
git clone https://github.com/zchuwie/dontslopme.git
```

### Setup for Cursor

Add the skills to `.cursor/rules` or link into your project prompt configuration:

```bash
mkdir -p .cursor/rules
cp -r dontslopme/skills/* .cursor/rules/
```

### Setup for Claude Code

Symlink or copy the skills into your project:

```bash
mkdir -p .claude/skills
ln -s $(pwd)/dontslopme/skills/dontslopme .claude/skills/dontslopme
ln -s $(pwd)/dontslopme/skills/dontslopme-ui .claude/skills/dontslopme-ui
```

Add an entry pointer to `CLAUDE.md`:

```markdown
<!-- dontslopme:start -->
## dontslopme Rules
For coding, architecture, and code discovery, consult `skills/dontslopme/SKILL.md`.
For UI, styling, and motion, consult `skills/dontslopme-ui/SKILL.md`.
Follow slice-read discovery, native reuse, and telegraphic output at all times.
<!-- dontslopme:end -->
```

### Setup for Gemini CLI & Codex CLI

Point your repository root instructions (`AGENTS.md` or `GEMINI.md`) to the core skills:

```markdown
## Active Skills

- Core hygiene: skills/dontslopme/SKILL.md
- UI craft: skills/dontslopme-ui/SKILL.md
```

## Specification Compliance

This repository conforms strictly to the `agentskills.io` open standard:

- Every skill maintains a valid YAML frontmatter with `name`, `description`, and `license`.
- Skill names match their parent directory names exactly.
- Skill descriptions use third-person phrasing and stay well below 1024 characters.
- Skill instruction files remain below 115 lines for optimal token economics.
- All deep reference material is organized into `references/` subdirectories for just-in-time retrieval.

## Versioning

`dontslopme` uses minor-focused SemVer (`0.1.0`, `0.2.0`, ...) during pre-1.0 development:

- **Pre-1.0 Minor Focus:** Structural iterations, rule updates, and reference additions increment the minor version (`0.1.0` -> `0.2.0`). Patch increments (`0.1.1`) are reserved for typographical or formatting fixes.
- **Root `VERSION` file:** Contains the active version string (`0.1.0`).
- **YAML Frontmatter:** Each `SKILL.md` specifies `version: 0.1.0`.
- **Git Tags:** Releases are tagged as `v0.1.0`, `v0.2.0`, and so on.

## License

MIT License. See [LICENSE](LICENSE) for details.
