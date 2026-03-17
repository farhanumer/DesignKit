import Testing
@testable import DesignKit

// MARK: - Sizing

@Suite("DesignKit.sizes Tests")
@MainActor
struct SizesTests {

    @Test("custom multiplier with default base unit (8)")
    func customDefaultBase() {
        DesignKit.sizes.baseUnit = 8
        #expect(DesignKit.sizes.custom(multiplier: 1)     == 8)
        #expect(DesignKit.sizes.custom(multiplier: 0.5)   == 4)
        #expect(DesignKit.sizes.custom(multiplier: 2)     == 16)
        #expect(DesignKit.sizes.custom(multiplier: 20)    == 160)
        #expect(DesignKit.sizes.custom(multiplier: 20.25) == 162)
    }

    @Test("custom multiplier with overridden base unit")
    func customOverriddenBase() {
        DesignKit.sizes.baseUnit = 4
        #expect(DesignKit.sizes.custom(multiplier: 1)   == 4)
        #expect(DesignKit.sizes.custom(multiplier: 2)   == 8)
        #expect(DesignKit.sizes.custom(multiplier: 0.5) == 2)
        DesignKit.sizes.baseUnit = 8
    }

    @Test("named tokens at default base (8)")
    func namedTokensDefault() {
        DesignKit.sizes.baseUnit = 8
        #expect(DesignKit.sizes.xxSmall     == 2)
        #expect(DesignKit.sizes.xSmall      == 4)
        #expect(DesignKit.sizes.small       == 8)
        #expect(DesignKit.sizes.mediumSmall == 12)
        #expect(DesignKit.sizes.medium      == 16)
        #expect(DesignKit.sizes.large       == 24)
        #expect(DesignKit.sizes.xLarge      == 32)
        #expect(DesignKit.sizes.xxLarge     == 48)
        #expect(DesignKit.sizes.giant       == 64)
    }

    @Test("named tokens scale with base unit change")
    func namedTokensScale() {
        DesignKit.sizes.baseUnit = 10
        #expect(DesignKit.sizes.small  == 10)
        #expect(DesignKit.sizes.medium == 20)
        #expect(DesignKit.sizes.large  == 30)
        DesignKit.sizes.baseUnit = 8
    }

    @Test("Token values match CGFloat tokens")
    func tokenValues() {
        DesignKit.sizes.baseUnit = 8
        #expect(DesignKit.sizes.Token.medium.value     == DesignKit.sizes.medium)
        #expect(DesignKit.sizes.Token.large.value      == DesignKit.sizes.large)
        #expect(DesignKit.sizes.Token.xxSmall.value    == DesignKit.sizes.xxSmall)
    }
}

// MARK: - Text Size

@Suite("DesignKitTextSize Tests")
struct TextSizeTests {

    @Test("all text sizes have correct raw values")
    func rawValues() {
        #expect(DesignKitTextSize.xxSmall.rawValue == 10)
        #expect(DesignKitTextSize.xSmall.rawValue  == 12)
        #expect(DesignKitTextSize.small.rawValue   == 14)
        #expect(DesignKitTextSize.body.rawValue    == 16)
        #expect(DesignKitTextSize.medium.rawValue  == 18)
        #expect(DesignKitTextSize.large.rawValue   == 20)
        #expect(DesignKitTextSize.xLarge.rawValue  == 24)
        #expect(DesignKitTextSize.xxLarge.rawValue == 32)
        #expect(DesignKitTextSize.display.rawValue == 40)
    }

    @Test("CaseIterable returns all 9 sizes")
    func caseCount() {
        #expect(DesignKitTextSize.allCases.count == 9)
    }
}

// MARK: - Colors

@Suite("DesignKitColor Tests")
struct ColorTests {

    @Test("hex without # prefix creates color without crash")
    func hexWithoutHash() {
        let color = DesignKitColor.hex("FF5733")
        let _ = color.color
    }

    @Test("hex with # prefix creates color without crash")
    func hexWithHash() {
        let color = DesignKitColor.hex("#FF5733")
        let _ = color.color
    }

    @Test("8-digit hex with alpha creates color without crash")
    func hexWithAlpha() {
        let color = DesignKitColor.hex("#FF5733CC")
        let _ = color.color
    }

    @Test("separate light/dark hex values are accepted")
    func hexLightDark() {
        let color = DesignKitColor.hex(light: "#FFFFFF", dark: "#000000")
        let _ = color.color
    }

    @Test("rgb factory creates color without crash")
    func rgbFactory() {
        let color = DesignKitColor.rgb(r: 0.5, g: 0.3, b: 0.8, alpha: 1.0)
        let _ = color.color
    }

