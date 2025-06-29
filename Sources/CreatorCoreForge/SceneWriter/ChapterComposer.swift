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

    /// Analyze pacing by returning an average scene length in words.
    public func pacingChecks(scenes: [SceneDraft]) -> Double {
        guard !scenes.isEmpty else { return 0 }
        let wordCounts = scenes.map { $0.text.split(separator: " ").count }
        return Double(wordCounts.reduce(0, +)) / Double(wordCounts.count)
    }

    /// Basic scene-to-scene transition text suggestions.
    public func transitions(for scenes: [SceneDraft]) -> [String] {
        guard scenes.count > 1 else { return [] }
        return (1..<scenes.count).map { _ in "Scene transition" }
    }

    /// Generate a simple summary of all scenes.
    public func summary(for scenes: [SceneDraft]) -> String {
        scenes.map { $0.text.prefix(40) + "..." }.joined(separator: " ")
    }

    public enum ExportFormat {
        case txt
        case epub
        case json
        case storyboard
    }

    /// Export the chapter string to disk in the desired format.
    @discardableResult
    public func export(chapter: String, format: ExportFormat, to url: URL) throws -> URL {
        let data: Data
        switch format {
        case .txt, .epub:
            data = Data(chapter.utf8)
        case .json:
            data = try JSONEncoder().encode(["chapter": chapter])
        case .storyboard:
            data = try JSONEncoder().encode(["storyboard": chapter])
        }
        try data.write(to: url)
        return url
    }
}
