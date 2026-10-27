//
//  SettingsStore.swift
//  IOSAppTemplate
//
//  Created by Bunsan on 10/27/26.
//

import SwiftUI

/// Central observable store managing global application state, settings propagation, and persistence.
@Observable
@MainActor
public final class SettingsStore {
    public static let shared = SettingsStore()

    public var settings: AppSettings {
        didSet {
            repository.saveSettings(settings)
            syncManagers()
        }
    }

    private let repository: SettingsRepositoryProtocol
    public let themeManager: ThemeManager
    public let localizationManager: LocalizationManager

    public convenience init() {
        self.init(
            repository: SettingsRepository(),
            themeManager: ThemeManager(),
            localizationManager: .shared
        )
    }

    public init(
        repository: SettingsRepositoryProtocol,
        themeManager: ThemeManager,
        localizationManager: LocalizationManager
    ) {
        self.repository = repository
        self.themeManager = themeManager
        self.localizationManager = localizationManager
        
        let initialSettings = repository.loadSettings()
        self.settings = initialSettings
        
        // Sync external managers immediately
        themeManager.update(theme: initialSettings.theme, appearanceMode: initialSettings.appearanceMode)
        localizationManager.currentLanguage = initialSettings.language
    }

    private func syncManagers() {
        themeManager.update(theme: settings.theme, appearanceMode: settings.appearanceMode)
        localizationManager.currentLanguage = settings.language
    }

    // MARK: - Mutating Actions

    public func updateTheme(_ theme: AppTheme) {
        settings.theme = theme
    }

    public func updateAppearanceMode(_ mode: AppearanceMode) {
        settings.appearanceMode = mode
    }

    public func updateKhmerFont(_ font: KhmerFont) {
        settings.khmerFont = font
    }

    public func updateEnglishFont(_ font: EnglishFont) {
        settings.englishFont = font
    }

    public func updateTypographyScale(_ scale: TypographyScale) {
        settings.typographyScale = scale
    }

    public func updateLanguage(_ language: AppLanguage) {
        settings.language = language
    }

    public func toggleHaptics() {
        settings.isHapticsEnabled.toggle()
    }

    public func toggleRespectDynamicType() {
        settings.respectsDynamicType.toggle()
    }

    public func resetToDefaults() {
        let defaults = repository.resetSettings()
        self.settings = defaults
    }

    // MARK: - Computed Properties for Views

    public var currentColors: ThemeColors {
        themeManager.colors
    }

    public var currentTypography: AppTypography {
        AppTypography(
            scale: settings.typographyScale,
            englishFont: settings.englishFont,
            khmerFont: settings.khmerFont
        )
    }
}

// MARK: - SwiftUI Environment Keys
private struct SettingsStoreKey: EnvironmentKey {
    static let defaultValue = SettingsStore.shared
}

extension EnvironmentValues {
    public var settingsStore: SettingsStore {
        get { self[SettingsStoreKey.self] }
        set { self[SettingsStoreKey.self] = newValue }
    }
}
