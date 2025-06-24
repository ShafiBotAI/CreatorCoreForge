import Foundation

/// Assembles frames into a simple clip structure.
public struct RenderedClip {
    public let frames: [String]
    public init(frames: [String]) { self.frames = frames }
}

public final class FrameRenderer {
    public init() {}

    /// Combine frames with optional transitions (ignored in stub).
    public func render(frames: [String]) -> RenderedClip {
        RenderedClip(frames: frames)
    }
}
