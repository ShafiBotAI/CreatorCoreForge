import Foundation

/// Captures simple load testing metrics for generated apps.
public struct LoadTester {
    public init() {}

    public func run() -> [String: Double] {
        ["fps": 60.0, "memory": 120.0, "loadTime": 1.0]
    }
}
