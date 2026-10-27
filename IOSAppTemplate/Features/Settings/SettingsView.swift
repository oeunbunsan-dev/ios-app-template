//
//  SettingsView.swift
//  IOSAppTemplate
//
//  Created by Bunsan on 10/27/26.
//

import SwiftUI

/// Central settings hub for appearance, themes, fonts, typography, language, and persistence.
public struct SettingsView: View {
    @Environment(\.settingsStore) private var store
    @Environment(\.themeColors) private var colors
    @Environment(\.appTypography) private var typography
    @Environment(\.localizationManager) private var l10n

    @State private var viewModel = SettingsViewModel()

    public init() {}

    public var body: some View {
        ThemedView {
            ScrollView {
                VStack(spacing: 24) {
                    AppHeader(
                        title: l10n.string(forKey: "settings_title"),
                        showsBackButton: false
                    )

                    // Appearance & Theme Section
                    SettingsSection(title: l10n.string(forKey: "settings_section_appearance")) {
                        VStack(spacing: 0) {
                            // Appearance mode picker
                            VStack(alignment: .leading, spacing: 10) {
                                ThemedText(l10n.string(forKey: "settings_appearance_mode"), style: .body, weight: .medium)

                                Picker(l10n.string(forKey: "settings_appearance_mode"), selection: Binding(
                                    get: { store.settings.appearanceMode },
                                    set: { store.updateAppearanceMode($0) }
                                )) {
                                    ForEach(AppearanceMode.allCases) { mode in
                                        Text(mode.displayName).tag(mode)
                                    }
                                }
                                .pickerStyle(.segmented)
                            }
                            .padding(16)

                            Divider().overlay(colors.border)

                            // Theme Row
                            NavigationLink(destination: ThemeSettingsView()) {
                                settingsNavigationRow(
                                    title: l10n.string(forKey: "settings_current_theme"),
                                    value: store.settings.theme.displayName,
                                    icon: "paintpalette.fill",
                                    badgeColor: colors.primary
                                )
                            }
                        }
                    }

                    // Typography & Fonts Section
                    SettingsSection(title: l10n.string(forKey: "settings_section_fonts")) {
                        VStack(spacing: 0) {
                            NavigationLink(destination: FontSettingsView()) {
                                settingsNavigationRow(
                                    title: l10n.string(forKey: "settings_khmer_font"),
                                    value: store.settings.khmerFont.displayName,
                                    icon: "character.book.closed.fill",
                                    badgeColor: colors.accent
                                )
                            }

                            Divider().overlay(colors.border)

                            NavigationLink(destination: FontSettingsView()) {
                                settingsNavigationRow(
                                    title: l10n.string(forKey: "settings_english_font"),
                                    value: store.settings.englishFont.displayName,
                                    icon: "textformat",
                                    badgeColor: colors.tint
                                )
                            }

                            Divider().overlay(colors.border)

                            NavigationLink(destination: TypographySettingsView()) {
                                settingsNavigationRow(
                                    title: l10n.string(forKey: "settings_typography_scale"),
                                    value: store.settings.typographyScale.displayTitle,
                                    icon: "textformat.size",
                                    badgeColor: colors.warning
                                )
                            }
                        }
                    }

                    // Language Section
                    SettingsSection(title: l10n.string(forKey: "settings_section_language")) {
                        NavigationLink(destination: LanguageSettingsView()) {
                            settingsNavigationRow(
                                title: l10n.string(forKey: "settings_language"),
                                value: "\(store.settings.language.flagEmoji) \(store.settings.language.nativeName)",
                                icon: "globe",
                                badgeColor: colors.primary
                            )
                        }
                    }

                    // Behavior & Accessibility Section
                    SettingsSection(title: l10n.string(forKey: "settings_section_behavior")) {
                        VStack(spacing: 0) {
                            Toggle(isOn: Binding(
                                get: { store.settings.isHapticsEnabled },
                                set: { _ in store.toggleHaptics() }
                            )) {
                                HStack(spacing: 12) {
                                    Image(systemName: "hand.tap")
                                        .foregroundStyle(colors.accent)
                                        .frame(width: 24)
                                    ThemedText(l10n.string(forKey: "settings_haptics"), style: .body)
                                }
                            }
                            .padding(16)

                            Divider().overlay(colors.border)

                            Toggle(isOn: Binding(
                                get: { store.settings.respectsDynamicType },
                                set: { _ in store.toggleRespectDynamicType() }
                            )) {
                                HStack(spacing: 12) {
                                    Image(systemName: "accessibility")
                                        .foregroundStyle(colors.tint)
                                        .frame(width: 24)
                                    ThemedText(l10n.string(forKey: "settings_dynamic_type"), style: .body)
                                }
                            }
                            .padding(16)
                        }
                    }

                    // Reset to Defaults Action
                    ThemedButton(
                        l10n.string(forKey: "settings_reset_button"),
                        icon: "arrow.counterclockwise",
                        variant: .outlined
                    ) {
                        viewModel.showingResetConfirmation = true
                    }
                    .padding(.top, 8)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 32)
            }
        }
        .confirmationDialog(
            l10n.string(forKey: "settings_reset_confirm_title"),
            isPresented: $viewModel.showingResetConfirmation,
            titleVisibility: .visible
        ) {
            Button(l10n.string(forKey: "common_reset"), role: .destructive) {
                viewModel.confirmReset(store: store)
            }
            Button(l10n.string(forKey: "common_cancel"), role: .cancel) {}
        } message: {
            Text(l10n.string(forKey: "settings_reset_confirm_message"))
        }
    }

    private func settingsNavigationRow(
        title: String,
        value: String,
        icon: String,
        badgeColor: Color
    ) -> some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.system(size: typography.scaledSize(for: 16)))
                .foregroundStyle(badgeColor)
                .frame(width: 32, height: 32)
                .background(badgeColor.opacity(0.12))
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))

            ThemedText(title, style: .body, weight: .medium)

            Spacer()

            ThemedText(value, style: .body, color: .secondary)

            Image(systemName: "chevron.right")
                .font(.system(size: typography.scaledSize(for: 14), weight: .semibold))
                .foregroundStyle(colors.tertiaryText)
        }
        .padding(16)
        .contentShape(Rectangle())
    }
}
