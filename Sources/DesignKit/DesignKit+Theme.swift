extension DesignKit {

    /// Controls how a color or view responds to the device's light/dark appearance.
    ///
    /// Use this type both when creating individual ``DesignKitColor`` tokens and when
    /// applying `.dkTheme(_:)` to a view subtree.
    ///
    /// ## Per-token appearance locking
    /// ```swift
    /// // Always the dark-mode value, even when the device is in light mode
    /// let brandGlow = DesignKitColor.hex("#A8FF78", mode: .dark)
    ///
    /// // Separate light and dark values, locked to light
    /// let invoiceBg = DesignKitColor.hex(light: "#FFFFFF", dark: "#FFFFFF", mode: .light)
    /// ```
    ///
    /// ## Subtree locking
    /// ```swift
    /// // Lock an entire card to light mode
    /// BrandCard()
    ///     .dkTheme(.light)
    ///
    /// // Lock a media player overlay to dark
    /// PlayerView()
    ///     .dkTheme(.dark)
    /// ```
    ///
    /// - SeeAlso: ``DesignKitColor``, ``DesignKitColorPalette``
    public enum Theme: Sendable {
        /// Follows the system (or parent view's) color scheme automatically.
        case system
        /// Always renders in light mode regardless of the system setting.
        case light
        /// Always renders in dark mode regardless of the system setting.
        case dark
    }
}
