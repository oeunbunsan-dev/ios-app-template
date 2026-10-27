//
//  AppHeader.swift
//  IOSAppTemplate
//
//  Created by Bunsan on 10/27/26.
//

import SwiftUI

/// Reusable navigation header with title, optional subtitle, and actions.
public struct AppHeader<TrailingAction: View>: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.themeColors) private var colors
    @Environment(\.appTypography) private var typography

    private let title: String
    private let subtitle: String?
    private let showsBackButton: Bool
    private let trailingAction: TrailingAction

    public init(
        title: String,
        subtitle: String? = nil,
        showsBackButton: Bool = false,
        @ViewBuilder trailingAction: () -> TrailingAction
    ) {
        self.title = title
        self.subtitle = subtitle
        self.showsBackButton = showsBackButton
        self.trailingAction = trailingAction()
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 12) {
                if showsBackButton {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: typography.scaledSize(for: 18), weight: .semibold))
                            .foregroundStyle(colors.primary)
                            .padding(8)
                            .background(colors.card)
                            .clipShape(Circle())
                    }
                    .accessibilityLabel("Back")
                }

                ThemedText(title, style: .largeTitle, weight: .bold)

                Spacer()

                trailingAction
            }

            if let subtitle {
                ThemedText(subtitle, style: .subheadline, color: .secondary)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
    }
}

extension AppHeader where TrailingAction == EmptyView {
    public init(
        title: String,
        subtitle: String? = nil,
        showsBackButton: Bool = false
    ) {
        self.init(
            title: title,
            subtitle: subtitle,
            showsBackButton: showsBackButton,
            trailingAction: { EmptyView() }
        )
    }
}
