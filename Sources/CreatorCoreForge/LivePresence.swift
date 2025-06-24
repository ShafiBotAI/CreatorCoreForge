import Foundation

/// Tracks real-time collaborator presence in a session.
public final class LivePresence {
    private var activeUsers: Set<String> = []
    public init() {}

    /// Mark a user as active.
    public func join(userID: String) {
        activeUsers.insert(userID)
    }

    /// Mark a user as inactive.
    public func leave(userID: String) {
        activeUsers.remove(userID)
    }

    /// List all active users.
    public func currentUsers() -> [String] {
        Array(activeUsers)
    }
}
