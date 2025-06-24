import Foundation

/// Represents a single detected scene within raw text.
public struct SceneMarker {
    public let index: Int
    public let text: String
    public let sentiment: LocalAIEnginePro.Sentiment
}

/// Collection of scene markers returned by `SceneDetector`.
public struct SceneMap {
    public let scenes: [SceneMarker]
}

/// Basic scene detector that splits text by double newlines
/// and tags each section with an estimated sentiment.
public final class SceneDetector {
    private let sentimentEngine: LocalAIEnginePro

    public init(sentimentEngine: LocalAIEnginePro = LocalAIEnginePro()) {
        self.sentimentEngine = sentimentEngine
    }

    /// Analyze the provided text and return a map of scenes.
    public func analyze(text: String) -> SceneMap {
        let rawScenes = text.components(separatedBy: "\n\n")
        var markers: [SceneMarker] = []
        for (idx, raw) in rawScenes.enumerated() {
            let trimmed = raw.trimmingCharacters(in: .whitespacesAndNewlines)
            guard !trimmed.isEmpty else { continue }
            let tone = sentimentEngine.analyzeSentiment(trimmed)
            markers.append(SceneMarker(index: idx, text: trimmed, sentiment: tone))
        }
        return SceneMap(scenes: markers)
    }
}
