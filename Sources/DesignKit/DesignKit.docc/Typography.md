# Typography

Semantic text styles, configurable font families, and SwiftUI extensions that make type usage consistent across your app.

## Overview

DesignKit's typography system separates _what_ text means from _how_ it looks:

- **`DesignKitTextStyle`** — 12 semantic styles (`displayLarge`, `bodyMedium`, `caption`, etc.) that express intent.
- **`DesignKit.fonts`** — the factory that maps each style to a concrete `(weight, size)` pair. Also holds the two configurable font families.
- **`DesignKitFont`** — a fully-specified font value (family + weight + size) that resolves to a SwiftUI `Font`.
- **Extensions** — `.font(.dk(.bodyMedium))` and `.dkTextStyle(...)` for concise call sites.

## Semantic Text Styles

| Style | Size | Weight | Typical use |
|---|---|---|---|
| `displayLarge` | 40 pt | Bold | Hero headlines, splash screens |
| `displaySmall` | 32 pt | Semibold | Section heroes |
| `headingLarge` | 24 pt | Bold | Page titles |
| `headingMedium` | 20 pt | Semibold | Card headers |
| `headingSmall` | 18 pt | Semibold | List section headers |
| `bodyLarge` | 18 pt | Regular | Lead paragraphs |
| `bodyMedium` | 16 pt | Regular | Standard body copy |
| `bodySmall` | 14 pt | Regular | Secondary body content |
| `labelLarge` | 14 pt | Medium | Button labels, form labels |
| `labelMedium` | 12 pt | Medium | Secondary labels, badges |
| `labelSmall` | 10 pt | Medium | Metadata, captions inside cells |
| `caption` | 12 pt | Regular | Image captions, legal text |

## Using Typography Tokens

The shortest path is the `Font.dk(_:)` extension:

```swift
Text("Welcome back").font(.dk(.headingLarge))
Text("Your recent orders").font(.dk(.bodyMedium))
Text("Last updated 2 min ago").font(.dk(.caption))
```

Combine with a color token in one modifier:

```swift
Text("Username")
    .dkTextStyle(.labelMedium, color: \.secondaryText)

Text("Error: field required")
    .dkTextStyle(.bodySmall, color: \.errorText)
```

Override the font family for a single call without changing global config:

```swift
Text("Code snippet")
    .font(.dk(.bodySmall, family: .systemMono))

Text("Elegant heading")
    .font(.dk(.headingMedium, family: .systemSerif))
```

## Font Families

`DesignKitFontFamily` supports four built-in system font designs and an escape hatch for custom fonts:

| Case | Resolves to |
|---|---|
| `.system` | SF Pro Text / Display (default) |
| `.systemRounded` | SF Pro Rounded |
| `.systemSerif` | New York |
| `.systemMono` | SF Mono |
| `.customLoaded(familyName:)` | Any PostScript family name registered by the host app |

### Loading Custom Fonts

Register your font files in your app target's Info.plist under `UIAppFonts`, then pass the PostScript family name:

```swift
// In your @main App init:
DesignKit.configure(
    primaryFamily:   .customLoaded(familyName: "NunitoSans-Regular"),
    secondaryFamily: .customLoaded(familyName: "NunitoSans-Bold")
)
```

> Important: DesignKit does not register font files — that is the host app's responsibility. The `.customLoaded(familyName:)` case simply passes the name to `Font.custom(_:size:)`.

## Configuring Global Families

Change the primary and secondary families once at app launch. All call sites that use `.font(.dk(...))` without an explicit family override will pick up the change automatically:

```swift
@main
struct MyApp: App {
    init() {
        DesignKit.configure(
            primaryFamily:   .customLoaded(familyName: "BrandSans-Regular"),
            secondaryFamily: .systemRounded
        )
    }
    // ...
}
```

## Font Weights

`DesignKitFontWeight` maps 9 common weights to `Font.Weight`:

```swift
// Rarely needed directly — DesignKit.fonts handles weight for each style
DesignKitFont(family: .system, weight: .semibold, size: 18).font
```

## Topics

### Styles and Configuration

- ``DesignKitTextStyle``
- ``DesignKitFontFamily``

### Font Values

- ``DesignKitFont``
- ``DesignKitFontWeight``
- ``DesignKitTextSize``
