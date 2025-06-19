import Foundation

/// Provides dynamic translation for entire strings and collections.
public final class LanguageTranslationManager {
    private let translations: [String: [String: String]]

    public init(translations: [String: [String: String]] = [:]) {
        self.translations = translations
    }

    public func translate(_ text: String, to language: String) -> String {
        translations[language]?[text] ?? text
    }

    public func translate(contents: [String], to language: String) -> [String] {
        contents.map { translate($0, to: language) }
    }
}
