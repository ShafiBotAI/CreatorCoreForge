import Foundation

/// Handles very basic video export operations.
public struct ExportRenderer {
    public enum Resolution: String {
        case p720
        case p1080
        case p4K
    }

    public init() {}

    /// Produce a copy of the video tagged with the desired resolution.
    public func export(video url: URL, resolution: Resolution) -> URL {
        let out = url.deletingLastPathComponent()
            .appendingPathComponent(resolution.rawValue + "_" + url.lastPathComponent)
        try? FileManager.default.copyItem(at: url, to: out)
        return out
    }
}
