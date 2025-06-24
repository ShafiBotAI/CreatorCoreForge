import Foundation

/// Provides erotic narration with optional language detection and accent tags.
public final class MultiLanguageAccentNarrator {
    public enum VoiceAccent: String, Codable, CaseIterable {
        case neutral
        case american
        case british
        case french
        case german
        case italian
        case spanish
    }

    private let languageEngine: MultilingualEngine

    public init(engine: MultilingualEngine = MultilingualEngine()) {
        self.languageEngine = engine
    }

    /// Detect the language of the provided text.
    public func detectLanguage(of text: String) -> MultilingualEngine.Language {
        languageEngine.detectLanguage(of: text)
    }

    /// Style the given text with NSFW tone and accent tags.
    /// - Parameters:
    ///   - text: input sentence.
    ///   - style: desired NSFW style.
    ///   - accent: accent tag to prefix the output with.
    /// - Returns: styled output tagged with the accent.
    public func narrate(_ text: String,
                        style: NSFWStyle = .sensual,
                        accent: VoiceAccent = .neutral) -> StyledVoiceOutput {
        let styled = applyNSFWTone(to: text, context: style)
        let prefix = accent == .neutral ? "" : "[\(accent.rawValue.capitalized)] "
        return StyledVoiceOutput(text: prefix + styled.styledText, style: styled.style)
    }
}
