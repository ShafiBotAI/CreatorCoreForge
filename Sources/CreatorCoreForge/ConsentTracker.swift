import Foundation
#if canImport(Combine)
import Combine

/// Tracks user consent events and monitors for safe-word triggers.
public final class ConsentTracker: ObservableObject {
    public static let shared = ConsentTracker()
    public init() {}

    public struct ConsentEvent: Identifiable, Codable {
        public var id: UUID = UUID()
        public var userID: String
        public var consentGiven: Bool
        public var date: Date
    }

    @Published public private(set) var events: [ConsentEvent] = []
    @Published public var safeWord: String = "red"

    public func logConsent(userID: String, consent: Bool) {
        let event = ConsentEvent(userID: userID, consentGiven: consent, date: Date())
        events.append(event)
    }

    /// Returns true when the supplied text contains the configured safe word.
    public func containsSafeWord(_ text: String) -> Bool {
        text.lowercased().contains(safeWord.lowercased())
    }

    public func lastConsent(for userID: String) -> ConsentEvent? {
        events.last { $0.userID == userID }
    }
}
#else

public final class ConsentTracker {
    public static let shared = ConsentTracker()
    public init() {}

    public struct ConsentEvent: Identifiable, Codable {
        public var id: UUID = UUID()
        public var userID: String
        public var consentGiven: Bool
        public var date: Date
    }

    public private(set) var events: [ConsentEvent] = []
    public var safeWord: String = "red"

    public func logConsent(userID: String, consent: Bool) {
        let event = ConsentEvent(userID: userID, consentGiven: consent, date: Date())
        events.append(event)
    }

    public func containsSafeWord(_ text: String) -> Bool {
        text.lowercased().contains(safeWord.lowercased())
    }

    public func lastConsent(for userID: String) -> ConsentEvent? {
        events.last { $0.userID == userID }
    }
}
#endif

// Example usage:
// ConsentTracker.shared.logConsent(userID: "user1", consent: true)
// if ConsentTracker.shared.containsSafeWord("stop now") { pausePlayback() }
