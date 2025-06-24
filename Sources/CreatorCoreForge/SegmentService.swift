import Foundation

/// Splits chapters into narration segments based on blank lines.
public struct SegmentService {
    private static var cache: [Int: [Segment]] = [:]

    public init() {}

    /// Segments chapters synchronously. Used by legacy code paths.
    public func segment(_ chapters: [Chapter]) -> [Segment] {
        chapters.flatMap { splitText($0.text) }
    }

    /// Segments chapters asynchronously in chunks to avoid blocking the main thread.
    /// Results are cached using a simple hash of the chapter text.
    public func segmentAsync(_ chapters: [Chapter],
                             queue: DispatchQueue = .global(qos: .userInitiated),
                             completion: @escaping ([Segment]) -> Void) {
        var results: [Segment] = []
        let group = DispatchGroup()
        for chap in chapters {
            group.enter()
            queue.async {
                let parts = self.splitText(chap.text)
                DispatchQueue.main.async { results.append(contentsOf: parts); group.leave() }
            }
        }
        group.notify(queue: .main) { completion(results) }
    }

    private func splitText(_ text: String) -> [Segment] {
        let hash = text.hashValue
        if let cached = SegmentService.cache[hash] {
            return cached
        }
        var segments: [Segment] = []
        let parts = text.components(separatedBy: "\n\n")
        for part in parts {
            let trimmed = part.trimmingCharacters(in: .whitespacesAndNewlines)
            if trimmed.isEmpty { continue }
            segments.append(Segment(text: trimmed))
        }
        SegmentService.cache[hash] = segments
        return segments
    }
}

