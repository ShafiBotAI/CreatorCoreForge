import Foundation

/// Placeholder translation service that uses a simple dictionary.
final class TranslationService {
    private let translations: [String: [String: String]]

    init(translations: [String: [String: String]] = [:]) {
        self.translations = translations
    }

    func translate(_ text: String, to language: String) -> String {
        translations[language]?[text] ?? text
    }
}
