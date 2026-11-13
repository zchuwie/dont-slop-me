---
name: dontslopme
version: 1
description: Core orchestrator and anti-slop filter for AI coding agents. Enforces low-token slice reading, minimal diffs, native platform reuse, and telegraphic output. Routes tasks to specialized reference guides just-in-time.
license: MIT
---

# dontslopme

Core anti-slop filter and token-conservation engine for AI coding agents.

Follow these rules on every code generation, discovery, and refactoring task.

## The Caveman + Ponytail Triad

### 1. Slice-Read Only (Low Input Tokens)

Never read full source files to inspect logic or audit defects.

- Run targeted `grep` or file search patterns first.
- Read only `±15` lines around matches using line-range slice tools.
- Never ingest entire multi-hundred-line files when looking for an isolated symbol.
- For discovery recipes, load `references/codebase-discovery.md` JIT.

### 2. Native Reuse and Minimal Diffs (Low Code Tokens)

Do not reinvent what the platform, framework, or repo already provides.

- Use standard library methods before adding utility packages.
- Reuse existing components, hooks, and CSS tokens present in the repository.
- Avoid speculative wrapper functions, one-caller abstractions, and factory layers.
- Output only targeted diffs or surgical file edits instead of reprinting full files.

### 3. Telegraphic Output (Low Output Tokens)

Cut all conversational waste and report facts directly.

- Strip greetings, pleasantries, hedging, and conversational transitions.
- Emit no unprompted code explanations or restatements of what the code does.
- Audit findings must be single-line bullets: `file:line` - defect - fix.
- For copywriting rules and comment cleanup, load `references/copy-and-code-hygiene.md` JIT.

## JIT Reference Routing

Load deep documentation only when the current task demands it:

- Codebase search, symbol audits, pattern scanning: read `references/codebase-discovery.md`.
- Copywriting, prose cleanup, comment hygiene: read `references/copy-and-code-hygiene.md`.
- Visual design, colors, cards, layout, or animations: activate `skills/dontslopme-ui/SKILL.md`.

## Hard Constraints

- Never add echo comments that rephrase code (for example: `// increment count`).
- Never introduce new third-party dependencies when native language features suffice.
- Never write speculative code for unrequested future requirements.
- Never emit conversational filler ("Certainly!", "I have updated the file for you").

