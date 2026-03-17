import SwiftUI

extension Color {
    /// Returns the SwiftUI `Color` for a semantic palette token.
    ///
    /// Use a key path to select any token defined in ``DesignKitColorPalette``. The value
    /// is read from ``DesignKit/colors/palette`` at call time, so swapping the palette
    /// at launch automatically affects all call sites.
    ///
    /// Prefer the leading-dot shorthand enabled by the `ShapeStyle` overload below:
    /// ```swift
    /// Text("Hello").foregroundStyle(.dk(\.primaryText))
    /// Rectangle().fill(.dk(\.accentObject))
    /// ```
    ///
    /// - Parameter keyPath: A key path into `DesignKitColorPalette` selecting the desired token.
    /// - Returns: The resolved SwiftUI `Color` for the active palette and current color scheme.
    @MainActor
    public static func dk(_ keyPath: KeyPath<any DesignKitColorPalette, DesignKitColor>) -> Color {
        DesignKit.colors.palette[keyPath: keyPath].color
    }
}

extension ShapeStyle where Self == Color {
    /// Returns the SwiftUI `Color` for a semantic palette token, enabling leading-dot syntax
    /// in any `ShapeStyle` context such as `foregroundStyle`, `fill`, and `background`.
    ///
    /// ```swift
    /// Text("Title")
    ///     .foregroundStyle(.dk(\.primaryText))
    ///
    /// Rectangle()
    ///     .fill(.dk(\.accentObject))
    ///
    /// card.background(.dk(\.secondaryBackground))
    /// ```
    ///
    /// - Parameter keyPath: A key path into ``DesignKitColorPalette`` selecting the desired token.
    /// - Returns: The resolved SwiftUI `Color` for the active palette and current color scheme.
    @MainActor
    public static func dk(_ keyPath: KeyPath<any DesignKitColorPalette, DesignKitColor>) -> Color {
        Color.dk(keyPath)
    }
}
