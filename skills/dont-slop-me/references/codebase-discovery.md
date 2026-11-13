# Codebase Discovery Protocol

Low-token inspection workflows, search recipes, and slice-reading standards for AI coding agents.

## Grep-First Slice Discovery Protocol

Traditional coding agents often read entire source files to inspect minor logic or verify imports. Reading full files wastes tens of thousands of context tokens.

The grep-first discovery protocol replaces full-file reads with targeted slice operations:

1. **Locate with Grep or Glob:** Pinpoint target symbols, manifests, or tokens without retrieving full file contents.
2. **Extract with Slice-Read:** Read strictly `±15` lines around the matching line number.
3. **Expand JIT Only When Blocked:** Expand the range only if the target symbol spans outside the `±15` window (for example, a large multi-line interface declaration).

## Manifest Scanning Recipes

Before proposing new libraries or reimplementing common helpers, run targeted grep commands against project manifests:

### Node.js / Web (`package.json`)

```bash
# Check installed UI libraries, icon sets, utility packages
grep -E '"(dependencies|devDependencies)"' -A 25 package.json | grep -E '(lucide|radix|shadcn|tailwind|framer-motion|date-fns|lodash)'
```

### Flutter / Dart (`pubspec.yaml`)

```bash
# Check flutter UI packages and animations
grep -E '^\s*(flutter_svg|provider|riverpod|bloc|animations):' pubspec.yaml
```

### Swift / Apple (`Package.swift` or `.xcodeproj`)

```bash
# Check Swift Package Manager dependencies
grep -E '\.package\(' Package.swift
```

### Rust (`Cargo.toml`)

```bash
# Check crate dependencies
grep -E '^\s*(serde|tokio|tracing)' Cargo.toml
```

## Design Token and Theme Discovery

Before writing CSS or styling components, identify existing design tokens:

### Tailwind CSS Tokens

```bash
# Tailwind v4 theme definitions
grep -rn '@theme' src/ styles/
# Tailwind v3 theme extensions
grep -rn 'extend:' tailwind.config.* -A 20
```

### CSS Custom Properties and Roots

```bash
# Search for root color variables and design tokens
grep -rn --include="*.css" -E '(:root|--color-|--radius-|--font-)' src/ styles/
```

### Existing UI Primitives Discovery

Never create a new `Button`, `Modal`, or `Card` before verifying if one already exists in the repository:

```bash
# Find existing primitive components
find src -maxdepth 3 -type f -name "*Button*" -o -name "*Dialog*" -o -name "*Modal*" -o -name "*Card*"
```

### Motion and Accessibility Tokens

```bash
# Check if prefers-reduced-motion is already configured
grep -rn 'prefers-reduced-motion' src/ styles/
```

## The ±15 Line Slice Rule

When reading file contents after a search hit:

- Calculate start line: `max(1, match_line - 15)`.
- Calculate end line: `match_line + 15`.
- Call line-bounded read tools (such as `read_file` with `StartLine` and `EndLine`).
- Never call unconstrained full-file read tools during exploratory or discovery tasks.

## High-Yield Slop-Detection Grep Recipes

Use these exact regex patterns to identify code slop, anti-patterns, and architecture bloat without reading full directories:

### 1. Echo and Boilerplate Comments

Find comments that merely narrate what the code already says:

```text
//\s*(initialize|set state|set count|get|return|call|check if|render|handle|update)\b
```

### 2. AI Hype Copy in Code and Markup

Find marketing superlatives and inflated buzzwords:

```text
\b(supercharge|seamless|seamlessly|unlock|elevate|empower|delve|tapestry|testament|game-changer|revolutionize)\b
```

### 3. Hardcoded Palette Values and Pure Extremes

Locate ad-hoc inline hex colors and stark black or white extremes bypassing design tokens:

```text
#[0-9a-fA-F]{3,8}\b|rgba?\(|#000000\b|#ffffff\b|#000\b|#fff\b
```

### 4. Speculative Placeholders and Stubbed Code

Identify dead-end stubs, speculative abstractions, and incomplete logic:

```text
\b(TODO|FIXME|TBD|stub|implement later|not implemented)\b
```

### 5. Loose Typing and Safety Bypasses

Detect type escape hatches that hide design flaws:

```text
(@ts-ignore|@ts-nocheck|any\b|as any|as unknown as)
```

### 6. Excessive Wrapper Nesting

Identify container div bloat and wrapper redundancy:

```text
<div[^>]*>\s*<div[^>]*>\s*<div
```

## Telegraphic Audit Output Format

Format discovery findings using the standard single-line schema:

```text
path/to/file.ext:42 | violation-category | concise description -> surgical fix
```

Example audit output:

```text
src/components/Header.tsx:18 | echo-comment | `// render nav links` echoes map call -> remove line
src/components/Card.tsx:44 | wrapper-bloat | Triple nested <div> around single <p> -> collapse to semantic <article>
src/styles/theme.css:102 | hardcoded-color | `#000000` pure black used -> replace with `var(--color-bg-dark, #0f172a)`
src/views/Hero.tsx:28 | slop-copy | "Supercharge your productivity" -> replace with "Run builds in under 5 seconds"
```

End audits with a single-line gate verdict:

```text
GATE: PASS
```

or

```text
GATE: FAIL (4 issues detected)
```
