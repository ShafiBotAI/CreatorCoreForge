import Foundation

/// Compiles scenes into a chapter preview and supports basic exporting.
public final class ChapterComposer {
    public init() {}

    /// Combine the text of active scenes into a single chapter string.
    public func compile(scenes: [SceneDraft]) -> String {
        scenes.map { $0.text }.joined(separator: "\n\n")
    }

    /// Convenience wrapper to compile from a SceneManager's active scenes.
    public func compile(from manager: SceneManager) -> String {
        compile(scenes: manager.activeScenes())
    }

    /// Export the chapter string to disk in the desired format.
    @discardableResult
    public func export(chapter: String, to url: URL) throws -> URL {
        try chapter.write(to: url, atomically: true, encoding: .utf8)
        return url
    }
}
