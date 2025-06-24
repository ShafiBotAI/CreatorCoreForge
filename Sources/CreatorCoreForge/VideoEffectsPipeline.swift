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

    /// Inserts interpolated frame tags between each pair of frames.
    public func interpolateFrames(_ frames: [String]) -> [String] {
        guard frames.count > 1 else { return frames }
        var result: [String] = []
        for i in 0..<frames.count - 1 {
            let current = frames[i]
            let next = frames[i + 1]
            result.append(current)
            result.append("\(current)_\(next)_interp")
        }
        result.append(frames.last!)
        return result
    }

    /// Overlays a simple watermark string onto each frame identifier.
    public func addWatermark(to frames: [String], watermark: String) -> [String] {
        frames.map { "\($0)-\(watermark)" }
    }

    /// Adds a fade-in at the beginning and fade-out at the end of the frame list.
    public func applyFadeInOut(to frames: [String]) -> [String] {
        guard !frames.isEmpty else { return [] }
        var result = ["fade-in"]
        result.append(contentsOf: frames)
        result.append("fade-out")
        return result
    }

    /// Combines processed frames with an audio track label to produce a clip.
    public func composeVideo(frames: [String], audio: String) -> RenderedClip {
        let tagged = frames.map { "\($0)|audio:\(audio)" }
        return RenderedClip(frames: tagged)
    }
}
