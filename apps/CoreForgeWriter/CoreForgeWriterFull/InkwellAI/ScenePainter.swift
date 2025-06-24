import Foundation

/// Provides a simple outline of scenes for a chapter to aid visual planning.
final class ScenePainter {
    func paintScenes(from chapter: String, sentencesPerScene: Int = 3) -> [String] {
        let sentences = chapter.split(separator: ".")
        return sentences.chunked(into: sentencesPerScene).map { chunk in
            chunk.map { String($0).trimmingCharacters(in: .whitespaces) }.joined(separator: ".")
        }
    }
}

private extension Array where Element == Substring {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map { Array(self[$0..<Swift.min($0+size, count)]) }
    }
}
