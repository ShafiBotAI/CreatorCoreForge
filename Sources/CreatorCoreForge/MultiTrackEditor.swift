import Foundation

/// Edits multiple audio tracks and performs a simple mixdown.
public final class MultiTrackEditor {
    public init() {}

    public func mix(tracks: [[Int]]) -> [Int] {
        guard let longest = tracks.map({ $0.count }).max() else { return [] }
        var result = Array(repeating: 0, count: longest)
        for track in tracks {
            for (i, sample) in track.enumerated() {
                result[i] += sample
            }
        }
        return result
    }
}
