//
//  TypographyPlaygroundView.swift
//  IOSAppTemplate
//
//  Created by Bunsan on 10/27/26.
//

import SwiftUI

/// Dedicated typography playground for testing scripts, fonts, sizes, weights, line spacing, and letter spacing.
public struct TypographyPlaygroundView: View {
    @Environment(\.settingsStore) private var store
    @Environment(\.themeColors) private var colors
    @Environment(\.appTypography) private var typography
    @Environment(\.localizationManager) private var l10n

    // Playground local states (isolated from global persistent settings unless applied)
    @State private var selectedScript: ScriptType = .english
    @State private var previewKhmerFont: KhmerFont = .battambang
    @State private var previewEnglishFont: EnglishFont = .inter
    @State private var previewTheme: AppTheme = .cleanLight
    @State private var fontSize: CGFloat = 20
    @State private var selectedWeight: AppFontWeight = .regular
    @State private var lineSpacing: CGFloat = 4
    @State private var letterSpacing: CGFloat = 0
    @State private var customText: String = ""

    public init() {}

    public var body: some View {
        let playgroundColors = ThemeRegistry.colors(for: previewTheme)

        ThemedView {
            ScrollView {
                VStack(spacing: 20) {
                    AppHeader(
                        title: l10n.string(forKey: "playground_title"),
                        subtitle: l10n.string(forKey: "playground_subtitle"),
                        showsBackButton: false
                    )

                    // Live Interactive Canvas Card
                    liveCanvasCard(colors: playgroundColors)

                    // Playground Controls
                    controlsCard(colors: playgroundColors)

                    // Action Buttons (Apply to Global Settings & Reset)
                    actionButtons
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 32)
            }
        }
        .onAppear {
            // Initialize with current global settings
            previewKhmerFont = store.settings.khmerFont
            previewEnglishFont = store.settings.englishFont
            previewTheme = store.settings.theme
            fontSize = round(20 * CGFloat(store.settings.typographyScale.rawValue))
        }
    }

