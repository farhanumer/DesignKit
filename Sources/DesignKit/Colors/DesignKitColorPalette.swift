import Foundation

/// Defines the full set of semantic color tokens for a design palette.
///
/// Implement this protocol to provide custom brand colors. Assign your implementation
/// to ``DesignKit.colors/current`` once at app launch.
///
/// Colors are grouped into three independent roles:
/// - **Text** — colors applied to `foregroundStyle`, tints, and in-line icons
/// - **Background** — colors applied to view `background()` and container fills
/// - **Object** — colors applied to interactive controls, icons, and dividers
///
/// Within each role, tokens are organized by semantic intensity:
/// primary → secondary → tertiary → accent, plus four status variants
/// (success, warning, error, info).
///
/// Each role is independent, so `primaryText` and `primaryBackground` can
/// resolve to completely different colors.
///
/// ## Implementing a custom palette
/// ```swift
/// struct BrandPalette: DesignKitColorPalette {
///     var primaryText:   DesignKitColor { .hex(light: "#1A1A2E", dark: "#EAEAF5") }
///     var secondaryText: DesignKitColor { .hex(light: "#44446A", dark: "#A0A0C8") }
///     // ... all 22 tokens required
/// }
///
/// // Assign at launch:
/// DesignKit.colors.current = BrandPalette()
/// ```
///
/// - SeeAlso: ``DesignKitDefaultPalette``, ``DesignKit.colors``
public protocol DesignKitColorPalette: Sendable {

    // MARK: Text tokens
    var primaryText: DesignKitColor { get }
    var secondaryText: DesignKitColor { get }
    var tertiaryText: DesignKitColor { get }
    var accentText: DesignKitColor { get }
    var successText: DesignKitColor { get }
    var warningText: DesignKitColor { get }
    var errorText: DesignKitColor { get }
    var infoText: DesignKitColor { get }

    // MARK: Background tokens
    var primaryBackground: DesignKitColor { get }
    var secondaryBackground: DesignKitColor { get }
    var tertiaryBackground: DesignKitColor { get }
    var successBackground: DesignKitColor { get }
    var warningBackground: DesignKitColor { get }
    var errorBackground: DesignKitColor { get }
    var infoBackground: DesignKitColor { get }

    // MARK: Object / UI element tokens
    var primaryObject: DesignKitColor { get }
    var secondaryObject: DesignKitColor { get }
    var tertiaryObject: DesignKitColor { get }
    var accentObject: DesignKitColor { get }
    var successObject: DesignKitColor { get }
    var warningObject: DesignKitColor { get }
    var errorObject: DesignKitColor { get }
    var infoObject: DesignKitColor { get }
}

// MARK: - Default palette

/// The built-in palette. Replace it via `DesignKit.colors.current = YourPalette()`.
///
/// All colors are adaptive (system light/dark) unless noted otherwise.
public struct DesignKitDefaultPalette: DesignKitColorPalette {

    public init() {}

    // MARK: Text
    public var primaryText:   DesignKitColor { .hex(light: "#1C1C1E", dark: "#F2F2F7") }
    public var secondaryText: DesignKitColor { .hex(light: "#3C3C43", dark: "#AEAEB2") }
    public var tertiaryText:  DesignKitColor { .hex(light: "#6C6C70", dark: "#636366") }
    public var accentText:    DesignKitColor { .system(.accentColor) }
    public var successText:   DesignKitColor { .hex(light: "#1B7F4A", dark: "#30D158") }
    public var warningText:   DesignKitColor { .hex(light: "#A05C00", dark: "#FFD60A") }
    public var errorText:     DesignKitColor { .hex(light: "#C0392B", dark: "#FF453A") }
    public var infoText:      DesignKitColor { .hex(light: "#0A6EBD", dark: "#0A84FF") }

    // MARK: Background
    public var primaryBackground:   DesignKitColor { .hex(light: "#FFFFFF", dark: "#000000") }
    public var secondaryBackground: DesignKitColor { .hex(light: "#F2F2F7", dark: "#1C1C1E") }
    public var tertiaryBackground:  DesignKitColor { .hex(light: "#FFFFFF", dark: "#2C2C2E") }
    public var successBackground:   DesignKitColor { .hex(light: "#D1F2EB", dark: "#0A3D22") }
    public var warningBackground:   DesignKitColor { .hex(light: "#FEF3CD", dark: "#3A2D00") }
    public var errorBackground:     DesignKitColor { .hex(light: "#FADBD8", dark: "#3B0F0C") }
    public var infoBackground:      DesignKitColor { .hex(light: "#D6EAF8", dark: "#0C2A45") }

    // MARK: Object
    public var primaryObject:   DesignKitColor { .hex(light: "#1C1C1E", dark: "#F2F2F7") }
    public var secondaryObject: DesignKitColor { .hex(light: "#3C3C43", dark: "#AEAEB2") }
    public var tertiaryObject:  DesignKitColor { .hex(light: "#C7C7CC", dark: "#3A3A3C") }
    public var accentObject:    DesignKitColor { .system(.accentColor) }
    public var successObject:   DesignKitColor { .hex(light: "#1B7F4A", dark: "#30D158") }
    public var warningObject:   DesignKitColor { .hex(light: "#A05C00", dark: "#FFD60A") }
    public var errorObject:     DesignKitColor { .hex(light: "#C0392B", dark: "#FF453A") }
    public var infoObject:      DesignKitColor { .hex(light: "#0A6EBD", dark: "#0A84FF") }
}
