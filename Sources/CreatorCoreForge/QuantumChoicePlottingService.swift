import Foundation

/// Combines branching story choices into a unique sorted list.
public struct QuantumChoicePlottingService {
    public init() {}
    public func plot(paths: [[String]]) -> [String] {
        Array(Set(paths.flatMap { $0 })).sorted()
    }
}
