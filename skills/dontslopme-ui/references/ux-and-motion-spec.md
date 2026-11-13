# UX and Motion Specification

Comprehensive motion physics, animation principles, ergonomic UX laws, tactile mechanics, and cross-platform tokens.

## Fast Motion Slop Grep Recipes

Identify sluggish or robotic transitions across source files without reading entire files:

### 1. Sluggish Transitions (>400ms)

```text
\b(duration-(500|700|1000)|transition:.*[4-9][0-9]{2}ms)\b
```

### 2. Linear or Symmetrical Easings on Entrances

```text
\b(ease-linear|transition-timing-function:\s*linear|animation-timing-function:\s*linear)\b
```

### 3. Missing Reduced Motion Declarations

```text
grep -rnL "prefers-reduced-motion" src/ styles/
```

## The 20 Principles of UX & Animation

### Classical Animation Principles (1-12)

#### 1. Squash & Stretch

- **Concept:** Elements distort momentarily during rapid acceleration or impact to convey elasticity.
- **Rule:** Scale sliders or toggle knobs by 12% in the direction of drag; compress buttons by 3% on press.

#### 2. Anticipation Wind-Up

- **Concept:** A subtle preparatory backward motion before a major action.
- **Rule:** Before launching a heavy modal or panel, compress the trigger slightly (`scale(0.97)`).

#### 3. Staging the Focus

- **Concept:** Directing visual attention exclusively to the single focal interaction.
- **Rule:** Dim backgrounds with an opaque neutral backdrop when modals appear; do not animate background cards while dialogs are open.

#### 4. Pose to Pose

- **Concept:** Defining crisp start, key, and end poses rather than continuous floating animations.
- **Rule:** State machine transitions must cleanly resolve between `collapsed`, `expanding`, and `expanded`.

#### 5. Follow Through

- **Concept:** Secondary components continue moving after the main body stops.
- **Rule:** When a drawer slides open, let its header settle before internal card items finish settling.

#### 6. Slow In & Slow Out

- **Concept:** Natural bodies take time to accelerate and decelerate.
- **Rule:** Use ease-out curves for elements entering the screen; use ease-in for exits.

#### 7. Moving in Arcs

- **Concept:** Organic movement naturally follows curved, parabolic trajectories.
- **Rule:** Floating action buttons, cursor tooltips, and fly-out menus should translate along subtle arc curves rather than straight diagonals.

#### 8. Secondary Action

- **Concept:** An auxiliary animation that emphasizes the primary action.
- **Rule:** When an item is deleted from a list, fade its text while simultaneously collapsing the row height.

#### 9. Snappy Timing

- **Concept:** Duration must reflect physical mass and cognitive urgency.
- **Rule:** Keep micro-interactions between 100ms and 150ms; keep full surface reveals under 300ms.

#### 10. Exaggerated Feedback for Milestones Only

- **Concept:** Heightened celebratory animation reserved for rare achievements.
- **Rule:** Confetti or burst animations are reserved for task completion (e.g. invoice paid); never fire bursts on basic button clicks.

#### 11. Solid Drawing in 3D

- **Concept:** Respecting physical spatial planes, layering, and z-index ordering.
- **Rule:** Ensure shadows correspond to a consistent simulated light source directly above the viewport.

#### 12. Overall Appeal

- **Concept:** Designing motion that feels effortless, cohesive, and intentional.
- **Rule:** Every animation must serve orientation or status comprehension, never gratuitous decoration.

### Ergonomic UX Laws (13-20)

#### 13. Fitts's Law

- **Rule:** The time to acquire a target is a function of distance and size. Place high-frequency actions near natural thumb and cursor resting positions.

#### 14. Bigger Hit Areas (>= 44px)

- **Rule:** Interactive touch targets must meet a minimum bounding box of 44x44 CSS pixels on mobile and 32x32 pixels on desktop with adequate spacing.

#### 15. Hick's Law

