import Foundation

/// Basic in-memory sync service to share settings with an Apple Watch.
public final class WatchSyncService: SyncService {
    private var storage: [String: [String: Any]] = [:]
    private(set) var lastSyncedProgress: Double = 0

    public init() {}

    public func upload(_ settings: [String: Any], userID: String, completion: @escaping (Bool) -> Void) {
        storage[userID] = settings
        completion(true)
    }

    public func fetch(userID: String, completion: @escaping ([String: Any]?) -> Void) {
        completion(storage[userID])

    }

    /// Sync the current playback progress to a companion watch app.
    /// The value is clamped between 0 and 1 for safety.
    public func sync(progress: Double) {
        lastSyncedProgress = min(max(progress, 0), 1)

    }
}
