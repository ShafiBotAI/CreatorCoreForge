import Foundation

/// Converts chapters into a simple screenplay format with character cues.
public struct ScreenplayConverter {
    public init() {}

    public func convert(chapters: [String]) -> String {
        chapters.enumerated().map { index, text in
            "Scene \(index + 1):\n" + text
        }.joined(separator: "\n\n")
    }
}
