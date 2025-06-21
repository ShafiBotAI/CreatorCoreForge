import Foundation

/// Placeholder timeline editor for advanced playback controls.
public final class AdvancedTimelineEditor {
    private(set) var markers: [Double: String] = [:]

    public init() {}

    /// Insert a timeline marker at the provided time stamp.
    /// Existing markers at the same time will be replaced.
    public func insert(marker: String, at time: Double) {
        markers[time] = marker
    }
}