- **Rule:** Decision time increases logarithmically with the number of options. Limit dropdowns to 5-7 items or categorize with search filters.

#### 16. Miller's Law (3-5 Item Chunks)

- **Rule:** Humans process information in small chunks. Group complex forms into 3-5 item fieldsets.

#### 17. Doherty Threshold (< 400ms)

- **Rule:** Productivity peaks when the system provides visual feedback in under 400ms. If processing takes longer, show an immediate skeleton or progress indicator.

#### 18. Postel's Law

- **Rule:** Be liberal in what you accept, conservative in what you send. Accept flexible user input formats (e.g. phone numbers with or without dashes) and sanitize internally.

#### 19. Jakob's Law

- **Rule:** Users spend most of their time on other sites. Match established conventions (e.g. cart top right, logo top left, search bar accessible via Cmd+K).

#### 20. Frequency of Use

- **Rule:** Optimize navigation paths for the top 5% daily actions. Tuck administrative edge cases into secondary menus.

## The 20 Tactile Animation Mechanics

### 1. Ease-Out Entrances

- **Mechanic:** Fast arrival with snappy deceleration.
- **Spec:** Use `cubic-bezier(0.16, 1, 0.3, 1)` or `ease-out`. Elements appear to arrive with high momentum and brake quickly.

### 2. Dropdowns at 150-250ms

- **Mechanic:** Menus must appear instantly upon trigger click.
- **Spec:** Target duration 180ms with 4px translation and opacity fade.

### 3. Stagger List Rows by 30ms (Cap 300ms)

- **Mechanic:** Cascading entrance for multi-row data.
- **Spec:** Delay each row by 30ms; cap the maximum cumulative delay at 300ms so rows 11+ enter together.

### 4. Scale to 0.97 on Press

- **Mechanic:** Instant tactile button depression.
- **Spec:** Apply `transform: scale(0.97)` on `:active` with 100ms transition.

### 5. Stretch Moving Knobs 12%

- **Mechanic:** Squash and stretch during drag gestures.
- **Spec:** Elongate slider thumb along the drag axis: `scaleX(1.12) scaleY(0.92)`.

### 6. Stagger Inner Details as Containers Settle

- **Mechanic:** Spatial hierarchy in modal opening.
- **Spec:** Modal frame expands at 0ms; internal inputs fade in at 60ms.

### 7. Arcs for Object Movement

- **Mechanic:** Curved translation for floating controls.
- **Spec:** Combine separate x and y easing functions to simulate a gentle parabola.

### 8. Pulse to Confirm Success

- **Mechanic:** Single confirmation pulse on successful action.
- **Spec:** Scale up to `1.04` and settle to `1.0` over 200ms. Never loop infinitely.

### 9. Ease-In-Out for Moves

- **Mechanic:** Symmetrical easing when moving between existing layout positions.
- **Spec:** Reordering list items or moving tabs uses `cubic-bezier(0.4, 0, 0.2, 1)`.

### 10. Start Popovers at 0.95

- **Mechanic:** Snappy scale entrance for tooltips and popovers.
- **Spec:** Initial state `opacity: 0; transform: scale(0.95)`. Animate to `1.0` over 150ms.

### 11. Enter from Trigger Origin

- **Mechanic:** Popovers and dialogs emerge from the button that invoked them.
- **Spec:** Set `transform-origin` dynamically to the click target coordinate.

### 12. Exit to Trigger Origin

- **Mechanic:** Collapsing surfaces return to their origin point.
- **Spec:** Scale down towards the invoking button upon dismissal.

### 13. No Bounce on Everyday UI

- **Mechanic:** Zero spring overshoot on utility controls.
- **Spec:** Critical menus, forms, and dialogs must not bounce or wobble. Reserve bounce solely for physical drag release.

### 14. Don't Tween While Held

