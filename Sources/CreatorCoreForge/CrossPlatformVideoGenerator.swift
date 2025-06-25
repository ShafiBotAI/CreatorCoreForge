import Foundation

/// Target platforms supported for video export.
public enum TargetPlatform {
    case iOS, android, macOS, windows, web
}

/// Generates videos in a format appropriate for the current platform.
public final class CrossPlatformVideoGenerator {
    private let engine: UnifiedVideoEngine

    public init(engine: UnifiedVideoEngine = .shared) {
        self.engine = engine
    }

    /// Generate a rendered clip for the selected platform.
    public func generate(frames: [String], platform: TargetPlatform) -> GPUVideoClip {
        let options = Self.options(for: platform)
        return engine.render(frames: frames, options: options)
    }

    private static func options(for platform: TargetPlatform) -> RendererOptions {
        switch platform {
        case .iOS, .android:
            return RendererOptions(width: 1080, height: 1920)
        case .macOS, .windows:
            return RendererOptions(width: 1920, height: 1080)
        case .web:
            return RendererOptions(width: 1280, height: 720)
        }
    }
}
