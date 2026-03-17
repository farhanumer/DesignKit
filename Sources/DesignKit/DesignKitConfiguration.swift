import CoreFoundation

/// A value type that bundles all design system settings into one object.
///
/// Use the built-in ``default`` configuration to apply system defaults with one line,
/// or create a custom configuration to express your brand's full token set:
///
/// ```swift
/// // Default settings (SF Pro, 8 pt base, built-in palette)
/// DesignKit.configure(with: .default)
///
/// // Custom brand configuration
/// DesignKit.configure(with: .brand)
///
/// // Inline one-off
/// DesignKit.configure(with: DesignKitConfiguration(
///     palette:       BrandPalette(),
///     primaryFamily: .customLoaded(familyName: "BrandSans"),
///     baseUnit:      8
/// ))
/// ```
///
/// ### Defining a reusable brand configuration
/// ```swift
/// extension DesignKitConfiguration {
///     static let brand = DesignKitConfiguration(
///         palette:       BrandPalette(),
///         primaryFamily: .customLoaded(familyName: "BrandSans"),
///         baseUnit:      8
///     )
/// }
///
/// // In App.init()
/// DesignKit.configure(with: .brand)
/// ```
public struct DesignKitConfiguration {

    /// The color palette applied to all semantic color tokens.
    public var palette: any DesignKitColorPalette

    /// The primary font family used for all text styles.
    public var primaryFamily: DesignKitFontFamily

    /// The secondary font family, typically used for display or brand differentiation.
    public var secondaryFamily: DesignKitFontFamily

    /// The spacing base unit in points. All spacing tokens are multiples of this value.
    public var baseUnit: CGFloat

    /// Creates a configuration with explicit values for every setting.
    public init(
        palette: any DesignKitColorPalette = DesignKitDefaultPalette(),
        primaryFamily: DesignKitFontFamily = .system,
        secondaryFamily: DesignKitFontFamily = .systemSerif,
        baseUnit: CGFloat = 8
    ) {
        self.palette         = palette
        self.primaryFamily   = primaryFamily
        self.secondaryFamily = secondaryFamily
        self.baseUnit        = baseUnit
    }

    /// The default configuration — `DesignKitDefaultPalette`, SF Pro, New York, 8 pt base.
    public static let `default` = DesignKitConfiguration()
}
