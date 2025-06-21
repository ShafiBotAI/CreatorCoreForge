import Foundation

/// Fills gaps between storyboard scenes using a local AI engine
/// and generates basic placeholder animation frames.
public struct SceneGapFiller {
    private let engine: AIEngine

    public init(engine: AIEngine = LocalAIEnginePro()) {
        self.engine = engine
    }

    /// Returns a new array with missing scenes filled in using the AI engine.
    /// Ensures at least `minScenes` scenes exist.
    public func fillGaps(in scenes: [String], minScenes: Int = 3,
                         completion: @escaping ([String]) -> Void) {
        var result = scenes.filter { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
        let missing = max(0, minScenes - result.count)
        guard missing > 0 else { completion(result); return }
        let group = DispatchGroup()
        for _ in 0..<missing {
            group.enter()
            engine.sendPrompt("Generate a short connecting scene.") { res in
                if case .success(let text) = res {
                    result.append("Scene: \(text)")
                }
                group.leave()
            }
        }
        group.notify(queue: .main) { completion(result) }
    }

    /// Produce placeholder animation frame names for a scene.
    public func generateAnimationFrames(for scene: String) -> [String] {
        ["\(scene)-frame1.png", "\(scene)-frame2.png", "\(scene)-frame3.png"]
    }
}
