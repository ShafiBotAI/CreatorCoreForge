import Foundation

/// Produces fully dramatized audiobook scenes with ambient sound layers.
public final class DramatizedAudiobookProducer {
    private let generator: MultiCastAudiobookGenerator
    private let soundEngine: SoundLayerEngine

    public init(generator: MultiCastAudiobookGenerator = MultiCastAudiobookGenerator(),
                soundEngine: SoundLayerEngine = SoundLayerEngine()) {
        self.generator = generator
        self.soundEngine = soundEngine
    }

    /// Combine narration with ambient SFX for immersive playback.
    public func produce(chapters: [[POVSegment]], ambience: [String]) -> [String] {
        ambience.forEach { soundEngine.addLayer($0) }
        let scenes = generator.generateScenes(from: chapters)
        let prefix = "[SFX: " + soundEngine.activeLayers.joined(separator: ",") + "]"
        return scenes.map { prefix + "\n" + $0 }
    }
}
