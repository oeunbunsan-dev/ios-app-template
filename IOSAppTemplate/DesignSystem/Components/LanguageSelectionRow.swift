//
//  LanguageSelectionRow.swift
//  IOSAppTemplate
//
//  Created by Bunsan on 10/27/26.
//

import SwiftUI

/// Reusable row component for language selection with native names and flag emojis.
public struct LanguageSelectionRow: View {
    @Environment(\.themeColors) private var colors
    @Environment(\.appTypography) private var typography

    private let language: AppLanguage
    private let isSelected: Bool
    private let action: () -> Void

    public init(
        language: AppLanguage,
        isSelected: Bool,
        action: @escaping () -> Void
    ) {
        self.language = language
        self.isSelected = isSelected
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {
                Text(language.flagEmoji)
                    .font(.system(size: typography.scaledSize(for: 28)))

                VStack(alignment: .leading, spacing: 2) {
                    ThemedText(language.nativeName, style: .headline, weight: .semibold)

                    ThemedText(language.englishName, style: .subheadline, color: .secondary)
                }

                Spacer()

                if isSelected {
                    Image(systemName: "checkmark")
                        .font(.system(size: typography.scaledSize(for: 16), weight: .bold))
                        .foregroundStyle(colors.primary)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 14)
            .background(isSelected ? colors.card.opacity(0.8) : Color.clear)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel("\(language.nativeName), \(isSelected ? "Selected" : "Unselected")")
    }
}
