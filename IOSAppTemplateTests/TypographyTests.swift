//
//  TypographyTests.swift
//  IOSAppTemplate
//
//  Created by Bunsan on 10/27/26.
//

import XCTest
import SwiftUI
@testable import IOSAppTemplate

final class TypographyTests: XCTestCase {
    func testTenKhmerFontsMapping() {
        XCTAssertEqual(KhmerFont.allCases.count, 10)
        for font in KhmerFont.allCases {
            let psRegular = FontRegistry.postScriptName(for: font, weight: .regular)
            XCTAssertFalse(psRegular.isEmpty)
            XCTAssertFalse(font.displayName.isEmpty)
            XCTAssertFalse(font.sampleText.isEmpty)
        }
    }

    func testTenEnglishFontsMapping() {
        XCTAssertEqual(EnglishFont.allCases.count, 10)
        for font in EnglishFont.allCases {
            let psRegular = FontRegistry.postScriptName(for: font, weight: .regular)
            XCTAssertFalse(psRegular.isEmpty)
            XCTAssertFalse(font.displayName.isEmpty)
        }
    }

    func testTypographyScalingCalculations() {
        let baseSize: CGFloat = 20

        let small = AppTypography(scale: .small).scaledSize(for: baseSize)
        XCTAssertEqual(small, 17) // 20 * 0.85 = 17

        let normal = AppTypography(scale: .normal).scaledSize(for: baseSize)
        XCTAssertEqual(normal, 20) // 20 * 1.00 = 20

        let medium = AppTypography(scale: .medium).scaledSize(for: baseSize)
        XCTAssertEqual(medium, 23) // 20 * 1.15 = 23

        let large = AppTypography(scale: .large).scaledSize(for: baseSize)
        XCTAssertEqual(large, 26) // 20 * 1.30 = 26

        let extraLarge = AppTypography(scale: .extraLarge).scaledSize(for: baseSize)
        XCTAssertEqual(extraLarge, 29) // 20 * 1.45 = 29
    }

    func testScriptDetection() {
        let englishText = "Welcome to your app."
        let khmerText = "សូមស្វាគមន៍មកកាន់កម្មវិធីរបស់អ្នក"
        let chineseText = "欢迎使用您的应用"

        XCTAssertFalse(FontRegistry.containsKhmerCharacters(englishText))
        XCTAssertTrue(FontRegistry.containsKhmerCharacters(khmerText))
        XCTAssertFalse(FontRegistry.containsKhmerCharacters(chineseText))

        XCTAssertFalse(FontRegistry.containsChineseCharacters(englishText))
        XCTAssertFalse(FontRegistry.containsChineseCharacters(khmerText))
        XCTAssertTrue(FontRegistry.containsChineseCharacters(chineseText))
    }
}
