import Foundation

/// Builds alternate timelines for multiverse storytelling.
public struct MultiverseTimelineBuilder {
    public init() {}

    public func build(base: [String], variants: [[String]]) -> [String: [String]] {
        var map: [String: [String]] = ["base": base]
        for (index, variant) in variants.enumerated() {
            map["variant\(index + 1)"] = variant
        }
        return map
    }
}
