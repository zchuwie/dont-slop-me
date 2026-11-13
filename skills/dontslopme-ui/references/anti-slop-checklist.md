# Anti-Slop Visual Checklist

Comprehensive visual defect catalog, telltale markers, design rationale, and surgical remedies for AI-generated interfaces.

Each entry follows the tri-part evaluation pattern:

- **Tell:** The identifiable symptom that signals unrefined AI generation.
- **Why:** The ergonomic, cognitive, or brand reason the pattern fails.
- **Fix:** The concrete, minimal code remediation.

## 1. Color and Surface Anti-Patterns

### Generic Blue-to-Purple / Cyan Gradient

- **Tell:** Hero sections or background canvases flooded with deep indigo-to-violet or cyan-to-purple diagonal linear gradients.
- **Why:** This is the most common default color treatment in AI image and code training data. It flags an interface as generic template output lacking brand identity.
- **Fix:** Extract colors from the project design tokens or brand specifications. Use grounded neutral background tones (`#0f172a`, `#f8fafc`) and introduce color through purposeful content highlights or border accents.

### Pure Black (#000000) or Pure White (#ffffff) Extremes

- **Tell:** Canvases, backgrounds, card surfaces, or body text styled with stark `#000000` or `#ffffff` extremes.
- **Why:** Absolute extremes produce harsh optical vibration and halation on modern displays, increasing eye fatigue. Natural materials and crafted interfaces always carry subtle warmth or cool undertones.
- **Fix:** Replace pure white with warm or cool off-whites (`#f8fafc`, `#f9fafb`, `#fafafa`) for light backgrounds. Replace pure black with rich charcoals or dark slates (`#090d16`, `#0f172a`, `#121214`) for dark backgrounds. Set primary typography to dark slate (`#0f172a`, `#1e293b`) against light backgrounds, and soft off-white (`#f1f5f9`, `#f4f4f5`) against dark backgrounds.

### Excessive Glassmorphism

- **Tell:** `backdrop-filter: blur(...)` and semi-transparent white/black backgrounds applied simultaneously to navbars, cards, modals, sidebars, and dropdowns.
- **Why:** Stacking blurred layers erases visual depth, muddies contrast ratios, degrades rendering performance on mobile GPUs, and eliminates clear foreground-background hierarchy.
- **Fix:** Restrict frosted glass effects to a maximum of one persistent floating layer (for example, a sticky navigation header). Keep cards, dialogs, and panels opaque.

### Glow Overuse

- **Tell:** Outer box-shadow glows (`box-shadow: 0 0 25px rgba(...)`) applied to normal cards, avatars, section dividers, and static badges.
- **Why:** Glow mimics optical emission. When every passive surface appears to emit light, nothing draws focal priority, creating visual noise.
- **Fix:** Reserve glow strictly for active status indicators (for example, live server status or camera active) or subtle focus-visible rings on interactive controls.

### Confetti Palettes (Too Many Colors)

- **Tell:** Using green for success, blue for links, yellow for alerts, purple for tags, pink for accents, and orange for icons all on the same screen.
- **Why:** A scattered spectrum destroys intentional visual hierarchy and cognitive priority.
- **Fix:** Enforce the 60-30-10 color rule: 60% dominant neutral foundation, 30% structural secondary tone, and 10% purposeful accent color for primary actions.

### Unmotivated Dark Mode Default

- **Tell:** Forcing an all-black or near-black background on utility applications, dashboards, or documentation with no dark/light consideration.
- **Why:** Dark mode is an intentional context choice for media consumption and low-light environments, not a generic proxy for sophistication. Reading dense text on pitch black can increase eye strain.
- **Fix:** Build with semantic CSS custom properties that support system color-scheme preferences (`prefers-color-scheme`), defaulting to light or neutral slate for productivity tools.

## 2. Geometry and Elevation Anti-Patterns

### Pill Shape Uniformity

