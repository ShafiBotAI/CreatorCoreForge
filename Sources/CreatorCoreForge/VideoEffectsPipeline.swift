import Foundation

/// Provides simple video post-processing utilities for all apps.
public struct VideoEffectsPipeline {
    public init() {}

    /// Applies fade transitions between frame identifiers.
    public func applyFadeTransitions(to frames: [String]) -> [String] {
        guard !frames.isEmpty else { return [] }
        var result: [String] = []
        for (index, frame) in frames.enumerated() {
            result.append(frame)
            if index < frames.count - 1 {
                result.append("fade")
            }
        }
        return result
    }

    /// Overlays a simple watermark string onto each frame identifier.
    public func addWatermark(to frames: [String], watermark: String) -> [String] {
        frames.map { "\($0)-\(watermark)" }
    }

    /// Combines processed frames with an audio track label to produce a clip.
    public func composeVideo(frames: [String], audio: String) -> RenderedClip {
        let tagged = frames.map { "\($0)|audio:\(audio)" }
        return RenderedClip(frames: tagged)
    }
}