    // MARK: - Live Canvas Card
    private func liveCanvasCard(colors: ThemeColors) -> some View {
        ThemedCard(cornerRadius: 18, padding: 20) {
            VStack(alignment: .leading, spacing: 14) {
                HStack {
                    HStack(spacing: 6) {
                        Image(systemName: "sparkles")
                            .foregroundStyle(colors.accent)
                        ThemedText(
                            l10n.string(forKey: "playground_card_title").uppercased(),
                            style: .caption,
                            weight: .bold,
                            color: .accent
                        )
                    }

                    Spacer()

                    ThemedText(
                        "\(Int(fontSize))pt • \(selectedWeight.displayName)",
                        style: .caption,
                        color: .secondary
                    )
                }

                // Render active script preview or custom text
                let activeText: String = {
                    if !customText.trimmingCharacters(in: .whitespaces).isEmpty {
                        return customText
                    }
                    switch selectedScript {
                    case .english:
                        return "Welcome to your app."
                    case .khmer:
                        return "សូមស្វាគមន៍មកកាន់កម្មវិធីរបស់អ្នក"
                    }
                }()

                let renderedFont: Font = {
                    if selectedScript == .khmer || FontRegistry.containsKhmerCharacters(activeText) {
                        let ps = FontRegistry.postScriptName(for: previewKhmerFont, weight: selectedWeight.swiftUIWeight)
                        return FontRegistry.customFont(name: ps, size: fontSize, weight: selectedWeight.swiftUIWeight)
                    } else if FontRegistry.containsChineseCharacters(activeText) {
                        return Font.system(size: fontSize, weight: selectedWeight.swiftUIWeight)
                    } else {
                        let ps = FontRegistry.postScriptName(for: previewEnglishFont, weight: selectedWeight.swiftUIWeight)
                        return FontRegistry.customFont(name: ps, size: fontSize, weight: selectedWeight.swiftUIWeight)
                    }
                }()

                Text(activeText)
                    .font(renderedFont)
                    .foregroundStyle(colors.primaryText)
                    .lineSpacing(lineSpacing)
                    .tracking(letterSpacing)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(16)
                    .background(colors.background)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .stroke(colors.border, lineWidth: 1)
                    )

                // Multilingual comparison strip
                VStack(alignment: .leading, spacing: 8) {
                    ThemedText("MULTILINGUAL COMPARISON", style: .caption, weight: .bold, color: .tertiary)

                    Text("English: Welcome to your app.")
                        .font(FontRegistry.customFont(name: previewEnglishFont.regularPostScriptName, size: 15))
                        .foregroundStyle(colors.secondaryText)

                    Text("Khmer: សូមស្វាគមន៍មកកាន់កម្មវិធីរបស់អ្នក")
                        .font(FontRegistry.customFont(name: previewKhmerFont.regularPostScriptName, size: 15))
                        .foregroundStyle(colors.secondaryText)

                    Text("Chinese: 欢迎使用您的应用")
                        .font(.system(size: 15))
                        .foregroundStyle(colors.secondaryText)
                }
                .padding(.top, 4)
            }
        }
    }

    // MARK: - Controls Card
    private func controlsCard(colors: ThemeColors) -> some View {
        ThemedCard(cornerRadius: 18, padding: 18) {
            VStack(alignment: .leading, spacing: 18) {
                ThemedText(
                    l10n.string(forKey: "playground_controls").uppercased(),
                    style: .caption,
                    weight: .bold,
                    color: .secondary
                )

                // Custom Text Input
                VStack(alignment: .leading, spacing: 6) {
                    ThemedText(l10n.string(forKey: "playground_custom_text"), style: .footnote, color: .secondary)

                    TextField("Type custom text here...", text: $customText)
                        .padding(12)
                        .background(colors.background)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .stroke(colors.border, lineWidth: 1)
                        )
                }

                // Script Selection
                VStack(alignment: .leading, spacing: 6) {
                    ThemedText("Script Switcher", style: .footnote, color: .secondary)

                    Picker("Script", selection: $selectedScript) {
                        Text("English").tag(ScriptType.english)
                        Text("Khmer (ភាសាខ្មែរ)").tag(ScriptType.khmer)
                    }
                    .pickerStyle(.segmented)
                }

                // Khmer Font Picker
                VStack(alignment: .leading, spacing: 6) {
                    ThemedText("Khmer Font Family", style: .footnote, color: .secondary)

                    Picker("Khmer Font", selection: $previewKhmerFont) {
                        ForEach(KhmerFont.allCases) { font in
                            Text(font.displayName).tag(font)
                        }
                    }
                    .pickerStyle(.menu)
                    .tint(colors.primary)
                }

                // English Font Picker
                VStack(alignment: .leading, spacing: 6) {
                    ThemedText("English Font Family", style: .footnote, color: .secondary)

                    Picker("English Font", selection: $previewEnglishFont) {
                        ForEach(EnglishFont.allCases) { font in
                            Text(font.displayName).tag(font)
                        }
                    }
                    .pickerStyle(.menu)
                    .tint(colors.primary)
                }

                // Theme In Playground
                VStack(alignment: .leading, spacing: 6) {
                    ThemedText("Preview Theme", style: .footnote, color: .secondary)

                    Picker("Preview Theme", selection: $previewTheme) {
                        ForEach(AppTheme.allCases) { theme in
                            Text(theme.displayName).tag(theme)
                        }
                    }
                    .pickerStyle(.menu)
                    .tint(colors.primary)
                }

                // Font Weight Selector
                VStack(alignment: .leading, spacing: 6) {
                    ThemedText(l10n.string(forKey: "playground_font_weight"), style: .footnote, color: .secondary)

                    Picker("Weight", selection: $selectedWeight) {
                        ForEach(AppFontWeight.allCases) { w in
                            Text(w.displayName).tag(w)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                // Font Size Slider
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        ThemedText("Font Size: \(Int(fontSize))pt", style: .footnote, color: .secondary)
                        Spacer()
                    }

                    Slider(value: $fontSize, in: 12...42, step: 1)
                        .tint(colors.primary)
                }

                // Line Spacing Slider
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        ThemedText("\(l10n.string(forKey: "playground_line_spacing")): \(Int(lineSpacing))pt", style: .footnote, color: .secondary)
                        Spacer()
                    }

                    Slider(value: $lineSpacing, in: 0...24, step: 1)
                        .tint(colors.accent)
                }

                // Letter Spacing Slider
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        ThemedText("\(l10n.string(forKey: "playground_letter_spacing")): \(String(format: "%.1f", letterSpacing))pt", style: .footnote, color: .secondary)
                        Spacer()
                    }

                    Slider(value: $letterSpacing, in: -1...8, step: 0.5)
                        .tint(colors.warning)
                }
            }
        }
    }

    // MARK: - Action Buttons
    private var actionButtons: some View {
        VStack(spacing: 12) {
            ThemedButton(
                "Apply Font & Theme to App",
                icon: "checkmark.circle",
                variant: .primary
            ) {
                withAnimation(.easeInOut(duration: 0.2)) {
                    store.updateKhmerFont(previewKhmerFont)
                    store.updateEnglishFont(previewEnglishFont)
                    store.updateTheme(previewTheme)
                }
            }

            ThemedButton(
                l10n.string(forKey: "playground_reset_preview"),
                icon: "arrow.counterclockwise",
                variant: .secondary
            ) {
                withAnimation(.easeInOut(duration: 0.2)) {
                    previewKhmerFont = store.settings.khmerFont
                    previewEnglishFont = store.settings.englishFont
                    previewTheme = store.settings.theme
                    fontSize = round(20 * CGFloat(store.settings.typographyScale.rawValue))
                    selectedWeight = .regular
                    lineSpacing = 4
                    letterSpacing = 0
                    customText = ""
                }
            }
        }
    }
}
