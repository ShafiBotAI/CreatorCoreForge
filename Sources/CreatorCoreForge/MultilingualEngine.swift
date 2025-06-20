import Foundation

/// Detects language and routes text to appropriate TTS models.
public final class MultilingualEngine {
    public enum Language: String {
        case english = "en"
        case spanish = "es"
        case french  = "fr"
        case german  = "de"
        case italian = "it"
        case unknown = "unknown"
    }

    public init() {}

    /// Very naive language detection based on character heuristics and keywords.
    public func detectLanguage(of text: String) -> Language {
        let lower = text.lowercased()
        if lower.contains("hola") || text.range(of: "[áéíóúñ]", options: .regularExpression) != nil {
            return .spanish
        }
        if lower.contains("bonjour") || text.range(of: "[àâçéèêëïîôùûü]", options: .regularExpression) != nil {
            return .french
        }
        if lower.contains("guten") || text.range(of: "[äöüß]", options: .regularExpression) != nil {
            return .german
        }
        if lower.contains("ciao") || text.range(of: "[àèìòù]", options: .regularExpression) != nil {
            return .italian
        }
        if text.range(of: "[a-zA-Z]", options: .regularExpression) != nil {
            return .english
        }
        return .unknown
    }

    /// Returns a string describing which model will be used for synthesis.
    public func modelForText(_ text: String) -> String {
        switch detectLanguage(of: text) {
        case .english: return "LocalVoiceAI-En"
        case .spanish: return "LocalVoiceAI-Es"
        case .french:  return "LocalVoiceAI-Fr"
        case .german:  return "LocalVoiceAI-De"
        case .italian: return "LocalVoiceAI-It"
        case .unknown: return "LocalVoiceAI-Default"
        }
    }
}
