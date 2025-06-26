import Foundation
import CreatorCoreForge

/// Simple AI-based voice assignment stub.
/// Assigns a voice ID based on length and mood keywords.
struct VoiceAssigner {
    static func assignVoice(for text: String) -> Voice {
        // Prefer user's favorite voice if one exists
        if let favID = FavoriteVoiceService.shared.favorites.first,
           let fav = VoiceConfig.voices.first(where: { $0.id == favID }) {
            return fav
        }
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
