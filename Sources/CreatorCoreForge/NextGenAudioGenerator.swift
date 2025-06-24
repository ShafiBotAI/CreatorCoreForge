import Foundation

/// Generates multi-layered audio loops using existing music and sound engines.
public final class NextGenAudioGenerator {
    private let musicGenerator: AdaptiveMusicGenerator
    private let soundEngine: SoundLayerEngine

    public init(musicGenerator: AdaptiveMusicGenerator = AdaptiveMusicGenerator(),
                soundEngine: SoundLayerEngine = SoundLayerEngine()) {
        self.musicGenerator = musicGenerator
        self.soundEngine = soundEngine
    }

    /// Produce audio loop files for each mood and activate corresponding layers.
    /// - Parameter moods: List of mood strings.
    /// - Returns: URLs to generated audio files in order.
    public func generateLoops(for moods: [String]) -> [URL] {
        moods.compactMap { mood in
            let url = musicGenerator.generate(mood: mood)
            if url != nil { soundEngine.addLayer(mood) }
            return url
        }
    }

    /// All active sound layers after generation.
    public var activeLayers: [String] { soundEngine.activeLayers }
}
