# iOS Pro App Template 🚀 — Native SwiftUI

A production-ready, modular **native iOS application starter template** built using modern Swift, SwiftUI, and Apple platform APIs. 

Includes an advanced customization system for **Khmer and English Google Fonts**, **10 handcrafted themes**, **instant English, Khmer, and Chinese localization**, **5-tier typography scaling**, **persistent preferences**, and a **reusable design system**.

---

## 🌟 Key Features

- 🇰🇭 **10 Google Khmer Fonts**: Battambang, Bayon, Bokor, Dangrek, Fasthand, Hanuman, Kantumruy Pro, Koulen, Moul, Siemreap.
- 🇬🇧 **10 Google English Fonts**: Inter, Roboto, Poppins, Montserrat, Open Sans, Lato, Raleway, Nunito, Oswald, Playfair Display.
- 🎨 **10 Handcrafted Themes**: Clean Light, Obsidian Dark, Midnight Neon, Cyberpunk Synth, Emerald Forest, Sunset Coral, Lavender Mist, Pacific Ocean, Espresso Latte, Royal Crimson.
- 🌐 **Instant Multilingual Localization**: English (`en`), Khmer (`km`, ភាសាខ្មែរ), and Simplified Chinese (`zh`, 中文) with String Catalogs (`Localizable.xcstrings`) and zero-restart in-memory switching.
- 🔠 **Typography Scaling System**: 5 scalable presets (Small 85%, Normal 100%, Medium 115%, Large 130%, Extra Large 145%) with Apple Dynamic Type support.
- 🧪 **Interactive Live Typography Playground**: Multi-script canvas with real-time size, weight, line spacing, letter spacing, and theme switching.
- 💾 **Persistent User Settings**: Centralized `@Observable` `SettingsStore` backed by `UserDefaults` with factory default reset and safe fallbacks.
- 🧩 **Reusable SwiftUI Design System**: Standardized components (`ThemedText`, `ThemedCard`, `ThemedButton`, `AppHeader`, `SettingsSection`, `FontSelectionCard`, `ThemeSelectionCard`, etc.).

---

## 🏗️ Architecture & Project Structure

```text
IOSAppTemplate/
├── App/
│   ├── IOSAppTemplateApp.swift       # Application entry point with environment injection
│   └── AppBootstrap.swift            # CoreText font registration and navigation bar setup
├── Core/
│   ├── Models/
│   │   ├── AppLanguage.swift         # Supported languages, native names, locale configs
│   │   ├── AppTheme.swift            # 10 themes and appearance mode definitions
│   │   ├── FontOption.swift          # Khmer & English font options, typography scale
│   │   └── AppSettings.swift         # Codable user settings model with sensible defaults
│   ├── Settings/
│   │   ├── SettingsStore.swift       # Central observable store managing global app state
│   │   └── SettingsRepository.swift  # UserDefaults persistence layer with safe fallback
│   ├── Localization/
│   │   └── LocalizationManager.swift # Instant language switching and locale formatters
│   ├── Typography/
│   │   ├── AppTypography.swift       # Semantic styles (largeTitle, headline, body, etc.)
│   │   └── FontRegistry.swift        # PostScript font mapping, CoreText loading, fallback
│   └── Theme/
│       ├── ThemeColors.swift         # Semantic color tokens (background, primary, card, etc.)
│       ├── ThemeRegistry.swift       # Handcrafted palettes for all 10 themes
│       └── ThemeManager.swift        # Observable theme manager and environment keys
├── DesignSystem/
│   ├── Components/
│   │   ├── ThemedText.swift          # Automatic script font resolver and theme text
│   │   ├── ThemedView.swift          # Screen layout container with background color
│   │   ├── ThemedCard.swift          # Surface container with corner radius and borders
│   │   ├── ThemedButton.swift        # Primary, secondary, outlined, and text buttons
│   │   ├── AppHeader.swift           # Reusable navigation header with back button
│   │   ├── SettingsSection.swift     # Grouped iOS settings container
│   │   ├── FontSelectionCard.swift   # Interactive font preview card with checkmark
│   │   ├── ThemeSelectionCard.swift  # Theme card with palette color swatches
│   │   ├── LanguageSelectionRow.swift# Language row with flag and native labels
│   │   ├── TypographyPreviewCard.swift# Multilingual EN/KM/ZH live preview card
│   │   ├── ConfirmationDialogView.swift# Styled alert confirmation card
│   │   └── AppTabView.swift          # Main 3-tab navigation (Home, Playground, Settings)
│   └── Modifiers/
│       ├── AppThemeModifier.swift    # View modifier for background and tint
│       └── AppTypographyModifier.swift# View modifier for scalable typography
├── Features/
│   ├── Home/
│   │   └── HomeView.swift            # Dashboard with hero banner and design system showcase
│   ├── Settings/
│   │   ├── SettingsView.swift        # Settings hub with appearance, fonts, themes, reset
│   │   └── SettingsViewModel.swift   # ViewModel managing settings view state
│   ├── Fonts/
│   │   ├── FontSettingsView.swift    # Dual-tab font browser (10 Khmer + 10 English)
│   │   └── FontSettingsViewModel.swift# Font search and tab filtering
│   ├── Themes/
│   │   └── ThemeSettingsView.swift   # Visual gallery of all 10 handcrafted themes
│   ├── Language/
│   │   └── LanguageSettingsView.swift# English, Khmer, and Chinese instant selector
│   ├── Typography/
│   │   └── TypographySettingsView.swift# 5-tier scaling presets with live preview
│   └── Playground/
│       └── TypographyPlaygroundView.swift# Interactive typography & font testing sandbox
├── Resources/
│   ├── Fonts/
│   │   ├── Khmer/                    # 10 Google Khmer font files (.ttf)
│   │   └── English/                  # 10 Google English font files (.ttf)
│   └── Localizable.xcstrings         # Apple String Catalog translations (EN, KM, ZH)
└── IOSAppTemplateTests/
    ├── SettingsStoreTests.swift      # Persistence, default settings, and reset tests
    ├── ThemeRegistryTests.swift      # Theme palette uniqueness and completeness tests
    └── TypographyTests.swift         # Scaling calculations and script detection tests
```

