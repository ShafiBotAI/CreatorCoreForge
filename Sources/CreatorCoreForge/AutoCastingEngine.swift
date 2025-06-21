import Foundation

/// Suggests voices based on genre and tone.
public final class AutoCastingEngine {
    public init() {}

    public func suggestedVoice(for genre: String) -> VoiceProfile {
        if genre.lowercased().contains("horror") {
            return VoiceProfile(name: "Spooky", emotion: "tense")
        }
        return VoiceProfile(name: "Narrator", emotion: "neutral")
    }
}
