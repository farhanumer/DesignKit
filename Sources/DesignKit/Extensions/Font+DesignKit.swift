import SwiftUI

extension Font {
    /// Returns the SwiftUI `Font` for a semantic text style.
    ///
    /// Resolves the style through ``DesignKit/fonts``, using ``DesignKit/fonts/primaryFamily``
    /// unless an explicit `family` is provided.
    ///
    /// ```swift
    /// // Default primary family
    /// Text("Title").font(.dk(.headingLarge))
    ///
    /// // Override family for this call only
    /// Text("Code").font(.dk(.bodySmall, family: .systemMono))
    /// Text("Serif").font(.dk(.headingMedium, family: .systemSerif))
    /// ```
    ///
    /// - Parameters:
    ///   - style: The semantic ``DesignKitTextStyle`` to resolve.
    ///   - family: An optional ``DesignKitFontFamily`` override. Pass `nil` (default) to use
    ///     ``DesignKit/fonts/primaryFamily``.
    /// - Returns: A SwiftUI `Font` configured with the appropriate size, weight, and design.
    @MainActor
    public static func dk(_ style: DesignKitTextStyle, family: DesignKitFontFamily? = nil) -> Font {
        DesignKit.fonts.resolve(style, family: family)
    }
}
