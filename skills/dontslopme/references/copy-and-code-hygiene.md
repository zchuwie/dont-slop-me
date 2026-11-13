# Copy and Code Hygiene Reference

Standards for anti-slop copy, comment sanitation, and telegraphic communication for AI coding agents.

## Anti-Slop Copywriting Standards

AI models reflexively default to inflated marketing adjectives, passive constructions, and repetitive transition words. When writing UI text, documentation, commit messages, or pull request descriptions, enforce concrete, direct language.

### Forbidden Words and Phrases

The following terms signal AI-generated filler and must be eliminated:

- **Inflated superlatives:** seamless, effortlessly, game-changer, revolutionary, cutting-edge, state-of-the-art, unrivaled.
- **Academic and literary cliches:** delve, tapestry, testament, beacon, foster, resonate, paramount, symphony.
- **Empty corporate jargon:** leverage, streamline, unlock, elevate, empower, synergy, holistically, robust.
- **Conversational padding:** in conclusion, it is worth noting, look no further, without further ado, let us dive in.

### Slop vs Direct Copy Matrix

| Slop Pattern | Direct Alternative | Rationale |
| :--- | :--- | :--- |
| "Unlock seamless collaboration across your entire team." | "Share workspaces and edit in real time." | Replaces vague metaphor with concrete feature capability. |
| "Delve into your data with our powerful analytics engine." | "Query tables and filter query logs." | Cuts academic verb and replaces generic boast with user action. |
| "A testament to cutting-edge craft and modern design." | "Built with accessible contrast and native dialogs." | Replaces subjective praise with technical specifications. |
| "Leverage robust features designed to elevate productivity." | "Automate billing exports to CSV." | Removes empty enterprise jargon in favor of utility. |

## Code Comment Hygiene

Code comments cost context tokens on every file read. Obvious comments waste tokens and obscure signal.

### The Zero-Slop Comment Filter

Follow these rules when reviewing or generating comments:

- **Echo comments are prohibited:** Comments that rephrase identifiers, function names, or obvious standard library calls must be removed immediately.
- **Dead code is prohibited:** Never leave commented-out code blocks in production files. Rely on version control.
- **Section banner dividers are prohibited:** Avoid large ASCII line separators (such as `// ============= UTILS =============`).
- **File header boilerplate is prohibited:** Remove generic generated headers like `// Created by Assistant on ...`.

### Permitted Comments

Comments are strictly reserved for information that cannot be expressed in code:

- **Hardware or browser quirks:** Workarounds for vendor-specific browser rendering bugs.
- **Mathematical or algorithmic invariants:** Mathematical proofs or non-obvious algorithmic complexity guarantees.
- **External API peculiarities:** Explaining unexpected payload structures mandated by legacy third-party endpoints.
- **Security trust boundaries:** Rationale for unescaped HTML or specific sanitization choices.

### Comment Diff Examples

#### Negative Example (Slop Comment)

```typescript
// BAD: Echoes identifier names and narrates standard language operations
// increment count by one
const count = currentCount + 1;

// check if user exists
if (!user) {
  // return null if no user
  return null;
}
```

#### Positive Example (Clean Hygiene)

```typescript
// GOOD: Code is self-explanatory, zero comments needed
const count = currentCount + 1;

if (!user) {
  return null;
}

// GOOD: Explains non-obvious external browser quirk
// Safari 16 bug: flex-basis calculation ignores min-width when gap is non-zero
element.style.minWidth = '0px';
```

## Telegraphic Communication Protocol

When communicating with users or returning results to an orchestrating agent:

### 1. Preamble Elimination

Strip all opening conversational scaffolding:

- **Do not say:** "Sure! I would be glad to help you refactor that component today."
- **Do not say:** "Here is the updated code that fulfills your exact request:"
- **Do say:** Jump immediately to the action, command, diff, or result.

### 2. Post-Code Narration Ban

Do not follow code blocks with paragraphs explaining what each line accomplishes unless explicitly asked to explain trade-offs.

### 3. Compact Diff Formatting

Never reprint hundreds of lines of unchanged code. Use compact diffs or targeted symbol replacements:

```typescript
// path/to/target.ts
<<<<
- const isEnabled = false;
====
+ const isEnabled = true;
>>>>
```

### 4. Dense One-Line Audit Format

Report code hygiene issues in a single line per finding:

```text
src/services/auth.ts:14 - [echo-comment] - `// initialize token` echoes assignment -> remove line
src/components/Hero.tsx:32 - [slop-copy] - "Unlock seamless workflows" -> replace with "Run builds in seconds"
src/utils/math.ts:50 - [dead-code] - Commented out legacy fallback -> remove lines 50-58
```
