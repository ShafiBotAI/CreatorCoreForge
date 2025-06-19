import Foundation

/// Manages personalized scene progression based on user interaction history.
final class AdaptiveAISceneManager {
    struct Scene {
        let id: UUID
        let tags: [String]
        let text: String
    }

    private var history: [String] = []

    init() {}

    /// Record a tag that the user engaged with.
    func recordPreference(_ tag: String) {
        history.append(tag.lowercased())
    }

    /// Suggests the next scene from a list based on past preferences.
    func nextScene(from scenes: [Scene]) -> Scene? {
        guard !scenes.isEmpty else { return nil }
        let preferences = Dictionary(grouping: history, by: { $0 }).mapValues { $0.count }
        return scenes.max { a, b in
            score(scene: a, prefs: preferences) < score(scene: b, prefs: preferences)
        }
    }

    private func score(scene: Scene, prefs: [String: Int]) -> Int {
        return scene.tags.reduce(0) { $0 + (prefs[$1.lowercased()] ?? 0) }
    }
}
