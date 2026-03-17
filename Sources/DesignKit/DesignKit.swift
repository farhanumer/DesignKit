/// # DesignKit
///
/// A standalone iOS design token library providing adaptive colors, semantic typography,
/// and a flexible spacing system — all accessible through a single `DesignKit` namespace.
///
/// ## Quick start
///
/// ```swift
/// // Colors — leading-dot in ShapeStyle contexts
/// Text("Hello").foregroundStyle(.dk(\.primaryText))
///
/// // Typography
/// Text("Display").font(.dk(.displayLarge))
/// Text("Body").dkTextStyle(.bodyMedium, color: \.secondaryText)
///
/// // Spacing
/// VStack(spacing: DesignKit.sizes.medium) { ... }
///     .padding(.horizontal, DesignKit.sizes.large)
///     .dkPadding(horizontal: .medium, vertical: .small)
///
/// // Configuration at launch
/// DesignKit.colors.palette        = BrandPalette()
/// DesignKit.fonts.primaryFamily   = .customLoaded(familyName: "BrandSans")
/// DesignKit.sizes.baseUnit     = 8
///
/// // JSON-based configuration
/// try DesignKit.configure(from: Bundle.main.url(forResource: "tokens", withExtension: "json")!)
/// ```

// All types are defined in their own files. This file serves as the module
// documentation entry point and declares the top-level `DesignKit` namespace.

/// The top-level namespace for all design token access and configuration.
///
/// Use the three sub-namespaces to access tokens:
/// - ``DesignKit/colors`` — 22 semantic color tokens
/// - ``DesignKit/fonts`` — 12 semantic text styles + font family config
/// - ``DesignKit/sizes`` — multiplier-based spacing grid
///
/// Configure everything once at app launch, or load from a JSON file:
/// ```swift
/// try DesignKit.configure(from: url)
/// ```
public enum DesignKit {}
