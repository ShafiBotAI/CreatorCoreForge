import Foundation

/// Represents a collaborator role within a Build project.
public enum CollaboratorRole: String, Codable {
    case owner
    case admin
    case developer
    case viewer
    case guest
}

/// Single collaborator entry with role and expiration for guests.
public struct Collaborator: Codable, Equatable {
    public let userID: String
    public let role: CollaboratorRole
    public let expires: Date?
    public init(userID: String, role: CollaboratorRole, expires: Date? = nil) {
        self.userID = userID
        self.role = role
        self.expires = expires
    }
}

/// Manages project sharing and collaborator audit history.
public final class ProjectSharingManager {
    private var collaborators: [Collaborator] = []
    private var auditTrail = AuditTrail()

    public init() {}

    /// Invite a collaborator to the project.
    @discardableResult
    public func invite(_ collaborator: Collaborator) -> Bool {
        collaborators.append(collaborator)
        auditTrail.record(userID: collaborator.userID, action: "invited")
        return true
    }

    /// Remove a collaborator by userID.
    public func revoke(userID: String) {
        collaborators.removeAll { $0.userID == userID }
        auditTrail.record(userID: userID, action: "revoked")
    }

    /// Current list of active collaborators (ignores expired guests).
    public func activeCollaborators() -> [Collaborator] {
        let now = Date()
        return collaborators.filter { collab in
            if let exp = collab.expires { return exp > now } else { return true }
        }
    }

    /// Full audit history for sharing events.
    public func history() -> [AuditEvent] { auditTrail.history() }
}
