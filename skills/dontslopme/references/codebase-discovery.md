# Codebase Discovery Protocol

Low-token inspection workflows, search recipes, and slice-reading standards for AI coding agents.

## Core Discovery Protocol

Traditional coding agents often read entire source files to inspect minor bugs or verify symbols. In a repository of 200+ line files, reading full files quickly burns tens of thousands of context tokens.

The low-token discovery protocol replaces whole-file reads with targeted slice operations:

1. **Locate with Grep or Glob:** Pinpoint target symbols, imports, or tokens without retrieving file bodies.
2. **Extract with Slice-Read:** Read strictly `±15` lines around the matching line number.
3. **Expand JIT Only When Blocked:** Expand the range only if the target symbol spans outside the `±15` window (for example, a large multi-line function signature or interface declaration).

## The ±15 Line Slice Rule

When reading file contents after a search hit:

- Calculate start line: `max(1, match_line - 15)`.
- Calculate end line: `match_line + 15`.
- Call line-bounded read tools (such as `read_file` with `StartLine` and `EndLine`).
- Never call unconstrained full-file read tools during exploratory or discovery tasks.

## High-Yield Grep Recipes

Use these exact regex patterns to identify code slop, anti-patterns, and architecture bloat without reading full directories:

### 1. Echo and Boilerplate Comments

Find comments that merely narrate what the code already says:

```text
//\s*(initialize|set|get|return|call|check if|render|handle|update)\b
```

### 2. Speculative Placeholders and Stubbed Code

Identify dead-end stubs, speculative abstractions, and incomplete logic:

```text
(TODO|FIXME|TBD|stub|implement later|not implemented)
```

### 3. Loose Typing and Safety Bypasses

Detect type escape hatches that hide design flaws:

```text
(@ts-ignore|@ts-nocheck|any\b|as any|as unknown as)
```

### 4. Hardcoded Palette Values and Pure Extremes

Locate ad-hoc inline hex colors and stark black or white extremes bypassing design tokens:

```text
#[0-9a-fA-F]{3,8}\b|rgba?\(|#000000\b|#ffffff\b|#000\b|#fff\b
```

### 5. Excessive Wrapper Nesting

Identify container div bloat and wrapper redundancy:

```text
<div[^>]*>\s*<div[^>]*>\s*<div
```

### 6. Premature Memoization and Wrapper Bloat

Detect unnecessary wrapping of trivial primitives in React:

```text
useCallback\(\s*\(\)\s*=>\s*\{\s*\},|useMemo\(\s*\(\)\s*=>\s*\[\s*\],
```

## Cross-Framework Discovery Matrix

Scan for stack-specific slop using targeted queries:

### React and Next.js

- **Pattern:** `"use client"` placed indiscriminately at the top of static components.
- **Search command:** `grep -rn '"use client"' src/components/`
- **Audit query:** Does the file use hooks (`useState`, `useEffect`) or browser APIs? If not, strip the directive.

### Vue and Svelte

- **Pattern:** Excessive watchers and bloated reactive definitions for derived state.
- **Search command:** `grep -rn 'watch(' src/` or `grep -rn '\$:' src/`
- **Audit query:** Can the value be computed synchronously via a pure getter or `computed()`?

### SwiftUI and Flutter

- **Pattern:** Deeply nested view pyramids and unnecessary container widgets.
- **Search command:** `grep -rn 'VStack {' .` or `grep -rn 'Container(' .`
- **Audit query:** Can layout modifiers or layout stacks be collapsed without changing rendered frames?

### Native Web (HTML / CSS / JS)

- **Pattern:** Custom JavaScript implementations of built-in platform capabilities (e.g. modals, accordions, tooltips).
- **Search command:** `grep -rn 'addEventListener.*click.*modal' .`
- **Audit query:** Can the element be replaced with native `<dialog>` or `<details>`?

## Telegraphic Audit Output Format

When returning discovery results to the user or orchestrator, omit introductory commentary. Format each finding as a dense, actionable single-line bullet:

```text
path/to/file.ext:42 - [category] - defect description -> proposed surgical fix
```

### Example Discovery Output

```text
src/components/Header.tsx:18 - [echo-comment] - `// render nav links` echoes map call -> remove comment
src/components/Card.tsx:44 - [wrapper-bloat] - Triple nested <div> around single <p> -> collapse to single semantic <article>
src/utils/format.ts:89 - [redundant-util] - Custom padStart polyfill -> replace with String.prototype.padStart
src/styles/theme.css:102 - [hardcoded-color] - `#7c3aed` bypasses token system -> replace with `var(--color-primary)`
```

