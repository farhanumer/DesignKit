# Extensions

SwiftUI shorthand extensions that make token usage concise and expressive at the call site.

## Overview

DesignKit ships five SwiftUI extensions that eliminate boilerplate when applying design tokens:

| Extension | What it does |
|---|---|
| `.dk(_:)` on `ShapeStyle` | Leading-dot color token in any `ShapeStyle` context |
| `Color.dk(_:)` | Explicit color token when the type must be `Color` |
| `Font.dk(_:family:)` | Resolves a semantic text style to a SwiftUI `Font` |
| `.dkTextStyle(_:color:family:)` | Applies font + optional color in one modifier |
| `.dkPadding(horizontal:vertical:)` | Applies axis-specific padding using ``DesignKit/sizes/Token`` values |
| `.dkTheme(_:)` | Forces a view subtree to a specific light/dark mode |

## `.dk(_:)` — Leading-dot shorthand

A `ShapeStyle where Self == Color` extension lets you drop `Color.` in any context where Swift expects a `ShapeStyle` — which covers `foregroundStyle`, `fill`, `background`, and `stroke`:

```swift
Text("Title")
    .foregroundStyle(.dk(\.primaryText))

Rectangle()
    .fill(.dk(\.accentObject))

card.background(.dk(\.secondaryBackground))

RoundedRectangle(cornerRadius: 10)
    .stroke(.dk(\.tertiaryObject), lineWidth: 1)
```

Use the explicit `Color.dk(_:)` form when the type must be pinned to `Color` — for example when storing in a variable:

```swift
let tint: Color = Color.dk(\.accentText)
```

The key path autocompletes to every property defined in ``DesignKitColorPalette``, so Xcode guides you to all 22 available tokens.

## `Font.dk(_:family:)`

Resolves a semantic text style to a SwiftUI `Font`, optionally overriding the global primary family:

```swift
// Use the global primary family
Text("Title").font(.dk(.headingLarge))

// Override family for this single call
Text("Code")
    .font(.dk(.bodySmall, family: .systemMono))

Text("Elegant")
    .font(.dk(.headingMedium, family: .systemSerif))

Text("Friendly")
    .font(.dk(.bodyMedium, family: .systemRounded))
```

Passing `family: nil` (the default) defers to `DesignKit.fonts.primaryFamily`.

## `.dkTextStyle(_:color:family:)`

Combines font + foreground color in a single readable modifier:

```swift
// Font only (color inherited from environment)
Text("Section heading")
    .dkTextStyle(.headingSmall)

// Font + color token
Text("Supporting text")
    .dkTextStyle(.bodyMedium, color: \.secondaryText)

// Font + color + family override
Text("Fine print")
    .dkTextStyle(.caption, color: \.tertiaryText, family: .systemSerif)

// Status colors
Text("3 errors found")
    .dkTextStyle(.labelLarge, color: \.errorText)

Text("Saved successfully")
    .dkTextStyle(.labelMedium, color: \.successText)
```

## `.dkPadding(horizontal:vertical:)`

Applies independent horizontal and vertical padding using ``DesignKit/sizes/Token`` values. Because the parameters are typed as `DesignKit.sizes.Token`, Swift can infer the type and you get leading-dot syntax:

```swift
// Leading-dot shorthand
CardView()
    .dkPadding(horizontal: .medium, vertical: .small)

// Horizontal only
view.dkPadding(horizontal: .large)

// Vertical only
view.dkPadding(vertical: .xSmall)
```

Both parameters are optional and default to `0` when omitted.

> Note: For native SwiftUI APIs (`VStack(spacing:)`, `.padding(_:_:)`) that accept `CGFloat`, use `DesignKit.sizes.medium` or `DesignKit.sizes.large` directly — leading-dot syntax is not available there because `CGFloat` is a system type.

## `.dkTheme(_:)`

Forces the SwiftUI `colorScheme` environment value for an entire subtree:

```swift
// Lock to light mode
InvoiceCard()
    .dkTheme(.light)

// Lock to dark mode
VideoPlayer()
    .dkTheme(.dark)

// Inherit from the system (no-op — this is the default behavior)
ContentView()
    .dkTheme(.system)
```

This modifier is equivalent to `.environment(\.colorScheme, .light)` or `.environment(\.colorScheme, .dark)`, but uses the `DesignKit.Theme` enum for consistency with the rest of the library.

> Note: `.dkTheme(.system)` removes any previously forced scheme in the subtree, restoring standard system-controlled behavior.

## Topics

### Color Scheme Modifier

- ``DesignKitColorSchemeModeModifier``
- ``DesignKit/Theme``
