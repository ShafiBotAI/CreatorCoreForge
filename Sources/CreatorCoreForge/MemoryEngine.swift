import Foundation

/// Supports multi-book voice continuity by bridging character and visual memory.
public final class MemoryEngine {
    private let characterStore: CharacterMemoryEngine
    private let visual: VisualMemoryEngine

    public init(character: CharacterMemoryEngine = CharacterMemoryEngine(),
                visual: VisualMemoryEngine = VisualMemoryEngine()) {
        self.characterStore = character
        self.visual = visual
    }

    public func rememberTrait(_ trait: String, value: String, character name: String) {
        characterStore.setTrait(trait, value: value, for: name)
    }

    public func trait(_ trait: String, for character: String) -> String? {
        characterStore.trait(trait, for: character)
    }

    public func addFrame(_ frame: String, project: String) {
        visual.addFrame(frame, project: project)
    }

    public func frames(for project: String) -> [String] {
        visual.frames(for: project)
    }

    /// Persist a voice assignment so it can be reused across books.
    public func rememberVoice(_ voice: VoiceProfile, for character: String, in series: String) {
        VoiceMemoryManager.shared.assign(voiceID: voice.id, to: character, in: series)
    }
}
