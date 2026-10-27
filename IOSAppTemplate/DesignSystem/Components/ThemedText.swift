//
//  ThemedText.swift
//  IOSAppTemplate
//
//  Created by Bunsan on 10/27/26.
//

import SwiftUI

/// Semantic text color variants.
public enum TextColorVariant {
    case primary
    case secondary
    case tertiary
    case accent
    case custom(Color)
}

/// Reusable typography component with script detection, typography scaling, and theme colors.
public struct ThemedText: View {
    @Environment(\.appTypography) private var typography
    @Environment(\.themeColors) private var colors

    private let text: String
    private let style: TypographyStyle
    private let weight: Font.Weight?
    private let colorVariant: TextColorVariant
    private let lineLimit: Int?
    private let lineSpacing: CGFloat?
    private let tracking: CGFloat?

    public init(
        _ text: String,
        style: TypographyStyle = .body,
        weight: Font.Weight? = nil,
        color: TextColorVariant = .primary,
        lineLimit: Int? = nil,
        lineSpacing: CGFloat? = nil,
        tracking: CGFloat? = nil
    ) {
        self.text = text
        self.style = style
        self.weight = weight
        self.colorVariant = color
        self.lineLimit = lineLimit
        self.lineSpacing = lineSpacing
        self.tracking = tracking
    }

    public var body: some View {
        let resolvedColor: Color = {
            switch colorVariant {
            case .primary: return colors.primaryText
            case .secondary: return colors.secondaryText
            case .tertiary: return colors.tertiaryText
            case .accent: return colors.accent
            case .custom(let customColor): return customColor
            }
        }()

        let font = typography.font(for: text, style: style, weight: weight)

        Text(text)
            .font(font)
            .foregroundStyle(resolvedColor)
            .lineLimit(lineLimit)
            .lineSpacing(lineSpacing ?? 0)
            .tracking(tracking ?? 0)
    }
}
