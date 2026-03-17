# Sizing & Spacing

A multiplier-based spacing grid and semantic spacing tokens that scale with a single configurable base unit.

## Overview

All spacing values in DesignKit are derived from one number: `DesignKit.sizes.baseUnit` (default **8 pt**). Every token is a named multiplier of that base:

```
token value = multiplier × baseUnit
```

This means:
- **Changing `baseUnit`** at launch instantly rescales _every_ spacing value in the app.
- **Named tokens** like `DesignKit.sizes.medium` (2× = 16 pt) are human-readable and resistant to magic-number drift.
- **Fractional multipliers** work (`sizes.custom(multiplier: 0.25)` → 2 pt, `sizes.custom(multiplier: 20.25)` → 162 pt), giving precise control when needed.

## The Core Utility

```swift
DesignKit.sizes.custom(multiplier: 1)     // →  8 pt  (1 × 8)
DesignKit.sizes.custom(multiplier: 2)     // → 16 pt  (2 × 8)
DesignKit.sizes.custom(multiplier: 0.5)   // →  4 pt  (0.5 × 8)
DesignKit.sizes.custom(multiplier: 20.25) // → 162 pt (20.25 × 8)
```

Use `sizes.custom(multiplier:)` directly when a named token doesn't exist for your multiplier, or when building custom token sets.

## Named Spacing Tokens

`DesignKit.sizes` exposes nine named tokens as `CGFloat` computed properties. Values shown are at the default base of 8 pt:

| Token | Multiplier | Default value |
|---|---|---|
| `xxSmall` | 0.25× | 2 pt |
| `xSmall` | 0.5× | 4 pt |
| `small` | 1× | 8 pt |
| `mediumSmall` | 1.5× | 12 pt |
| `medium` | 2× | 16 pt |
| `large` | 3× | 24 pt |
| `xLarge` | 4× | 32 pt |
| `xxLarge` | 6× | 48 pt |
| `giant` | 8× | 64 pt |

### Using Tokens in Views

Named tokens return `CGFloat` and are used directly with native SwiftUI APIs:

```swift
VStack(spacing: DesignKit.sizes.medium) { ... }
HStack(spacing: DesignKit.sizes.small) { ... }

view.padding(.horizontal, DesignKit.sizes.large)
view.padding(.vertical, DesignKit.sizes.xSmall)
```

For the `.dkPadding` modifier, use ``DesignKit/sizes/Token`` values instead — these enable leading-dot syntax because the parameter type is known:

```swift
// Leading-dot shorthand
card.dkPadding(horizontal: .medium, vertical: .small)

// Equivalent explicit form
card.dkPadding(
    horizontal: DesignKit.sizes.Token.medium,
    vertical:   DesignKit.sizes.Token.small
)
```

## Configuring the Base Unit

```swift
// At app launch via DesignKit.configure — affects every spacing value app-wide
DesignKit.configure(baseUnit: 6)   // tighter grid
DesignKit.configure(baseUnit: 10)  // looser grid

// Or directly
DesignKit.sizes.baseUnit = 6
```

> Note: Changing `baseUnit` after views have already been laid out does not automatically trigger a SwiftUI redraw. Set it once before the view hierarchy is created, or use `@State`/`@Published` wrappers to propagate changes if live updating is needed.

## Text Size Constants

`DesignKitTextSize` provides named point-size constants for use with `.font(.system(size:))` or when building custom `DesignKitFont` values:

| Case | Raw value |
|---|---|
| `xxSmall` | 10 pt |
| `xSmall` | 12 pt |
| `small` | 14 pt |
| `body` | 16 pt |
| `medium` | 18 pt |
| `large` | 20 pt |
| `xLarge` | 24 pt |
| `xxLarge` | 32 pt |
| `display` | 40 pt |

```swift
// Direct usage
.font(.system(size: DesignKitTextSize.large.rawValue))

// Iterate all sizes (useful in design showcases)
ForEach(DesignKitTextSize.allCases, id: \.rawValue) { size in
    Text("Aa").font(.system(size: size.rawValue))
}
```

## Topics

### Spacing

- ``DesignKit/sizes``
- ``DesignKit/sizes/Token``

### Text Sizes

- ``DesignKitTextSize``
