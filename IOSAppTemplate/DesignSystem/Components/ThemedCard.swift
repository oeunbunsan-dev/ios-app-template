//
//  ThemedCard.swift
//  IOSAppTemplate
//
//  Created by Bunsan on 10/27/26.
//

import SwiftUI

/// Reusable card component providing consistent background, border, corner radius, and padding.
public struct ThemedCard<Content: View>: View {
    @Environment(\.themeColors) private var colors
    private let content: Content
    private let cornerRadius: CGFloat
    private let padding: CGFloat
    private let showsBorder: Bool

    public init(
        cornerRadius: CGFloat = 16,
        padding: CGFloat = 16,
        showsBorder: Bool = true,
        @ViewBuilder content: () -> Content
    ) {
        self.cornerRadius = cornerRadius
        self.padding = padding
        self.showsBorder = showsBorder
        self.content = content()
    }

    public var body: some View {
        content
            .padding(padding)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .fill(colors.card)
            )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(showsBorder ? colors.border : Color.clear, lineWidth: 1)
            )
            .shadow(color: Color.black.opacity(0.04), radius: 6, x: 0, y: 3)
    }
}
