import Foundation

/// Minimal video export that packages frame names as a text blob.
public final class VideoExportService {
    public init() {}

    public func exportVideo(frames: [String], format: String) -> Data {
        let joined = frames.joined(separator: "\n")
        return Data(joined.utf8)
    }
}

