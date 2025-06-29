import Foundation

/// Represents a single scene draft with basic metadata.
public struct SceneDraft: Codable, Identifiable {
    public let id: UUID
    public let chapterID: UUID
    public var text: String
    public var tone: String
    public var pov: String
    public var emotion: String

    public init(id: UUID = UUID(),
                chapterID: UUID,
                text: String,
                tone: String = "neutral",
                pov: String = "third",
                emotion: String = "neutral") {
        self.id = id
        self.chapterID = chapterID
        self.text = text
        self.tone = tone
        self.pov = pov
        self.emotion = emotion
    }
}

/// Minimal memory state to provide recent scene context.
public struct MemoryState {
    public var recentScenes: [SceneDraft]
    public init(recentScenes: [SceneDraft] = []) {
        self.recentScenes = recentScenes
    }
}

/// Generates scene drafts with simple continuity support.
public final class SceneWriterEngine {
    public init() {}

    /// Generate a new scene draft using the provided prompt and memory.
    /// The text is returned as-is while metadata defaults are applied.
    public func generateScene(prompt: String, memory: MemoryState) -> SceneDraft {
        let chapterID = memory.recentScenes.last?.chapterID ?? UUID()
        return SceneDraft(chapterID: chapterID, text: prompt)
    }
}
