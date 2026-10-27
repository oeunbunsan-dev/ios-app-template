//
//  HomeView.swift
//  IOSAppTemplate
//
//  Created by Bunsan on 10/27/26.
//

import SwiftUI

/// Dashboard home screen showcasing the complete architecture, themes, typography, and design system.
public struct HomeView: View {
    @Environment(\.settingsStore) private var store
    @Environment(\.themeColors) private var colors
    @Environment(\.appTypography) private var typography
    @Environment(\.localizationManager) private var l10n

    @State private var sampleCounter = 0
    @State private var currentDate = Date()

    public init() {}

    public var body: some View {
        ThemedView {
            ScrollView {
                VStack(spacing: 20) {
                    // App Header
                    AppHeader(
                        title: l10n.string(forKey: "home_title"),
                        subtitle: l10n.string(forKey: "home_subtitle")
                    ) {
                        NavigationLink(destination: SettingsView()) {
                            Image(systemName: "gearshape.fill")
                                .font(.system(size: typography.scaledSize(for: 18), weight: .semibold))
                                .foregroundStyle(colors.primary)
                                .padding(10)
                                .background(colors.card)
                                .clipShape(Circle())
                        }
                    }

                    // Hero Banner Card
                    heroBanner

                    // Core Pillars Grid
                    featuresSection

                    // Live Multilingual Typography Preview Card
                    TypographyPreviewCard()
                        .padding(.horizontal, 20)

                    // Locale-Aware Formatting Card
                    localeFormattingSection

                    // Interactive Design System Showcase
                    designSystemShowcase

                    // Quick Jump Actions
                    quickActionsSection
                }
                .padding(.bottom, 32)
            }
        }
    }

