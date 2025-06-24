import Foundation

/// Simple struct representing a render metric.
public struct RenderMetric: Equatable {
    public let name: String
    public let value: Double
    public init(name: String, value: Double) {
        self.name = name
        self.value = value
    }
}

/// Minimal analytics dashboard that formats metrics for display.
public struct RenderAnalyticsDashboard {
    public init() {}
    public func display(metrics: [RenderMetric]) -> String {
        metrics.map { "\($0.name): \($0.value)" }.joined(separator: "\n")
    }
}
