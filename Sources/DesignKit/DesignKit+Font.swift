import SwiftUI

extension DesignKit {

    /// Typography configuration and font resolution.
    ///
    /// ## Configuring families
    /// ```swift
    /// DesignKit.fonts.primaryFamily   = .customLoaded(familyName: "BrandSans")
    /// DesignKit.fonts.secondaryFamily = .systemSerif
    /// ```
    ///
    /// ## Resolving fonts
    /// ```swift
    /// // Via shorthand extension (preferred)
    /// Text("Title").font(.dk(.headingLarge))
    ///
    /// // Direct access
    /// Text("Title").font(DesignKit.fonts.headingLarge)
    ///
    /// // With family override
    /// Text("Mono").font(DesignKit.fonts.resolve(.bodySmall, family: .systemMono))
    /// ```
    public enum fonts {

        // MARK: - Configuration

        /// The default font family for all text styles. Defaults to `.system` (SF Pro).
        @MainActor public static var primaryFamily: DesignKitFontFamily = .system

        /// An alternate font family, typically used for display/brand differentiation.
        @MainActor public static var secondaryFamily: DesignKitFontFamily = .systemSerif

        // MARK: - Resolution

        /// Returns the SwiftUI `Font` for the given style, using `primaryFamily` unless overridden.
        @MainActor
        public static func resolve(_ style: DesignKitTextStyle, family: DesignKitFontFamily? = nil) -> Font {
            let (weight, size) = styleMap[style] ?? (.regular, .body)
            let resolvedFamily = family ?? primaryFamily
            return DesignKitFont(family: resolvedFamily, weight: weight, size: size.rawValue).font
        }

        // MARK: - Named shorthands

        @MainActor public static var displayLarge:  Font { resolve(.displayLarge) }
        @MainActor public static var displaySmall:  Font { resolve(.displaySmall) }
        @MainActor public static var headingLarge:  Font { resolve(.headingLarge) }
        @MainActor public static var headingMedium: Font { resolve(.headingMedium) }
        @MainActor public static var headingSmall:  Font { resolve(.headingSmall) }
        @MainActor public static var bodyLarge:     Font { resolve(.bodyLarge) }
        @MainActor public static var bodyMedium:    Font { resolve(.bodyMedium) }
        @MainActor public static var bodySmall:     Font { resolve(.bodySmall) }
        @MainActor public static var labelLarge:    Font { resolve(.labelLarge) }
        @MainActor public static var labelMedium:   Font { resolve(.labelMedium) }
        @MainActor public static var labelSmall:    Font { resolve(.labelSmall) }
        @MainActor public static var caption:       Font { resolve(.caption) }

        // MARK: - Style map (single source of truth for weight/size defaults)

        private static let styleMap: [DesignKitTextStyle: (DesignKitFontWeight, DesignKitTextSize)] = [
            .displayLarge:  (.bold,     .display),
            .displaySmall:  (.semibold, .xxLarge),
            .headingLarge:  (.bold,     .xLarge),
            .headingMedium: (.semibold, .large),
            .headingSmall:  (.semibold, .medium),
            .bodyLarge:     (.regular,  .medium),
            .bodyMedium:    (.regular,  .body),
            .bodySmall:     (.regular,  .small),
            .labelLarge:    (.medium,   .small),
            .labelMedium:   (.medium,   .xSmall),
            .labelSmall:    (.medium,   .xxSmall),
            .caption:       (.regular,  .xSmall),
        ]
    }
}
