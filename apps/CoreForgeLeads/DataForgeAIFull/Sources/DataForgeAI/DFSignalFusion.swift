import Foundation

/// Utility that merges multiple signal sources into a unified score table.
public struct DFSignalFusion {
    public init() {}

    public func fuse(primary: [String], secondary: [String], tertiary: [String]) -> [String: Int] {
        var counts: [String: Int] = [:]
        for signal in primary { counts[signal, default: 0] += 3 }
        for signal in secondary { counts[signal, default: 0] += 2 }
        for signal in tertiary { counts[signal, default: 0] += 1 }
        return counts
    }
}
