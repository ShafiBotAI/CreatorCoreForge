import Foundation

/// Represents a collaborator role within a Build project.
public enum CollaboratorRole: String, Codable {
    case owner
    case admin
    case developer
    case reviewer
    case viewer
    case commenter
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

    /// Lookup a collaborator's role by user ID.
    public func role(for userID: String) -> CollaboratorRole? {
        collaborators.first { $0.userID == userID }?.role
    }

    /// Promote or demote a collaborator to a new role.
    public func promote(userID: String, to newRole: CollaboratorRole) {
        if let index = collaborators.firstIndex(where: { $0.userID == userID }) {
            let current = collaborators[index]
            collaborators[index] = Collaborator(userID: current.userID, role: newRole, expires: current.expires)
            auditTrail.record(userID: userID, action: "role:\(newRole.rawValue)")
        }
    }

    /// Check if the collaborator may view project content.
    public func canView(userID: String) -> Bool {
        guard let role = role(for: userID) else { return false }
        switch role {
        case .owner, .admin, .developer, .reviewer, .viewer, .commenter:
            return true
        case .guest:
            return false
        }
    }

    /// Check if the collaborator may edit project content.
    public func canEdit(userID: String) -> Bool {
        guard let role = role(for: userID) else { return false }
        switch role {
        case .owner, .admin, .developer:
            return true
        default:
            return false
        }
    }

    /// Check if the collaborator may comment on project content.
    public func canComment(userID: String) -> Bool {
        guard let role = role(for: userID) else { return false }
        switch role {
        case .owner, .admin, .developer, .reviewer, .commenter:
            return true
        default:
            return false
        }
    }

    /// Record API access for auditing purposes.
    public func logAPIAccess(userID: String, endpoint: String) {
        auditTrail.record(userID: userID, action: "api:\(endpoint)")
    }

    /// Full audit history for sharing events.
    public func history() -> [AuditEvent] { auditTrail.history() }
}
