import Foundation

/// Synchronizes timelines for characters, locations, and events.
public struct TimelineSynchronizer {
    public init() {}

    /// Merge individual timelines into a combined timeline where the key is a
    /// timestamp and the value contains the associated entities.
    public func synchronize(characters: [String: [Int]],
                            locations: [String: [Int]],
                            events: [String: [Int]]) -> [Int: [String]] {
        var result: [Int: [String]] = [:]
        func insert(_ map: [String: [Int]], prefix: String) {
            for (entity, times) in map {
                for t in times {
                    result[t, default: []].append("\(prefix)\(entity)")
                }
            }
        }
        insert(characters, prefix: "C:")
        insert(locations, prefix: "L:")
        insert(events, prefix: "E:")
        return result
    }
}
