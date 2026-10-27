//
//  ThemeSettingsView.swift
//  IOSAppTemplate
//
//  Created by Bunsan on 10/27/26.
//

import SwiftUI

/// Screen displaying all ten handcrafted themes with live previews and immediate switching.
public struct ThemeSettingsView: View {
    @Environment(\.settingsStore) private var store
    @Environment(\.localizationManager) private var l10n
    @Environment(\.themeColors) private var colors

    public init() {}

    public var body: some View {
        ThemedView {
            ScrollView {
                VStack(spacing: 20) {
                    AppHeader(
                        title: l10n.string(forKey: "themes_title"),
                        subtitle: l10n.string(forKey: "themes_subtitle"),
                        showsBackButton: true
                    )

                    VStack(spacing: 12) {
                        ForEach(AppTheme.allCases) { theme in
                            ThemeSelectionCard(
                                theme: theme,
                                isSelected: store.settings.theme == theme
                            ) {
                                withAnimation(.easeInOut(duration: 0.25)) {
                                    store.updateTheme(theme)
                                }
                            }
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
