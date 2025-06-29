import Foundation

/// Automatically select narrator and character accents for an entire document.
public struct AutoVoiceSelector {
    private let mapper: CharacterVoiceMapper

    public init(mapper: CharacterVoiceMapper = CharacterVoiceMapper()) {
        self.mapper = mapper
    }

    public struct CharacterAccent {
        public let name: String
        public let voice: String
        public let accent: MultiLanguageAccentNarrator.VoiceAccent
    }

    /// Select accents for narrator and all detected characters.
    /// - Parameter text: Full book or document text.
    /// - Returns: Narrator accent and per-character accent mapping.
    public func selectVoices(for text: String) -> (narrator: MultiLanguageAccentNarrator.VoiceAccent, characters: [CharacterAccent]) {
        let narratorAccent = Self.guessAccent(in: text)
        let voiceMaps = mapper.assignVoices(to: text)
        let nsText = text as NSString
        var results: [CharacterAccent] = []
        for map in voiceMaps {
            let range = nsText.range(of: map.name, options: .caseInsensitive)
            let snippet: String
            if range.location != NSNotFound {
                let start = max(0, range.location - 80)
                let len = min(nsText.length - start, 160)
                snippet = nsText.substring(with: NSRange(location: start, length: len))
            } else {
                snippet = ""
            }
            let accent = Self.guessAccent(in: snippet)
            results.append(CharacterAccent(name: map.name, voice: map.assignedVoice, accent: accent))
        }
        return (narratorAccent, results)
    }

    private static func guessAccent(in text: String) -> MultiLanguageAccentNarrator.VoiceAccent {
        let lower = text.lowercased()
        if lower.contains("french") || lower.contains("paris") || lower.contains("france") {
            return .french
        }
        if lower.contains("german") || lower.contains("berlin") || lower.contains("germany") {
            return .german
        }
        if lower.contains("british") || lower.contains("london") || lower.contains("england") {
            return .british
        }
        if lower.contains("italian") || lower.contains("rome") || lower.contains("italy") {
            return .italian
        }
        if lower.contains("spanish") || lower.contains("madrid") || lower.contains("spain") {
            return .spanish
        }
        return .american
    }
}
