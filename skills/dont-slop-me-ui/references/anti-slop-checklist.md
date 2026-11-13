# Anti-Slop Visual Checklist

Defect catalog, regex detection patterns, before/after diffs, and remediation rules for AI-generated interfaces.

## Fast Slop-Detection Grep Recipes

Scan codebases for telltale UI slop patterns without reading entire files:

### 1. Pill Shapes on Everything

```text
class="[^"]*\b(rounded-full)\b[^"]*"
```

### 2. Random Italics for Fake Sophistication

```text
\b(italic|font-style:\s*italic)\b|<(em|i)>
```

### 3. Over-Tightened Negative Kerning

```text
\b(tracking-tighter|letter-spacing:\s*-[0-9.]+px)\b
```

### 4. Pure Black and Pure White Extremes

```text
#(000000|ffffff)\b|#000\b|#fff\b|rgba?\(\s*0\s*,\s*0\s*,\s*0\s*(,|\))|rgba?\(\s*255\s*,\s*255\s*,\s*255\s*(,|\))
```

### 5. Eyebrow Tags and Section Numbering Clichés

```text
\b(01\s*\/\/\s*|0[1-9]\s*\.\s*|EYEBROW|KICKER)\b
```

### 6. Verbose Titles Terminated with Periods

```text
<h[1-6][^>]*>[^<]*\.\s*<\/h[1-6]>
```

## The 20 AI Design Slop Indicators to Ban

### 1. Tags & Pills Everywhere

- **Violation:** Wrapping every status, category, feature name, and date in a `rounded-full` pill badge.
- **Remediation:** Remove filler badges. Use plain text with subtle color or bullet separation.

### 2. Excessive Italics

- **Violation:** Italicizing random words in headlines to simulate deep editorial nuance.
- **Remediation:** Keep display typography in upright roman weights. Use word choice for emphasis.

### 3. Instrument Serif Clichés

- **Violation:** Defaulting to trendy retro display serifs (*Instrument Serif*, *Editorial New*) on modern software tools.
- **Remediation:** Match typography to the domain: robust geometric grotesques for SaaS, functional system sans for productivity.

### 4. Negative Kerning

- **Violation:** Crushing letter-spacing on display headings (`tracking-tighter` or `-0.05em`), causing letters to collide.
- **Remediation:** Use standard tracking (`tracking-tight` at most for display sizes above 36px, `tracking-normal` for body).

### 5. Over-the-Top Detailed UI

- **Violation:** Micro-badges, mini-graphs, tiny progress circles, and redundant metadata crammed into simple cards.
- **Remediation:** Remove secondary clutter. Elevate the single primary metric or action.

### 6. Overusing Dividers

- **Violation:** Hairline border dividers (`border-b`, `<hr>`) between every title, paragraph, metric, and row.
- **Remediation:** Group related elements using whitespace hierarchy (12px, 24px, 48px) instead of visual lines.

### 7. Muddy Color Shades & Opacities

- **Violation:** Stacking multiple layers of low-opacity grays (`rgba(255,255,255,0.05)` on `#1e293b`), creating dingy, washed-out surfaces.
- **Remediation:** Use solid, intentional background tones with verified WCAG AA contrast.

### 8. Containers with Borders

- **Violation:** Enclosing every paragraph, statistic, icon, and button in its own bordered container box.
- **Remediation:** Let content breathe on the base surface. Reserve borders strictly for distinct interactive cards.

### 9. Overly Detailed Diagrams

- **Violation:** Decorative SVG node graphs, simulated neural networks, or circuit lines that communicate no real data.
- **Remediation:** Show the actual product UI, real code samples, or concrete data tables.

### 10. Verbose / Redundant Text

- **Violation:** Restating the headline in an eyebrow tag above and repeating it again in a subtitle below.
- **Remediation:** Delete redundant labels. A headline should state the capability without conversational padding.

### 11. Code Breadcrumbs

- **Violation:** Fabricated terminal paths (`app > core > index.ts`) rendered above consumer cards to look technical.
- **Remediation:** Remove decorative paths. Use clear domain titles.

### 12. 01 // Section Numbering

- **Violation:** Numbering section titles as `01 // Overview`, `02 // Features` to mimic hacker aesthetics.
- **Remediation:** State the section title plainly without pseudocode numbering.

### 13. Eyebrows

- **Violation:** Tiny uppercase kickers (`FEATURE LAUNCH`, `INNOVATION`) hovering above every heading.
- **Remediation:** Integrate the context directly into the main headline.

### 14. Dithering

- **Violation:** Heavy pixel noise or dithering patterns overlaying clean vector graphics.
- **Remediation:** Keep gradients smooth and vectors clean.

### 15. ASCII Images

- **Violation:** Embedding decorative ASCII art boxes or terminal frames into consumer web products.
- **Remediation:** Use crisp SVG icons or high-fidelity UI components.

### 16. Squircles Everywhere

