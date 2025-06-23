import Foundation

/// Simple placeholder for a private vault with consent logging.
/// Stores entries in memory and logs user consent timestamps.
public class PrivateVault {
    private var logs: [Date] = []
    private var entries: [String] = []

    public init() {}

    /// Adds a private note and records consent time.
    public func addEntry(_ text: String) {
        entries.append(text)
        logs.append(Date())
    }

    /// Returns the number of stored entries.
    public var count: Int { entries.count }
}
