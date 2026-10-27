//
//  AppBootstrap.swift
//  IOSAppTemplate
//
//  Created by Bunsan on 10/27/26.
//

import SwiftUI

/// Startup bootstrapper that configures fonts, services, and defaults before view rendering.
public final class AppBootstrap {
    public static let shared = AppBootstrap()

    private init() {}

    public func configure() {
        // Register all bundled Google Khmer and English custom fonts
        FontRegistry.shared.registerCustomFonts()

        // Configure system appearance defaults
        configureNavigationBarAppearance()
    }

    private func configureNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.label
        ]
        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor.label
        ]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
