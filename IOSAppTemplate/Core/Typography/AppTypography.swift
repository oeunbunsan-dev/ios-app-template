//
//  AppTypography.swift
//  IOSAppTemplate
//
//  Created by Bunsan on 10/27/26.
//

import SwiftUI

/// Semantic typography style token definitions.
public enum TypographyStyle {
    case largeTitle
    case title
    case title2
    case title3
    case headline
    case subheadline
    case body
    case callout
    case footnote
    case caption
    case button

    public var baseSize: CGFloat {
        switch self {
        case .largeTitle: return 34
        case .title: return 28
        case .title2: return 22
        case .title3: return 20
        case .headline: return 17
        case .subheadline: return 15
        case .body: return 17
        case .callout: return 16
        case .footnote: return 13
        case .caption: return 12
        case .button: return 16
        }
    }

    public var defaultWeight: Font.Weight {
        switch self {
        case .largeTitle, .title, .title2:
            return .bold
        case .headline, .button:
            return .semibold
        case .title3:
            return .medium
        default:
            return .regular
        }
    }

    public var textStyle: Font.TextStyle {
        switch self {
        case .largeTitle: return .largeTitle
        case .title: return .title
        case .title2: return .title2
        case .title3: return .title3
        case .headline: return .headline
        case .subheadline: return .subheadline
        case .body: return .body
        case .callout: return .callout
        case .footnote: return .footnote
        case .caption: return .caption
        case .button: return .headline
        }
    }
}

/// Centralized typography token and sizing calculator.
public struct AppTypography {
    public let scale: TypographyScale
    public let englishFont: EnglishFont
    public let khmerFont: KhmerFont

    public init(
        scale: TypographyScale = .normal,
        englishFont: EnglishFont = .inter,
        khmerFont: KhmerFont = .battambang
    ) {
        self.scale = scale
        self.englishFont = englishFont
        self.khmerFont = khmerFont
    }

    /// Computes the scaled point size for a base point size.
    public func scaledSize(for baseSize: CGFloat) -> CGFloat {
        round(baseSize * CGFloat(scale.rawValue))
    }

    /// Resolves the styled font for a given text snippet.
    public func font(
        for text: String,
        style: TypographyStyle,
        weight: Font.Weight? = nil
    ) -> Font {
        let size = scaledSize(for: style.baseSize)
        let resolvedWeight = weight ?? style.defaultWeight
        return FontRegistry.fontForText(
            text,
            englishFont: englishFont,
            khmerFont: khmerFont,
            size: size,
            weight: resolvedWeight,
            relativeTo: style.textStyle
        )
    }

    /// Resolves a specific script font at a given typography style.
    public func scriptFont(
        script: ScriptType,
        style: TypographyStyle,
        weight: Font.Weight? = nil
    ) -> Font {
        let size = scaledSize(for: style.baseSize)
        let resolvedWeight = weight ?? style.defaultWeight
        switch script {
        case .khmer:
            let psName = FontRegistry.postScriptName(for: khmerFont, weight: resolvedWeight)
            return FontRegistry.customFont(name: psName, size: size, weight: resolvedWeight, relativeTo: style.textStyle)
        case .english:
            let psName = FontRegistry.postScriptName(for: englishFont, weight: resolvedWeight)
            return FontRegistry.customFont(name: psName, size: size, weight: resolvedWeight, relativeTo: style.textStyle)
        }
    }
}

// MARK: - SwiftUI Environment Keys
private struct AppTypographyKey: EnvironmentKey {
    static let defaultValue = AppTypography()
}

extension EnvironmentValues {
    public var appTypography: AppTypography {
        get { self[AppTypographyKey.self] }
        set { self[AppTypographyKey.self] = newValue }
    }
}
