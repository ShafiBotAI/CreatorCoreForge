import Foundation

/// Coordinates video rendering for a sequence of scenes
public final class RendererControl {
    private var isRendering = false

    public init() {}

    /// Begin rendering process using a simple iterative engine.
    public func startRendering(scenes: [(scene: VideoScene, voice: String)], progress: @escaping (Double) -> Void) {
        guard !isRendering else { return }
        isRendering = true
        let total = Double(scenes.count)
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            for (index, _) in scenes.enumerated() {
                Thread.sleep(forTimeInterval: 0.01)
                DispatchQueue.main.async {
                    progress(Double(index + 1) / total)
                }
            }
            DispatchQueue.main.async { self?.isRendering = false }
        }
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

    /// Render a multi-hour video and write to disk incrementally. The scenes are
    /// rendered in chunks and appended to a simple text-based video log which
    /// mimics a final video file for demo purposes.
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
        let lines = scenes.map { "\($0.scene.id)|\($0.voice)" }.joined(separator: "\n")
        try? lines.write(to: outputURL, atomically: true, encoding: .utf8)
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
