import Foundation

/// Stores prompt and response history for contextual AI conversations.
public final class ContextualMemory {
    private var entries: [(prompt: String, response: String)] = []
    private let limit: Int

    /// Creates a new memory container keeping the most recent `limit` entries.
    public init(limit: Int = 10) {
        self.limit = limit
    }

    /// Adds a prompt/response pair to the memory.
    public func add(prompt: String, response: String) {
        entries.append((prompt, response))
        while entries.count > limit {
            entries.removeFirst()
        }
    }

    /// Returns a combined context string of all stored entries.
    public func contextString() -> String {
        entries.map { "Q: \($0.prompt)\nA: \($0.response)" }.joined(separator: "\n")
    }

    /// Clears all stored history.
    public func clear() {
        entries.removeAll()
    }
}
