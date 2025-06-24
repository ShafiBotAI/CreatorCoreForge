import Foundation

/// Suggests optimal voice profiles based on genre and tone.
public final class AutoCastingEngine {
    public init() {}

    /// Return a suggested voice profile for the provided genre and tone.
    public func suggestVoice(for genre: String, tone: String) -> VoiceProfile {
        let name = "\(genre.capitalized) \(tone.capitalized)"
        return VoiceProfile(name: name, emotion: tone.lowercased())

    }

    /// Suggest a default voice based solely on genre.
    public func suggestedVoice(for genre: String) -> VoiceProfile {
        if genre.lowercased().contains("horror") {
            return VoiceProfile(name: "Spooky", emotion: "tense")
        }
        return VoiceProfile(name: "Narrator", emotion: "neutral")

    }
}
