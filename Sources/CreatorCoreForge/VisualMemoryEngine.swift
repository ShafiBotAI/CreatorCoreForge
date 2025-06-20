import Foundation

/// Tracks rendered frames across projects for later recall.
public final class VisualMemoryEngine {
    private let store: UserDefaults
    private let key = "VisualMemoryEngineTimeline"
    private var timeline: [(project: String, frame: String)]

    public init(store: UserDefaults = .standard) {
        self.store = store
        if let data = store.array(forKey: key) as? [String] {
            self.timeline = data.compactMap { entry in
                let parts = entry.split(separator: "|", maxSplits: 1)
                guard parts.count == 2 else { return nil }
                return (String(parts[0]), String(parts[1]))
            }
        } else {
            self.timeline = []
        }
    }

    /// Append a frame identifier for the given project.
    public func addFrame(_ frame: String, project: String) {
        timeline.append((project, frame))
        persist()
    }

    /// Return all frames for a single project.
    public func frames(for project: String) -> [String] {
        timeline.filter { $0.project == project }.map { $0.frame }
    }

    /// Combine frames from all projects in the order they were added.
    public func allFramesTimeline() -> [String] {
        timeline.map { $0.frame }
    }

    /// Clear all stored frames.
    public func clear() {
        timeline.removeAll()
        persist()
    }

    private func persist() {
        let data = timeline.map { "\($0.project)|\($0.frame)" }
        store.set(data, forKey: key)
    }
}
