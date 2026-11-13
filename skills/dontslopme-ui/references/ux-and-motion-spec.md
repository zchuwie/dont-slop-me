# UX and Motion Specification

Motion physics, duration budgets, accessibility standards, and framework implementation tokens.

## Motion Physics Principles

AI-generated interfaces often default to slow, linear, or floating transitions that make software feel sluggish and unresponsive. High-craft software uses spring physics and quick deceleration curves that mirror physical mechanics.

### Core Motion Rules

- **Favor deceleration:** Elements should enter with high velocity and settle crisply. Use ease-out curves rather than symmetric ease-in-out.
- **Micro-budgeting:** Interactive feedback must happen within 150ms. Never make the user wait for decoration.
- **Physical weighting:** Small elements (buttons, badges) move faster with higher stiffness than heavy elements (sheets, modals).
- **Zero motion on data changes:** Changing table rows or filtering lists should be instantaneous; avoid cascading stagger animations on high-frequency data.

## Motion Duration Budgets

Adhere to strict duration ceilings:

| Interaction Type | Target Duration | Allowed Range | Purpose |
| :--- | :--- | :--- | :--- |
| Micro-interaction | 120ms | 100ms to 150ms | Button click, toggle switch, checkbox check. |
| Small surface reveal | 180ms | 150ms to 200ms | Dropdown menu, popover, tooltip display. |
| Medium surface reveal | 240ms | 200ms to 300ms | Drawer slide-in, modal dialog entrance, accordion. |
| View / page transition | 300ms | 250ms to 350ms | Route transition, full-screen canvas switch. |
| Prohibited duration | > 400ms | Never allowed | Destroys perceived speed and user responsiveness. |

## Easing Curves and Spring Tokens Across Stacks

### 1. Pure CSS and Web Tokens

Define standardized custom properties:

```css
:root {
  /* Fast deceleration for entrances */
  --ease-snappy: cubic-bezier(0.16, 1, 0.3, 1);
  /* Gentle exit curve */
  --ease-exit: cubic-bezier(0.7, 0, 0.84, 0);
  /* Standard smooth transition */
  --ease-standard: cubic-bezier(0.2, 0, 0, 1);

  /* Duration tokens */
  --duration-micro: 120ms;
  --duration-surface: 200ms;
  --duration-modal: 260ms;
}
```

### 2. Tailwind CSS Configuration

Extend the Tailwind theme with snappy curves:

```javascript
// tailwind.config.js
module.exports = {
  theme: {
    extend: {
      transitionTimingFunction: {
        'snappy': 'cubic-bezier(0.16, 1, 0.3, 1)',
        'standard': 'cubic-bezier(0.2, 0, 0, 1)',
      },
      transitionDuration: {
        'micro': '120ms',
        'surface': '200ms',
        'modal': '260ms',
      },
    },
  },
};
```

Common utility application:

```html
<!-- Interactive button with snappy micro-press -->
<button class="transition-transform duration-micro ease-snappy active:scale-[0.97]">
  Submit
</button>
```

### 3. Framer Motion and Motion (React)

Use spring configurations instead of time-based easings:

```typescript
// Snappy micro-interaction
export const snappySpring = {
  type: "spring",
  stiffness: 450,
  damping: 32,
  mass: 0.8,
};

// Surface / modal entrance
export const surfaceSpring = {
  type: "spring",
  stiffness: 260,
  damping: 26,
  mass: 1.0,
};

// Usage example
<motion.div
  initial={{ opacity: 0, scale: 0.96 }}
  animate={{ opacity: 1, scale: 1 }}
  exit={{ opacity: 0, scale: 0.98 }}
  transition={surfaceSpring}
/>
```

### 4. SwiftUI (Apple Platforms)

Leverage native interactive spring models:

```swift
// Snappy control interaction
withAnimation(.spring(response: 0.28, dampingFraction: 0.72)) {
    isExpanded.toggle()
}

// Dialog or sheet presentation
withAnimation(.spring(response: 0.36, dampingFraction: 0.82)) {
    showModal = true
}
```

### 5. Flutter

Use standard physics-based curves or springs:

```dart
// Snappy curved animation
CurvedAnimation(
  parent: controller,
  curve: Curves.easeOutCubic,
  reverseCurve: Curves.easeInCubic,
);

// Spring simulation for custom physics
final spring = SpringDescription(
  mass: 0.8,
  stiffness: 400.0,
  damping: 30.0,
);
```

## Accessibility and Reduced Motion Protocol

Every interactive interface must respect user system preferences regarding vestibular disorders and motion sensitivity.

### CSS Standard Media Query

Disable translations and scaling while preserving functional state changes:

```css
@media (prefers-reduced-motion: reduce) {
  *,
  *::before,
  *::after {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
    scroll-behavior: auto !important;
  }
}
```

### Tailwind Reduced Motion Support

Apply motion safety conditionally:

```html
<div class="transition-transform motion-reduce:transition-none transform hover:-translate-y-1 motion-reduce:hover:translate-y-0">
  Accessible Card Content
</div>
```

### React and Framer Motion Reduced Motion Hook

```typescript
import { useReducedMotion } from "framer-motion";

export function Modal({ isOpen, children }) {
  const shouldReduceMotion = useReducedMotion();

  const transition = shouldReduceMotion
    ? { duration: 0 }
    : { type: "spring", stiffness: 300, damping: 28 };

  return (
    <motion.div
      initial={{ opacity: 0, y: shouldReduceMotion ? 0 : 16 }}
      animate={{ opacity: isOpen ? 1 : 0, y: 0 }}
      transition={transition}
    >
      {children}
    </motion.div>
  );
}
```

## Interactive State Ergonomics

Every actionable element must explicitly define five tactile states:

1. **Default:** Stable visual baseline with clear affordance.
2. **Hover:** Subtle brightness or background lift (do not shift geometry or cause layout reflow).
3. **Active / Pressed:** Physical compression feedback (e.g. `transform: scale(0.97)` to `scale(0.98)`).
4. **Focus-Visible:** High-contrast outline ring (minimum 2px width, minimum 2px offset). Never set `outline: none` without providing an accessible visible replacement.
5. **Disabled:** Reduced opacity (40% to 50%) with `cursor: not-allowed` and `pointer-events: none` or disabled attribute.

