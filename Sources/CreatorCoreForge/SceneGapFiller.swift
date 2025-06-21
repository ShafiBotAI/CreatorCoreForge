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

        func addMissingScenes(_ remaining: Int) {
            guard remaining > 0 else { completion(result); return }
            let group = DispatchGroup()
            var added = 0
            for _ in 0..<remaining {
                group.enter()
                engine.sendPrompt("Generate a short connecting scene.") { res in
                    if case .success(let text) = res {
                        result.append("Scene: \(text)")
                        added += 1
                    }
                    group.leave()
                }
            }
            group.notify(queue: .main) {
                let stillMissing = max(0, minScenes - result.count)
                if stillMissing > 0 && added > 0 {
                    addMissingScenes(stillMissing)
                } else {
                    completion(result)
                }
            }
        }

        let missing = max(0, minScenes - result.count)
        if missing == 0 {
            completion(result)
        } else {
            addMissingScenes(missing)
        }
    }

    /// Produce simple animation frame names derived from the scene text.
    /// Whitespace is trimmed and replaced so frame names are predictable.
    public func generateAnimationFrames(for scene: String) -> [String] {
        let base = scene.replacingOccurrences(of: "\\s+", with: "_",
                                              options: .regularExpression)
                          .lowercased()
        return ["\(base)_frame1.png", "\(base)_frame2.png", "\(base)_frame3.png"]
    }
}
