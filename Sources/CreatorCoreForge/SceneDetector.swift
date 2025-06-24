import Foundation

/// Represents a single detected scene within raw text.
public enum SceneShift: String, Codable {
    case timeJump
    case locationChange
}

public struct SceneMarker {
    public let index: Int
    public let text: String
    public let sentiment: LocalAIEnginePro.Sentiment
    public let shifts: [SceneShift]
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
=======
        var lastLocation: String?
        for (idx, raw) in rawScenes.enumerated() {
            let trimmed = raw.trimmingCharacters(in: .whitespacesAndNewlines)
            guard !trimmed.isEmpty else { continue }
            let tone = sentimentEngine.analyzeSentiment(trimmed)
            var shifts: [SceneShift] = []
            if idx > 0 {
                if Self.containsTimeCue(trimmed) { shifts.append(.timeJump) }
            }
            if let loc = Self.detectLocation(trimmed) {
                if let last = lastLocation, last != loc { shifts.append(.locationChange) }
                lastLocation = loc
            }
            markers.append(SceneMarker(index: idx, text: trimmed, sentiment: tone, shifts: shifts))

        }
        return SceneMap(scenes: markers)
    }

    private static func containsTimeCue(_ text: String) -> Bool {
        let cues = ["next day", "next morning", "the following day", "later", "years later", "months later", "previously", "earlier", "after"]
        let lower = text.lowercased()
        return cues.contains { lower.contains($0) }
    }

    private static func detectLocation(_ text: String) -> String? {
        let pattern = #"\b(in|at|to|into|visited)\s+([A-Z][a-zA-Z]+)"#
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return nil }
        let ns = text as NSString
        let range = NSRange(location: 0, length: ns.length)
        guard let match = regex.firstMatch(in: text, range: range) else { return nil }
        if match.numberOfRanges >= 3 {
            return ns.substring(with: match.range(at: 2)).lowercased()
        }
        return nil
    }
}