---

## 🇰🇭 1. Ten Google Khmer Fonts

| # | Font Name | PostScript Name | Script / Characteristics |
|---|---|---|---|
| 1 | **Battambang** | `Battambang-Regular`, `Battambang-Bold` | High-legibility modern Khmer body text |
| 2 | **Bayon** | `Bayon-Regular` | Distinctive decorative headline typeface |
| 3 | **Bokor** | `Bokor-Regular` | Expressive display font inspired by southern Cambodia |
| 4 | **Dangrek** | `Dangrek-Regular` | Bold geometric display font |
| 5 | **Fasthand** | `Fasthand-Regular` | Elegant artistic script style |
| 6 | **Hanuman** | `Hanuman-Regular` | Classic literary typeface with serifs |
| 7 | **Kantumruy Pro** | `KantumruyPro-Regular` | Modern variable font engineered for contemporary UI |
| 8 | **Koulen** | `Koulen-Regular` | Compact monumental display font |
| 9 | **Moul** | `Moul-Regular` | Traditional ornate Khmer headline typeface |
| 10 | **Siemreap** | `Siemreap` | Clean, highly readable text typeface |

---

## 🇬🇧 2. Ten Google English Fonts

| # | Font Name | Regular PostScript Name | Available Weights |
|---|---|---|---|
| 1 | **Inter** | `Inter-Regular` | Variable (Thin...Black) |
| 2 | **Roboto** | `Roboto-Regular` | Variable (Thin...Black) |
| 3 | **Poppins** | `Poppins-Regular` | Regular, Medium, SemiBold, Bold |
| 4 | **Montserrat** | `Montserrat-Thin` | Variable (Thin...Black) |
| 5 | **Open Sans** | `OpenSans-Regular` | Variable (Light...ExtraBold) |
| 6 | **Lato** | `Lato-Regular` | Regular, Bold |
| 7 | **Raleway** | `Raleway-Thin` | Variable (Thin...Black) |
| 8 | **Nunito** | `Nunito-ExtraLight` | Variable (ExtraLight...Black) |
| 9 | **Oswald** | `Oswald-Regular` | Variable (ExtraLight...Bold) |
| 10 | **Playfair Display** | `PlayfairDisplay-Regular` | Variable (Regular...Black) |

---

## 🎨 3. Ten Handcrafted Themes

Each theme provides a tailored semantic color palette:

