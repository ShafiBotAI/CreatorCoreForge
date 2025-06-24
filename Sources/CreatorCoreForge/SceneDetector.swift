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
    /// Scene boundaries are detected using double newlines and
    /// simple time/location keywords.
    public func analyze(text: String) -> SceneMap {
        let paragraphs = text.components(separatedBy: "\n\n")
        var markers: [SceneMarker] = []
        var index = 0
        let shiftKeywords = ["later", "meanwhile", "the next", "in the", "at the"]

        for para in paragraphs {
            let trimmed = para.trimmingCharacters(in: .whitespacesAndNewlines)
            guard !trimmed.isEmpty else { continue }

            var buffer = ""
            let sentences = trimmed.split(separator: ".")
            for part in sentences {
                let sentence = part.trimmingCharacters(in: .whitespacesAndNewlines)
                guard !sentence.isEmpty else { continue }
                buffer += sentence + ". "
                let lower = sentence.lowercased()
                if shiftKeywords.contains(where: { lower.contains($0) }) {
                    let sceneText = buffer.trimmingCharacters(in: .whitespacesAndNewlines)
                    if !sceneText.isEmpty {
                        let tone = sentimentEngine.analyzeSentiment(sceneText)
                        markers.append(SceneMarker(index: index, text: sceneText, sentiment: tone))
                        index += 1
                        buffer = ""
                    }
                }
            }
            if !buffer.isEmpty {
                let sceneText = buffer.trimmingCharacters(in: .whitespacesAndNewlines)
                let tone = sentimentEngine.analyzeSentiment(sceneText)
                markers.append(SceneMarker(index: index, text: sceneText, sentiment: tone))
                index += 1
            }
        }
        return SceneMap(scenes: markers)
    }
}
