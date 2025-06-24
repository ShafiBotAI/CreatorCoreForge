import Foundation

/// Records user actions for auditing purposes.
public struct AuditEvent: Codable, Equatable {
    public let userID: String
    public let action: String
    public let timestamp: Date
    public init(userID: String, action: String, timestamp: Date = Date()) {
        self.userID = userID
        self.action = action
        self.timestamp = timestamp
    }
}

/// Simple in-memory audit trail.
public final class AuditTrail {
    private var events: [AuditEvent] = []
    public init() {}
    
    /// Record an event.
    public func record(userID: String, action: String) {
        let event = AuditEvent(userID: userID, action: action)
        events.append(event)
    }
    
    /// Return all recorded events.
    public func history() -> [AuditEvent] {
        events
    }
}
