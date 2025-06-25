import Foundation

/// Tracks character appearances across multiple books for continuity.
public final class MemoryTracker {
    private var memory: [String: Set<String>] = [:] // bookID -> character names

    public init() {}

    /// Record that a character appears in a given book.
    public func add(character: String, in book: String) {
        memory[book, default: []].insert(character)
    }

    /// Retrieve all characters for a book.
    public func characters(in book: String) -> [String] {
        Array(memory[book] ?? [])
    }

    /// Remove all memory for a particular book.
    public func clear(book: String) {
        memory[book] = nil
    }
}
