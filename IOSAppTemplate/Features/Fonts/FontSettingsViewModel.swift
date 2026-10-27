//
//  FontSettingsViewModel.swift
//  IOSAppTemplate
//
//  Created by Bunsan on 10/27/26.
//

import SwiftUI

@Observable
@MainActor
public final class FontSettingsViewModel {
    public var selectedTab: ScriptType = .khmer
    public var searchText: String = ""

    public init() {}

    public var filteredKhmerFonts: [KhmerFont] {
        if searchText.trimmingCharacters(in: .whitespaces).isEmpty {
            return KhmerFont.allCases
        }
        return KhmerFont.allCases.filter {
            $0.displayName.localizedCaseInsensitiveContains(searchText)
        }
    }

    public var filteredEnglishFonts: [EnglishFont] {
        if searchText.trimmingCharacters(in: .whitespaces).isEmpty {
            return EnglishFont.allCases
        }
        return EnglishFont.allCases.filter {
            $0.displayName.localizedCaseInsensitiveContains(searchText)
        }
    }
}
