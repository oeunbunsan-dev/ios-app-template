//
//  SettingsViewModel.swift
//  IOSAppTemplate
//
//  Created by Bunsan on 10/27/26.
//

import SwiftUI

@Observable
@MainActor
public final class SettingsViewModel {
    public var showingResetConfirmation = false

    public init() {}

    public func confirmReset(store: SettingsStore) {
        store.resetToDefaults()
        showingResetConfirmation = false
    }
}
