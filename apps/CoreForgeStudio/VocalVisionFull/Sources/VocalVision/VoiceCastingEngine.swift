import Foundation

/// Assigns character voices to each scene
public final class VoiceCastingEngine {
    private var availableVoices: [String]

    public init(availableVoices: [String] = ["narrator", "hero", "villain"]) {
        self.availableVoices = availableVoices
    }

    /// Map scenes to a voice using a simple round-robin algorithm
    public func assignVoices(to scenes: [VideoScene]) -> [(scene: VideoScene, voice: String)] {
        guard !availableVoices.isEmpty else { return [] }
        var assignments: [(VideoScene, String)] = []
        for (index, scene) in scenes.enumerated() {
            let voice = availableVoices[index % availableVoices.count]
            assignments.append((scene, voice))
        }
        return assignments
    }
}
