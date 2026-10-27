//
//  ThemeRegistryTests.swift
//  IOSAppTemplate
//
//  Created by Bunsan on 10/27/26.
//

import XCTest
import SwiftUI
@testable import IOSAppTemplate

final class ThemeRegistryTests: XCTestCase {
    func testAllTenThemesPresent() {
        XCTAssertEqual(AppTheme.allCases.count, 10)
        let expectedThemes: Set<AppTheme> = [
            .cleanLight,
            .obsidianDark,
            .midnightNeon,
            .cyberpunkSynth,
            .emeraldForest,
            .sunsetCoral,
            .lavenderMist,
            .pacificOcean,
            .espressoLatte,
            .royalCrimson
        ]
        XCTAssertEqual(Set(AppTheme.allCases), expectedThemes)
    }

    func testDistinctPalettesForEachTheme() {
        var observedPalettes = [ThemeColors]()

        for theme in AppTheme.allCases {
            let colors = ThemeRegistry.colors(for: theme)
            XCTAssertFalse(theme.displayName.isEmpty)
            XCTAssertFalse(theme.description.isEmpty)

            // Ensure no duplicate identical palettes are returned
            XCTAssertFalse(observedPalettes.contains(colors), "Theme \(theme) shares an identical palette with another theme")
            observedPalettes.append(colors)
        }
    }
}
