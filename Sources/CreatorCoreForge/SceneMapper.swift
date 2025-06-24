import Foundation

/// Maps chapters into smaller visual scenes with basic tone analysis.
public struct MappedScene: Identifiable {
    public let id = UUID()
    public let chapterTitle: String
    public let text: String
    public let tone: LocalAIEnginePro.Sentiment
    public let characters: [String]
}

/// Simple scene mapper that splits chapter text into paragraph-based scenes
/// and tags them with sentiment and detected characters.
public struct SceneMapper {
    private let recognizer: CharacterRecognizer
    private let sentimentEngine: LocalAIEnginePro

    public init(recognizer: CharacterRecognizer = CharacterRecognizer(),
                sentimentEngine: LocalAIEnginePro = LocalAIEnginePro()) {
        self.recognizer = recognizer
        self.sentimentEngine = sentimentEngine
    }

    /// Map an array of chapters into scenes.
    public func mapScenes(from chapters: [Chapter]) -> [MappedScene] {
        var result: [MappedScene] = []
        for chapter in chapters {
            let paragraphs = chapter.text.components(separatedBy: "\n\n")
            for para in paragraphs {
                let trimmed = para.trimmingCharacters(in: .whitespacesAndNewlines)
                guard !trimmed.isEmpty else { continue }
                let tone = sentimentEngine.analyzeSentiment(trimmed)
                let chars = recognizer.recognize(in: trimmed)
                result.append(MappedScene(chapterTitle: chapter.title,
                                           text: trimmed,
                                           tone: tone,
                                           characters: chars))
            }
        }
        return result
    }
}

