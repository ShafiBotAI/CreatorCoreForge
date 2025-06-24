import Foundation

/// Suggests scene completions based on prior scenes and memory.
public struct AdaptiveSceneCompletion {
    private let memory: VisualMemoryEngine
    private let gapFiller: SceneGapFiller

    public init(memory: VisualMemoryEngine = VisualMemoryEngine(),
                gapFiller: SceneGapFiller = SceneGapFiller()) {
        self.memory = memory
        self.gapFiller = gapFiller
    }

    /// Fill missing scenes so the sequence reaches at least the desired count.
    public func completeScenes(_ scenes: [String],
                               project: String,
                               targetCount: Int,
                               completion: @escaping ([String]) -> Void) {
        // Start with stored frames as a hint for style continuity
        var combined = scenes
        let previous = memory.frames(for: project)
        if !previous.isEmpty {
            combined.insert(contentsOf: previous.map { "Recall: \($0)" }, at: 0)
        }
        gapFiller.fillGaps(in: combined, minScenes: targetCount) { result in
            // Remove recall markers before returning
            completion(result.filter { !$0.hasPrefix("Recall:") })
        }
    }
}
