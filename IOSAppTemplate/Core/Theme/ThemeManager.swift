//
//  ThemeManager.swift
//  IOSAppTemplate
//
//  Created by Bunsan on 10/27/26.
//

import SwiftUI

/// Observable coordinator managing theme tokens and appearance changes.
@Observable
@MainActor
public final class ThemeManager {
    public var currentTheme: AppTheme {
        didSet {
            colors = ThemeRegistry.colors(for: currentTheme)
        }
    }
    public var appearanceMode: AppearanceMode
    public private(set) var colors: ThemeColors

    public init(theme: AppTheme = .cleanLight, appearanceMode: AppearanceMode = .system) {
        self.currentTheme = theme
        self.appearanceMode = appearanceMode
        self.colors = ThemeRegistry.colors(for: theme)
    }

    public func update(theme: AppTheme, appearanceMode: AppearanceMode) {
        self.currentTheme = theme
        self.appearanceMode = appearanceMode
        self.colors = ThemeRegistry.colors(for: theme)
    }
}

// MARK: - SwiftUI Environment Keys
private struct ThemeColorsKey: EnvironmentKey {
    static let defaultValue: ThemeColors = ThemeRegistry.colors(for: .cleanLight)
}

private struct AppThemeKey: EnvironmentKey {
    static let defaultValue: AppTheme = .cleanLight
}

extension EnvironmentValues {
    public var themeColors: ThemeColors {
        get { self[ThemeColorsKey.self] }
        set { self[ThemeColorsKey.self] = newValue }
    }

    public var appTheme: AppTheme {
        get { self[AppThemeKey.self] }
        set { self[AppThemeKey.self] = newValue }
    }
}
