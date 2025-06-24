import Foundation

/// Generates scenes for multi-cast audiobooks by combining multiple POV segments.
public final class MultiCastAudiobookGenerator {
    private let builder: MultiPOVSceneBuilder
    public init(builder: MultiPOVSceneBuilder = MultiPOVSceneBuilder()) {
        self.builder = builder
    }

    /// Render an array of chapters, where each chapter is a collection of POV segments.
    public func generateScenes(from chapters: [[POVSegment]]) -> [String] {
        chapters.map { segments in
            builder.reset()
            segments.forEach { builder.addSegment(character: $0.character, text: $0.text) }
            return builder.buildScene()
        }
    }
}
