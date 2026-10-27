//
//  LanguageSettingsView.swift
//  IOSAppTemplate
//
//  Created by Bunsan on 10/27/26.
//

import SwiftUI

/// Screen managing application language selection with immediate reactive updating.
public struct LanguageSettingsView: View {
    @Environment(\.settingsStore) private var store
    @Environment(\.localizationManager) private var l10n
    @Environment(\.themeColors) private var colors

    public init() {}

    public var body: some View {
        ThemedView {
            ScrollView {
                VStack(spacing: 20) {
                    AppHeader(
                        title: l10n.string(forKey: "language_title"),
                        subtitle: l10n.string(forKey: "language_subtitle"),
                        showsBackButton: true
                    )

                    ThemedCard(padding: 0) {
                        VStack(spacing: 0) {
                            ForEach(AppLanguage.allCases) { lang in
                                LanguageSelectionRow(
                                    language: lang,
                                    isSelected: store.settings.language == lang
                                ) {
                                    withAnimation(.easeInOut(duration: 0.2)) {
                                        store.updateLanguage(lang)
                                    }
                                }

                                if lang != AppLanguage.allCases.last {
                                    Divider().overlay(colors.border)
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 20)

                    // Live Multilingual Preview
                    TypographyPreviewCard()
                        .padding(.horizontal, 20)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
