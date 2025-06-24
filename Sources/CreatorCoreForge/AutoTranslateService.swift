import Foundation

/// Naive offline translation service using word dictionaries.
public final class AutoTranslateService {
    private var dictionaries: [String: [String: String]]

    public init(dictionaries: [String: [String: String]] = [:]) {
        self.dictionaries = dictionaries
    }

    /// Register a translation dictionary for the given language code.
    public func addDictionary(_ code: String, mapping: [String: String]) {
        dictionaries[code] = mapping
    }

    /// Translate a text string using the dictionary for the target language.
    public func translate(_ text: String, to code: String) -> String {
        guard let map = dictionaries[code] else { return text }
        let words = text.split { $0.isWhitespace }
        let translated = words.map { word in
            map[word.lowercased()] ?? String(word)
        }
        return translated.joined(separator: " ")
    }

    /// Translate chapters while preserving metadata.
    public func translate(chapters: [Chapter], to code: String) -> [Chapter] {
        chapters.map { chapter in
            let newText = translate(chapter.text, to: code)
            return Chapter(title: chapter.title,
                           text: newText,
                           order: chapter.order,
                           metadata: chapter.metadata,
                           audioURL: chapter.audioURL)
        }
    }
}
