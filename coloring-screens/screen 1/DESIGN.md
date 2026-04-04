# Design System Strategy: The Imaginative Canvas

## 1. Overview & Creative North Star
This design system is built upon the Creative North Star of **"The Tactile Playground."** While many children's apps rely on cluttered interfaces and chaotic animations, this system takes a high-end editorial approach to play. We treat the digital interface as a premium physical toy—smooth, inviting, and impeccably organized.

The goal is to move away from "flat" design and toward a **hyper-tactile reality**. We achieve this through intentional asymmetry, where floating toolbars and overlapping canvas elements create a sense of depth and discovery. By using sophisticated tonal layering and "squishy" geometry, we ensure the experience is intuitive for a child’s motor skills while maintaining the aesthetic polish of a bespoke digital experience.

## 2. Colors & Atmospheric Depth
Our palette is a sophisticated trio of energy: **Primary Yellow** (Sunshine), **Secondary Blue** (Sky), and **Tertiary Pink** (Spark). These are not merely decorative; they define the functional zones of the app.

### The "No-Line" Rule
To maintain a soft, friendly environment, **1px solid borders are strictly prohibited.** Boundaries between sections must be defined through background color shifts. For instance, a drawing tool palette should be a `surface-container-highest` element sitting on a `surface` background. The lack of harsh lines prevents the UI from feeling "clinical" or "restrictive."

### Surface Hierarchy & Nesting
We treat the UI as a series of physical layers. Use the following hierarchy to define importance:
*   **Base Layer:** `surface` or `surface-container-low` (The "Desk").
*   **Active Canvas:** `surface-container-lowest` (The "Paper").
*   **Interaction Containers:** `surface-container-high` to `surface-container-highest` (The "Toolboxes").
Nesting a `surface-container-highest` button within a `surface-container-low` header creates a natural, soft depth that guides the eye without needing structural dividers.

### The "Glass & Gradient" Rule
To add soul to the interface, avoid purely flat colors for high-impact elements. 
*   **Floating Palettes:** Use **Glassmorphism** for tool overlays. Apply a semi-transparent `surface-variant` with a high `backdrop-blur`. This allows the child’s artwork to peek through the UI, making the app feel like a single, cohesive world.
*   **Signature Textures:** For main Action Buttons (CTAs), use a subtle radial gradient transitioning from `primary` to `primary-container`. This mimics the look of a polished, convex plastic button, inviting a "press."

## 3. Typography: Whimsical Clarity
We utilize **Plus Jakarta Sans** for its geometric friendliness and exceptional legibility. The type hierarchy is designed to be "glanceable" for children who may still be learning to read.

*   **The Hero Voice (Display LG/MD):** Used for celebratory moments and screen titles. The large scale provides a sense of wonder and importance.
*   **The Friendly Guide (Headline SM):** Used for instructional prompts. It is sized to be authoritative yet approachable.
*   **The Functional Label (Label MD):** Used sparingly. Most functions should be icon-driven, but where text exists, it is set in high-contrast `on-surface` colors to ensure maximum accessibility.

## 4. Elevation & Tonal Layering
Traditional shadows are often too "heavy" for a vibrant children’s app. Instead, we use **Tonal Layering** and **Ambient Light**.

*   **The Layering Principle:** Depth is achieved by stacking. A `surface-container-lowest` card placed on a `surface-dim` background creates a "lifted" effect that feels natural and light.
*   **Ambient Shadows:** When a floating effect is required (e.g., a modal or a floating brush picker), use an extra-diffused shadow. 
    *   *Formula:* Blur: 24px–40px | Opacity: 6% | Color: `surface-tint`.
*   **The "Ghost Border" Fallback:** If accessibility requires a container definition, use the `outline-variant` token at **15% opacity**. This creates a "suggestion" of a border rather than a hard edge.

## 5. Components & Interaction Patterns

### Buttons (Tactile Triggers)
*   **Primary:** Uses `primary_container` with a `xl` (3rem) or `full` roundedness. These should be large (minimum 64px height) to accommodate "fat-finger" interactions.
*   **Secondary:** Uses `secondary_container`. These are for secondary tools like "Undo" or "Clear."
*   **States:** On press, a button should not just change color; it should visually "sink." Use a slight scale down (0.95x) to provide haptic-like visual feedback.

### The Drawing Palette (Toolbox)
Avoid the grid. Use an asymmetrical "staggered" layout for color swatches. This makes the interface feel more like a messy, fun art table and less like a spreadsheet.
*   **Selection State:** When a color or tool is selected, use a `primary` ring or a slight "pop-out" scale effect.

### Cards & Progress
*   **Art Gallery Cards:** Use `surface-container-low`. Forbid divider lines. Use `vertical white space` (from the Spacing Scale) to separate the artwork from the metadata.
*   **Progress Bars:** Use `tertiary_container` for the track and `tertiary` for the fill. The ends must be `full` rounded to maintain the soft aesthetic.

### Input Fields (For Parents/Setup)
*   **Styling:** Use `surface_container_highest` with a `md` (1.5rem) corner radius. Use the "Ghost Border" (15% `outline-variant`) for the container.

## 6. Do's and Don'ts

### Do:
*   **Do** use `xl` and `full` rounded corners for almost everything. Sharp corners are "scary" in this system.
*   **Do** overlap elements. Let a brush icon slightly hang off the edge of its container to create a 3D, editorial feel.
*   **Do** prioritize the `on-primary` and `on-secondary` colors for text to ensure high-contrast readability against vibrant backgrounds.

### Don't:
*   **Don't** use black (`#000000`) for text or shadows. Always use the `on-surface` or `surface-tint` tokens to keep the palette warm.
*   **Don't** use standard 1px borders. If you feel you need a line, use a color-block shift instead.
*   **Don't** cram the screen. Children need "breathing room" to avoid accidental taps. Use generous spacing from the `xl` scale.