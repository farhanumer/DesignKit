<div align="center">

# DesignKit

### A lightweight, token-based iOS design system library for consistent, scalable UI

[![Swift](https://img.shields.io/badge/Swift-6.2+-orange.svg)](https://swift.org)
[![iOS](https://img.shields.io/badge/iOS-18.0+-blue.svg)](https://developer.apple.com/ios/)
[![SPM](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://swift.org/package-manager/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-iOS-red.svg)]()

</div>

---

## Why DesignKit?

DesignKit gives every iOS project a **single source of truth** for colors, typography, and spacing — all accessible through one unified `DesignKit` namespace. No more scattered hex codes, magic numbers, or inconsistent font sizes.

### What It Offers

- **One namespace** — `DesignKit.colors`, `DesignKit.fonts`, `DesignKit.sizes`
- **Automatic dark mode** — every color token adapts with zero extra code
- **Swift 6 type safety** — compile-time enforcement of design decisions
- **JSON configuration** — swap palettes, fonts, and base sizing from a file

---

## Features

### **Adaptive Color System**

- 22 semantic tokens that automatically switch between light and dark
- Per-token mode locking — pin brand colors to always-light or always-dark
- Swap the entire palette at launch with one line
- Hex, RGB, and system color factories built in
- Tokens grouped by role: text, background, and object

### **Semantic Typography**

- 12 named text styles from `displayLarge` to `caption`
- Four built-in families: system, rounded, serif, mono — plus custom loaded fonts
- Full `Font.Weight` range, `ultraLight` through `black`
- Family override per call site — no global state mutation needed

### **Multiplier-Based Sizing**

- All spacing derived from a single `baseUnit` (default 8 pt)
- 9 named tokens — `xxSmall` through `giant`
- Change `baseUnit` at launch to rescale the entire app instantly
- `Token` type enables leading-dot syntax: `.dkPadding(horizontal: .medium)`

### **JSON Configuration**

- Load colors, font families, and base unit from a JSON file
- Per-token color overrides with light/dark and mode-lock support
- Designed for designer-developer handoff workflows

---

## Installation

### Swift Package Manager

#### Via Xcode

1. Open your project in Xcode
2. Go to **File → Add Package Dependencies → Add Local…**
3. Navigate to the `DesignKit` folder and click **Add Package**
4. Select the `DesignKit` product and add it to your app target

#### Via Package.swift

```swift
dependencies: [
    .package(path: "../DesignKit")
]
```

---

## Quick Start

### 1. Configure at Launch

```swift
import SwiftUI
import DesignKit

@main
struct MyApp: App {
    init() {
        // One-line setup with defaults
        DesignKit.configure(with: .default)

        // Or apply a named brand config (define once, reuse everywhere)
        DesignKit.configure(with: .brand)

        // Or override individual settings
        DesignKit.configure(
            palette:       BrandPalette(),
            primaryFamily: .customLoaded(familyName: "BrandSans"),
            baseUnit:      8
        )

        // Or load everything from a JSON file
        if let url = Bundle.main.url(forResource: "tokens", withExtension: "json") {
            try? DesignKit.configure(from: url)
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

// Define a reusable brand config as a static extension
extension DesignKitConfiguration {
    static let brand = DesignKitConfiguration(
        palette:       BrandPalette(),
        primaryFamily: .customLoaded(familyName: "BrandSans"),
        baseUnit:      8
    )
}
```

### 2. Using Colors

```swift
import SwiftUI
import DesignKit

struct WelcomeView: View {
    var body: some View {
        ZStack {
            // Adaptive background — switches automatically with system light/dark
            Color.dk(\.primaryBackground)
                .ignoresSafeArea()

            VStack(spacing: DesignKit.sizes.medium) {
                Text("Welcome to DesignKit!")
                    .foregroundStyle(.dk(\.primaryText))

                Button("Get Started") {}
                    .foregroundStyle(.white)
                    .padding(.horizontal, DesignKit.sizes.large)
                    .padding(.vertical, DesignKit.sizes.small)
                    .background(.dk(\.accentObject))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
        }
    }
}
```

### 3. Using Typography

```swift
import SwiftUI
import DesignKit

struct TypographyExampleView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: DesignKit.sizes.small) {

            // Semantic font shorthand — reads primaryFamily automatically
            Text("Display Title")
                .font(.dk(.displayLarge))
                .foregroundStyle(.dk(\.primaryText))

            Text("Section Heading")
                .font(.dk(.headingMedium))

            Text("Body copy goes here.")
                .font(.dk(.bodyMedium))
                .foregroundStyle(.dk(\.secondaryText))

            Text("Fine print")
                .font(.dk(.caption))
                .foregroundStyle(.dk(\.tertiaryText))

            // Override family for one call only
            Text("Monospaced value: 42")
                .font(.dk(.labelMedium, family: .systemMono))

            // Font + color in a single modifier
            Text("3 errors found")
                .dkTextStyle(.labelLarge, color: \.errorText)
        }
    }
}
```

### 4. Spacing & Sizing

```swift
import SwiftUI
import DesignKit

struct SpacingExampleView: View {
    var body: some View {
        VStack(spacing: DesignKit.sizes.medium) {

            Text("Card Title")
                .font(.dk(.headingSmall))

            Text("Card content with consistent, token-driven spacing.")
                .font(.dk(.bodyMedium))
                .foregroundStyle(.dk(\.secondaryText))

            Button("Action") {}
                .padding(.horizontal, DesignKit.sizes.large)
                .padding(.vertical, DesignKit.sizes.small)
                .background(.dk(\.accentObject))
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        // Leading-dot padding via Token type
        .dkPadding(horizontal: .medium, vertical: .large)
        .background(.dk(\.secondaryBackground))
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}
```

---

## Before & After

### Before DesignKit

```swift
// Magic numbers, hard-coded colors, no dark mode
struct ContentView: View {
    var body: some View {
        VStack(spacing: 16) {
            Text("Title")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(Color(red: 0.11, green: 0.11, blue: 0.12))

            Button("Action") {}
                .foregroundColor(.white)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(Color(red: 0, green: 0.48, blue: 1))
                .cornerRadius(8)
        }
        .padding(20)
        .background(Color(red: 0.95, green: 0.95, blue: 0.97))
    }
}
```

### After DesignKit

```swift
// Semantic, dark-mode-ready, and effortless to update
struct ContentView: View {
    var body: some View {
        VStack(spacing: DesignKit.sizes.medium) {
            Text("Title")
                .font(.dk(.displaySmall))
                .foregroundStyle(.dk(\.primaryText))

            Button("Action") {}
                .foregroundStyle(.white)
                .padding(.horizontal, DesignKit.sizes.large)
                .padding(.vertical, DesignKit.sizes.small)
                .background(.dk(\.accentObject))
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
        .dkPadding(horizontal: .medium, vertical: .medium)
        .background(.dk(\.primaryBackground))
    }
}
```

---

## Advanced Configuration

### Custom Palette

Implement `DesignKitColorPalette` to replace every color token at once:

```swift
struct BrandPalette: DesignKitColorPalette {
    var primaryText:   DesignKitColor { .hex(light: "#1A1A2E", dark: "#EAEAF5") }
    var secondaryText: DesignKitColor { .hex(light: "#44446A", dark: "#A0A0C8") }
    var accentText:    DesignKitColor { .hex("#7B5EA7") }
    var accentObject:  DesignKitColor { .hex("#7B5EA7") }
    var primaryBackground:   DesignKitColor { .hex(light: "#FFFFFF", dark: "#0E0E1A") }
    var secondaryBackground: DesignKitColor { .hex(light: "#F3F3FB", dark: "#1A1A2E") }
    // ... remaining 16 tokens
}

// Assign once at app launch
DesignKit.colors.palette = BrandPalette()
```

### JSON Configuration

Create a `tokens.json` in your app bundle:

```json
{
  "spacing": {
    "baseUnit": 8
  },
  "font": {
    "primaryFamily": "system",
    "secondaryFamily": "systemSerif"
  },
  "colors": {
    "primaryText":         { "light": "#1A1A2E", "dark": "#EAEAF5" },
    "accentText":          { "hex": "#7B5EA7" },
    "accentObject":        { "hex": "#7B5EA7" },
    "primaryBackground":   { "light": "#FFFFFF", "dark": "#0E0E1A" },
    "secondaryBackground": { "light": "#F3F3FB", "dark": "#1A1A2E" }
  }
}
```

Load it at launch:

```swift
if let url = Bundle.main.url(forResource: "tokens", withExtension: "json") {
    try DesignKit.configure(from: url)
}
```

Only keys present in the file are changed — all other tokens keep their defaults.

### Per-Token Mode Locking

Pin individual colors to a specific appearance, regardless of the device setting:

```swift
// Always renders in dark, even in light mode
let brandGlow = DesignKitColor.hex("#A8FF78", mode: .dark)

// Always renders in light
let invoiceBackground = DesignKitColor.hex(light: "#FFFFFF", dark: "#FFFFFF", mode: .light)
```

---

## Color Scheme Control

Force an entire view subtree into a specific appearance with `.dkTheme(_:)`:

```swift
// Always light — e.g. a branded invoice card on a dark screen
InvoiceCard()
    .dkTheme(.light)

// Always dark — e.g. a media player overlay
PlayerView()
    .dkTheme(.dark)

// Follow the device (default behavior)
ContentView()
    .dkTheme(.system)
```

---

## Spacing Reference

All tokens derive from `DesignKit.sizes.baseUnit` (default **8 pt**):

| Token | Multiplier | Default |
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

For arbitrary values: `DesignKit.sizes.custom(multiplier: 2.5)` → 20 pt at default base.

---

## Typography Reference

| Style | Size | Weight |
|---|---|---|
| `displayLarge` | 40 pt | Bold |
| `displaySmall` | 32 pt | Semibold |
| `headingLarge` | 24 pt | Bold |
| `headingMedium` | 20 pt | Semibold |
| `headingSmall` | 18 pt | Semibold |
| `bodyLarge` | 18 pt | Regular |
| `bodyMedium` | 16 pt | Regular |
| `bodySmall` | 14 pt | Regular |
| `labelLarge` | 14 pt | Medium |
| `labelMedium` | 12 pt | Medium |
| `labelSmall` | 10 pt | Medium |
| `caption` | 12 pt | Regular |

---

## Color Reference

| Group | Tokens |
|---|---|
| **Text** | `primaryText`, `secondaryText`, `tertiaryText`, `accentText`, `successText`, `warningText`, `errorText`, `infoText` |
| **Background** | `primaryBackground`, `secondaryBackground`, `tertiaryBackground`, `successBackground`, `warningBackground`, `errorBackground`, `infoBackground` |
| **Object** | `primaryObject`, `secondaryObject`, `tertiaryObject`, `accentObject`, `successObject`, `warningObject`, `errorObject`, `infoObject` |

---

## API Cheat Sheet

```swift
// Setup (call once at app launch)
DesignKit.configure(with: .default)            // built-in defaults
DesignKit.configure(with: .brand)              // named brand config
DesignKit.configure(palette: BrandPalette(), primaryFamily: .customLoaded(familyName: "BrandSans"), baseUnit: 8)
try DesignKit.configure(from: url)             // or load from JSON file

// Colors
.foregroundStyle(.dk(\.primaryText))           // leading-dot (preferred)
Color.dk(\.accentObject)                        // explicit Color
DesignKit.colors.palette = BrandPalette()       // swap palette at runtime

// Typography
.font(.dk(.headingLarge))                       // primary family
.font(.dk(.bodyMedium, family: .systemMono))    // family override
.dkTextStyle(.labelSmall, color: \.errorText)   // font + color in one modifier
DesignKit.fonts.primaryFamily = .customLoaded(familyName: "BrandSans")

// Spacing
DesignKit.sizes.medium                          // 16 pt CGFloat
DesignKit.sizes.custom(multiplier: 2.5)                     // 20 pt CGFloat
.dkPadding(horizontal: .medium, vertical: .small)  // leading-dot Token
DesignKit.sizes.baseUnit = 8                    // rescale everything

// Theme (color scheme)
.dkTheme(.light)                          // force subtree to light
.dkTheme(.dark)                           // force subtree to dark
.dkTheme(.system)                         // follow device setting
DesignKitColor.hex("#A8FF78", mode: .dark)      // lock individual token
```

---

### Development Setup

```bash
git clone <repo-url>
cd DesignKit
swift build
swift test
```

---

## 📄 License

DesignKit is released under the MIT License. See [LICENSE](LICENSE) for details.

---

<div align="center">

_Built for consistent, scalable iOS design_

</div>
