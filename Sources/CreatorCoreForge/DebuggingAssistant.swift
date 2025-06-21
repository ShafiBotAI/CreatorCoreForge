import Foundation

/// Provides basic debugging hints for build issues.
public struct DebuggingAssistant {
    public init() {}
    /// Generates simple hints based on a log message.
    public func hints(for message: String) -> [String] {
        guard !message.isEmpty else { return [] }
        return ["Check configuration for \(message)"]
    }
}
