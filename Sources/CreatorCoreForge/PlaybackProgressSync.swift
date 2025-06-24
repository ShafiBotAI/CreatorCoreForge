import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// Synchronizes playback position across devices using SettingsSync.
public final class PlaybackProgressSync {
    private let sync: SyncService
    private let userID: String
    private let fileURL: URL
    private var cache: [String: Int] = [:]

    public init(userID: String,
                directory: URL? = nil,
                sync: SyncService = SettingsSync.shared) {
        self.userID = userID
        self.sync = sync
        let dir = directory ?? FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        self.fileURL = dir.appendingPathComponent("playback_progress.json")
        if let data = try? Data(contentsOf: fileURL),
           let obj = try? JSONDecoder().decode([String: Int].self, from: data) {
            self.cache = obj
        }
    }

    /// Save playback progress for a specific book and upload asynchronously.
    public func saveProgress(bookID: String, chapter: Int) {
        cache[bookID] = chapter
        persist()
        sync.upload(cache, userID: userID) { _ in }
    }

    /// Load playback progress, fetching from the remote service if needed.
    public func loadProgress(bookID: String, completion: @escaping (Int?) -> Void) {
        if let index = cache[bookID] {
            completion(index)
            return
        }
        sync.fetch(userID: userID) { [weak self] result in
            guard let self = self else { return }
            if let remote = result as? [String: Int] {
                self.cache = remote
                self.persist()
                completion(remote[bookID])
            } else {
                completion(nil)
            }
        }
    }

    private func persist() {
        if let data = try? JSONEncoder().encode(cache) {
            try? data.write(to: fileURL)
        }
    }
}
