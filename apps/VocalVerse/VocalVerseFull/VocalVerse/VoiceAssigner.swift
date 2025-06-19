import Foundation

/// Simple AI-based voice assignment stub.
/// Assigns a voice ID based on length and mood keywords.
struct VoiceAssigner {
    static func assignVoice(for text: String) -> Voice {
        // Basic heuristics: choose narrator for long text, celebrity for keywords
        let lowercased = text.lowercased()
        if lowercased.contains("wow") || lowercased.contains("incredible") {
            return Voice(id: "celebrity", name: "Celebrity")
        }
        if text.count > 200 {
            return Voice(id: "narrator", name: "Narrator")
        }
        // Default voice
        return VoiceConfig.voices.first ?? Voice(id: "default", name: "Default")
    }
}
