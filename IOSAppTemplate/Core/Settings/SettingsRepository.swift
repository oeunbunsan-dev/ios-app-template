//
//  SettingsRepository.swift
//  IOSAppTemplate
//
//  Created by Bunsan on 10/27/26.
//

import Foundation

/// Protocol defining settings persistence operations.
@MainActor
public protocol SettingsRepositoryProtocol {
    func loadSettings() -> AppSettings
    func saveSettings(_ settings: AppSettings)
    func resetSettings() -> AppSettings
}

/// Standard UserDefaults-backed persistence repository.
@MainActor
public final class SettingsRepository: SettingsRepositoryProtocol {
    private let userDefaults: UserDefaults
    private let storageKey = "com.bunsan.iosapptemplate.appsettings"

    public init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    public func loadSettings() -> AppSettings {
        guard let data = userDefaults.data(forKey: storageKey) else {
            return .default
        }
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(AppSettings.self, from: data)
        } catch {
            print("[SettingsRepository] Error decoding persisted settings: \(error). Falling back to defaults.")
            return .default
        }
    }

    public func saveSettings(_ settings: AppSettings) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(settings)
            userDefaults.set(data, forKey: storageKey)
        } catch {
            print("[SettingsRepository] Error encoding settings: \(error)")
        }
    }

    public func resetSettings() -> AppSettings {
        userDefaults.removeObject(forKey: storageKey)
        return .default
    }
}
