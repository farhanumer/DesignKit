import SwiftUI

// MARK: - Environment key

private struct DesignKitThemeKey: EnvironmentKey {
    static let defaultValue: DesignKit.Theme = .system
}

extension EnvironmentValues {
    /// The `DesignKit.Theme` applied to this view subtree.
    public var dkThemeMode: DesignKit.Theme {
        get { self[DesignKitThemeKey.self] }
        set { self[DesignKitThemeKey.self] = newValue }
    }
}

// MARK: - View modifier

/// A `ViewModifier` that forces an ``DesignKit.Theme`` on its content and all descendants.
///
/// Apply this modifier via the `.dkTheme(_:)` View extension rather than using it directly.
/// When `.light` or `.dark` is applied, it also sets `\.colorScheme` in the
/// SwiftUI environment so that system components (sheets, alerts, etc.) respect the override.
public struct DesignKitColorSchemeModeModifier: ViewModifier {
    let mode: DesignKit.Theme

    public func body(content: Content) -> some View {
        switch mode {
        case .system:
            content
                .environment(\.dkThemeMode, .system)
        case .light:
            content
                .environment(\.dkThemeMode, .light)
                .environment(\.colorScheme, .light)
        case .dark:
            content
                .environment(\.dkThemeMode, .dark)
                .environment(\.colorScheme, .dark)
        }
    }
}

// MARK: - View extension

extension View {
    /// Forces a specific light/dark mode on this view and all its descendants.
    ///
    /// When `.light` or `.dark` is passed, the modifier sets both the
    /// DesignKit environment value and SwiftUI's `\.colorScheme`, so all
    /// system-provided colors and components within the subtree also respect the override.
    ///
    /// ```swift
    /// // Always light — useful for branded invoice cards on a dark screen
    /// InvoiceCard()
    ///     .dkTheme(.light)
    ///
    /// // Always dark — good for media players, overlays
    /// PlayerView()
    ///     .dkTheme(.dark)
    ///
    /// // Restore system behavior (no-op if not inside a forced subtree)
    /// ContentView()
    ///     .dkTheme(.system)
    /// ```
    ///
    /// - Parameter mode: The ``DesignKit.Theme`` to apply to this view's subtree.
    public func dkTheme(_ mode: DesignKit.Theme) -> some View {
        modifier(DesignKitColorSchemeModeModifier(mode: mode))
    }
}
