import SwiftUI
import UIKit

/// A design token color that carries its own light/dark mode locking behavior.
///
/// `DesignKitColor` wraps a SwiftUI `Color` alongside an ``DesignKit.Theme`` that
/// controls whether the color adapts to the system scheme or is pinned to always-
/// light or always-dark.  Most colors in ``DesignKitDefaultPalette`` use `.system` so
/// they automatically switch with the device; individual tokens can override this.
///
/// ## Creating colors
/// ```swift
/// // Hex — adapts to system light/dark
/// let surface = DesignKitColor.hex(light: "#FFFFFF", dark: "#1C1C1E")
///
/// // Hex — always dark, even in light mode
/// let brandGlow = DesignKitColor.hex("#A8FF78", mode: .dark)
///
/// // Wrap any SwiftUI system color
/// let accent = DesignKitColor.system(.accentColor)
///
/// // RGBA components
/// let overlay = DesignKitColor.rgb(r: 0, g: 0, b: 0, alpha: 0.4)
/// ```
///
/// ## Using the resolved color
/// ```swift
/// Text("Hello")
///     .foregroundStyle(myToken.color)
/// ```
///
/// - Note: The `UIColor(dynamicProvider:)` API is used internally to implement
///   per-token mode locking. `UIKit` is not exposed in the public interface.
/// - SeeAlso: ``DesignKit.Theme``, ``DesignKitColorPalette``
public struct DesignKitColor: Sendable {

    /// The resolved SwiftUI `Color`, respecting the token's own mode lock.
    public let color: Color

    /// The mode lock applied when this color was created.
    public let mode: DesignKit.Theme

    // MARK: - Factories

    /// Creates an `DesignKitColor` from any SwiftUI `Color`.
    /// - Parameters:
    ///   - color: Any `Color` value, including system colors like `Color.blue`.
    ///   - mode: Whether this token follows the system scheme or is locked to light/dark.
    public static func system(_ color: Color, mode: DesignKit.Theme = .system) -> DesignKitColor {
        DesignKitColor(resolved: makeUIColor(from: color, mode: mode), mode: mode)
    }

    /// Creates an `DesignKitColor` from a hex string.
    /// - Parameters:
    ///   - hex: A string in `"#RRGGBB"` or `"#RRGGBBAA"` format (the `#` is optional).
    ///   - mode: Whether this token follows the system scheme or is locked to light/dark.
    public static func hex(_ hex: String, mode: DesignKit.Theme = .system) -> DesignKitColor {
        let uiColor = uiColorFromHex(hex)
        return DesignKitColor(resolved: makeAdaptiveColor(light: uiColor, dark: uiColor, mode: mode), mode: mode)
    }

    /// Creates an `DesignKitColor` from a hex string with separate light and dark values.
    /// - Parameters:
    ///   - lightHex: Hex string used in light mode.
    ///   - darkHex: Hex string used in dark mode.
    ///   - mode: Whether this token follows the system scheme or is locked to light/dark.
    public static func hex(light lightHex: String, dark darkHex: String, mode: DesignKit.Theme = .system) -> DesignKitColor {
        let light = uiColorFromHex(lightHex)
        let dark = uiColorFromHex(darkHex)
        return DesignKitColor(resolved: makeAdaptiveColor(light: light, dark: dark, mode: mode), mode: mode)
    }

    /// Creates an `DesignKitColor` from RGBA component values (0.0–1.0).
    /// - Parameters:
    ///   - r: Red channel, 0.0–1.0.
    ///   - g: Green channel, 0.0–1.0.
    ///   - b: Blue channel, 0.0–1.0.
    ///   - alpha: Opacity, 0.0–1.0. Defaults to `1.0`.
    ///   - mode: Whether this token follows the system scheme or is locked to light/dark.
    public static func rgb(r: Double, g: Double, b: Double, alpha: Double = 1.0, mode: DesignKit.Theme = .system) -> DesignKitColor {
        let uiColor = UIColor(red: r, green: g, blue: b, alpha: alpha)
        return DesignKitColor(resolved: makeAdaptiveColor(light: uiColor, dark: uiColor, mode: mode), mode: mode)
    }

    /// Creates an `DesignKitColor` from RGBA components with separate light and dark values.
    public static func rgb(
        light: (r: Double, g: Double, b: Double, alpha: Double),
        dark: (r: Double, g: Double, b: Double, alpha: Double),
        mode: DesignKit.Theme = .system
    ) -> DesignKitColor {
        let lightUI = UIColor(red: light.r, green: light.g, blue: light.b, alpha: light.alpha)
        let darkUI  = UIColor(red: dark.r,  green: dark.g,  blue: dark.b,  alpha: dark.alpha)
        return DesignKitColor(resolved: makeAdaptiveColor(light: lightUI, dark: darkUI, mode: mode), mode: mode)
    }

    // MARK: - Private init

    private init(resolved uiColor: UIColor, mode: DesignKit.Theme) {
        self.color = Color(uiColor: uiColor)
        self.mode = mode
    }

    // MARK: - Internal helpers (nonisolated pure functions, no shared state)

    private static func makeUIColor(from color: Color, mode: DesignKit.Theme) -> UIColor {
        let base = UIColor(color)
        return makeAdaptiveColor(light: base, dark: base, mode: mode)
    }

    private static func makeAdaptiveColor(light: UIColor, dark: UIColor, mode: DesignKit.Theme) -> UIColor {
        switch mode {
        case .system:
            return UIColor { traitCollection in
                traitCollection.userInterfaceStyle == .dark ? dark : light
            }
        case .light:
            return UIColor { _ in light }
        case .dark:
            return UIColor { _ in dark }
        }
    }

    private static func uiColorFromHex(_ hex: String) -> UIColor {
        var cleaned = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if cleaned.hasPrefix("#") { cleaned = String(cleaned.dropFirst()) }

        let length = cleaned.count
        guard length == 6 || length == 8 else { return UIColor.systemPink }

        var value: UInt64 = 0
        guard Scanner(string: cleaned).scanHexInt64(&value) else { return UIColor.systemPink }

        let r, g, b, a: Double
        if length == 6 {
            r = Double((value >> 16) & 0xFF) / 255
            g = Double((value >> 8)  & 0xFF) / 255
            b = Double(value         & 0xFF) / 255
            a = 1.0
        } else {
            r = Double((value >> 24) & 0xFF) / 255
            g = Double((value >> 16) & 0xFF) / 255
            b = Double((value >> 8)  & 0xFF) / 255
            a = Double(value         & 0xFF) / 255
        }
        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}
