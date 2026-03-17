# Colors

Adaptive, role-based color tokens that automatically switch between light and dark appearances.

## Overview

DesignKit's color system is built around two ideas:

1. **Semantic roles** — tokens are named for their _purpose_ (`primaryText`, `successBackground`) rather than their visual appearance (`gray900`, `green200`). This keeps code readable and makes palette swaps trivial.
2. **Per-token mode locking** — every `DesignKitColor` value carries an optional `DesignKit.Theme`. Most tokens respond to the system scheme, but individual tokens — or whole view subtrees — can be pinned to always-light or always-dark.

## Color Roles

The 22 tokens in `DesignKitColorPalette` are divided into three roles. The same semantic name can appear in multiple roles, but each resolves to a different actual color:

| Role | Purpose | Example tokens |
|---|---|---|
| **Text** | `foregroundStyle`, `tint`, in-text icons | `primaryText`, `secondaryText`, `accentText` |
| **Background** | `background()`, container fills | `primaryBackground`, `successBackground` |
| **Object** | Interactive controls, icons, dividers | `accentObject`, `errorObject` |

Within each role there are four semantic "intensity" levels — primary, secondary, tertiary, accent — plus four status variants: success, warning, error, info.

## Using Color Tokens

In any context that accepts `ShapeStyle` — `foregroundStyle`, `fill`, `background`, `stroke` — you can use the leading-dot shorthand without writing `Color.` explicitly:

```swift
Text("Title")
    .foregroundStyle(.dk(\.primaryText))

RoundedRectangle(cornerRadius: 12)
    .fill(.dk(\.secondaryBackground))

Image(systemName: "checkmark")
    .foregroundStyle(.dk(\.successObject))
```

Use the explicit `Color.dk(_:)` form when the type must be `Color` (e.g. storing in a variable or passing to an API that requires `Color` specifically):

```swift
let tint: Color = Color.dk(\.accentText)
let color = DesignKit.colors.palette.primaryText.color
```

## Creating Custom Colors

`DesignKitColor` exposes five static factory methods:

```swift
// Wrap any SwiftUI system color
let accent = DesignKitColor.system(.accentColor)

// Single hex value — adapts to system light/dark automatically
let brand  = DesignKitColor.hex("#0A84FF")

// Separate light/dark hex values
let surface = DesignKitColor.hex(light: "#FFFFFF", dark: "#1C1C1E")

// RGBA components (0.0–1.0)
let overlay = DesignKitColor.rgb(r: 0, g: 0, b: 0, alpha: 0.4)

// Separate light/dark RGBA
let gradient = DesignKitColor.rgb(
    light: (r: 1, g: 1, b: 1, alpha: 0.9),
    dark:  (r: 0, g: 0, b: 0, alpha: 0.8)
)
```

Each factory accepts an optional `mode:` parameter to lock the color:

```swift
// Always renders as the dark-mode value, even in light mode
let lockedDark = DesignKitColor.hex("#A8FF78", mode: .dark)
```

## Swapping the Palette

Implement `DesignKitColorPalette` to define your brand colors, then assign it at launch via `DesignKit.configure`:

```swift
struct BrandPalette: DesignKitColorPalette {
    var primaryText:         DesignKitColor { .hex(light: "#1A1A2E", dark: "#EAEAF5") }
    var secondaryText:       DesignKitColor { .hex(light: "#44446A", dark: "#A0A0C8") }
    var tertiaryText:        DesignKitColor { .hex(light: "#7777AA", dark: "#6666A0") }
    var accentText:          DesignKitColor { .hex("#6C63FF") }
    var successText:         DesignKitColor { .hex(light: "#1B7F4A", dark: "#30D158") }
    var warningText:         DesignKitColor { .hex(light: "#A05C00", dark: "#FFD60A") }
    var errorText:           DesignKitColor { .hex(light: "#C0392B", dark: "#FF453A") }
    var infoText:            DesignKitColor { .hex(light: "#0A6EBD", dark: "#0A84FF") }

    var primaryBackground:   DesignKitColor { .hex(light: "#F5F5FF", dark: "#0D0D1A") }
    var secondaryBackground: DesignKitColor { .hex(light: "#EBEBFF", dark: "#1A1A2E") }
    var tertiaryBackground:  DesignKitColor { .hex(light: "#FFFFFF", dark: "#25253D") }
    var successBackground:   DesignKitColor { .hex(light: "#D1F2EB", dark: "#0A3D22") }
    var warningBackground:   DesignKitColor { .hex(light: "#FEF3CD", dark: "#3A2D00") }
    var errorBackground:     DesignKitColor { .hex(light: "#FADBD8", dark: "#3B0F0C") }
    var infoBackground:      DesignKitColor { .hex(light: "#D6EAF8", dark: "#0C2A45") }

    var primaryObject:   DesignKitColor { .hex(light: "#1A1A2E", dark: "#EAEAF5") }
    var secondaryObject: DesignKitColor { .hex(light: "#44446A", dark: "#A0A0C8") }
    var tertiaryObject:  DesignKitColor { .hex(light: "#BBBBDD", dark: "#33334D") }
    var accentObject:    DesignKitColor { .hex("#6C63FF") }
    var successObject:   DesignKitColor { .hex(light: "#1B7F4A", dark: "#30D158") }
    var warningObject:   DesignKitColor { .hex(light: "#A05C00", dark: "#FFD60A") }
    var errorObject:     DesignKitColor { .hex(light: "#C0392B", dark: "#FF453A") }
    var infoObject:      DesignKitColor { .hex(light: "#0A6EBD", dark: "#0A84FF") }
}

// In your @main App:
DesignKit.configure(palette: BrandPalette())
```

## Forcing Light or Dark Mode

`.dkTheme(_:)` applies `.environment(\.colorScheme, ...)` to an entire view subtree:

```swift
// This card always shows light-mode colors, even when the device is in dark mode
BrandCard()
    .dkTheme(.light)

// This overlay is always dark
MediaOverlay()
    .dkTheme(.dark)
```

> Important: Per-token mode locking (set via the `mode:` parameter on factories) takes effect when the `DesignKitColor` is created. Subtree-level forcing via `.dkTheme(_:)` is independent and applies to the whole SwiftUI environment.

## Topics

### Color Token

- ``DesignKitColor``

### Mode Control

- ``DesignKit/Theme``

### Palette

- ``DesignKitColorPalette``
- ``DesignKitDefaultPalette``
