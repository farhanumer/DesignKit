import Foundation

/// Semantic text-style tokens that express intent rather than specific sizes.
///
/// Each style maps to a default `(DesignKitFontWeight, DesignKitTextSize)` pair via ``DesignKit/fonts``.
///
/// ## Usage
/// ```swift
/// // Resolve to a SwiftUI Font
/// Text("Hello").font(.dk(.headingMedium))
///
/// // One-shot font + color
/// Text("Supporting").dkTextStyle(.bodySmall, color: \.secondaryText)
/// ```
///
/// ## Style reference
/// | Style | Size | Weight |
/// |---|---|---|
/// | `displayLarge` | 40 pt | Bold |
/// | `displaySmall` | 32 pt | Semibold |
/// | `headingLarge` | 24 pt | Bold |
/// | `headingMedium` | 20 pt | Semibold |
/// | `headingSmall` | 18 pt | Semibold |
/// | `bodyLarge` | 18 pt | Regular |
/// | `bodyMedium` | 16 pt | Regular |
/// | `bodySmall` | 14 pt | Regular |
/// | `labelLarge` | 14 pt | Medium |
/// | `labelMedium` | 12 pt | Medium |
/// | `labelSmall` | 10 pt | Medium |
/// | `caption` | 12 pt | Regular |
///
/// - SeeAlso: ``DesignKitFontFamily``, ``DesignKitFont``
public enum DesignKitTextStyle: Sendable, CaseIterable {
    // Display
    /// Hero headlines — 40 pt bold.
    case displayLarge
    /// Section heroes — 32 pt semibold.
    case displaySmall

    // Heading
    /// Page titles — 24 pt bold.
    case headingLarge
    /// Card headers — 20 pt semibold.
    case headingMedium
    /// List section headers — 18 pt semibold.
    case headingSmall

    // Body
    /// Lead paragraphs — 18 pt regular.
    case bodyLarge
    /// Standard body copy — 16 pt regular.
    case bodyMedium
    /// Secondary body content — 14 pt regular.
    case bodySmall

    // Label
    /// Button labels, form labels — 14 pt medium.
    case labelLarge
    /// Secondary labels, badges — 12 pt medium.
    case labelMedium
    /// Metadata, captions inside cells — 10 pt medium.
    case labelSmall

    // Utility
    /// Image captions, legal text — 12 pt regular.
    case caption

    /// A human-readable name for use in showcases and debug output.
    public var label: String {
        switch self {
        case .displayLarge:  return "Display Large"
        case .displaySmall:  return "Display Small"
        case .headingLarge:  return "Heading Large"
        case .headingMedium: return "Heading Medium"
        case .headingSmall:  return "Heading Small"
        case .bodyLarge:     return "Body Large"
        case .bodyMedium:    return "Body Medium"
        case .bodySmall:     return "Body Small"
        case .labelLarge:    return "Label Large"
        case .labelMedium:   return "Label Medium"
        case .labelSmall:    return "Label Small"
        case .caption:       return "Caption"
        }
    }
}
