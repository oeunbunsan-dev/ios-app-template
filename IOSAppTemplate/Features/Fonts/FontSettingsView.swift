//
//  FontSettingsView.swift
//  IOSAppTemplate
//
//  Created by Bunsan on 10/27/26.
//

import SwiftUI

/// Screen managing independent Khmer and English font family selections with live script previews.
public struct FontSettingsView: View {
    @Environment(\.settingsStore) private var store
    @Environment(\.themeColors) private var colors
    @Environment(\.appTypography) private var typography
    @Environment(\.localizationManager) private var l10n

    @State private var viewModel = FontSettingsViewModel()

    public init() {}

    public var body: some View {
        ThemedView {
            ScrollView {
                VStack(spacing: 20) {
                    AppHeader(
                        title: l10n.string(forKey: "fonts_title"),
                        showsBackButton: true
                    )

                    // Script Picker Segment
                    Picker("Script", selection: $viewModel.selectedTab) {
                        Text(l10n.string(forKey: "fonts_tab_khmer")).tag(ScriptType.khmer)
                        Text(l10n.string(forKey: "fonts_tab_english")).tag(ScriptType.english)
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal, 20)

                    // Live Multi-Script Preview Card
                    TypographyPreviewCard()
                        .padding(.horizontal, 20)

                    // Font Selection Cards
                    VStack(spacing: 12) {
                        if viewModel.selectedTab == .khmer {
                            khmerFontsList
                        } else {
                            englishFontsList
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 32)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    // MARK: - Khmer Fonts List
    private var khmerFontsList: some View {
        ForEach(viewModel.filteredKhmerFonts) { font in
            let isSelected = store.settings.khmerFont == font
            let customFont = FontRegistry.customFont(
                name: font.regularPostScriptName,
                size: typography.scaledSize(for: 18)
            )

            FontSelectionCard(
                title: font.displayName,
                sampleText: font.sampleText,
                isSelected: isSelected,
                customFont: customFont
            ) {
                withAnimation(.easeInOut(duration: 0.2)) {
                    store.updateKhmerFont(font)
                }
            }
        }
    }

    // MARK: - English Fonts List
    private var englishFontsList: some View {
        ForEach(viewModel.filteredEnglishFonts) { font in
            let isSelected = store.settings.englishFont == font
            let customFont = FontRegistry.customFont(
                name: font.regularPostScriptName,
                size: typography.scaledSize(for: 17)
            )

            FontSelectionCard(
                title: font.displayName,
                sampleText: font.sampleText,
                isSelected: isSelected,
                customFont: customFont
            ) {
                withAnimation(.easeInOut(duration: 0.2)) {
                    store.updateEnglishFont(font)
                }
            }
        }
    }
}