1. **Clean Light**: Crisp whites (`#F8FAFC`), subtle slate borders (`#E2E8F0`), sapphire blue primary (`#2563EB`).
2. **Obsidian Dark**: Pure pitch obsidian (`#0A0B0E`), sleek surfaces (`#12141A`), electric cyan accent (`#66FCF1`).
3. **Midnight Neon**: Midnight navy (`#090D16`), neon magenta (`#FF007F`), neon cyan (`#00F0FF`).
4. **Cyberpunk Synth**: Retro synthwave violet (`#0E0B1F`), laser yellow (`#FFE600`), hot pink (`#FF2A85`).
5. **Emerald Forest**: Deep pine forest (`#06140D`), jade surfaces (`#0B2217`), vibrant emerald (`#10B981`).
6. **Sunset Coral**: Golden peach ambiance (`#FFF7F5`), sunset coral (`#FF5A43`), amber gold (`#FB923C`).
7. **Lavender Mist**: Dreamy lilac mist (`#F8F7FC`), pastel violet (`#8B5CF6`), soft lilac (`#A78BFA`).
8. **Pacific Ocean**: Abyssal ocean navy (`#051329`), sea blue (`#0284C7`), aquamarine foam (`#38BDF8`).
9. **Espresso Latte**: Roasted coffee bean (`#17120F`), warm artisan latte (`#D4A373`), cream accents (`#FAEDCD`).
10. **Royal Crimson**: Velvet dark garnet (`#18050B`), ruby crimson (`#E11D48`), antique gold (`#F59E0B`).

---

## 🌐 4. Localization System (EN, KM, ZH)

- **Instant Switching**: Changing language immediately updates all visible text and formatters without requiring an app restart.
- **Root Locale Environment**: Injects `.environment(\.locale, settingsStore.settings.language.locale)` at the app root window.
- **Locale-Aware Formatting**:
  - English: USD (`$1,299.99`), US Date formatting (`Oct 27, 2026, 9:26 AM`).
  - Khmer: KHR (`1,299.99 ៛`), Khmer Date formatting.
  - Chinese: CNY (`¥1,299.99`), Chinese Date formatting.
- **Dual Resolution Architecture**:
  - Apple String Catalog (`Localizable.xcstrings`) for native iOS ecosystem support.
  - In-memory `LocalizationDictionary` for zero-latency, reactive view updates.

---

## 🔠 5. Typography Sizing Presets

| Preset | Scale Factor | Base 17pt (Body) | Base 20pt (Title3) | Base 34pt (LargeTitle) |
|---|---|---|---|---|
| **Small** | 85% (0.85) | 14pt | 17pt | 29pt |
| **Normal** | 100% (1.00) | 17pt | 20pt | 34pt |
| **Medium** | 115% (1.15) | 20pt | 23pt | 39pt |
| **Large** | 130% (1.30) | 22pt | 26pt | 44pt |
| **Extra Large** | 145% (1.45) | 25pt | 29pt | 49pt |

---

## 🚀 Building & Running

### Prerequisites
- macOS Sonoma or later
- Xcode 16.0 or later
- iOS 17.0+ deployment target

### Build via Command Line
```bash
# Build for iOS Simulator
xcodebuild -scheme IOSAppTemplate -destination 'generic/platform=iOS Simulator' build

# Run on booted simulator
xcrun simctl install booted /Users/$(whoami)/Library/Developer/Xcode/DerivedData/IOSAppTemplate-*/Build/Products/Debug-iphonesimulator/IOSAppTemplate.app
xcrun simctl launch booted Bunsan.IOSAppTemplate
```

### Build via Xcode
1. Open `IOSAppTemplate.xcodeproj` in Xcode.
2. Select the `IOSAppTemplate` scheme and an iOS Simulator (e.g., iPhone 16/17/18 Pro).
3. Press `Cmd + R` to build and run.

---

## 🛠️ Extending the Template

1. **Adding a New Theme**:
   Add a case to `AppTheme` in `Core/Models/AppTheme.swift` and define its colors in `Core/Theme/ThemeRegistry.swift`.
2. **Adding a New Font**:
   Drop the `.ttf` font file into `Resources/Fonts/`, register the filename in `IOSAppTemplate-Info.plist`, and add a case to `KhmerFont` or `EnglishFont` in `Core/Models/FontOption.swift`.
3. **Adding New Localized Strings**:
   Add translation keys to `LocalizationDictionary.table` in `Core/Localization/LocalizationManager.swift` and `Resources/Localizable.xcstrings`.
