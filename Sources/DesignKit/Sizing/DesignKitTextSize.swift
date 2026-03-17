import CoreFoundation

/// Semantic text-size tokens mapped to point values.
///
/// Use `.rawValue` to get the `CGFloat` for a `Font` initializer:
/// ```swift
/// .font(.system(size: DesignKitTextSize.body.rawValue))
/// // or via the typography API:
/// .font(.dk(.bodyMedium))
/// ```
public enum DesignKitTextSize: CGFloat, Sendable, CaseIterable {
    /// 10 pt — smallest caption / legal text
    case xxSmall  = 10
    /// 12 pt — captions, footnotes
    case xSmall   = 12
    /// 14 pt — secondary body, labels
    case small    = 14
    /// 16 pt — standard body text
    case body     = 16
    /// 18 pt — large body / sub-headline
    case medium   = 18
    /// 20 pt — small title
    case large    = 20
    /// 24 pt — section header / title
    case xLarge   = 24
    /// 32 pt — page title / hero text
    case xxLarge  = 32
    /// 40 pt — display / marketing headline
    case display  = 40
}
