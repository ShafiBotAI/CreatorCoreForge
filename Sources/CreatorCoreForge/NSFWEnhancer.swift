import Foundation

/// Applies NSFW enhancements such as whispers, breathing, and camera pacing.
public struct NSFWEnhancer {
    public init() {}

    /// Enhance a scene with optional audio cues and pacing info.
    public func enhance(scene: String,
                        whisper: Bool = false,
                        breathing: Bool = false,
                        cameraPace: Double = 1.0) -> String {
        var output = scene
        if whisper { output += " [whisper]" }
        if breathing { output += " [breath]" }
        output += " [pace:\(String(format: "%.2f", cameraPace))]"
        return output
    }
}
