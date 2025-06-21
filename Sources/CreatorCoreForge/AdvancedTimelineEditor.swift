import Foundation

/// Lightweight timeline editor for playback controls.
/// Allows insertion, removal and lookup of markers by time stamp.
public final class AdvancedTimelineEditor {
    private var markers: [Double: String] = [:]

    public init() {}

    /// Insert a timeline marker at the provided time stamp.
    /// Existing markers at the same time will be replaced.
    public func insert(marker: String, at time: Double) {
        markers[time] = marker
    }

    /// Remove a marker at a specific time.
    @discardableResult
    public func removeMarker(at time: Double) -> String? {
        return markers.removeValue(forKey: time)
    }

    /// Retrieve a marker at the requested time.
    public func marker(at time: Double) -> String? {
        markers[time]
    }

    /// All markers sorted by time.
    public func allMarkers() -> [(time: Double, marker: String)] {
        markers.keys.sorted().map { ($0, markers[$0]!) }
    }
}
