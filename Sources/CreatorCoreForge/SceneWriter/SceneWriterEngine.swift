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
}
