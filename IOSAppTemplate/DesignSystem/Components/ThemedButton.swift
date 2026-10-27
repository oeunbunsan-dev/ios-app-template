//
//  ThemedButton.swift
//  IOSAppTemplate
//
//  Created by Bunsan on 10/27/26.
//

import SwiftUI

/// Available button design variants.
public enum ThemedButtonVariant {
    case primary
    case secondary
    case outlined
    case text
}

/// Reusable styled button adhering to active theme and typography scale.
public struct ThemedButton: View {
    @Environment(\.themeColors) private var colors
    @Environment(\.appTypography) private var typography
    @Environment(\.isEnabled) private var isEnabled

    private let title: String
    private let icon: String?
    private let variant: ThemedButtonVariant
    private let action: () -> Void

    public init(
        _ title: String,
        icon: String? = nil,
        variant: ThemedButtonVariant = .primary,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.icon = icon
        self.variant = variant
        self.action = action
    }

    public var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if let icon {
                    Image(systemName: icon)
                        .font(.system(size: typography.scaledSize(for: 16), weight: .semibold))
                }

                Text(title)
                    .font(typography.font(for: title, style: .button, weight: .semibold))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .padding(.horizontal, 20)
            .background(backgroundStyle)
            .foregroundStyle(foregroundStyle)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .stroke(borderStyle, lineWidth: variant == .outlined ? 1.5 : 0)
            )
            .opacity(isEnabled ? 1.0 : 0.5)
        }
        .buttonStyle(ScaleButtonStyle())
        .accessibilityLabel(title)
    }

    @ViewBuilder
    private var backgroundStyle: some View {
        switch variant {
        case .primary:
            colors.primary
        case .secondary:
            colors.card
        case .outlined, .text:
            Color.clear
        }
    }

    private var foregroundStyle: Color {
        switch variant {
        case .primary:
            // High-contrast foreground for primary filled button
            return colors.background
        case .secondary:
            return colors.primaryText
        case .outlined, .text:
            return colors.primary
        }
    }

    private var borderStyle: Color {
        switch variant {
        case .outlined:
            return colors.primary
        default:
            return Color.clear
        }
    }
}

/// Smooth scale micro-animation on press.
private struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.easeOut(duration: 0.15), value: configuration.isPressed)
    }
}
