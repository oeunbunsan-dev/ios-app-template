//
//  AppTabView.swift
//  IOSAppTemplate
//
//  Created by Bunsan on 10/27/26.
//

import SwiftUI

/// Main application tab navigation coordinator.
public struct AppTabView: View {
    @Environment(\.themeColors) private var colors
    @Environment(\.localizationManager) private var l10n
    @State private var selectedTab: Int = 0

    public init() {}

    public var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                HomeView()
            }
            .tabItem {
                Label(
                    l10n.string(forKey: "tab_home"),
                    systemImage: selectedTab == 0 ? "house.fill" : "house"
                )
            }
            .tag(0)

            NavigationStack {
                TypographyPlaygroundView()
            }
            .tabItem {
                Label(
                    l10n.string(forKey: "tab_playground"),
                    systemImage: selectedTab == 1 ? "slider.horizontal.3" : "slider.horizontal.below.rectangle"
                )
            }
            .tag(1)

            NavigationStack {
                SettingsView()
            }
            .tabItem {
                Label(
                    l10n.string(forKey: "tab_settings"),
                    systemImage: selectedTab == 2 ? "gearshape.fill" : "gearshape"
                )
            }
            .tag(2)
        }
        .tint(colors.primary)
    }
}
