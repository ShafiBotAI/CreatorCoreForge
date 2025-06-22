import Foundation

/// Scans documents and video frames for keyword occurrences.
public final class DocVideoScanner {
    public init() {}

    /// Count occurrences of keywords in a document string.
    public func scanDocument(_ text: String, keywords: [String]) -> [String: Int] {
        var counts: [String: Int] = [:]
        let lower = text.lowercased()
        for key in keywords {
            let k = key.lowercased()
            let c = lower.components(separatedBy: k).count - 1
            if c > 0 { counts[key] = c }
        }
        return counts
    }

    /// Count frames that contain a given tag string.
    public func scanVideoFrames(_ frames: [String], tag: String) -> Int {
        frames.reduce(0) { $0 + ($1.contains(tag) ? 1 : 0) }
    }
}
