import SwiftUI

extension DesignKit {

    /// Color token access and palette configuration.
    ///
    /// ## Accessing tokens
    /// ```swift
    /// // Direct SwiftUI Color
    /// let fg: Color = DesignKit.colors.primaryText
    ///
    /// // Leading-dot shorthand in ShapeStyle contexts (preferred)
    /// Text("Hello").foregroundStyle(.dk(\.primaryText))
    /// ```
    ///
    /// ## Swapping the palette
    /// ```swift
    /// DesignKit.colors.palette = BrandPalette()
    /// ```
    public enum colors {

        /// The active color palette. Defaults to ``DesignKitDefaultPalette``.
        /// Replace at app launch to apply brand colors globally.
        @MainActor public static var palette: any DesignKitColorPalette = DesignKitDefaultPalette()

        // MARK: Text tokens

        @MainActor public static var primaryText:   Color { palette.primaryText.color }
        @MainActor public static var secondaryText: Color { palette.secondaryText.color }
        @MainActor public static var tertiaryText:  Color { palette.tertiaryText.color }
        @MainActor public static var accentText:    Color { palette.accentText.color }
        @MainActor public static var successText:   Color { palette.successText.color }
        @MainActor public static var warningText:   Color { palette.warningText.color }
        @MainActor public static var errorText:     Color { palette.errorText.color }
        @MainActor public static var infoText:      Color { palette.infoText.color }

        // MARK: Background tokens

        @MainActor public static var primaryBackground:   Color { palette.primaryBackground.color }
        @MainActor public static var secondaryBackground: Color { palette.secondaryBackground.color }
        @MainActor public static var tertiaryBackground:  Color { palette.tertiaryBackground.color }
        @MainActor public static var successBackground:   Color { palette.successBackground.color }
        @MainActor public static var warningBackground:   Color { palette.warningBackground.color }
        @MainActor public static var errorBackground:     Color { palette.errorBackground.color }
        @MainActor public static var infoBackground:      Color { palette.infoBackground.color }

        // MARK: Object tokens

        @MainActor public static var primaryObject:   Color { palette.primaryObject.color }
        @MainActor public static var secondaryObject: Color { palette.secondaryObject.color }
        @MainActor public static var tertiaryObject:  Color { palette.tertiaryObject.color }
        @MainActor public static var accentObject:    Color { palette.accentObject.color }
        @MainActor public static var successObject:   Color { palette.successObject.color }
        @MainActor public static var warningObject:   Color { palette.warningObject.color }
        @MainActor public static var errorObject:     Color { palette.errorObject.color }
        @MainActor public static var infoObject:      Color { palette.infoObject.color }
    }
}
