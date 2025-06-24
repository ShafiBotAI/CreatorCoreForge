import Foundation

/// Maintains an ordered list of chapters for an audiobook project.
public final class ChapterManager {
    private(set) var chapters: [String] = []

    public init() {}

    public func load(from text: String) {
        chapters = ChapterSegmenter().segments(from: text)
    }

    public func chapter(at index: Int) -> String? {
        guard chapters.indices.contains(index) else { return nil }
        return chapters[index]
    }
}
