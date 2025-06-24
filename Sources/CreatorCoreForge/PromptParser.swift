import Foundation

public struct ParsedPrompt {
    public let language: MultilingualEngine.Language
    public let text: String
}

/// Parses user prompts with simple language detection and normalization.
public struct PromptParser {
    private let languageEngine: MultilingualEngine

    public init(languageEngine: MultilingualEngine = MultilingualEngine()) {
        self.languageEngine = languageEngine
    }

    /// Parse a prompt string and detect the language.
    public func parse(_ text: String) -> ParsedPrompt {
        let normalized = normalize(text)
        let lang = languageEngine.detectLanguage(of: normalized)
        return ParsedPrompt(language: lang, text: normalized)
    }

    /// Normalize malformed input by trimming whitespace, collapsing spaces,
    /// and balancing quotation marks if needed.
    public func normalize(_ text: String) -> String {
        var cleaned = text.trimmingCharacters(in: .whitespacesAndNewlines)
        cleaned = cleaned.replacingOccurrences(of: "\\s+", with: " ", options: .regularExpression)
        let quoteCount = cleaned.filter { $0 == "\"" }.count
        if quoteCount % 2 != 0 {
            cleaned.append("\"")
        }
        return cleaned
    }
}
