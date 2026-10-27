//
//  TypographyPreviewCard.swift
//  IOSAppTemplate
//
//  Created by Bunsan on 10/27/26.
//

import SwiftUI

/// Reusable card previewing English, Khmer, and Chinese scripts together with current typography.
public struct TypographyPreviewCard: View {
    @Environment(\.appTypography) private var typography
    @Environment(\.themeColors) private var colors

    public init() {}

    public var body: some View {
        ThemedCard(cornerRadius: 16, padding: 18) {
            VStack(alignment: .leading, spacing: 14) {
                // English preview
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        ThemedText("ENGLISH", style: .caption, weight: .bold, color: .accent)
                        Spacer()
                        ThemedText(typography.englishFont.displayName, style: .caption, color: .secondary)
                    }

                    ThemedText("Welcome to your app.", style: .title3, weight: .semibold)
                }

                Divider().overlay(colors.border)

                // Khmer preview
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        ThemedText("KHMER (ខ្មែរ)", style: .caption, weight: .bold, color: .accent)
                        Spacer()
                        ThemedText(typography.khmerFont.displayName, style: .caption, color: .secondary)
                    }

                    ThemedText("សូមស្វាគមន៍មកកាន់កម្មវិធីរបស់អ្នក", style: .title3, weight: .medium)
                }

                Divider().overlay(colors.border)

                // Chinese preview
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        ThemedText("CHINESE (中文)", style: .caption, weight: .bold, color: .accent)
                        Spacer()
                        ThemedText("PingFang SC / System", style: .caption, color: .secondary)
                    }

                    ThemedText("欢迎使用您的应用", style: .title3, weight: .regular)
                }
            }
        }
    }
}
