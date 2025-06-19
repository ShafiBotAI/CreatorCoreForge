import Foundation

/// Coordinates video rendering for a sequence of scenes
public final class RendererControl {
    private var isRendering = false

    public init() {}

    /// Begin rendering process (mock implementation)
    public func startRendering(scenes: [(scene: VideoScene, voice: String)], progress: (Double) -> Void) {
        guard !isRendering else { return }
        isRendering = true
        let total = Double(scenes.count)
        for (index, _) in scenes.enumerated() {
            // Simulate some work
            progress(Double(index + 1) / total)
        }
        isRendering = false
    }

    /// Render long videos in chunks to avoid memory spikes. Each chunk is processed
    /// sequentially and progress is updated based on overall scene count.
    public func startLongRendering(scenes: [(scene: VideoScene, voice: String)],
                                   chunkSize: Int = 50,
                                   progress: (Double) -> Void) {
        guard !isRendering else { return }
        isRendering = true
        let total = Double(scenes.count)
        var processed = 0
        for chunk in scenes.chunked(into: chunkSize) {
            startRendering(scenes: chunk, progress: { _ in })
            processed += chunk.count
            progress(Double(processed) / total)
        }
        isRendering = false
    }

    /// Render a multi-hour video and write to disk incrementally.
    /// This simply forwards to `startLongRendering` and writes a placeholder
    /// file URL when complete.
    public func exportMultiHourVideo(scenes: [(scene: VideoScene, voice: String)],
                                     to outputURL: URL,
                                     metadata: [String: String]? = nil,
                                     nsfw: Bool = false,
                                     birthDate: Date = Date(timeIntervalSince1970: 0),
                                     progress: (Double) -> Void,
                                     completion: @escaping (URL?) -> Void) {
        guard NSFWGuard.isAllowed(nsfwEnabled: nsfw, birthDate: birthDate) || !nsfw else {
            completion(nil)
            return
        }
        startLongRendering(scenes: scenes, chunkSize: 100) { value in
            progress(value)
        }
        // In a real implementation, rendered data would be written incrementally.
        try? "rendered".write(to: outputURL, atomically: true, encoding: .utf8)
        if let metadata = metadata {
            MetadataSyncManager().sync(metadata: metadata, for: outputURL.lastPathComponent) { _ in }
        }
        completion(outputURL)
    }

    /// Cancel any ongoing render
    public func cancel() {
        isRendering = false
    }
}

private extension Array {
    func chunked(into size: Int) -> [[Element]] {
        stride(from: 0, to: count, by: size).map { start in
            let end = Swift.min(start + size, count)
            return Array(self[start..<end])
        }
    }
}
