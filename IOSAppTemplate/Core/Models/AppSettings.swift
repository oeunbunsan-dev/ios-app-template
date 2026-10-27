//
//  AppSettings.swift
//  IOSAppTemplate
//
//  Created by Bunsan on 10/27/26.
//

import Foundation

/// Persistent user configuration for the application.
public struct AppSettings: Codable, Equatable {
    /// Selected app language.
    public var language: AppLanguage
    
    /// Selected Khmer font family.
    public var khmerFont: KhmerFont
    
    /// Selected English font family.
    public var englishFont: EnglishFont
    
    /// Selected visual theme.
    public var theme: AppTheme
    
    /// Preferred appearance mode (System, Light, Dark).
    public var appearanceMode: AppearanceMode
    
    /// Global typography sizing scale preset.
    public var typographyScale: TypographyScale
    
    /// Feedback haptics toggle.
    public var isHapticsEnabled: Bool
    
    /// Dynamic Type system coupling.
    public var respectsDynamicType: Bool

    /// Default application settings according to requirements.
    public static let `default` = AppSettings(
        language: .english,
        khmerFont: .battambang,
        englishFont: .inter,
        theme: .cleanLight,
        appearanceMode: .system,
        typographyScale: .normal,
        isHapticsEnabled: true,
        respectsDynamicType: true
    )

    public init(
        language: AppLanguage = .english,
        khmerFont: KhmerFont = .battambang,
        englishFont: EnglishFont = .inter,
        theme: AppTheme = .cleanLight,
        appearanceMode: AppearanceMode = .system,
        typographyScale: TypographyScale = .normal,
        isHapticsEnabled: Bool = true,
        respectsDynamicType: Bool = true
    ) {
        self.language = language
        self.khmerFont = khmerFont
        self.englishFont = englishFont
        self.theme = theme
        self.appearanceMode = appearanceMode
        self.typographyScale = typographyScale
        self.isHapticsEnabled = isHapticsEnabled
        self.respectsDynamicType = respectsDynamicType
    }
}
