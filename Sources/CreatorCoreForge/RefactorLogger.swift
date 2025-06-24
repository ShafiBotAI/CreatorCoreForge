import Foundation

/// Logs co-pilot suggestions that were applied by the user.
public final class RefactorLogger {
    private var entries: [String] = []
    public init() {}

    public func record(_ message: String) {
        entries.append("\(Date()): \(message)")
    }

    public func allLogs() -> [String] { entries }
}
