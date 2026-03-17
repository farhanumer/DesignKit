import SwiftUI

extension View {

    /// Applies a semantic text style (font + optional foreground color) in one modifier.
    ///
    /// Reads the resolved font from ``DesignKit/fonts`` and the color from
    /// ``DesignKit/colors/palette``.
    ///
    /// ```swift
    /// // Font only — color inherited from environment
    /// Text("Section heading")
    ///     .dkTextStyle(.headingSmall)
    ///
    /// // Font + color token
    /// Text("Supporting text")
    ///     .dkTextStyle(.bodyMedium, color: \.secondaryText)
    ///
    /// // Font + color + family override
    /// Text("Fine print")
    ///     .dkTextStyle(.caption, color: \.tertiaryText, family: .systemSerif)
    ///
    /// // Status styling
    /// Text("3 errors found")
    ///     .dkTextStyle(.labelLarge, color: \.errorText)
    /// ```
    ///
    /// - Parameters:
    ///   - style: The semantic ``DesignKitTextStyle`` to apply.
    ///   - color: An optional key path into ``DesignKitColorPalette`` for the foreground color.
    ///     When `nil`, the view inherits the foreground color from its environment.
    ///   - family: An optional ``DesignKitFontFamily`` override for this call only.
    @MainActor
    public func dkTextStyle(
        _ style: DesignKitTextStyle,
        color: KeyPath<any DesignKitColorPalette, DesignKitColor>? = nil,
        family: DesignKitFontFamily? = nil
    ) -> some View {
        let resolvedFont = DesignKit.fonts.resolve(style, family: family)
        if let colorKeyPath = color {
            let resolvedColor = DesignKit.colors.palette[keyPath: colorKeyPath].color
            return AnyView(
                self
                    .font(resolvedFont)
                    .foregroundStyle(resolvedColor)
            )
        }
        return AnyView(self.font(resolvedFont))
    }

    /// Applies padding using ``DesignKit/sizes/Token`` values for the horizontal and vertical
    /// axes, enabling leading-dot syntax at the call site.
    ///
    /// Both parameters are optional; omitting one applies zero padding on that axis.
    ///
    /// ```swift
    /// // Leading-dot shorthand
    /// CardView()
    ///     .dkPadding(horizontal: .medium, vertical: .small)
    ///
    /// // Horizontal only
    /// view.dkPadding(horizontal: .large)
    /// ```
    ///
    /// - Parameters:
    ///   - horizontal: Padding applied to the leading and trailing edges. Defaults to `0`.
    ///   - vertical: Padding applied to the top and bottom edges. Defaults to `0`.
    public func dkPadding(horizontal: DesignKit.sizes.Token? = nil, vertical: DesignKit.sizes.Token? = nil) -> some View {
        self
            .padding(.horizontal, horizontal?.value ?? 0)
            .padding(.vertical, vertical?.value ?? 0)
    }
}
