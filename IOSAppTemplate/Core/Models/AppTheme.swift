//
//  AppTheme.swift
//  IOSAppTemplate
//
//  Created by Bunsan on 10/27/26.
//

import SwiftUI

/// The ten handcrafted app themes supported by the design system.
public enum AppTheme: String, CaseIterable, Identifiable, Codable {
    case cleanLight
    case obsidianDark
    case midnightNeon
    case cyberpunkSynth
    case emeraldForest
    case sunsetCoral
    case lavenderMist
    case pacificOcean
    case espressoLatte
    case royalCrimson

    public var id: String { rawValue }

    /// Localized display name for the theme.
    public var displayName: String {
        switch self {
        case .cleanLight:
            return "Clean Light"
        case .obsidianDark:
            return "Obsidian Dark"
        case .midnightNeon:
            return "Midnight Neon"
        case .cyberpunkSynth:
            return "Cyberpunk Synth"
        case .emeraldForest:
            return "Emerald Forest"
        case .sunsetCoral:
            return "Sunset Coral"
        case .lavenderMist:
            return "Lavender Mist"
        case .pacificOcean:
            return "Pacific Ocean"
        case .espressoLatte:
            return "Espresso Latte"
        case .royalCrimson:
            return "Royal Crimson"
        }
    }

    /// Short thematic description.
    public var description: String {
        switch self {
        case .cleanLight:
            return "Crisp minimal light interface with subtle slate borders and sapphire blue accents."
        case .obsidianDark:
            return "Deep pitch obsidian backgrounds with electric cyan highlights and high contrast."
        case .midnightNeon:
            return "Ultra-dark midnight blue atmosphere infused with vibrant hot magenta and neon cyan."
        case .cyberpunkSynth:
            return "Retro-futuristic synthwave aesthetic featuring vivid electric purple and yellow accents."
        case .emeraldForest:
            return "Natural deep pine and moss tones highlighted with lush emerald and warm gold."
        case .sunsetCoral:
            return "Warm golden hour peach and coral shades inspired by tropical sunsets."
        case .lavenderMist:
            return "Soft ethereal lilac and pastel purple tones creating a soothing calm ambiance."
        case .pacificOcean:
            return "Submerged deep oceanic navy paired with clear azure waves and aquamarine."
        case .espressoLatte:
            return "Earthy artisanal roasted coffee bean browns paired with creamy warm latte hues."
        case .royalCrimson:
            return "Regal imperial dark garnet palette accented with rich velvet crimson and gold."
        }
    }

    /// Whether this theme is predominantly dark or light by default.
    public var isDarkTheme: Bool {
        switch self {
        case .cleanLight, .sunsetCoral, .lavenderMist:
            return false
        default:
            return true
        }
    }
}

/// Appearance mode preferences (System, Light, Dark).
public enum AppearanceMode: String, CaseIterable, Identifiable, Codable {
    case system
    case light
    case dark

    public var id: String { rawValue }

    public var displayName: String {
        switch self {
        case .system:
            return "System"
        case .light:
            return "Light"
        case .dark:
            return "Dark"
        }
    }

    public var colorScheme: ColorScheme? {
        switch self {
        case .system:
            return nil
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}
