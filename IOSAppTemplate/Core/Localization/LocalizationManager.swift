//
//  LocalizationManager.swift
//  IOSAppTemplate
//
//  Created by Bunsan on 10/27/26.
//

import SwiftUI

/// Centralized manager for in-app localization, instant language switching, and localized formatting.
@Observable
@MainActor
public final class LocalizationManager {
    public static let shared = LocalizationManager()

    public var currentLanguage: AppLanguage {
        didSet {
            updateFormatters()
        }
    }

    private var dateFormatter: DateFormatter
    private var numberFormatter: NumberFormatter
    private var currencyFormatter: NumberFormatter

    public init(language: AppLanguage = .english) {
        self.currentLanguage = language
        self.dateFormatter = DateFormatter()
        self.numberFormatter = NumberFormatter()
        self.currencyFormatter = NumberFormatter()
        updateFormatters()
    }

    private func updateFormatters() {
        let locale = currentLanguage.locale
        dateFormatter.locale = locale
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short

        numberFormatter.locale = locale
        numberFormatter.numberStyle = .decimal

        currencyFormatter.locale = locale
        currencyFormatter.numberStyle = .currency
        if currentLanguage == .khmer {
            currencyFormatter.currencyCode = "KHR"
        } else if currentLanguage == .chinese {
            currencyFormatter.currencyCode = "CNY"
        } else {
            currencyFormatter.currencyCode = "USD"
        }
    }

    // MARK: - Formatted Strings

    public func formatDate(_ date: Date) -> String {
        dateFormatter.string(from: date)
    }

    public func formatNumber(_ number: NSNumber) -> String {
        numberFormatter.string(from: number) ?? "\(number)"
    }

    public func formatCurrency(_ amount: NSNumber) -> String {
        currencyFormatter.string(from: amount) ?? "$\(amount)"
    }

    // MARK: - Instant Localized String Lookup

    public func string(forKey key: String) -> String {
        if let translation = LocalizationDictionary.table[key]?[currentLanguage] {
            return translation
        }
        // Fallback to English
        if let fallback = LocalizationDictionary.table[key]?[.english] {
            return fallback
        }
        return key
    }
}

