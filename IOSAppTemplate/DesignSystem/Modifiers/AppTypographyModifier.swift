//
//  AppTypographyModifier.swift
//  IOSAppTemplate
//
//  Created by Bunsan on 10/27/26.
//

import SwiftUI

public struct AppTypographyModifier: ViewModifier {
    @Environment(\.appTypography) private var typography
    let style: TypographyStyle
    let weight: Font.Weight?
    let text: String

    public init(style: TypographyStyle, weight: Font.Weight? = nil, text: String = "") {
        self.style = style
        self.weight = weight
        self.text = text
    }

    public func body(content: Content) -> some View {
        content
            .font(typography.font(for: text, style: style, weight: weight))
    }
}

extension View {
    public func applyTypography(
        style: TypographyStyle,
        weight: Font.Weight? = nil,
        sampleText: String = ""
    ) -> some View {
        modifier(AppTypographyModifier(style: style, weight: weight, text: sampleText))
    }
}
