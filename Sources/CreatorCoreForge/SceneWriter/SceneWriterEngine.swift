import Foundation

/// Represents a single scene draft with basic metadata.
public struct SceneDraft: Codable, Identifiable {
    public var id: UUID
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
    /// Metadata can be supplied inline using `[tone:]`, `[pov:]`, and
    /// `[emotion:]` tags which will be stripped from the resulting text.
    public func generateScene(prompt: String, memory: MemoryState) -> SceneDraft {
        let chapterID = memory.recentScenes.last?.chapterID ?? UUID()

        var tone = "neutral"
        var pov = "third"
        var emotion = "neutral"
        var text = prompt

        func extract(_ key: String, into variable: inout String) {
            let pattern = "\\[" + key + ":(.*?)\\]"
            guard let regex = try? NSRegularExpression(pattern: pattern) else { return }
            let nsrange = NSRange(text.startIndex..<text.endIndex, in: text)
            if let match = regex.firstMatch(in: text, range: nsrange),
               let range = Range(match.range(at: 1), in: text) {
                variable = String(text[range])
                text = regex.stringByReplacingMatches(in: text, range: nsrange, withTemplate: "").trimmingCharacters(in: .whitespaces)
            }
        }

        extract("tone", into: &tone)
        extract("pov", into: &pov)
        extract("emotion", into: &emotion)

        return SceneDraft(chapterID: chapterID, text: text, tone: tone, pov: pov, emotion: emotion)
    }

    /// Build a scene from a structured smart prompt.
    public func smartPrompt(sceneNumber: Int, character: String, event: String, memory: MemoryState) -> SceneDraft {
        let base = "Scene \(sceneNumber): \(character) \(event)."
        return generateScene(prompt: base, memory: memory)
    }

    /// Identify scenes that may drag based on word count.
    public func pacingReview(scenes: [SceneDraft]) -> [UUID] {
        let threshold = 200
        return scenes.filter { $0.text.split(separator: " ").count > threshold }.map { $0.id }
    }

    /// Generate three alternate endings for a scene.
    public func alternateEndings(for scene: SceneDraft) -> [SceneDraft] {
        ["A", "B", "C"].map { suffix in
            SceneDraft(id: UUID(),
                       chapterID: scene.chapterID,
                       text: scene.text + "\nEnding \(suffix).",
                       tone: scene.tone,
                       pov: scene.pov,
                       emotion: scene.emotion)
        }
    }
}
