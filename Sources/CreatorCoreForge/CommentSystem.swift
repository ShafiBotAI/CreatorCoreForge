import Foundation

/// Represents a comment linked to a component or code block.
public struct Comment: Codable, Equatable {
    public let id: UUID
    public let userID: String
    public let text: String
    public let timestamp: Date

    public init(id: UUID = UUID(), userID: String, text: String, timestamp: Date = Date()) {
        self.id = id
        self.userID = userID
        self.text = text
        self.timestamp = timestamp
    }
}

/// Simple in-memory comment manager.
public final class CommentSystem {
    private var commentsByTarget: [String: [Comment]] = [:]

    public init() {}

    /// Add a comment for a given target identifier (e.g., component ID).
    public func addComment(targetID: String, userID: String, text: String) {
        let comment = Comment(userID: userID, text: text)
        commentsByTarget[targetID, default: []].append(comment)
    }

    /// Retrieve comments for a target.
    public func comments(for targetID: String) -> [Comment] {
        commentsByTarget[targetID] ?? []
    }
}
