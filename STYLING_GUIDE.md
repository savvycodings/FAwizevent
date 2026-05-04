# Styling Guide (Themes, Colors, Spacing)

This file explains how styling is done in this project: theme colors, where colors are used, and how we handle margins, padding, gaps, banners, and boxes.

## Core Rule

- Use theme values and layout constants first.
- Avoid hardcoded spacing values unless there is a strong design reason.
- Prefer reusable components (`Section`, `ThemedCard`, `ThemedButton`) instead of styling from scratch each time.

## 1) Theme And Color System

Main theme definitions are in:

- `src/theme.ts`

Theme context usage:

- `src/context.tsx`
- `src/main.tsx`

### Available themes

- `lightTheme`
- `darkTheme`
- `hackerNews`
- `miami`
- `vercel`
- `wizards`

### Common theme color tokens

These are the main values used across components:

- `theme.backgroundColor` - screen/page background
- `theme.textColor` - main text color
- `theme.mutedForegroundColor` - secondary/subtle text
- `theme.cardBackground` - card/banner surface
- `theme.borderColor` - card/input/border stroke
- `theme.tintColor` - primary accent (buttons/highlights)
- `theme.tintTextColor` - text color on tinted backgrounds
- `theme.tabBarActiveTintColor` / `theme.tabBarInactiveTintColor`

Navigation/tailwind color variables are also wired in:

- `NAV_THEME` in `src/theme.ts`
- `tailwind.config.js` (CSS variable based colors like `--background`, `--primary`, etc.)

## 2) Where Colors Are Used

### App-level and navigation colors

- `src/main.tsx`
  - Tab active/inactive colors from theme
  - Tab background from `theme.backgroundColor`

### Section headers and text

- `src/components/layout/Section.tsx`
  - Title uses `theme.textColor`
  - "See all" uses `theme.mutedForegroundColor`

### Reusable cards and buttons

- `src/components/ui/ThemedCard.tsx`
  - Uses `theme.cardBackground` and `theme.borderColor`
- `src/components/ui/ThemedButton.tsx`
  - Primary button uses `theme.tintColor`
  - Secondary/outline use `theme.buttonBackground` and `theme.borderColor`
  - Text uses `theme.tintTextColor` / `theme.textColor`

### Shop/banner style examples

- `src/components/shop/VaultingSection.tsx`
  - Card uses `theme.cardBackground` and `theme.borderColor`
  - Text uses `theme.textColor` and `theme.mutedForegroundColor`
  - CTA uses `theme.tintColor`
- `src/components/profile/SellCardsBanner.tsx`
  - Banner surface uses `theme.cardBackground`
  - Text/icons are mostly white variants
- `src/components/shop/PromoCarousel.tsx`
  - Uses a fixed light card style (`#FFFFFF` / `#000000`) for promo visual contrast

## 3) Spacing, Margin, Padding, Gap

Main spacing tokens live in:

- `src/constants/layout.ts`

### SPACING tokens

- `xs: 4`
- `sm: 8`
- `md: 12`
- `lg: 16`
- `xl: 20`
- `2xl: 24`
- `3xl: 32`
- `4xl: 40`

Semantic spacing:

- `sectionGap` (24) - space between major sections
- `sectionTitleBottom` (12) - gap below section headers
- `cardPadding` (16) - internal card/banner padding
- `containerPadding` (16) - screen horizontal padding
- `headerPadding` (12) - header vertical padding

### Radius tokens (for boxes/cards/buttons)

- `RADIUS.sm`
- `RADIUS.md`
- `RADIUS.lg`
- `RADIUS.xl`
- `RADIUS.full`

Defined in `src/constants/layout.ts` and used throughout cards, pills, badges, and buttons.

## 4) How We Style Boxes And Banners

### Recommended box/card recipe

Use this pattern (usually via `ThemedCard`):

- `backgroundColor: theme.cardBackground`
- `borderRadius: RADIUS.md` or `RADIUS.lg`
- `padding: SPACING.cardPadding` (or component-specific padding)
- `borderWidth: 1`
- `borderColor: theme.borderColor`

Reference:

- `src/components/ui/ThemedCard.tsx`

### Recommended banner recipe

For clickable banners:

- Use card surface + border (`theme.cardBackground`, `theme.borderColor`)
- Use `borderRadius: RADIUS.lg`
- Use `padding: SPACING.cardPadding`
- Use `marginBottom: SPACING.sectionGap` when banner sits between sections

Reference:

- `src/components/profile/SellCardsBanner.tsx`

### Shop section spacing flow

- `ScrollView` content uses `SPACING.containerPadding` and `SPACING.lg`
- Each section starts with `marginTop: SPACING.sectionGap`
- Section header bottom spacing uses `SPACING.sectionTitleBottom`

Reference:

- `src/screens/shop.tsx`
- `src/components/layout/Section.tsx`

## 5) Typography In Styling

Typography tokens are in `src/constants/layout.ts`:

- Headings: `h1`, `h2`, `h3`, `h4`
- Body text: `body`, `bodySmall`, `caption`, `label`

Font family comes from theme font tokens (`theme.boldFont`, `theme.regularFont`, etc.) defined in `src/theme.ts`.

## 6) Practical Do/Don't

### Do

- Use `SPACING`, `TYPOGRAPHY`, `RADIUS` from `src/constants/layout.ts`
- Use theme tokens for colors (`theme.*`)
- Use `Section` for consistent top spacing and title spacing
- Use `ThemedCard` / `ThemedButton` for repeated UI patterns

### Don't

- Don't hardcode margin/padding values if a token exists
- Don't hardcode colors for normal UI surfaces/text when theme token exists
- Don't duplicate card/button styles in many files

## 7) Quick Start Example

```tsx
import { SPACING, RADIUS, TYPOGRAPHY } from '../constants/layout'
import { ThemeContext } from '../context'

// inside component
const { theme } = useContext(ThemeContext)

const styles = StyleSheet.create({
  card: {
    backgroundColor: theme.cardBackground,
    borderColor: theme.borderColor,
    borderWidth: 1,
    borderRadius: RADIUS.lg,
    padding: SPACING.cardPadding,
    marginTop: SPACING.sectionGap,
  },
  title: {
    color: theme.textColor,
    fontSize: TYPOGRAPHY.h3,
    fontFamily: theme.boldFont,
  },
  subtitle: {
    color: theme.mutedForegroundColor,
    fontSize: TYPOGRAPHY.bodySmall,
    fontFamily: theme.regularFont,
  },
  cta: {
    backgroundColor: theme.tintColor,
    borderRadius: RADIUS.md,
    paddingHorizontal: SPACING.lg,
    paddingVertical: SPACING.sm,
  },
})
```

---

If you add a new component, follow this order:

1. Pick colors from `theme.*`
2. Pick spacing/radius/font size from constants
3. Reuse existing layout patterns from `Section`, `ThemedCard`, and `ThemedButton`
