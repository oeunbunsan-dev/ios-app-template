//
//  AppThemeModifier.swift
//  IOSAppTemplate
//
//  Created by Bunsan on 10/27/26.
//

import SwiftUI

public struct AppThemeModifier: ViewModifier {
    @Environment(\.themeColors) private var colors
    let themeColors: ThemeColors?
    let appearanceMode: AppearanceMode?

    public init(themeColors: ThemeColors? = nil, appearanceMode: AppearanceMode? = nil) {
        self.themeColors = themeColors
        self.appearanceMode = appearanceMode
    }

    public func body(content: Content) -> some View {
        let activeColors = themeColors ?? colors
        content
            .background(activeColors.background)
            .tint(activeColors.tint)
            .preferredColorScheme(appearanceMode?.colorScheme)
    }
}

extension View {
    public func applyAppTheme(
        themeColors: ThemeColors? = nil,
        appearanceMode: AppearanceMode? = nil
    ) -> some View {
        modifier(AppThemeModifier(themeColors: themeColors, appearanceMode: appearanceMode))
    }
}
