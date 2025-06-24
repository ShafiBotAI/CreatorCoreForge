import Foundation

/// Options for GPU-based rendering.
public struct RendererOptions {
    public let width: Int
    public let height: Int
    public init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }
}

/// Represents a rendered clip from the GPU renderer.
public struct GPUVideoClip {
    public let frames: [String]
    public init(frames: [String]) { self.frames = frames }
}

/// Simple GPU renderer that just echoes back provided frames.
public final class GPUVideoRenderer {
    public init() {}
    public func render(frames: [String], options: RendererOptions) -> GPUVideoClip {
        GPUVideoClip(frames: frames)
    }
}
