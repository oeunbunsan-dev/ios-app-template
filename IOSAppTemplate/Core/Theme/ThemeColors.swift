//
//  ThemeColors.swift
//  IOSAppTemplate
//
//  Created by Bunsan on 10/27/26.
//

import SwiftUI

/// Semantic palette containing all color tokens required by the design system.
public struct ThemeColors: Equatable {
    public let background: Color
    public let surface: Color
    public let card: Color
    public let border: Color
    
    public let primary: Color
    public let secondary: Color
    public let accent: Color
    public let tint: Color
    
    public let primaryText: Color
    public let secondaryText: Color
    public let tertiaryText: Color
    
    public let success: Color
    public let warning: Color
    public let error: Color

    public init(
        background: Color,
        surface: Color,
        card: Color,
        border: Color,
        primary: Color,
        secondary: Color,
        accent: Color,
        tint: Color,
        primaryText: Color,
        secondaryText: Color,
        tertiaryText: Color,
        success: Color = Color(hex: 0x10B981),
        warning: Color = Color(hex: 0xF59E0B),
        error: Color = Color(hex: 0xEF4444)
    ) {
        self.background = background
        self.surface = surface
        self.card = card
        self.border = border
        self.primary = primary
        self.secondary = secondary
        self.accent = accent
        self.tint = tint
        self.primaryText = primaryText
        self.secondaryText = secondaryText
        self.tertiaryText = tertiaryText
        self.success = success
        self.warning = warning
        self.error = error
    }
}

// MARK: - Color Hex Initializer
extension Color {
    /// Initialize a SwiftUI Color from a 24-bit RGB integer (e.g. 0xFF5733) or 32-bit RGBA.
    public init(hex: UInt32, alpha: Double = 1.0) {
        let red = Double((hex >> 16) & 0xFF) / 255.0
        let green = Double((hex >> 8) & 0xFF) / 255.0
        let blue = Double(hex & 0xFF) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: alpha)
    }

    /// Initialize a SwiftUI Color from a hex string (e.g. "#66FCF1" or "66FCF1").
    public init(hexString: String, alpha: Double = 1.0) {
        let cleaned = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: cleaned).scanHexInt64(&int)
        let r, g, b: Double
        switch cleaned.count {
        case 3: // RGB (12-bit)
            r = Double((int >> 8) * 17) / 255.0
            g = Double((int >> 4 & 0xF) * 17) / 255.0
            b = Double((int & 0xF) * 17) / 255.0
        case 6: // RGB (24-bit)
            r = Double((int >> 16) & 0xFF) / 255.0
            g = Double((int >> 8) & 0xFF) / 255.0
            b = Double(int & 0xFF) / 255.0
        default:
            r = 0; g = 0; b = 0
        }
        self.init(.sRGB, red: r, green: g, blue: b, opacity: alpha)
    }
}
