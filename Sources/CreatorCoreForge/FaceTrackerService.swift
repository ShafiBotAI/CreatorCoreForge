import Foundation

/// Represents a detected face position.
public struct FacePosition: Equatable {
    public let x: Double
    public let y: Double
    public init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
}

/// Basic stub face tracker returning no faces by default.
public final class FaceTrackerService {
    public init() {}

    /// Track faces in the given frame. Returns an array of positions.
    public func track(frame: Any) -> [FacePosition] {
        []
    }
}
