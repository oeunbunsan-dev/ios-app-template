//
//  IOSAppTemplateApp.swift
//  IOSAppTemplate
//
//  Created by Bunsan on 10/27/26.
//

import SwiftUI

@main
struct IOSAppTemplateApp: App {
    @State private var settingsStore = SettingsStore.shared

    init() {
        AppBootstrap.shared.configure()
    }

    var body: some Scene {
        WindowGroup {
            AppTabView()
                .environment(settingsStore)
                .environment(\.settingsStore, settingsStore)
                .environment(\.themeColors, settingsStore.currentColors)
                .environment(\.appTheme, settingsStore.settings.theme)
                .environment(\.appTypography, settingsStore.currentTypography)
                .environment(\.localizationManager, settingsStore.localizationManager)
                .environment(\.locale, settingsStore.settings.language.locale)
                .preferredColorScheme(settingsStore.settings.appearanceMode.colorScheme)
                .applyAppTheme(
                    themeColors: settingsStore.currentColors,
                    appearanceMode: settingsStore.settings.appearanceMode
                )
        }
    }
}
