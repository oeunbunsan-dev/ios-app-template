//
//  TypographySettingsView.swift
//  IOSAppTemplate
//
//  Created by Bunsan on 10/27/26.
//

import SwiftUI

/// Screen managing global typography scaling presets with live preview and reset action.
public struct TypographySettingsView: View {
    @Environment(\.settingsStore) private var store
    @Environment(\.localizationManager) private var l10n
    @Environment(\.themeColors) private var colors
    @Environment(\.appTypography) private var typography

    public init() {}

    public var body: some View {
        ThemedView {
            ScrollView {
                VStack(spacing: 20) {
                    AppHeader(
                        title: l10n.string(forKey: "typography_title"),
                        subtitle: l10n.string(forKey: "typography_subtitle"),
                        showsBackButton: true
                    )

                    // Presets Grid
                    VStack(spacing: 12) {
                        ForEach(TypographyScale.allCases) { scale in
                            let isSelected = store.settings.typographyScale == scale

                            Button(action: {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    store.updateTypographyScale(scale)
                                }
                            }) {
                                ThemedCard(cornerRadius: 14, padding: 16, showsBorder: isSelected) {
                                    HStack {
                                        VStack(alignment: .leading, spacing: 4) {
                                            ThemedText(scale.displayName, style: .headline, weight: .bold)
                                            ThemedText(scale.percentageString, style: .subheadline, color: .secondary)
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
                                }
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, 20)

                    // Live Multilingual Typography Preview Card
                    TypographyPreviewCard()
                        .padding(.horizontal, 20)

                    // Reset Typography to Normal (100%)
                    ThemedButton(
                        "Reset to Normal (100%)",
                        icon: "arrow.counterclockwise",
                        variant: .secondary
                    ) {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            store.updateTypographyScale(.normal)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 32)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
