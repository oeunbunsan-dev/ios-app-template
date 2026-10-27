//
//  FontRegistry.swift
//  IOSAppTemplate
//
//  Created by Bunsan on 10/27/26.
//

import SwiftUI
import CoreText

/// Centralized registry managing font registration, PostScript mapping, and safe fallback resolution.
public final class FontRegistry {
    public static let shared = FontRegistry()

    private var registeredFontNames = Set<String>()
    private var isInitialized = false

    private init() {}

    /// Registers bundled font files with CoreText.
    public func registerCustomFonts() {
        guard !isInitialized else { return }
        isInitialized = true

        let fontExtensions = ["ttf", "otf"]
        for ext in fontExtensions {
            if let urls = Bundle.main.urls(forResourcesWithExtension: ext, subdirectory: nil) {
                for url in urls {
                    registerFont(at: url)
                }
            }
        }
    }

    private func registerFont(at url: URL) {
        var errorRef: Unmanaged<CFError>?
        if CTFontManagerRegisterFontsForURL(url as CFURL, .process, &errorRef) {
            registeredFontNames.insert(url.lastPathComponent)
        } else if let error = errorRef?.takeRetainedValue() {
            let desc = CFErrorCopyDescription(error) as String? ?? "Unknown error"
            // Ignore error code 105 (already registered by Info.plist)
            let code = CFErrorGetCode(error)
            if code != 105 {
                print("[FontRegistry] Note registering \(url.lastPathComponent): \(desc)")
            }
            registeredFontNames.insert(url.lastPathComponent)
        }
    }

    // MARK: - PostScript Name Resolution

    /// Resolves the PostScript name for a Khmer font.
    public static func postScriptName(for khmerFont: KhmerFont, weight: Font.Weight = .regular) -> String {
        switch weight {
        case .bold, .heavy, .black:
            return khmerFont.boldPostScriptName
        default:
            return khmerFont.regularPostScriptName
        }
    }

    /// Resolves the PostScript name for an English font.
    public static func postScriptName(for englishFont: EnglishFont, weight: Font.Weight = .regular) -> String {
        switch weight {
        case .medium:
            return englishFont.mediumPostScriptName
        case .semibold:
            return englishFont.semiboldPostScriptName
        case .bold, .heavy, .black:
            return englishFont.boldPostScriptName
        default:
            return englishFont.regularPostScriptName
        }
    }

    // MARK: - SwiftUI Font Builder

    /// Builds a custom SwiftUI `Font` with verified PostScript name and safe system fallback.
    public static func customFont(
        name: String,
        size: CGFloat,
        weight: Font.Weight = .regular,
        relativeTo textStyle: Font.TextStyle = .body
    ) -> Font {
        // Test if UIFont can instantiate this name
        if UIFont(name: name, size: size) != nil {
            return Font.custom(name, size: size, relativeTo: textStyle).weight(weight)
        } else {
            // Fallback to system font with the intended weight and design
            return Font.system(size: size, weight: weight, design: .default)
        }
    }

    /// Determines whether the string contains Khmer Unicode characters (range U+1780...U+17FF).
    public static func containsKhmerCharacters(_ text: String) -> Bool {
        for scalar in text.unicodeScalars {
            if (0x1780...0x17FF).contains(scalar.value) {
                return true
            }
        }
        return false
    }

    /// Determines whether the string contains CJK / Chinese Unicode characters (range U+4E00...U+9FFF).
    public static func containsChineseCharacters(_ text: String) -> Bool {
        for scalar in text.unicodeScalars {
            if (0x4E00...0x9FFF).contains(scalar.value) || (0x3400...0x4DBF).contains(scalar.value) {
                return true
            }
        }
        return false
    }

    /// Resolves the optimal font for a given text string considering its script, current settings, and weight.
    public static func fontForText(
        _ text: String,
        englishFont: EnglishFont,
        khmerFont: KhmerFont,
        size: CGFloat,
        weight: Font.Weight = .regular,
        relativeTo style: Font.TextStyle = .body
    ) -> Font {
        if containsKhmerCharacters(text) {
            let psName = postScriptName(for: khmerFont, weight: weight)
            return customFont(name: psName, size: size, weight: weight, relativeTo: style)
        } else if containsChineseCharacters(text) {
            // Apple standard PingFang SC system font for Chinese
            return Font.system(size: size, weight: weight, design: .default)
        } else {
            let psName = postScriptName(for: englishFont, weight: weight)
            return customFont(name: psName, size: size, weight: weight, relativeTo: style)
        }
    }
}
