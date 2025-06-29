import Foundation

/// Splits a scene description into basic shot segments.
public final class SceneSegmenter {
    public init() {}

    /// Segment the scene string using simple period separation.
    public func segments(from scene: String) -> [String] {
        scene.split(separator: ".").map { $0.trimmingCharacters(in: .whitespaces) }.filter { !$0.isEmpty }
    }

    /// Segment chapters into scene clips with basic emotion tagging.
    public func segment(chapters: [Chapter]) -> [SceneClip] {
        var result: [SceneClip] = []
        let analyzer = EmotionAnalyzer()
        var index = 0
        for chapter in chapters {
            let lines = chapter.text.components(separatedBy: .newlines)
            for (lineIndex, line) in lines.enumerated() {
                let trimmed = line.trimmingCharacters(in: .whitespaces)
                guard !trimmed.isEmpty else { continue }
                let tone = analyzer.classify(sentence: trimmed)
                let clip = SceneClip(
                    clipID: "\(chapter.order)-\(lineIndex)",
                    text: trimmed,
                    sceneIndex: index,
                    startLine: lineIndex,
                    endLine: lineIndex,
                    tone: tone,
                    transitionType: "cut"
                )
                result.append(clip)
                index += 1
            }
        }
        return result
    }
}
