import CoreFoundation

// MARK: - Top-level config shape

/// The Codable model that mirrors the JSON configuration file.
struct DesignKitJSONConfig: Codable {
    var spacing: SpacingConfig?
    var font: FontConfig?
    var colors: [String: ColorEntry]?

    struct SpacingConfig: Codable {
        var baseUnit: CGFloat?
    }

    struct FontConfig: Codable {
        var primaryFamily: String?
        var secondaryFamily: String?
    }

    /// A single color token entry in the JSON file.
    ///
    /// Supported shapes:
    /// ```json
    /// { "light": "#FFFFFF", "dark": "#000000" }
    /// { "hex": "#FF0000" }
    /// { "light": "#FFFFFF", "dark": "#000000", "mode": "light" }
    /// ```
    struct ColorEntry: Codable {
        var light: String?
        var dark: String?
        var hex: String?
        var mode: String?

        func resolve() -> DesignKitColor {
            let colorMode = DesignKit.Theme.from(string: mode)
            if let light, let dark {
                return .hex(light: light, dark: dark, mode: colorMode)
            } else if let single = hex ?? light ?? dark {
                return .hex(single, mode: colorMode)
            }
            // Fallback: transparent
            return .rgb(r: 0, g: 0, b: 0, alpha: 0)
        }
    }
}

// MARK: - DesignKit.Theme string initializer

extension DesignKit.Theme {
    static func from(string: String?) -> DesignKit.Theme {
        switch string {
        case "light": return .light
        case "dark":  return .dark
        default:            return .system
        }
    }
}

// MARK: - DesignKitFontFamily string initializer

extension DesignKitFontFamily {
    static func from(string: String) -> DesignKitFontFamily {
        switch string {
        case "system":        return .system
        case "systemRounded": return .systemRounded
        case "systemSerif":   return .systemSerif
        case "systemMono":    return .systemMono
        default:              return .customLoaded(familyName: string)
        }
    }
}

// MARK: - JSON-overriding palette

/// A palette that wraps a base palette and applies per-token hex overrides from JSON.
struct JSONColorPalette: DesignKitColorPalette {
    private let base: any DesignKitColorPalette
    private let overrides: [String: DesignKitJSONConfig.ColorEntry]

    init(base: any DesignKitColorPalette, overrides: [String: DesignKitJSONConfig.ColorEntry]) {
        self.base = base
        self.overrides = overrides
    }

    private func resolve(_ key: String, fallback: DesignKitColor) -> DesignKitColor {
        overrides[key]?.resolve() ?? fallback
    }

    // Text
    var primaryText:   DesignKitColor { resolve("primaryText",   fallback: base.primaryText) }
    var secondaryText: DesignKitColor { resolve("secondaryText", fallback: base.secondaryText) }
    var tertiaryText:  DesignKitColor { resolve("tertiaryText",  fallback: base.tertiaryText) }
    var accentText:    DesignKitColor { resolve("accentText",    fallback: base.accentText) }
    var successText:   DesignKitColor { resolve("successText",   fallback: base.successText) }
    var warningText:   DesignKitColor { resolve("warningText",   fallback: base.warningText) }
    var errorText:     DesignKitColor { resolve("errorText",     fallback: base.errorText) }
    var infoText:      DesignKitColor { resolve("infoText",      fallback: base.infoText) }

    // Background
    var primaryBackground:   DesignKitColor { resolve("primaryBackground",   fallback: base.primaryBackground) }
    var secondaryBackground: DesignKitColor { resolve("secondaryBackground", fallback: base.secondaryBackground) }
    var tertiaryBackground:  DesignKitColor { resolve("tertiaryBackground",  fallback: base.tertiaryBackground) }
    var successBackground:   DesignKitColor { resolve("successBackground",   fallback: base.successBackground) }
    var warningBackground:   DesignKitColor { resolve("warningBackground",   fallback: base.warningBackground) }
    var errorBackground:     DesignKitColor { resolve("errorBackground",     fallback: base.errorBackground) }
    var infoBackground:      DesignKitColor { resolve("infoBackground",      fallback: base.infoBackground) }

    // Object
    var primaryObject:   DesignKitColor { resolve("primaryObject",   fallback: base.primaryObject) }
    var secondaryObject: DesignKitColor { resolve("secondaryObject", fallback: base.secondaryObject) }
    var tertiaryObject:  DesignKitColor { resolve("tertiaryObject",  fallback: base.tertiaryObject) }
    var accentObject:    DesignKitColor { resolve("accentObject",    fallback: base.accentObject) }
    var successObject:   DesignKitColor { resolve("successObject",   fallback: base.successObject) }
    var warningObject:   DesignKitColor { resolve("warningObject",   fallback: base.warningObject) }
    var errorObject:     DesignKitColor { resolve("errorObject",     fallback: base.errorObject) }
    var infoObject:      DesignKitColor { resolve("infoObject",      fallback: base.infoObject) }
}
