import Foundation

/// Collects session logs that can be exported for parental or creator review.
public final class ParentReportManager {
    public static let shared = ParentReportManager()

    private var log: [String] = []

    private init() {}

    /// Record a single event line.
    public func record(_ event: String) {
        log.append(event)
    }

    /// Export the log as a newline separated string.
    public func exportReport() -> String {
        log.joined(separator: "\n")
    }

    public func clear() {
        log.removeAll()
    }
}
