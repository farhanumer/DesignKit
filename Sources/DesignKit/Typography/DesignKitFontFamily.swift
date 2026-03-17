import Foundation

/// Identifies a font family for use in the design system.
///
/// Built-in cases map to Apple's SF Pro design variants available on all iOS devices.
/// Use `.customLoaded(familyName:)` when your brand requires a non-system typeface.
///
/// ## Built-in families
/// | Case | Typeface |
/// |---|---|
/// | `.system` | SF Pro (default) |
/// | `.systemRounded` | SF Pro Rounded |
/// | `.systemSerif` | New York |
/// | `.systemMono` | SF Mono |
///
/// ## Using a custom font
/// Add the font file(s) to your **app target** (not this package), declare them in
/// `UIAppFonts` in your app's `Info.plist`, then assign the PostScript family name:
///
/// ```swift
/// // In @main App init:
/// ACNTypography.primaryFamily = .customLoaded(familyName: "NunitoSans-Regular")
/// ```
///
/// - Note: DesignKit does not register font files. The host app is responsible
///   for including the font and declaring it in `UIAppFonts`.
/// - SeeAlso: ``ACNTypography``, ``DesignKitTextStyle``
public enum DesignKitFontFamily: Sendable, Hashable {
    /// SF Pro — the default iOS system font.
    case system
    /// SF Pro Rounded — friendly, rounded variant of SF Pro.
    case systemRounded
    /// New York — Apple's serif typeface.
    case systemSerif
    /// SF Mono — monospaced system font.
    case systemMono
    /// A custom font loaded by the host app.
    ///
    /// - Parameter familyName: The PostScript **family** name of the font
    ///   (e.g., `"Nunito"`, `"BrandSans-Regular"`).
    case customLoaded(familyName: String)
}
