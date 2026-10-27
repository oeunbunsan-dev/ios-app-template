//
//  SettingsStoreTests.swift
//  IOSAppTemplate
//
//  Created by Bunsan on 10/27/26.
//

import XCTest
@testable import IOSAppTemplate

final class MockSettingsRepository: SettingsRepositoryProtocol {
    var storedSettings: AppSettings?

    func loadSettings() -> AppSettings {
        return storedSettings ?? .default
    }

    func saveSettings(_ settings: AppSettings) {
        storedSettings = settings
    }

    func resetSettings() -> AppSettings {
        storedSettings = .default
        return .default
    }
}

@MainActor
final class SettingsStoreTests: XCTestCase {
    func testDefaultSettings() {
        let mockRepo = MockSettingsRepository()
        let store = SettingsStore(repository: mockRepo)

        XCTAssertEqual(store.settings.language, .english)
        XCTAssertEqual(store.settings.khmerFont, .battambang)
        XCTAssertEqual(store.settings.englishFont, .inter)
        XCTAssertEqual(store.settings.theme, .cleanLight)
        XCTAssertEqual(store.settings.typographyScale, .normal)
        XCTAssertEqual(store.settings.appearanceMode, .system)
    }

    func testThemeUpdateAndPersistence() {
        let mockRepo = MockSettingsRepository()
        let store = SettingsStore(repository: mockRepo)

        store.updateTheme(.cyberpunkSynth)

        XCTAssertEqual(store.settings.theme, .cyberpunkSynth)
        XCTAssertEqual(mockRepo.storedSettings?.theme, .cyberpunkSynth)
        XCTAssertEqual(store.themeManager.currentTheme, .cyberpunkSynth)
    }

    func testFontUpdateAndPersistence() {
        let mockRepo = MockSettingsRepository()
        let store = SettingsStore(repository: mockRepo)

        store.updateKhmerFont(.koulen)
        store.updateEnglishFont(.poppins)

        XCTAssertEqual(store.settings.khmerFont, .koulen)
        XCTAssertEqual(store.settings.englishFont, .poppins)
        XCTAssertEqual(mockRepo.storedSettings?.khmerFont, .koulen)
        XCTAssertEqual(mockRepo.storedSettings?.englishFont, .poppins)
    }

    func testResetToDefaults() {
        let mockRepo = MockSettingsRepository()
        let store = SettingsStore(repository: mockRepo)

        store.updateTheme(.royalCrimson)
        store.updateLanguage(.khmer)
        store.updateTypographyScale(.extraLarge)

        XCTAssertEqual(store.settings.theme, .royalCrimson)

        store.resetToDefaults()

        XCTAssertEqual(store.settings.theme, .cleanLight)
        XCTAssertEqual(store.settings.language, .english)
        XCTAssertEqual(store.settings.typographyScale, .normal)
    }
}
