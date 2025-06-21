import Foundation

/// Syncs playback progress with a companion watch app.
public final class WatchSyncService {
    private(set) var lastSyncedProgress: Double = 0

    public init() {}

    /// Sync the current playback progress to a companion watch app.
    /// The value is clamped between 0 and 1 for safety.
    public func sync(progress: Double) {
        lastSyncedProgress = min(max(progress, 0), 1)
    }
}
