import Foundation

/// Tracks free voice revisions for an audiobook project.
public final class VoiceRevisionManager {
    private let defaults: UserDefaults
    private let dateKeyPrefix = "VRM_Date_"
    private let countKeyPrefix = "VRM_Count_"
    private let freeLimit = 5
    private let freeDays = 30

    public init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    /// Returns true if a revision can be made without credits.
    public func canRevise(bookID: String) -> Bool {
        resetIfNeeded(bookID: bookID)
        return defaults.integer(forKey: countKeyPrefix + bookID) < freeLimit
    }

    /// Record a revision for the given book.
    public func recordRevision(bookID: String) {
        resetIfNeeded(bookID: bookID)
        let key = countKeyPrefix + bookID
        defaults.set(defaults.integer(forKey: key) + 1, forKey: key)
    }

    /// Indicates whether credits are required for another revision.
    public func requiresCredit(bookID: String) -> Bool {
        !canRevise(bookID: bookID)
    }

    private func resetIfNeeded(bookID: String) {
        let dateKey = dateKeyPrefix + bookID
        let countKey = countKeyPrefix + bookID
        let now = Date()
        if let created = defaults.object(forKey: dateKey) as? Date {
            if let days = Calendar.current.dateComponents([.day], from: created, to: now).day, days >= freeDays {
                defaults.set(now, forKey: dateKey)
                defaults.set(0, forKey: countKey)
            }
        } else {
            defaults.set(now, forKey: dateKey)
            defaults.set(0, forKey: countKey)
        }
    }
}