- **Mechanic:** 1:1 positional tracking during direct manipulation.
- **Spec:** Disable transitions while the user is actively dragging or scrubbing; re-enable spring physics on release.

### 15. Make Exits 20% Shorter

- **Mechanic:** Dismissal animations must feel faster than entrances.
- **Spec:** If entrance is 250ms, exit must be 200ms.

### 16. Overlap Old & New States

- **Mechanic:** Seamless crossfading during route or tab switches.
- **Spec:** Start new view entrance at 50% of old view exit to eliminate blank flashes.

### 17. Masks for Reveals & Color

- **Mechanic:** Using CSS `clip-path` masks for reveals rather than resizing DOM containers.
- **Spec:** `clip-path: inset(0 0 0 0)` to prevent layout reflows during expand animations.

### 18. Crossfade Icons + Blur

- **Mechanic:** Smooth morphing between two icons (such as hamburger to close X).
- **Spec:** Crossfade opacity paired with 2px blur filter over 140ms.

### 19. Rubber Band Past Bounds

- **Mechanic:** Logarithmic resistance when dragging past viewport or list boundaries.
- **Spec:** Displacement formula: `offset = distance * 0.35`.

### 20. Reuse Shared Layout IDs

- **Mechanic:** Continuous spatial element morphing across view transitions.
- **Spec:** Use platform layout IDs:
  - Web: CSS `view-transition-name`
  - React / Framer Motion: `layoutId="hero-card"`
  - SwiftUI: `.matchedGeometryEffect(id: "card", in: namespace)`
  - Flutter: `Hero(tag: 'card', child: ...)`

## Cross-Platform Implementation Tokens

### Web CSS

```css
:root {
  --ease-snappy: cubic-bezier(0.16, 1, 0.3, 1);
  --ease-move: cubic-bezier(0.4, 0, 0.2, 1);
  --duration-micro: 120ms;
  --duration-surface: 200ms;
  --duration-modal: 260ms;
}

/* Reduced motion mandatory override */
@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
    scroll-behavior: auto !important;
  }
}
```

### Tailwind CSS Utility Application

```html
<!-- Snappy button with reduced-motion safety -->
<button class="transition-transform duration-120 ease-out active:scale-[0.97] motion-reduce:active:scale-100">
  Confirm Action
</button>
```

### Framer Motion (React)

```typescript
import { useReducedMotion, motion } from "framer-motion";

export function SnappyDialog({ isOpen, children }: { isOpen: boolean; children: React.ReactNode }) {
  const shouldReduceMotion = useReducedMotion();

  const transition = shouldReduceMotion
    ? { duration: 0.01 }
    : { type: "spring", stiffness: 450, damping: 32, mass: 0.8 };

  return (
    <motion.div
      initial={{ opacity: 0, scale: shouldReduceMotion ? 1 : 0.95 }}
      animate={{ opacity: isOpen ? 1 : 0, scale: isOpen ? 1 : 0.95 }}
      transition={transition}
    >
      {children}
    </motion.div>
  );
}
```

### SwiftUI (Apple Platforms)

```swift
import SwiftUI

struct TactileButton: View {
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @State private var isPressed = false

    var body: some View {
        Button(action: {}) {
            Text("Submit")
                .padding()
                .scaleEffect(isPressed && !reduceMotion ? 0.97 : 1.0)
                .animation(.spring(response: 0.28, dampingFraction: 0.72), value: isPressed)
        }
    }
}
```

### Flutter

```dart
import 'package:flutter/material.dart';

Widget buildTactileButton(BuildContext context, VoidCallback onPressed) {
  final reduceMotion = MediaQuery.of(context).disableAnimations;

  return AnimatedScale(
    scale: 0.97,
    duration: reduceMotion ? Duration.zero : const Duration(milliseconds: 120),
    curve: Curves.easeOutCubic,
    child: ElevatedButton(
      onPressed: onPressed,
      child: const Text('Confirm'),
    ),
  );
}
```
