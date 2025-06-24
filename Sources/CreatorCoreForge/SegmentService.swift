import Foundation

/// Splits chapters into narration segments based on blank lines.
public struct SegmentService {
    private static var cache: [Int: [Segment]] = [:]
    private static var cacheOrder: [Int] = []
    private static let cacheLimit = 50

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

    /// Segments chapters concurrently using async task groups.
    /// - Parameters:
    ///   - chapters: Chapters to segment.
    ///   - chunkSize: Number of chapters processed per task.
    /// - Returns: Flattened array of segments.
    public func segmentAsyncChunked(_ chapters: [Chapter], chunkSize: Int = 2) async -> [Segment] {
        var results: [Segment] = []
        await withTaskGroup(of: [Segment].self) { group in
            for chunk in chapters.chunked(into: chunkSize) {
                group.addTask {
                    chunk.flatMap { self.splitText($0.text) }
                }
            }
            for await seg in group {
                results.append(contentsOf: seg)
            }
        }
        return results
    }

    private func splitText(_ text: String) -> [Segment] {
        let hash = text.hashValue
        if let cached = SegmentService.cache[hash] {
            if let idx = SegmentService.cacheOrder.firstIndex(of: hash) {
                SegmentService.cacheOrder.remove(at: idx)
                SegmentService.cacheOrder.append(hash)
            }
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
        SegmentService.cacheOrder.append(hash)
        if SegmentService.cacheOrder.count > SegmentService.cacheLimit {
            let old = SegmentService.cacheOrder.removeFirst()
            SegmentService.cache.removeValue(forKey: old)
        }
        return segments
    }
}

private extension Array {
    func chunked(into size: Int) -> [[Element]] {
        guard size > 0 else { return [self] }
        return stride(from: 0, to: count, by: size).map { start in
            let end = Swift.min(start + size, count)
            return Array(self[start..<end])
        }
    }
}