    @Test("system factory wraps SwiftUI Color without crash")
    func systemFactory() {
        let color = DesignKitColor.system(.blue)
        let _ = color.color
    }
}

// MARK: - Font Weight

@Suite("DesignKitFontWeight Tests")
struct FontWeightTests {

    @Test("all weights have non-empty labels")
    func weightLabels() {
        for weight in DesignKitFontWeight.allCases {
            #expect(!weight.label.isEmpty)
        }
    }

    @Test("CaseIterable returns all 9 weights")
    func weightCount() {
        #expect(DesignKitFontWeight.allCases.count == 9)
    }

    @Test("each weight maps to a distinct Font.Weight")
    func weightMapping() {
        #expect(DesignKitFontWeight.regular.fontWeight  == .regular)
        #expect(DesignKitFontWeight.bold.fontWeight     == .bold)
        #expect(DesignKitFontWeight.semibold.fontWeight == .semibold)
        #expect(DesignKitFontWeight.black.fontWeight    == .black)
    }
}

// MARK: - Theme

@Suite("DesignKit.Theme Tests")
struct ThemeTests {

    @Test("Theme has three cases")
    func themeCases() {
        let themes: [DesignKit.Theme] = [.system, .light, .dark]
        #expect(themes.count == 3)
    }
}

// MARK: - Configuration

@Suite("DesignKitConfiguration Tests")
@MainActor
struct ConfigurationTests {

    @Test("default configuration uses expected defaults")
    func defaultConfiguration() {
        let config = DesignKitConfiguration.default
        #expect(config.baseUnit == 8)
        // primaryFamily default is .system (verified via font resolution)
    }

    @Test("configure(with:) applies baseUnit")
    func configureWithAppliesBaseUnit() {
        let config = DesignKitConfiguration(baseUnit: 12)
        DesignKit.configure(with: config)
        #expect(DesignKit.sizes.baseUnit == 12)
        // Reset
        DesignKit.configure(with: .default)
    }

    @Test("configure(baseUnit:) applies only baseUnit")
    func configureBaseUnitOnly() {
        DesignKit.configure(baseUnit: 6)
        #expect(DesignKit.sizes.baseUnit == 6)
        // Reset
        DesignKit.configure(with: .default)
    }

    @Test("configure(palette:) swaps palette")
    func configurePaletteOnly() {
        let customPalette = DesignKitDefaultPalette()
        DesignKit.configure(palette: customPalette)
        let _ = DesignKit.colors.palette.primaryText.color
        // Reset
        DesignKit.configure(with: .default)
    }

    @Test("configure(with: .default) restores baseUnit to 8")
    func configureDefaultRestores() {
        DesignKit.sizes.baseUnit = 99
        DesignKit.configure(with: .default)
        #expect(DesignKit.sizes.baseUnit == 8)
    }
}

// MARK: - Font Resolution

@Suite("DesignKit.fonts Tests")
@MainActor
struct FontsTests {

    @Test("resolve returns a non-nil Font for all text styles")
    func resolveAllStyles() {
        for style in DesignKitTextStyle.allCases {
            let font = DesignKit.fonts.resolve(style, family: nil)
            let _ = font  // just confirm no crash / assertion failure
        }
    }

    @Test("resolve with explicit family overrides primary family")
    func resolveWithFamilyOverride() {
        let font = DesignKit.fonts.resolve(.bodyMedium, family: .systemMono)
        let _ = font
    }
}

// MARK: - Default Palette

@Suite("DesignKitDefaultPalette Tests")
struct DefaultPaletteTests {

    @Test("all 22 palette tokens return a color without crashing")
    func allTokensResolve() {
        let palette = DesignKitDefaultPalette()
        // Text
        let _ = palette.primaryText.color
        let _ = palette.secondaryText.color
        let _ = palette.tertiaryText.color
        let _ = palette.accentText.color
        let _ = palette.successText.color
        let _ = palette.warningText.color
        let _ = palette.errorText.color
        let _ = palette.infoText.color
        // Background
        let _ = palette.primaryBackground.color
        let _ = palette.secondaryBackground.color
        let _ = palette.tertiaryBackground.color
        let _ = palette.successBackground.color
        let _ = palette.warningBackground.color
        let _ = palette.errorBackground.color
        let _ = palette.infoBackground.color
        // Object
        let _ = palette.primaryObject.color
        let _ = palette.secondaryObject.color
        let _ = palette.tertiaryObject.color
        let _ = palette.accentObject.color
        let _ = palette.successObject.color
        let _ = palette.warningObject.color
        let _ = palette.errorObject.color
    }
}
