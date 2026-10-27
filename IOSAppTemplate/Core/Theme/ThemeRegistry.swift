//
//  ThemeRegistry.swift
//  IOSAppTemplate
//
//  Created by Bunsan on 10/27/26.
//

import SwiftUI

/// Central registry providing theme color palettes.
public struct ThemeRegistry {
    /// Retrieve the color palette for a specified theme.
    public static func colors(for theme: AppTheme) -> ThemeColors {
        switch theme {
        case .cleanLight:
            return ThemeColors(
                background: Color(hex: 0xF8FAFC),
                surface: Color(hex: 0xFFFFFF),
                card: Color(hex: 0xF1F5F9),
                border: Color(hex: 0xE2E8F0),
                primary: Color(hex: 0x2563EB),
                secondary: Color(hex: 0x64748B),
                accent: Color(hex: 0x0284C7),
                tint: Color(hex: 0x3B82F6),
                primaryText: Color(hex: 0x0F172A),
                secondaryText: Color(hex: 0x475569),
                tertiaryText: Color(hex: 0x94A3B8)
            )

        case .obsidianDark:
            return ThemeColors(
                background: Color(hex: 0x0A0B0E),
                surface: Color(hex: 0x12141A),
                card: Color(hex: 0x181B22),
                border: Color(hex: 0x242833),
                primary: Color(hex: 0x66FCF1),
                secondary: Color(hex: 0x45A29E),
                accent: Color(hex: 0x45F3FF),
                tint: Color(hex: 0x66FCF1),
                primaryText: Color(hex: 0xFFFFFF),
                secondaryText: Color(hex: 0xC5C6C7),
                tertiaryText: Color(hex: 0x7E8694)
            )

        case .midnightNeon:
            return ThemeColors(
                background: Color(hex: 0x090D16),
                surface: Color(hex: 0x0E1424),
                card: Color(hex: 0x141C33),
                border: Color(hex: 0x222F54),
                primary: Color(hex: 0xFF007F),
                secondary: Color(hex: 0x7928CA),
                accent: Color(hex: 0x00F0FF),
                tint: Color(hex: 0xFF007F),
                primaryText: Color(hex: 0xF8FAFC),
                secondaryText: Color(hex: 0x94A3B8),
                tertiaryText: Color(hex: 0x64748B)
            )

        case .cyberpunkSynth:
            return ThemeColors(
                background: Color(hex: 0x0E0B1F),
                surface: Color(hex: 0x171233),
                card: Color(hex: 0x201A45),
                border: Color(hex: 0x3B2E75),
                primary: Color(hex: 0xFF2A85),
                secondary: Color(hex: 0x8A2BE2),
                accent: Color(hex: 0xFFE600),
                tint: Color(hex: 0xFF2A85),
                primaryText: Color(hex: 0xFFFFFF),
                secondaryText: Color(hex: 0xD8B4FE),
                tertiaryText: Color(hex: 0x9333EA)
            )

        case .emeraldForest:
            return ThemeColors(
                background: Color(hex: 0x06140D),
                surface: Color(hex: 0x0B2217),
                card: Color(hex: 0x113123),
                border: Color(hex: 0x1B4D37),
                primary: Color(hex: 0x10B981),
                secondary: Color(hex: 0x059669),
                accent: Color(hex: 0xF59E0B),
                tint: Color(hex: 0x10B981),
                primaryText: Color(hex: 0xECFDF5),
                secondaryText: Color(hex: 0xA7F3D0),
                tertiaryText: Color(hex: 0x6EE7B7)
            )

        case .sunsetCoral:
            return ThemeColors(
                background: Color(hex: 0xFFF7F5),
                surface: Color(hex: 0xFFFFFF),
                card: Color(hex: 0xFFEFEA),
                border: Color(hex: 0xFED7CC),
                primary: Color(hex: 0xFF5A43),
                secondary: Color(hex: 0xFB923C),
                accent: Color(hex: 0xEA580C),
                tint: Color(hex: 0xFF5A43),
                primaryText: Color(hex: 0x29150E),
                secondaryText: Color(hex: 0x7C402E),
                tertiaryText: Color(hex: 0xB57B6C)
            )

        case .lavenderMist:
            return ThemeColors(
                background: Color(hex: 0xF8F7FC),
                surface: Color(hex: 0xFFFFFF),
                card: Color(hex: 0xF0EDF9),
                border: Color(hex: 0xDDD6FE),
                primary: Color(hex: 0x8B5CF6),
                secondary: Color(hex: 0xA78BFA),
                accent: Color(hex: 0xC084FC),
                tint: Color(hex: 0x8B5CF6),
                primaryText: Color(hex: 0x1E1438),
                secondaryText: Color(hex: 0x5B4687),
                tertiaryText: Color(hex: 0x9B89BF)
            )

        case .pacificOcean:
            return ThemeColors(
                background: Color(hex: 0x051329),
                surface: Color(hex: 0x0A2042),
                card: Color(hex: 0x0E2C5A),
                border: Color(hex: 0x184482),
                primary: Color(hex: 0x0284C7),
                secondary: Color(hex: 0x0EA5E9),
                accent: Color(hex: 0x38BDF8),
                tint: Color(hex: 0x0284C7),
                primaryText: Color(hex: 0xF0F9FF),
                secondaryText: Color(hex: 0xBAE6FD),
                tertiaryText: Color(hex: 0x7DD3FC)
            )

        case .espressoLatte:
            return ThemeColors(
                background: Color(hex: 0x17120F),
                surface: Color(hex: 0x221B16),
                card: Color(hex: 0x2E251E),
                border: Color(hex: 0x483B31),
                primary: Color(hex: 0xD4A373),
                secondary: Color(hex: 0xBB8555),
                accent: Color(hex: 0xFAEDCD),
                tint: Color(hex: 0xD4A373),
                primaryText: Color(hex: 0xFEFAE0),
                secondaryText: Color(hex: 0xD4A373),
                tertiaryText: Color(hex: 0xA98467)
            )

        case .royalCrimson:
            return ThemeColors(
                background: Color(hex: 0x18050B),
                surface: Color(hex: 0x260A13),
                card: Color(hex: 0x340F1B),
                border: Color(hex: 0x54182B),
                primary: Color(hex: 0xE11D48),
                secondary: Color(hex: 0xBE123C),
                accent: Color(hex: 0xF59E0B),
                tint: Color(hex: 0xE11D48),
                primaryText: Color(hex: 0xFFF1F2),
                secondaryText: Color(hex: 0xFECDD3),
                tertiaryText: Color(hex: 0xFDA4AF)
            )
        }
    }
}
