# ``DesignKit``

A lightweight, token-based iOS design system library for consistent, scalable UI.

## Overview

DesignKit gives your iOS app a single source of truth for design decisions. Instead of scattering raw hex values and magic numbers throughout your codebase, you reference named tokens that automatically adapt to light and dark mode, scale with a configurable base unit, and can be swapped wholesale at launch.

The library has three sub-namespaces, all accessed through the top-level `DesignKit` enum:

- **`DesignKit.colors`** — 22 semantic color tokens organized by role (text, background, object), each carrying its own optional light/dark lock.
- **`DesignKit.fonts`** — 12 semantic text styles mapped to size + weight pairs, with configurable font families.
- **`DesignKit.sizes`** — A multiplier-based spacing grid (`n × baseUnit`) with 9 named tokens and arbitrary custom values.

All three layers expose SwiftUI-friendly shorthand extensions so common usage reads naturally at the call site.

### Quick Start

```swift
import DesignKit

// 1. Configure once at app launch (all parameters optional)
DesignKit.configure(with: .default)                  // built-in defaults
DesignKit.configure(with: .brand)                    // your custom config
DesignKit.configure(palette: BrandPalette())         // palette only

// 2. Use tokens in views
Text("Welcome")
    .font(.dk(.headingLarge))
    .foregroundStyle(.dk(\.primaryText))             // leading-dot shorthand

VStack(spacing: DesignKit.sizes.medium) {
    // ...
}
.dkPadding(horizontal: .large, vertical: .medium)

// 3. Force a subtree to a specific appearance
BrandCard()
    .dkTheme(.light)
```

## Topics

### Essentials

- <doc:GettingStarted>

### Colors

- <doc:Colors>
- ``DesignKitColor``
- ``DesignKit/Theme``
- ``DesignKitColorPalette``
- ``DesignKitDefaultPalette``

### Typography

- <doc:Typography>
- ``DesignKitTextStyle``
- ``DesignKitFontFamily``
- ``DesignKitFontWeight``
- ``DesignKitFont``

### Sizing & Spacing

- <doc:Sizing>
- ``DesignKitTextSize``

### Extensions

- <doc:Extensions>
- ``DesignKitColorSchemeModeModifier``

### Configuration

- ``DesignKitConfiguration``
