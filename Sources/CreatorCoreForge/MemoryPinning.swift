#if canImport(Combine)
import Foundation
import Combine

/// Stores memorable events for characters with optional permanence.
public final class MemoryPinning: ObservableObject {
    /// Shared singleton instance.
    public static let shared = MemoryPinning()

    /// Represents a single pinned memory.
    public struct MemoryPin: Codable, Identifiable {
        public var id: UUID = UUID()
        public var timestamp: Date
        public var character: String
        public var eventSummary: String
        public var emotionalWeight: Float  // 0.0 to 1.0
        public var permanent: Bool

        public init(timestamp: Date,
                    character: String,
                    eventSummary: String,
                    emotionalWeight: Float,
                    permanent: Bool) {
            self.timestamp = timestamp
            self.character = character
            self.eventSummary = eventSummary
            self.emotionalWeight = emotionalWeight
            self.permanent = permanent
        }
    }

    @Published public var pinnedMemories: [MemoryPin] = []

    public init() {}

    /// Pin a new memory for a character.
    public func pinMemory(for character: String,
                          event: String,
                          weight: Float = 0.5,
                          permanent: Bool = false) {
        let pin = MemoryPin(timestamp: Date(),
                            character: character,
                            eventSummary: event,
                            emotionalWeight: weight,
                            permanent: permanent)
        pinnedMemories.append(pin)
    }

    /// Return pinned memories for a given character.
    public func getPinned(for character: String) -> [MemoryPin] {
        pinnedMemories.filter { $0.character.lowercased() == character.lowercased() }
    }

    /// Remove a memory pin by identifier.
    public func removePin(_ id: UUID) {
        pinnedMemories.removeAll { $0.id == id }
    }

    /// Remove all non-permanent pins.
    public func clearTemporaryPins() {
        pinnedMemories.removeAll { !$0.permanent }
    }

    /// Remove all stored pins.
    public func clearAllPins() {
        pinnedMemories.removeAll()
    }

    /// Generate a summary string for all of a character's pins.
    public func summary(for character: String) -> String {
        let pins = getPinned(for: character)
        return pins.map { "[\($0.timestamp)] \($0.eventSummary)" }.joined(separator: "\n")
    }
}
#else
import Foundation

public final class MemoryPinning {
    public static let shared = MemoryPinning()

    public struct MemoryPin: Codable, Identifiable {
        public var id: UUID = UUID()
        public var timestamp: Date
        public var character: String
        public var eventSummary: String
        public var emotionalWeight: Float
        public var permanent: Bool

        public init(timestamp: Date,
                    character: String,
                    eventSummary: String,
                    emotionalWeight: Float,
                    permanent: Bool) {
            self.timestamp = timestamp
            self.character = character
            self.eventSummary = eventSummary
            self.emotionalWeight = emotionalWeight
            self.permanent = permanent
        }
    }

    public var pinnedMemories: [MemoryPin] = []

    public func pinMemory(for character: String,
                          event: String,
                          weight: Float = 0.5,
                          permanent: Bool = false) {
        let pin = MemoryPin(timestamp: Date(),
                            character: character,
                            eventSummary: event,
                            emotionalWeight: weight,
                            permanent: permanent)
        pinnedMemories.append(pin)
    }

    public func getPinned(for character: String) -> [MemoryPin] {
        pinnedMemories.filter { $0.character.lowercased() == character.lowercased() }
    }

    public func removePin(_ id: UUID) {
        pinnedMemories.removeAll { $0.id == id }
    }

    public func clearTemporaryPins() {
        pinnedMemories.removeAll { !$0.permanent }
    }

    public func clearAllPins() {
        pinnedMemories.removeAll()
    }

    public func summary(for character: String) -> String {
        let pins = getPinned(for: character)
        return pins.map { "[\($0.timestamp)] \($0.eventSummary)" }.joined(separator: "\n")
    }
}
#endif

// Example:
// MemoryPinning.shared.pinMemory(for: "Nash", event: "confessed love to Zara", weight: 0.9, permanent: true)