/// In-memory dictionary providing immediate, zero-restart translations for English, Khmer, and Chinese.
public struct LocalizationDictionary {
    public static let table: [String: [AppLanguage: String]] = [
        // Tab & Navigation
        "tab_home": [
            .english: "Home",
            .khmer: "ទំព័រដើម",
            .chinese: "首页"
        ],
        "tab_playground": [
            .english: "Playground",
            .khmer: "កន្លែងសាកល្បង",
            .chinese: "演练场"
        ],
        "tab_settings": [
            .english: "Settings",
            .khmer: "ការកំណត់",
            .chinese: "设置"
        ],

        // Home View
        "home_title": [
            .english: "Native SwiftUI Starter",
            .khmer: "គំរូចាប់ផ្ដើម SwiftUI ទំនើប",
            .chinese: "现代化原生 SwiftUI 模版"
        ],
        "home_subtitle": [
            .english: "Production-ready foundation with custom typography, 10 themes, and instant multilingual support.",
            .khmer: "មូលដ្ឋានគ្រឹះរួចរាល់សម្រាប់ផលិតកម្ម ជាមួយពុម្ពអក្សរផ្ទាល់ខ្លួន ស្បែក ១០ និងការគាំទ្រពហុភាសាភ្លាមៗ។",
            .chinese: "生产就绪的架构基底，具备定制字体系统、10款手作主题以及无感多语言即时切换。"
        ],
        "home_feature_themes": [
            .english: "10 Handcrafted Themes",
            .khmer: "ស្បែកកម្មវិធីចំនួន ១០",
            .chinese: "10 款精选质感主题"
        ],
        "home_feature_themes_desc": [
            .english: "From Clean Light to Cyberpunk Synth and Obsidian Dark.",
            .khmer: "ចាប់ពី ស្អាតភ្លឺ ដល់ ស៊ីប័រផាំង និង ខ្មៅងងឹត។",
            .chinese: "从明亮简约到赛博朋克与黑曜暗夜全覆盖。"
        ],
        "home_feature_fonts": [
            .english: "20 Bundled Google Fonts",
            .khmer: "ពុម្ពអក្សរ Google ចំនួន ២០",
            .chinese: "20 款内置 Google 字体"
        ],
        "home_feature_fonts_desc": [
            .english: "10 Khmer Google Fonts + 10 English Google Fonts with safe fallbacks.",
            .khmer: "ពុម្ពអក្សរខ្មែរ ១០ និងពុម្ពអក្សរអង់គ្លេស ១០ ជាមួយប្រព័ន្ធបម្រុងសុវត្ថិភាព។",
            .chinese: "10 款高棉语字体与 10 款英文字体独立渲染与完备回退。"
        ],
        "home_feature_localization": [
            .english: "Multilingual Engine",
            .khmer: "ម៉ាស៊ីនពហុភាសា",
            .chinese: "多语言智能引擎"
        ],
        "home_feature_localization_desc": [
            .english: "Instant language switching between English, Khmer, and Chinese.",
            .khmer: "ប្តូរភាសាភ្លាមៗរវាង អង់គ្លេស ខ្មែរ និង ចិន ដោយមិនបាច់បិទបើកឡើងវិញ។",
            .chinese: "无需重启应用即可实现英、高棉、中文即时切换。"
        ],
        "home_feature_scaling": [
            .english: "Typography Scaling",
            .khmer: "ការកំណត់ទំហំអក្សរ",
            .chinese: "排版与字号动态缩放"
        ],
        "home_feature_scaling_desc": [
            .english: "5 presets from 85% to 145% respecting Apple Dynamic Type.",
            .khmer: "កម្រិតកំណត់ ៥ ចាប់ពី ៨៥% ដល់ ១៤៥% ស្របតាម Apple Dynamic Type។",
            .chinese: "5 档预设从 85% 到 145%，完美契合 Apple Dynamic Type。"
        ],
        "home_quick_actions": [
            .english: "Quick Actions",
            .khmer: "សកម្មភាពរហ័ស",
            .chinese: "快捷入口"
        ],
        "home_action_try_playground": [
            .english: "Test in Playground",
            .khmer: "សាកល្បងក្នុង Playground",
            .chinese: "在演练场中测试"
        ],
        "home_action_customize_theme": [
            .english: "Change Theme",
            .khmer: "ប្តូរស្បែកកម្មវិធី",
            .chinese: "更换主题"
        ],
        "home_action_change_fonts": [
            .english: "Manage Fonts",
            .khmer: "គ្រប់គ្រងពុម្ពអក្សរ",
            .chinese: "管理字体"
        ],
        "home_sample_formatting": [
            .english: "Locale-Aware Formatting",
            .khmer: "ការធ្វើទ្រង់ទ្រាយតាមតំបន់",
            .chinese: "区域智能格式化演示"
        ],
        "home_sample_date": [
            .english: "Date & Time",
            .khmer: "កាលបរិច្ឆេទ និងម៉ោង",
            .chinese: "日期与时间"
        ],
        "home_sample_currency": [
            .english: "Currency",
            .khmer: "រូបិយប័ណ្ណ",
            .chinese: "货币数值"
        ],
        "home_sample_number": [
            .english: "Standard Number",
            .khmer: "លេខស្តង់ដារ",
            .chinese: "数字格式"
        ],

        // Settings View
        "settings_title": [
            .english: "Settings",
            .khmer: "ការកំណត់",
            .chinese: "设置"
        ],
        "settings_section_appearance": [
            .english: "Appearance & Theme",
            .khmer: "រូបរាង និងស្បែក",
            .chinese: "外观与主题"
        ],
        "settings_appearance_mode": [
            .english: "Color Scheme",
            .khmer: "ទម្រង់រូបរាង",
            .chinese: "外观模式"
        ],
        "settings_current_theme": [
            .english: "Active Theme",
            .khmer: "ស្បែកសកម្ម",
            .chinese: "当前主题"
        ],
        "settings_section_fonts": [
            .english: "Typography & Fonts",
            .khmer: "ពុម្ពអក្សរ និងទំហំ",
            .chinese: "字体与排版"
        ],
        "settings_khmer_font": [
            .english: "Khmer Font",
            .khmer: "ពុម្ពអក្សរខ្មែរ",
            .chinese: "高棉文字体"
        ],
        "settings_english_font": [
            .english: "English Font",
            .khmer: "ពុម្ពអក្សរអង់គ្លេស",
            .chinese: "英文字体"
        ],
        "settings_typography_scale": [
            .english: "Font Scale",
            .khmer: "ទំហំអក្សរ",
            .chinese: "字体缩放"
        ],
        "settings_section_language": [
            .english: "Language & Region",
            .khmer: "ភាសា និងតំបន់",
            .chinese: "语言与偏好"
        ],
        "settings_language": [
            .english: "App Language",
            .khmer: "ភាសាកម្មវិធី",
            .chinese: "应用语言"
        ],
        "settings_section_behavior": [
            .english: "System & Behavior",
            .khmer: "ប្រព័ន្ធ និងអាកប្បកិរិយា",
            .chinese: "系统与交互"
        ],
        "settings_haptics": [
            .english: "Haptic Feedback",
            .khmer: "ញ័រពេលប៉ះ (Haptics)",
            .chinese: "触感反馈"
        ],
        "settings_dynamic_type": [
            .english: "Respect Dynamic Type",
            .khmer: "ស្របតាមទំហំអក្សរប្រព័ន្ធ",
            .chinese: "遵循系统动态字体"
        ],
        "settings_reset_button": [
            .english: "Reset to Default Settings",
            .khmer: "កំណត់ឡើងវិញទៅលំនាំដើម",
            .chinese: "重置为默认设置"
        ],
        "settings_reset_confirm_title": [
            .english: "Reset Settings?",
            .khmer: "កំណត់ការកំណត់ឡើងវិញ?",
            .chinese: "确认重置所有设置？"
        ],
        "settings_reset_confirm_message": [
            .english: "This will revert your theme, fonts, typography scale, and language to their factory defaults.",
            .khmer: "សកម្មភាពនេះនឹងប្តូរស្បែក ពុម្ពអក្សរ ទំហំអក្សរ និងភាសាទៅកាន់តម្លៃដើមវិញ។",
            .chinese: "此操作会将您的主题、字体、排版缩放与语言恢复为初始默认状态。"
        ],
        "common_cancel": [
            .english: "Cancel",
            .khmer: "បោះបង់",
            .chinese: "取消"
        ],
        "common_reset": [
            .english: "Reset",
            .khmer: "កំណត់ឡើងវិញ",
            .chinese: "重置"
        ],
        "common_done": [
            .english: "Done",
            .khmer: "រួចរាល់",
            .chinese: "完成"
        ],
        "common_apply": [
            .english: "Apply",
            .khmer: "អនុវត្ត",
            .chinese: "应用"
        ],

        // Themes Feature
        "themes_title": [
            .english: "App Themes",
            .khmer: "ស្បែកកម្មវិធី",
            .chinese: "应用主题"
        ],
        "themes_subtitle": [
            .english: "Choose from 10 handcrafted color palettes tailored for day and night use.",
            .khmer: "ជ្រើសរើសក្នុងចំណោមស្បែកពណ៌ចំនួន ១០ ដែលរចនាឡើងយ៉ាងយកចិត្តទុកដាក់។",
            .chinese: "精选 10 款专为日间与夜间环境手工调校的主题配色。"
        ],

        // Fonts Feature
        "fonts_title": [
            .english: "Font Settings",
            .khmer: "ការកំណត់ពុម្ពអក្សរ",
            .chinese: "字体设置"
        ],
        "fonts_tab_khmer": [
            .english: "Khmer Fonts (10)",
            .khmer: "ពុម្ពខ្មែរ (១០)",
            .chinese: "高棉文字体 (10)"
        ],
        "fonts_tab_english": [
            .english: "English Fonts (10)",
            .khmer: "ពុម្ពអង់គ្លេស (១០)",
            .chinese: "英文字体 (10)"
        ],
        "fonts_preview_header": [
            .english: "Live Script Preview",
            .khmer: "ការមើលគំរូផ្ទាល់",
            .chinese: "文字实时预览"
        ],

        // Typography Feature
        "typography_title": [
            .english: "Typography Scaling",
            .khmer: "ទំហំអក្សរ",
            .chinese: "排版缩放"
        ],
        "typography_subtitle": [
            .english: "Adjust the global font size scale across all screens and components.",
            .khmer: "កែសម្រួលទំហំអក្សរទូទៅនៅគ្រប់ទំព័រ និងសមាសភាគ។",
            .chinese: "调整全局组件与界面的字号缩放比例。"
        ],

        // Playground Feature
        "playground_title": [
            .english: "Typography Playground",
            .khmer: "កន្លែងសាកល្បងអក្សរ",
            .chinese: "排版实战演练场"
        ],
        "playground_subtitle": [
            .english: "Test fonts, weights, line spacing, tracking, and script combinations interactively.",
            .khmer: "សាកល្បងពុម្ពអក្សរ កម្រាស់ គម្លាតបន្ទាត់ និងការរួមបញ្ចូលភាសាដោយផ្ទាល់។",
            .chinese: "交互式调试字体、字重、行距、字间距与多语种混排效果。"
        ],
        "playground_card_title": [
            .english: "Live Canvas",
            .khmer: "ផ្ទាំងគំរូផ្ទាល់",
            .chinese: "实时渲染画布"
        ],
        "playground_controls": [
            .english: "Style Controls",
            .khmer: "ឧបករណ៍បញ្ជា",
            .chinese: "排版参数控制"
        ],
        "playground_custom_text": [
            .english: "Custom Preview Text",
            .khmer: "អត្ថបទផ្ទាល់ខ្លួន",
            .chinese: "自定义预览文本"
        ],
        "playground_font_weight": [
            .english: "Font Weight",
            .khmer: "កម្រាស់អក្សរ",
            .chinese: "字重粗细"
        ],
        "playground_line_spacing": [
            .english: "Line Spacing",
            .khmer: "គម្លាតបន្ទាត់",
            .chinese: "行间距"
        ],
        "playground_letter_spacing": [
            .english: "Letter Spacing",
            .khmer: "គម្លាតតួអក្សរ",
            .chinese: "字间距"
        ],
        "playground_reset_preview": [
            .english: "Reset Playground",
            .khmer: "កំណត់កន្លែងសាកល្បងឡើងវិញ",
            .chinese: "重置演练场"
        ],

        // Language Feature
        "language_title": [
            .english: "Language",
            .khmer: "ភាសា",
            .chinese: "语言选择"
        ],
        "language_subtitle": [
            .english: "Select your preferred application language.",
            .khmer: "ជ្រើសរើសភាសាកម្មវិធីដែលអ្នកពេញចិត្ត។",
            .chinese: "选择您偏好的应用显示语言。"
        ]
    ]
}

// MARK: - SwiftUI Environment Keys
private struct LocalizationManagerKey: EnvironmentKey {
    static let defaultValue = LocalizationManager.shared
}

extension EnvironmentValues {
    public var localizationManager: LocalizationManager {
        get { self[LocalizationManagerKey.self] }
        set { self[LocalizationManagerKey.self] = newValue }
    }
}
