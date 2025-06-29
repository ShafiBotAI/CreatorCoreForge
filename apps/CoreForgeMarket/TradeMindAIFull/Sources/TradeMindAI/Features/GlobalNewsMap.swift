import Foundation

/// Maps news headlines to simplified region identifiers.
public struct GlobalNewsMap {
    public init() {}

    public func map(headlines: [String: String]) -> [String: [String]] {
        var result: [String: [String]] = [:]
        for (region, text) in headlines {
            result[region, default: []].append(text)
        }
        return result
    }
}
