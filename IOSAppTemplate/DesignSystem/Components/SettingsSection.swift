//
//  SettingsSection.swift
//  IOSAppTemplate
//
//  Created by Bunsan on 10/27/26.
//

import SwiftUI

/// Standard grouped settings section with title, optional description, and card container.
public struct SettingsSection<Content: View>: View {
    @Environment(\.themeColors) private var colors
    private let title: String
    private let description: String?
    private let content: Content

    public init(
        title: String,
        description: String? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.description = description
        self.content = content()
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading, spacing: 4) {
                ThemedText(title.uppercased(), style: .caption, weight: .bold, color: .secondary)

                if let description {
                    ThemedText(description, style: .footnote, color: .tertiary)
                }
            }
            .padding(.horizontal, 4)

            ThemedCard(padding: 0) {
                VStack(spacing: 0) {
                    content
                }
            }
        }
    }
}
