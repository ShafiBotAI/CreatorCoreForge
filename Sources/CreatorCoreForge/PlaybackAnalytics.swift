import Foundation

/// Tracks playback events for analytics.
public final class PlaybackAnalytics {
    private var events: [String] = []
    public init() {}
    public func record(_ event: String) {
        events.append(event)
    }
    public func allEvents() -> [String] { events }
    public func reset() { events.removeAll() }
}