- **Violation:** Applying complex super-ellipse squircle masks to standard buttons, icons, and thumbnails.
- **Remediation:** Use standard platform border-radii.

### 17. Excessive Mono Fonts

- **Violation:** Rendering marketing headlines, paragraph text, or button text in `font-mono`.
- **Remediation:** Restrict monospace fonts strictly to code blocks, logs, and numeric data columns.

### 18. ALL CAPS Subtitles

- **Violation:** Formatting entire multi-word subtitle sentences in uppercase tracking.
- **Remediation:** Use sentence case for subtitles to maintain rapid scanning legibility.

### 19. Gradient Backgrounds

- **Violation:** Diagonal indigo-to-purple or cyan-to-fuchsia linear gradients flooding hero canvases.
- **Remediation:** Use grounded solid neutral backgrounds (`#0f172a`, `#f8fafc`) with a single crisp accent.

### 20. Periods in Titles

- **Violation:** Terminating 2-3 word marketing headings with a full stop (for example: *Work Faster.*).
- **Remediation:** Do not end titles or display headings with periods.

### Supplementary Rule: No Pure Black or White

- **Violation:** Stark `#000000` or `#ffffff` canvases and text causing optical vibration and halation.
- **Remediation:** Use off-whites (`#f8fafc`, `#fafafa`) and deep charcoals/slates (`#090d16`, `#0f172a`).

## The 20 Ways to Unslop UI

### 1. Delete Filler Badges

Replace badge containers with plain text:

```html
<!-- BEFORE: Slop badge -->
<span class="inline-flex items-center px-3 py-1 rounded-full text-xs bg-indigo-500/10 text-indigo-400 border border-indigo-500/20">
  New Feature
</span>

<!-- AFTER: Clean text label -->
<span class="text-xs font-medium text-emerald-600 dark:text-emerald-400">
  New Feature
</span>
```

### 2. Drop Redundant Labels

Eliminate self-evident descriptor labels (e.g. `Email Address:` before an input clearly styled as an email field).

### 3. Unitalicize Random Words

Render all display headers in upright letterforms.

### 4. Mono Only Where Needed

Reserve `font-mono` strictly for hashes, code snippets, git commits, and table figures.

### 5. Use a Design System

Bind all spacing, colors, and radii to project tokens rather than inventing ad-hoc tailwind values.

### 6. Show the Actual Product

Replace abstract SVG blobs or 3D glass spheres with functional screenshots, code editors, or interactive widgets.

### 7. Enlarge the Main Feature

Create an unmistakable visual hierarchy: make the primary product capability dominate 60% of the viewport.

### 8. Group with Spacing

Separate layout blocks using consistent proportional whitespace (8px, 16px, 32px, 64px) rather than dividing lines.

### 9. Make Headlines Specific

- **Slop:** *"The All-in-One Platform for Modern Teams."*
- **Unslopped:** *"Host PostgreSQL databases with instant branching."*

### 10. Emphasize the CTA

Ensure the primary call-to-action button is visually prominent with high contrast; keep secondary actions ghost or outline.

### 11. Add 1 Accent Color

Limit visual focus to a single deliberate brand accent (emerald, amber, cyan, or violet). Do not spray the entire spectrum.

### 12. Keep Icons Consistent

Use a single icon library (such as Lucide or Heroicons) with uniform stroke width (1.5px or 2px) throughout the application.

### 13. Remove Embellishments

Delete decorative corner crosses, floating particle dots, and blueprint background grid lines.

### 14. Enforce Concentric Radii

When nesting a card inside a container, match the corner curves mathematically:

$$\text{inner\_radius} = \max(0, \text{outer\_radius} - \text{padding})$$

```css
/* Card container */
.container {
  padding: 12px;
  border-radius: 16px;
}
/* Nested child button: 16px - 12px = 4px */
.container .child-btn {
  border-radius: 4px;
}
```

### 15. Improve Text Contrast (WCAG AA)

Guarantee a minimum contrast ratio of 4.5:1 for body copy and 3:1 for large display headings against their backgrounds.

### 16. Wrap Headlines Properly

Add `text-wrap: balance` to all headings to prevent unsightly single-word orphan lines:

```css
h1, h2, h3 {
  text-wrap: balance;
}
```

### 17. Align by Eye Not Pixels

Optically center icons paired with text: shift uppercase icon baselines by 1px down to match x-height centerlines.

### 18. Use Tabular Numbers

Apply `font-variant-numeric: tabular-nums` or `font-feature-settings: "tnum"` to counters, pricing tables, and timers so characters don't jump horizontally during updates.

```css
.metric-value {
  font-variant-numeric: tabular-nums;
}
```

### 19. Add Loading States

Every asynchronous data surface must provide a structural skeleton or discrete spinner, preventing abrupt layout shifts (CLS).

### 20. Animate Useful Feedback

Tie animations exclusively to state transitions: button press feedback, sheet slide-in, or toast confirmation.