- **Tell:** Buttons, text input fields, search bars, tag badges, cards, and modal dialogs all styled with `border-radius: 9999px` or `rounded-full`.
- **Why:** Universal pill shapes erase component identity. Users rely on subtle geometric conventions to distinguish click targets from input fields and static containers.
- **Fix:** Establish a clear radius token scale:
  - Buttons and inputs: 6px to 8px (`rounded-md` or `rounded-lg`).
  - Cards and dialogs: 10px to 16px (`rounded-xl`).
  - Badges and count tags: pill shape permitted (`rounded-full`).

### Diffuse Floating Shadows

- **Tell:** Cards elevated with massive, low-opacity blur radii (for example: `0 20px 50px rgba(0,0,0,0.08)`) with no directional source.
- **Why:** Overly diffuse shadows create a floaty, disconnected aesthetic where surfaces lack physical weight and spatial grounding.
- **Fix:** Use layered, tight directional shadows with subtle borders:
  ```css
  box-shadow: 0 1px 2px 0 rgba(0, 0, 0, 0.05), 0 1px 3px 1px rgba(0, 0, 0, 0.03);
  border: 1px solid var(--border-subtle);
  ```

### Stock Grid and Dot Matrices

- **Tell:** Subtle graph paper grids, dot arrays, or isometric wireframes placed behind hero text to convey technical depth.
- **Why:** Stock background patterns add visual clutter without communicating domain value.
- **Fix:** Use clean negative space. Let typography hierarchy, whitespace, and sharp layout grid alignment communicate technical precision.

### Sterile Default (The Safe Void)

- **Tell:** Flat grey borders, zero accent color, generic system sans-serif typography, and stark white backgrounds with no visual hierarchy.
- **Why:** Over-filtering without artistic direction produces a soulless wireframe rather than a production-ready product.
- **Fix:** Introduce typographic rhythm (high-contrast headline weight paired with clean body text), deliberate whitespace scaling, and an unmistakable brand accent on primary interactive targets.

## 3. Structural and Semantic Anti-Patterns

### Div Soup and Nested Container Bloat

- **Tell:** Three or more levels of nested `<div>` wrappers around a single paragraph or image element.
- **Why:** Bloats DOM size, degrades screen reader accessibility, and wastes parser tokens during agent refactoring.
- **Fix:** Flatten tree structures using modern CSS grid or flex alignment directly on semantic parents (`<header>`, `<main>`, `<section>`, `<article>`, `<aside>`).

### Third-Party Component Bloat vs Native Platform Primitives

- **Tell:** Pulling multi-kilobyte JavaScript libraries to render basic modals, accordions, tooltips, or color pickers.
- **Why:** Inflates bundle size, introduces hydration lag, and causes cross-platform accessibility bugs that standard platform elements already solve.
- **Fix:** Default to native browser and platform primitives first:

| UI Need | Bloated AI Default | Native Platform Primitive |
| :--- | :--- | :--- |
| Modal Dialog | React Portal + custom backdrop div + key listeners | Native `<dialog>` element with `.showModal()` |
| Collapsible / Accordion | Custom state hook + height animation wrapper | Native `<details>` and `<summary>` elements |
| Tooltip / Popover | Floating UI / Popper.js wrapper library | HTML `popover` attribute and CSS anchor positioning |
| Color Picker | Canvas-based npm color wheel | Native `<input type="color">` |
| Autocomplete | Custom filtered dropdown list component | Native `<input list="...">` with `<datalist>` |
| Date Selection | Custom calendar grid component | Native `<input type="date">` |

### Mobile Tap Target Violations

- **Tell:** Interactive icons or text links with hitboxes smaller than 24x24 pixels, packed closely together.
- **Why:** Prevents reliable fingertip activation on touch devices, causing rage clicks and accessibility failures.
- **Fix:** Guarantee minimum 44x44px touch targets on mobile viewports using CSS padding or minimum dimension constraints (`min-height: 44px; min-width: 44px`).