    // MARK: - Hero Banner
    private var heroBanner: some View {
        ThemedCard(cornerRadius: 20, padding: 20) {
            VStack(alignment: .leading, spacing: 14) {
                HStack {
                    HStack(spacing: 6) {
                        Text(store.settings.language.flagEmoji)
                        ThemedText(store.settings.language.nativeName, style: .caption, weight: .bold, color: .accent)
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(colors.accent.opacity(0.15))
                    .clipShape(Capsule())

                    Spacer()

                    HStack(spacing: 6) {
                        Circle()
                            .fill(colors.primary)
                            .frame(width: 8, height: 8)
                        ThemedText(store.settings.theme.displayName, style: .caption, weight: .bold, color: .primary)
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(colors.primary.opacity(0.12))
                    .clipShape(Capsule())
                }

                VStack(alignment: .leading, spacing: 6) {
                    ThemedText(
                        l10n.string(forKey: "home_title"),
                        style: .title2,
                        weight: .bold
                    )

                    ThemedText(
                        l10n.string(forKey: "home_subtitle"),
                        style: .subheadline,
                        color: .secondary
                    )
                }

                HStack(spacing: 12) {
                    NavigationLink(destination: TypographyPlaygroundView()) {
                        HStack {
                            Image(systemName: "slider.horizontal.3")
                            Text(l10n.string(forKey: "home_action_try_playground"))
                        }
                        .font(typography.font(for: "Playground", style: .button, weight: .semibold))
                        .foregroundStyle(colors.background)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 16)
                        .background(colors.primary)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }

                    NavigationLink(destination: ThemeSettingsView()) {
                        HStack {
                            Image(systemName: "paintpalette.fill")
                            Text(l10n.string(forKey: "home_action_customize_theme"))
                        }
                        .font(typography.font(for: "Theme", style: .button, weight: .semibold))
                        .foregroundStyle(colors.primary)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 16)
                        .background(colors.card)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12, style: .continuous)
                                .stroke(colors.border, lineWidth: 1)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    }
                }
            }
        }
        .padding(.horizontal, 20)
    }

    // MARK: - Features Section
    private var featuresSection: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                featureItem(
                    icon: "paintpalette.fill",
                    title: l10n.string(forKey: "home_feature_themes"),
                    desc: l10n.string(forKey: "home_feature_themes_desc"),
                    color: colors.primary
                )

                featureItem(
                    icon: "textformat",
                    title: l10n.string(forKey: "home_feature_fonts"),
                    desc: l10n.string(forKey: "home_feature_fonts_desc"),
                    color: colors.accent
                )
            }

            HStack(spacing: 12) {
                featureItem(
                    icon: "globe",
                    title: l10n.string(forKey: "home_feature_localization"),
                    desc: l10n.string(forKey: "home_feature_localization_desc"),
                    color: colors.tint
                )

                featureItem(
                    icon: "textformat.size",
                    title: l10n.string(forKey: "home_feature_scaling"),
                    desc: l10n.string(forKey: "home_feature_scaling_desc"),
                    color: colors.warning
                )
            }
        }
        .padding(.horizontal, 20)
    }

    private func featureItem(icon: String, title: String, desc: String, color: Color) -> some View {
        ThemedCard(cornerRadius: 14, padding: 14) {
            VStack(alignment: .leading, spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: typography.scaledSize(for: 20)))
                    .foregroundStyle(color)
                    .padding(8)
                    .background(color.opacity(0.12))
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))

                ThemedText(title, style: .headline, weight: .bold)

                ThemedText(desc, style: .caption, color: .secondary, lineLimit: 3)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    // MARK: - Locale Formatting Section
    private var localeFormattingSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            ThemedText(
                l10n.string(forKey: "home_sample_formatting").uppercased(),
                style: .caption,
                weight: .bold,
                color: .secondary
            )
            .padding(.horizontal, 24)

            ThemedCard(cornerRadius: 16, padding: 16) {
                VStack(spacing: 12) {
                    formattingRow(
                        title: l10n.string(forKey: "home_sample_date"),
                        value: l10n.formatDate(currentDate),
                        icon: "calendar"
                    )

                    Divider().overlay(colors.border)

                    formattingRow(
                        title: l10n.string(forKey: "home_sample_currency"),
                        value: l10n.formatCurrency(1299.99),
                        icon: "banknote"
                    )

                    Divider().overlay(colors.border)

                    formattingRow(
                        title: l10n.string(forKey: "home_sample_number"),
                        value: l10n.formatNumber(9876543.21),
                        icon: "number"
                    )
                }
            }
            .padding(.horizontal, 20)
        }
    }

    private func formattingRow(title: String, value: String, icon: String) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundStyle(colors.accent)
                .font(.system(size: typography.scaledSize(for: 16)))
                .frame(width: 24)

            ThemedText(title, style: .body, color: .secondary)

            Spacer()

            ThemedText(value, style: .body, weight: .semibold, color: .primary)
        }
    }

    // MARK: - Design System Showcase
    private var designSystemShowcase: some View {
        VStack(alignment: .leading, spacing: 12) {
            ThemedText(
                "DESIGN SYSTEM BUTTONS",
                style: .caption,
                weight: .bold,
                color: .secondary
            )
            .padding(.horizontal, 24)

            ThemedCard(cornerRadius: 16, padding: 16) {
                VStack(spacing: 12) {
                    HStack(spacing: 12) {
                        ThemedButton(
                            "Primary Tap (\(sampleCounter))",
                            icon: "hand.tap.fill",
                            variant: .primary
                        ) {
                            sampleCounter += 1
                        }

                        ThemedButton(
                            "Secondary",
                            icon: "arrow.counterclockwise",
                            variant: .secondary
                        ) {
                            sampleCounter = 0
                        }
                    }

                    HStack(spacing: 12) {
                        ThemedButton(
                            "Outlined Style",
                            icon: "sparkles",
                            variant: .outlined
                        ) {}

                        ThemedButton(
                            "Text Variant",
                            icon: "info.circle",
                            variant: .text
                        ) {}
                    }
                }
            }
            .padding(.horizontal, 20)
        }
    }

    // MARK: - Quick Actions Section
    private var quickActionsSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            ThemedText(
                l10n.string(forKey: "home_quick_actions").uppercased(),
                style: .caption,
                weight: .bold,
                color: .secondary
            )
            .padding(.horizontal, 24)

            VStack(spacing: 10) {
                NavigationLink(destination: TypographyPlaygroundView()) {
                    actionRow(
                        icon: "character.textbox",
                        title: l10n.string(forKey: "playground_title"),
                        subtitle: l10n.string(forKey: "playground_subtitle")
                    )
                }

                NavigationLink(destination: ThemeSettingsView()) {
                    actionRow(
                        icon: "paintpalette",
                        title: l10n.string(forKey: "themes_title"),
                        subtitle: store.settings.theme.displayName
                    )
                }

                NavigationLink(destination: FontSettingsView()) {
                    actionRow(
                        icon: "textformat",
                        title: l10n.string(forKey: "fonts_title"),
                        subtitle: "\(store.settings.khmerFont.displayName) & \(store.settings.englishFont.displayName)"
                    )
                }
            }
            .padding(.horizontal, 20)
        }
    }

    private func actionRow(icon: String, title: String, subtitle: String) -> some View {
        ThemedCard(cornerRadius: 14, padding: 14) {
            HStack(spacing: 14) {
                Image(systemName: icon)
                    .font(.system(size: typography.scaledSize(for: 18)))
                    .foregroundStyle(colors.primary)
                    .frame(width: 36, height: 36)
                    .background(colors.primary.opacity(0.12))
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))

                VStack(alignment: .leading, spacing: 2) {
                    ThemedText(title, style: .headline, weight: .semibold)
                    ThemedText(subtitle, style: .footnote, color: .secondary, lineLimit: 1)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: typography.scaledSize(for: 14), weight: .semibold))
                    .foregroundStyle(colors.tertiaryText)
            }
        }
    }
}
