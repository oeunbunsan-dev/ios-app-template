//
//  ContentView.swift
//  IOSAppTemplate
//
//  Created by Bunsan on 10/27/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        AppTabView()
    }
}

#Preview {
    ContentView()
        .environment(SettingsStore.shared)
        .environment(\.settingsStore, SettingsStore.shared)
        .environment(\.themeColors, ThemeRegistry.colors(for: .cleanLight))
        .environment(\.appTypography, AppTypography())
        .environment(\.localizationManager, LocalizationManager.shared)
}
