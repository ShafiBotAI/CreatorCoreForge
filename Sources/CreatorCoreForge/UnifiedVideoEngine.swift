import Foundation

/// Shared video engine wrapper around `GPUVideoRenderer` for cross-app usage.
public final class UnifiedVideoEngine {
    public static let shared = UnifiedVideoEngine()
    private let renderer: GPUVideoRenderer

    public init(renderer: GPUVideoRenderer = GPUVideoRenderer()) {
        self.renderer = renderer
    }

    /// Render frames using the underlying GPU renderer.
    public func render(frames: [String], options: RendererOptions) -> GPUVideoClip {
        renderer.render(frames: frames, options: options)
    }
}
