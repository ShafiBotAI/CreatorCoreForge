import Foundation

/// Supported camera motions.
public enum CameraMotion {
    case zoom
    case pan
    case tilt
}

/// Applies camera motion tags to frames.
public struct CameraMotionRenderer {
    public init() {}

    public func applyMotion(to frames: [String], motion: CameraMotion) -> [String] {
        let tag: String
        switch motion {
        case .zoom: tag = "zoom"
        case .pan: tag = "pan"
        case .tilt: tag = "tilt"
        }
        return frames.map { "\($0)-\(tag)" }
    }
}
