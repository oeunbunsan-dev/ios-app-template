//
//  FontOption.swift
//  IOSAppTemplate
//
//  Created by Bunsan on 10/27/26.
//

import SwiftUI

/// Supported script types in the application.
public enum ScriptType: String, CaseIterable, Identifiable, Codable {
    case khmer
    case english

    public var id: String { rawValue }

    public var displayName: String {
        switch self {
        case .khmer: return "Khmer (ភាសាខ្មែរ)"
        case .english: return "English"
        }
    }
}

/// The 10 Google Khmer fonts.
public enum KhmerFont: String, CaseIterable, Identifiable, Codable {
    case battambang
    case bayon
    case bokor
    case dangrek
    case fasthand
    case hanuman
    case kantumruyPro
    case koulen
    case moul
    case siemreap

    public var id: String { rawValue }

    public var displayName: String {
        switch self {
        case .battambang: return "Battambang"
        case .bayon: return "Bayon"
        case .bokor: return "Bokor"
        case .dangrek: return "Dangrek"
        case .fasthand: return "Fasthand"
        case .hanuman: return "Hanuman"
        case .kantumruyPro: return "Kantumruy Pro"
        case .koulen: return "Koulen"
        case .moul: return "Moul"
        case .siemreap: return "Siemreap"
        }
    }

    /// Sample Khmer phrase demonstrating character combinations.
    public var sampleText: String {
        switch self {
        case .battambang:
            return "សូមស្វាគមន៍មកកាន់កម្ពុជា"
        case .bayon:
            return "ប្រាសាទបាយ័ន និងអង្គរវត្ត"
        case .bokor:
            return "ភ្នំបូកគោ ខេត្តកំពត"
        case .dangrek:
            return "ជួរភ្នំដងរែក ព្រំដែនធម្មជាតិ"
        case .fasthand:
            return "អក្សរឆ្លាក់បែបសិល្បៈទាន់សម័យ"
        case .hanuman:
            return "រឿងរាមកេរ្តិ៍ខ្មែរបុរាណ"
        case .kantumruyPro:
            return "កន្ទុំរុយ ប្រូ ពុម្ពទំនើប"
        case .koulen:
            return "ឧទ្យានជាតិភ្នំគូលែន"
        case .moul:
            return "អក្សរមូលបែបបុរាណខ្មែរ"
        case .siemreap:
            return "ខេត្តសៀមរាបទឹកដីអង្គរ"
        }
    }

    /// Primary PostScript font name registered with iOS.
    public var regularPostScriptName: String {
        switch self {
        case .battambang: return "Battambang-Regular"
        case .bayon: return "Bayon-Regular"
        case .bokor: return "Bokor-Regular"
        case .dangrek: return "Dangrek-Regular"
        case .fasthand: return "Fasthand-Regular"
        case .hanuman: return "Hanuman-Regular"
        case .kantumruyPro: return "KantumruyPro-Regular"
        case .koulen: return "Koulen-Regular"
        case .moul: return "Moul-Regular"
        case .siemreap: return "Siemreap"
        }
    }

    /// Bold PostScript name when available, else fallback to regular.
    public var boldPostScriptName: String {
        switch self {
        case .battambang: return "Battambang-Bold"
        default: return regularPostScriptName
        }
    }
}

/// The 10 Google English fonts.
public enum EnglishFont: String, CaseIterable, Identifiable, Codable {
    case inter
    case roboto
    case poppins
    case montserrat
    case openSans
    case lato
    case raleway
    case nunito
    case oswald
    case playfairDisplay

    public var id: String { rawValue }

    public var displayName: String {
        switch self {
        case .inter: return "Inter"
        case .roboto: return "Roboto"
        case .poppins: return "Poppins"
        case .montserrat: return "Montserrat"
        case .openSans: return "Open Sans"
        case .lato: return "Lato"
        case .raleway: return "Raleway"
        case .nunito: return "Nunito"
        case .oswald: return "Oswald"
        case .playfairDisplay: return "Playfair Display"
        }
    }

    public var sampleText: String {
        return "The quick brown fox jumps over the lazy dog."
    }

    /// Primary PostScript font name registered with iOS.
    public var regularPostScriptName: String {
        switch self {
        case .inter: return "Inter-Regular"
        case .roboto: return "Roboto-Regular"
        case .poppins: return "Poppins-Regular"
        case .montserrat: return "Montserrat-Thin"
        case .openSans: return "OpenSans-Regular"
        case .lato: return "Lato-Regular"
        case .raleway: return "Raleway-Thin"
        case .nunito: return "Nunito-ExtraLight"
        case .oswald: return "Oswald-Regular"
        case .playfairDisplay: return "PlayfairDisplay-Regular"
        }
    }

    /// Medium PostScript name when available.
    public var mediumPostScriptName: String {
        switch self {
        case .poppins: return "Poppins-Medium"
        default: return regularPostScriptName
        }
    }

    /// Semibold PostScript name when available.
    public var semiboldPostScriptName: String {
        switch self {
        case .poppins: return "Poppins-SemiBold"
        default: return regularPostScriptName
        }
    }

    /// Bold PostScript name when available.
    public var boldPostScriptName: String {
        switch self {
        case .poppins: return "Poppins-Bold"
        case .lato: return "Lato-Bold"
        default: return regularPostScriptName
        }
    }
}

/// The 5 preset typography scaling levels.
public enum TypographyScale: Double, CaseIterable, Identifiable, Codable {
    case small = 0.85
    case normal = 1.00
    case medium = 1.15
    case large = 1.30
    case extraLarge = 1.45

    public var id: Double { rawValue }

    public var displayName: String {
        switch self {
        case .small: return "Small"
        case .normal: return "Normal"
        case .medium: return "Medium"
        case .large: return "Large"
        case .extraLarge: return "Extra Large"
        }
    }

    public var percentageString: String {
        "\(Int(rawValue * 100))%"
    }

    public var displayTitle: String {
        "\(displayName) (\(percentageString))"
    }
}

/// Font weight options for interactive playground controls.
public enum AppFontWeight: String, CaseIterable, Identifiable, Codable {
    case regular
    case medium
    case semibold
    case bold

    public var id: String { rawValue }

    public var displayName: String {
        switch self {
        case .regular: return "Regular"
        case .medium: return "Medium"
        case .semibold: return "SemiBold"
        case .bold: return "Bold"
        }
    }

    public var swiftUIWeight: Font.Weight {
        switch self {
        case .regular: return .regular
        case .medium: return .medium
        case .semibold: return .semibold
        case .bold: return .bold
        }
    }
}
