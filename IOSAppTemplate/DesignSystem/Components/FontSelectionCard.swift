//
//  FontSelectionCard.swift
//  IOSAppTemplate
//
//  Created by Bunsan on 10/27/26.
//

import SwiftUI

/// Interactive selection card for fonts displaying live script preview and selection checkmark.
public struct FontSelectionCard: View {
    @Environment(\.themeColors) private var colors
    @Environment(\.appTypography) private var typography

    private let title: String
    private let sampleText: String
    private let isSelected: Bool
    private let customFont: Font
    private let action: () -> Void

    public init(
        title: String,
        sampleText: String,
        isSelected: Bool,
        customFont: Font,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.sampleText = sampleText
        self.isSelected = isSelected
        self.customFont = customFont
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            ThemedCard(
                cornerRadius: 14,
                padding: 16,
                showsBorder: isSelected
            ) {
                HStack(alignment: .center, spacing: 14) {
                    VStack(alignment: .leading, spacing: 6) {
                        HStack {
                            ThemedText(title, style: .headline, weight: .semibold)

                            Spacer()

                            if isSelected {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundStyle(colors.primary)
                                    .font(.system(size: typography.scaledSize(for: 20)))
                            } else {
                                Image(systemName: "circle")
                                    .foregroundStyle(colors.border)
                                    .font(.system(size: typography.scaledSize(for: 20)))
                            }
                        }

                        Text(sampleText)
                            .font(customFont)
                            .foregroundStyle(colors.secondaryText)
                            .lineLimit(2)
                            .multilineTextAlignment(.leading)
                    }
                }
            }
        }
        .buttonStyle(.plain)
        .accessibilityLabel("\(title), \(isSelected ? "Selected" : "Unselected")")
    }
}
