//
//  AppLanguage.swift
//  IOSAppTemplate
//
//  Created by Bunsan on 10/27/26.
//

import Foundation

/// Supported languages across the application.
public enum AppLanguage: String, CaseIterable, Identifiable, Codable {
    case english = "en"
    case khmer = "km"
    case chinese = "zh"

    public var id: String { rawValue }

    /// Native name used in language selection interfaces.
    public var nativeName: String {
        switch self {
        case .english:
            return "English"
        case .khmer:
            return "ភាសាខ្មែរ"
        case .chinese:
            return "中文"
        }
    }

    /// English display name.
    public var englishName: String {
        switch self {
        case .english:
            return "English"
        case .khmer:
            return "Khmer"
        case .chinese:
            return "Simplified Chinese"
        }
    }

    /// Standard Apple locale identifier.
    public var localeIdentifier: String {
        switch self {
        case .english:
            return "en_US"
        case .khmer:
            return "km_KH"
        case .chinese:
            return "zh_CN"
        }
    }

    /// Foundation `Locale` instance.
    public var locale: Locale {
        Locale(identifier: localeIdentifier)
    }

    /// Regional flag emoji.
    public var flagEmoji: String {
        switch self {
        case .english:
            return "🇬🇧"
        case .khmer:
            return "🇰🇭"
        case .chinese:
            return "🇨🇳"
        }
    }

    /// Sample multilingual text for preview cards.
    public var sampleWelcomeText: String {
        switch self {
        case .english:
            return "Welcome to your app."
        case .khmer:
            return "សូមស្វាគមន៍មកកាន់កម្មវិធីរបស់អ្នក"
        case .chinese:
            return "欢迎使用您的应用"
        }
    }
}
