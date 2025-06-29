import Foundation

/// Tracks character growth milestones across a story timeline.
public final class CharacterGrowthTracker {
    public struct Event: Codable, Equatable {
        public let chapter: Int
        public let description: String
        public init(chapter: Int, description: String) {
            self.chapter = chapter
            self.description = description
        }
    }

    private var events: [String: [Event]] = [:]

    public init() {}

    /// Record a growth event for a character.
    public func record(character: String, chapter: Int, description: String) {
        var list = events[character, default: []]
        list.append(Event(chapter: chapter, description: description))
        events[character] = list.sorted { $0.chapter < $1.chapter }
    }

    /// Return the timeline of events for a character.
    public func timeline(for character: String) -> [Event] {
        events[character] ?? []
    }
}
