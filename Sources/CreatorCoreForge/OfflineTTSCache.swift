import Foundation

/// Simple cache for offline Text-to-Speech audio data.
public final class OfflineTTSCache {
    private var cache: [String: Data] = [:]
    private let queue = DispatchQueue(label: "offline.tts.cache", attributes: .concurrent)

    public init() {}

    /// Stores voice data for a given key.
    public func store(_ data: Data, for key: String) {
        queue.async(flags: .barrier) { self.cache[key] = data }
    }

    /// Retrieves voice data for a key if available.
    public func data(for key: String) -> Data? {
        queue.sync { cache[key] }
    }

    /// Clears the entire cache.
    public func clear() {
        queue.async(flags: .barrier) { self.cache.removeAll() }
    }
}
