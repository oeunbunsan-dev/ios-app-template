//
//  ThemeSelectionCard.swift
//  IOSAppTemplate
//
//  Created by Bunsan on 10/27/26.
//

import SwiftUI

/// Interactive card for theme selection showing distinct color swatches and active indicator.
public struct ThemeSelectionCard: View {
    @Environment(\.themeColors) private var colors
    @Environment(\.appTypography) private var typography

    private let theme: AppTheme
    private let isSelected: Bool
    private let action: () -> Void

    public init(
        theme: AppTheme,
        isSelected: Bool,
        action: @escaping () -> Void
    ) {
        self.theme = theme
        self.isSelected = isSelected
        self.action = action
    }

    public var body: some View {
        let palette = ThemeRegistry.colors(for: theme)

        Button(action: action) {
            ThemedCard(
                cornerRadius: 16,
                padding: 16,
                showsBorder: isSelected
            ) {
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            ThemedText(theme.displayName, style: .headline, weight: .bold)

                            ThemedText(theme.description, style: .footnote, color: .secondary, lineLimit: 2)
                        }

                        Spacer()

                        if isSelected {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundStyle(colors.primary)
                                .font(.system(size: typography.scaledSize(for: 22)))
                        } else {
                            Image(systemName: "circle")
                                .foregroundStyle(colors.border)
                                .font(.system(size: typography.scaledSize(for: 22)))
                        }
                    }

                    // Theme Color Swatches Bar
                    HStack(spacing: 8) {
                        swatch(color: palette.background, label: "BG")
                        swatch(color: palette.surface, label: "Surface")
                        swatch(color: palette.card, label: "Card")
                        swatch(color: palette.primary, label: "Primary")
                        swatch(color: palette.accent, label: "Accent")
                    }
                    .padding(8)
                    .background(palette.background.opacity(0.7))
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .stroke(palette.border, lineWidth: 1)
                    )
                }
            }
        }
        .buttonStyle(.plain)
        .accessibilityLabel("\(theme.displayName), \(isSelected ? "Selected" : "Unselected")")
    }

    private func swatch(color: Color, label: String) -> some View {
        RoundedRectangle(cornerRadius: 6, style: .continuous)
            .fill(color)
            .frame(height: 28)
            .overlay(
                RoundedRectangle(cornerRadius: 6, style: .continuous)
                    .stroke(Color.black.opacity(0.15), lineWidth: 0.5)
            )
    }
}
