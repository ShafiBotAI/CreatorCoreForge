import Foundation

public struct SeriesMemoryTracker {
    private var arcs: [String: [String]] = [:]
    public init() {}
    public mutating func record(book: String, events: [String]) {
        arcs[book] = events
    }
    public func allEvents() -> [String] {
        arcs.values.flatMap { $0 }
    }
}

public struct PromoCodeHandler {
    public init() {}
    public func apply(code: String, to total: Double) -> Double {
        if code.lowercased().hasPrefix("free") {
            return 0
        }
        return max(total - 5, 0)
    }
}

public struct WritingMoodTuner {
    public init() {}
    public func tune(text: String, mood: String) -> String {
        "\(mood): \(text)"
    }
}
