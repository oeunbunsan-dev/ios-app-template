//
//  ConfirmationDialogView.swift
//  IOSAppTemplate
//
//  Created by Bunsan on 10/27/26.
//

import SwiftUI

/// Styled confirmation dialog view for important state resets.
public struct ConfirmationDialogView: View {
    @Environment(\.themeColors) private var colors
    @Environment(\.appTypography) private var typography

    private let title: String
    private let message: String
    private let confirmTitle: String
    private let cancelTitle: String
    private let onConfirm: () -> Void
    private let onCancel: () -> Void

    public init(
        title: String,
        message: String,
        confirmTitle: String = "Confirm",
        cancelTitle: String = "Cancel",
        onConfirm: @escaping () -> Void,
        onCancel: @escaping () -> Void
    ) {
        self.title = title
        self.message = message
        self.confirmTitle = confirmTitle
        self.cancelTitle = cancelTitle
        self.onConfirm = onConfirm
        self.onCancel = onCancel
    }

    public var body: some View {
        ThemedCard(cornerRadius: 20, padding: 22) {
            VStack(spacing: 16) {
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: typography.scaledSize(for: 36)))
                    .foregroundStyle(colors.warning)

                ThemedText(title, style: .headline, weight: .bold)
                    .multilineTextAlignment(.center)

                ThemedText(message, style: .body, color: .secondary)
                    .multilineTextAlignment(.center)

                HStack(spacing: 12) {
                    ThemedButton(cancelTitle, variant: .secondary, action: onCancel)
                    ThemedButton(confirmTitle, variant: .primary, action: onConfirm)
                }
            }
        }
        .padding(.horizontal, 24)
    }
}
