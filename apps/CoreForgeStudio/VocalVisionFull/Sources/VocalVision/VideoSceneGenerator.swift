import Foundation

/// Parses text into video scenes and handles dramatization cues
public enum StylePreset: String, CaseIterable {
    case anime, noir, cinematic
}

public struct VideoScene {
    public var id: Int
    public var description: String
    public var cameraAngle: String
    public var stylePreset: StylePreset
}

public final class VideoSceneGenerator {
    public init() {}

    /// Naively split a book into scenes every N sentences
    public func generateScenes(from text: String, sentencesPerScene: Int = 4) -> [VideoScene] {
        let sentences = text.split(separator: ".")
        var scenes: [VideoScene] = []
        for (index, chunk) in sentences.chunked(into: sentencesPerScene).enumerated() {
            let description = chunk.joined(separator: ".")
            let angle = CameraAngleAdvisor.suggestAngle(for: description)
            let style = StylePreset.allCases[index % StylePreset.allCases.count]
            let scene = VideoScene(id: index,
                                   description: description,
                                   cameraAngle: angle,
                                   stylePreset: style)
            scenes.append(scene)
        }
        return scenes
    }
}

struct CameraAngleAdvisor {
    static func suggestAngle(for text: String) -> String {
        let lower = text.lowercased()
        if lower.contains("fight") || lower.contains("battle") {
            return "wide"
        } else if lower.contains("whisper") || lower.contains("quiet") {
            return "close-up"
        } else {
            return "medium"
        }
    }
}

private extension ArraySlice where Element == Substring {
    func joined(separator: String) -> String {
        self.map(String.init).joined(separator: separator)
    }
}

private extension Array where Element == Substring {
    func chunked(into size: Int) -> [ArraySlice<Element>] {
        stride(from: 0, to: count, by: size).map { start in
            let end = Swift.min(start + size, count)
            return self[start..<end]
        }
    }
}
