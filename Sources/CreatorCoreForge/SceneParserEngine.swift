import Foundation

/// Represents a parsed scene node with basic metadata.
public struct SceneNode: Identifiable {
    public let id = UUID()
    public let text: String
    public let tone: LocalAIEnginePro.Sentiment
    public let characters: [String]
    public let timestamp: TimeInterval

    public init(text: String,
                tone: LocalAIEnginePro.Sentiment,
                characters: [String],
                timestamp: TimeInterval) {
        self.text = text
        self.tone = tone
        self.characters = characters
        self.timestamp = timestamp
    }
}

/// Parses chapters or raw text into SceneNode objects.
public final class SceneParserEngine {
    private let mapper: SceneMapper
    private let generator: SceneGenerator

    public init(mapper: SceneMapper = SceneMapper(),
                generator: SceneGenerator = SceneGenerator()) {
        self.mapper = mapper
        self.generator = generator
    }

    /// Parse an array of chapters into scene nodes with tone and character info.
    public func parseScenes(from chapters: [Chapter]) -> [SceneNode] {
        let mapped = mapper.mapScenes(from: chapters)
        return mapped.enumerated().map { index, scene in
            SceneNode(text: scene.text,
                      tone: scene.tone,
                      characters: scene.characters,
                      timestamp: TimeInterval(index))
        }
    }

    /// Parse simple text into scene nodes when full chapter data is unavailable.
    public func parseScenes(from text: String) -> [SceneNode] {
        let scenes = generator.generateScenes(from: text, maxScenes: 10)
        return scenes.enumerated().map { index, value in
            SceneNode(text: value,
                      tone: .neutral,
                      characters: [],
                      timestamp: TimeInterval(index))
        }
    }
}
