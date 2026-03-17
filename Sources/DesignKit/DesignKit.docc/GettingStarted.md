# Getting Started with DesignKit

Add the library to your Xcode project and apply your first design tokens in minutes.

## Overview

DesignKit is distributed as a local Swift Package. Once added to your project, every token is available through short, readable call sites — no imports beyond `import DesignKit` are needed.

## Step 1 — Add the Package

1. In Xcode, choose **File > Add Package Dependencies… > Add Local…**
2. Navigate to the `DesignKit/` folder and click **Add Package**.
3. Select the **DesignKit** product and add it to your app target.

> Note: If you're using `xcodebuild` from the command line, create a workspace that references both your `.xcodeproj` and the local package directory. Building through the workspace ensures the package resolves correctly.

## Step 2 — Import the Module

```swift
import DesignKit
```

That single import exposes all color tokens, typography styles, spacing utilities, and SwiftUI extensions.

## Step 3 — (Optional) Configure at Launch

Override defaults once in your `@main` App before any views render:

```swift
@main
struct MyApp: App {
    init() {
        // Apply a complete custom brand config in one line
        DesignKit.configure(with: .brand)

        // Or override individual settings
        DesignKit.configure(
            palette:       BrandPalette(),
            primaryFamily: .customLoaded(familyName: "BrandSans-Regular"),
            baseUnit:      6
        )

        // Or load from a JSON file
        if let url = Bundle.main.url(forResource: "tokens", withExtension: "json") {
            try? DesignKit.configure(from: url)
        }
    }

    var body: some Scene {
        WindowGroup { ContentView() }
    }
}
```

If you skip this step, the library ships with sensible iOS-style defaults:
- **Colors** — `DesignKitDefaultPalette` (iOS system grays, semantic greens/reds/yellows)
- **Typography** — SF Pro (`DesignKitFontFamily.system`), serif secondary
- **Spacing** — 8-point grid

## Step 4 — Use Tokens in Views

### Colors

In `foregroundStyle`, `fill`, `background`, and `stroke` contexts Swift infers the `Color` type, so you can use the leading-dot shorthand:

```swift
Text("Title")
    .foregroundStyle(.dk(\.primaryText))

RoundedRectangle(cornerRadius: 12)
    .fill(.dk(\.secondaryBackground))

// Use Color.dk() explicitly when assigning to a variable
let brandGlow = DesignKitColor.hex("#A8FF78", mode: .dark)
```

### Typography

```swift
// Apply a semantic text style
Text("Display").font(.dk(.displayLarge))
Text("Body").font(.dk(.bodyMedium))

// One-call shorthand — font + color
Text("Caption")
    .dkTextStyle(.caption, color: \.secondaryText)

// Override the font family for a single call
Text("Rounded heading")
    .font(.dk(.headingSmall, family: .systemRounded))
```

### Spacing

```swift
// Semantic spacing tokens
VStack(spacing: DesignKit.sizes.medium) {
    // ...
}
.padding(.horizontal, DesignKit.sizes.large)

// Raw multiplier
let inset = DesignKit.sizes.custom(multiplier: 2.5)  // → 20 pt at default base

// Combined padding shorthand — leading-dot syntax via DesignKit.sizes.Token
CardView()
    .dkPadding(horizontal: .medium, vertical: .small)
```

## Step 5 — Force Light or Dark Mode on a Subtree

Use `.dkTheme(_:)` to lock any view hierarchy to a specific appearance, independent of the device setting:

```swift
// Always light — useful for branded cards on a dark screen
BrandCard()
    .dkTheme(.light)

// Always dark — good for media players, modals
PlayerView()
    .dkTheme(.dark)

// Follow the system (default behavior)
ContentView()
    .dkTheme(.system)
```

## Next Steps

- Explore the full color token reference: <doc:Colors>
- Learn about semantic typography styles: <doc:Typography>
- Understand the spacing grid: <doc:Sizing>
- Browse all SwiftUI extensions: <doc:Extensions>
