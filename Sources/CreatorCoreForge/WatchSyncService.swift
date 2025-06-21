import Foundation

/// Basic in-memory sync service to share settings with an Apple Watch.
public final class WatchSyncService: SyncService {
    private var storage: [String: [String: Any]] = [:]

    public init() {}

    public func upload(_ settings: [String : Any], userID: String, completion: @escaping (Bool) -> Void) {
        storage[userID] = settings
        completion(true)
    }

    public func fetch(userID: String, completion: @escaping ([String : Any]?) -> Void) {
        completion(storage[userID])
    }
}
