import Foundation

/// Exports a simple session description for common DAWs.
public final class DAWSessionExporter {
    public init() {}

    /// Write a textual session file listing each track and segment.
    @discardableResult
    public func exportSession(tracks: [String: [Data]], to url: URL) throws -> URL {
        var lines = ["# DAW Session"]
        for (character, segments) in tracks {
            lines.append("[Track: \(character)]")
            for i in 0..<segments.count {
                lines.append("Segment \(i)")
            }
        }
        let data = lines.joined(separator: "\n").data(using: .utf8)!
        try data.write(to: url)
        return url
    }
}
