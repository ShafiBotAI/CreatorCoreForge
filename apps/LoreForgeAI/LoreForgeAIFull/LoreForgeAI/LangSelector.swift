import Foundation

struct LangSelector {
    static var available: [String] = ["English", "Spanish", "Japanese", "French", "German", "Italian", "Korean"]
    static var defaultLanguage: String = available.first ?? "English"
    static var enabledLanguages: [String] = [defaultLanguage]
    static var isMultiLanguageEnabled: Bool = false {
        didSet {
            if isMultiLanguageEnabled {
                enabledLanguages = available
            } else {
                enabledLanguages = [defaultLanguage]
            }
        }
    }

    static func setDefault(_ lang: String) {
        if available.contains(lang) {
            defaultLanguage = lang
            if !enabledLanguages.contains(lang) {
                enabledLanguages.append(lang)
            }
        }
    }

    static func enableAll() {
        defaultLanguage = available.first ?? "English"
        isMultiLanguageEnabled = true
    }

    static func enableMultiLanguage() {
        isMultiLanguageEnabled = true
    }

    static func disableMultiLanguage() {
        isMultiLanguageEnabled = false
    }
}
