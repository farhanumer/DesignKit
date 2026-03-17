import SwiftUI

/// A fully-specified font token combining family, weight, and size.
///
/// Obtain instances via `DesignKit.fonts.resolve(_:family:)` or the shorthand `Font.dk(.bodyMedium)`.
/// You can also construct one directly:
/// ```swift
/// let custom = DesignKitFont(family: .customLoaded(familyName: "Nunito"), weight: .semibold, size: 18)
/// Text("Hello").font(custom.font)
/// ```
public struct DesignKitFont: Sendable {

    /// The font family for this token.
    public let family: DesignKitFontFamily
    /// The weight applied to this font.
    public let weight: DesignKitFontWeight
    /// The point size of this font.
    public let size: CGFloat

    public init(family: DesignKitFontFamily, weight: DesignKitFontWeight, size: CGFloat) {
        self.family = family
        self.weight = weight
        self.size = size
    }

    /// The resolved SwiftUI `Font`.
    public var font: Font {
        switch family {
        case .system:
            return .system(size: size, weight: weight.fontWeight, design: .default)
        case .systemRounded:
            return .system(size: size, weight: weight.fontWeight, design: .rounded)
        case .systemSerif:
            return .system(size: size, weight: weight.fontWeight, design: .serif)
        case .systemMono:
            return .system(size: size, weight: weight.fontWeight, design: .monospaced)
        case .customLoaded(let familyName):
            // Font.custom falls back gracefully to the system font if not found.
            return .custom(familyName, size: size).weight(weight.fontWeight)
        }
    }
}
