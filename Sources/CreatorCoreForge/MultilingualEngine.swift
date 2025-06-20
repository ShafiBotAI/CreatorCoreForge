import Foundation

/// Detects language and routes text to appropriate TTS models.
public final class MultilingualEngine {
    public enum Language: String {
        case english = "en"
        case spanish = "es"
        case french  = "fr"
        case unknown = "unknown"
    }

    public init() {}

    /// Very naive language detection based on character heuristics.
    public func detectLanguage(of text: String) -> Language {
        if text.range(of: "[áéíóúñ]", options: .regularExpression) != nil { return .spanish }
        if text.range(of: "[àâçéèêëïîôùûü]", options: .regularExpression) != nil { return .french }
        if text.range(of: "[a-zA-Z]", options: .regularExpression) != nil { return .english }
        return .unknown
    }

    /// Returns a string describing which model will be used for synthesis.
    public func modelForText(_ text: String) -> String {
        switch detectLanguage(of: text) {
        case .english: return "LocalVoiceAI-En"
        case .spanish: return "LocalVoiceAI-Es"
        case .french:  return "LocalVoiceAI-Fr"
        case .unknown: return "LocalVoiceAI-Default"
        }
    }
}
