import Foundation

public final class MoodJournal {
    private var entries: [Date: String] = [:]
    public init() {}
    public func addEntry(_ text: String, date: Date = Date()) {
        entries[date] = text
    }
    public var count: Int { entries.count }
}

public struct GuidedSessions {
    public func play(session: String) -> String {
        "Playing \(session)"
    }
}

public final class PrivateVault {
    private var store: [String: String] = [:]
    public init() {}
    public func save(key: String, value: String) { store[key] = value }
    public func fetch(key: String) -> String? { store[key] }
}
