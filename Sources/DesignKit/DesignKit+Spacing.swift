import CoreFoundation

extension DesignKit {

    /// Spacing configuration and named spacing tokens.
    ///
    /// All values derive from `baseUnit` via `custom(_ multiplier:)`.
    ///
    /// ## Named tokens (return `CGFloat` for native SwiftUI APIs)
    /// ```swift
    /// VStack(spacing: DesignKit.sizes.medium) { ... }
    ///     .padding(.horizontal, DesignKit.sizes.large)
    /// ```
    ///
    /// ## `Token` values (for `.dkPadding` leading-dot syntax)
    /// ```swift
    /// view.dkPadding(horizontal: .medium, vertical: .small)
    /// ```
    ///
    /// ## Custom multiplier
    /// ```swift
    /// DesignKit.sizes.custom(multiplier: 2.5)   // → 20 pt at default base
    /// ```
    public enum sizes {

        /// The base unit in points. Defaults to `8`. Change once at app launch.
        @MainActor public static var baseUnit: CGFloat = 8

        /// Returns `multiplier × baseUnit` in points.
        @MainActor public static func custom(multiplier: CGFloat) -> CGFloat {
            multiplier * baseUnit
        }

        // MARK: Named tokens (CGFloat)

        /// 0.25× base — 2 pt default
        @MainActor public static var xxSmall:     CGFloat { custom(multiplier: 0.25) }
        /// 0.5× base — 4 pt default
        @MainActor public static var xSmall:      CGFloat { custom(multiplier: 0.5) }
        /// 1× base — 8 pt default
        @MainActor public static var small:       CGFloat { custom(multiplier: 1) }
        /// 1.5× base — 12 pt default
        @MainActor public static var mediumSmall: CGFloat { custom(multiplier: 1.5) }
        /// 2× base — 16 pt default
        @MainActor public static var medium:      CGFloat { custom(multiplier: 2) }
        /// 3× base — 24 pt default
        @MainActor public static var large:       CGFloat { custom(multiplier: 3) }
        /// 4× base — 32 pt default
        @MainActor public static var xLarge:      CGFloat { custom(multiplier: 4) }
        /// 6× base — 48 pt default
        @MainActor public static var xxLarge:     CGFloat { custom(multiplier: 6) }
        /// 8× base — 64 pt default
        @MainActor public static var giant:       CGFloat { custom(multiplier: 8) }

        // MARK: Token (typed values for dkPadding leading-dot syntax)

        /// A resolved spacing value typed for use with ``View/dkPadding(horizontal:vertical:)``.
        ///
        /// Use the static properties for leading-dot syntax:
        /// ```swift
        /// view.dkPadding(horizontal: .medium, vertical: .small)
        /// ```
        public struct Token: Sendable {
            public let value: CGFloat

            @MainActor public static var xxSmall:     Token { Token(value: sizes.custom(multiplier: 0.25)) }
            @MainActor public static var xSmall:      Token { Token(value: sizes.custom(multiplier: 0.5)) }
            @MainActor public static var small:       Token { Token(value: sizes.custom(multiplier: 1)) }
            @MainActor public static var mediumSmall: Token { Token(value: sizes.custom(multiplier: 1.5)) }
            @MainActor public static var medium:      Token { Token(value: sizes.custom(multiplier: 2)) }
            @MainActor public static var large:       Token { Token(value: sizes.custom(multiplier: 3)) }
            @MainActor public static var xLarge:      Token { Token(value: sizes.custom(multiplier: 4)) }
            @MainActor public static var xxLarge:     Token { Token(value: sizes.custom(multiplier: 6)) }
            @MainActor public static var giant:       Token { Token(value: sizes.custom(multiplier: 8)) }
        }
    }
}
