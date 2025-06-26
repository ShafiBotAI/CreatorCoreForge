import Foundation

/// Maintains voice and character memory across projects.
public final class MultiverseMemoryManager {
    private var memory: [String: [String: String]] = [:]
    public init() {}

    /// Assign a voice to a character within a project.
    public func assignVoice(_ voice: String, to character: String, project: String) {
        memory[project, default: [:]][character] = voice
    }

    /// Retrieve the assigned voice for a character in a project.
    public func voice(for character: String, project: String) -> String? {
        memory[project]?[character]
    }
}
