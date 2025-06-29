import Foundation

/// Compiles a list of rendered clips into a final video structure.
public final class CinematicCompiler {
    private let effects = VideoEffectsPipeline()
    public init() {}

    /// Stitch clips together with simple fade transitions.
    public func stitch(clips: [RenderedClip]) -> FinalVideo {
        var frames: [String] = []
        for (idx, clip) in clips.enumerated() {
            frames.append(contentsOf: clip.frames)
            if idx < clips.count - 1 {
                frames.append("fade")
            }
        }
        let processed = effects.applyTransitions(to: frames, style: "fade")
        return FinalVideo(frames: processed)
    }
}
