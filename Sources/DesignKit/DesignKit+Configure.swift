import Foundation

extension DesignKit {

    /// Configures the design system from a ``DesignKitConfiguration`` value.
    ///
    /// Use `.default` to apply system defaults, or pass a custom configuration.
    /// Call once at app launch before any views render.
    ///
    /// ```swift
    /// // Default settings
    /// DesignKit.configure(with: .default)
    ///
    /// // Custom brand config defined as a static extension
    /// DesignKit.configure(with: .brand)
    ///
    /// // Inline
    /// DesignKit.configure(with: DesignKitConfiguration(
    ///     palette:       BrandPalette(),
    ///     primaryFamily: .customLoaded(familyName: "BrandSans"),
    ///     baseUnit:      8
    /// ))
    /// ```
    ///
    /// - Parameter configuration: The ``DesignKitConfiguration`` to apply.
    @MainActor
    public static func configure(with configuration: DesignKitConfiguration = .default) {
        DesignKit.colors.palette        = configuration.palette
        DesignKit.fonts.primaryFamily   = configuration.primaryFamily
        DesignKit.fonts.secondaryFamily = configuration.secondaryFamily
        DesignKit.sizes.baseUnit        = configuration.baseUnit
    }

    /// Configures the design system in a single call with individual overrides.
    ///
    /// All parameters are optional — omit any you want to leave at their defaults.
    ///
    /// ```swift
    /// DesignKit.configure(palette: BrandPalette(), primaryFamily: .customLoaded(familyName: "BrandSans"))
    /// ```
    ///
    /// - Parameters:
    ///   - palette: The color palette to activate. Defaults to ``DesignKitDefaultPalette``.
    ///   - primaryFamily: The primary font family. Defaults to `.system` (SF Pro).
    ///   - secondaryFamily: The secondary font family. Defaults to `.systemSerif` (New York).
    ///   - baseUnit: The spacing base unit in points. Defaults to `8`.
    @MainActor
    public static func configure(
        palette: (any DesignKitColorPalette)? = nil,
        primaryFamily: DesignKitFontFamily? = nil,
        secondaryFamily: DesignKitFontFamily? = nil,
        baseUnit: CGFloat? = nil
    ) {
        if let palette         { DesignKit.colors.palette         = palette }
        if let primaryFamily   { DesignKit.fonts.primaryFamily    = primaryFamily }
        if let secondaryFamily { DesignKit.fonts.secondaryFamily  = secondaryFamily }
        if let baseUnit        { DesignKit.sizes.baseUnit         = baseUnit }
    }

    /// Configures the design system from a JSON file at the given URL.
    ///
    /// Call this once at app launch (before any views render) to apply brand tokens
    /// without writing Swift code. Only keys present in the file are changed; all
    /// others keep their current defaults.
    ///
    /// ## JSON format
    /// ```json
    /// {
    ///   "spacing": { "baseUnit": 8 },
    ///   "font": {
    ///     "primaryFamily": "system",
    ///     "secondaryFamily": "systemSerif"
    ///   },
    ///   "colors": {
    ///     "primaryText":         { "light": "#1C1C1E", "dark": "#F2F2F7" },
    ///     "accentText":          { "hex": "#007AFF" },
    ///     "primaryBackground":   { "light": "#FFFFFF", "dark": "#000000" }
    ///   }
    /// }
    /// ```
    ///
    /// ### Supported font family strings
    /// `"system"`, `"systemRounded"`, `"systemSerif"`, `"systemMono"`, or any
    /// PostScript family name registered by the host app (e.g. `"BrandSans"`).
    ///
    /// ### Supported color mode strings (optional `"mode"` key)
    /// `"system"` (default), `"light"`, `"dark"`
    ///
    /// - Parameter url: A `URL` pointing to a JSON file on disk or in the app bundle.
    /// - Throws: `DecodingError` if the file cannot be parsed, or a file-system error
    ///   if the URL cannot be read.
    @MainActor
    public static func configure(from url: URL) throws {
        let data = try Data(contentsOf: url)
        let config = try JSONDecoder().decode(DesignKitJSONConfig.self, from: data)

        if let baseUnit = config.spacing?.baseUnit {
            DesignKit.sizes.baseUnit = baseUnit
        }

        if let fontConfig = config.font {
            if let primary = fontConfig.primaryFamily {
                DesignKit.fonts.primaryFamily = DesignKitFontFamily.from(string: primary)
            }
            if let secondary = fontConfig.secondaryFamily {
                DesignKit.fonts.secondaryFamily = DesignKitFontFamily.from(string: secondary)
            }
        }

        if let colorOverrides = config.colors {
            DesignKit.colors.palette = JSONColorPalette(
                base: DesignKit.colors.palette,
                overrides: colorOverrides
            )
        }
    }
}
