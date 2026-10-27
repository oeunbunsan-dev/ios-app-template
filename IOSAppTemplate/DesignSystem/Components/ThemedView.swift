//
//  ThemedView.swift
//  IOSAppTemplate
//
//  Created by Bunsan on 10/27/26.
//

import SwiftUI

/// Reusable full-bleed screen container that applies background color and theme styling.
public struct ThemedView<Content: View>: View {
    @Environment(\.themeColors) private var colors
    private let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        ZStack {
            colors.background
                .ignoresSafeArea()

            content
        }
    }
}
