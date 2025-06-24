import Foundation

/// Generates indexes of scene markers within chapters.
public struct SceneIndexGenerator {
    public init() {}

    /// Map chapter titles to line numbers that contain the word "scene".
    public func indexScenes(in chapters: [Chapter]) -> [String: [Int]] {
        var map: [String: [Int]] = [:]
        for chapter in chapters {
            var indices: [Int] = []
            let lines = chapter.text.components(separatedBy: .newlines)
            for (i, line) in lines.enumerated() {
                if line.lowercased().contains("scene") {
                    indices.append(i)
                }
            }
            map[chapter.title] = indices
        }
        return map
    }
}
