import Foundation

/// Represents a short segment of narration from a specific character's POV.
public struct POVSegment: Codable, Equatable {
    public let character: String
    public let text: String
    public init(character: String, text: String) {
        self.character = character
        self.text = text
    }
}

/// Builds a scene by combining multiple POV segments in sequence.
public final class MultiPOVSceneBuilder {
    private var segments: [POVSegment] = []

    public init() {}

    /// Add a segment from a character's point of view.
    public func addSegment(character: String, text: String) {
        let segment = POVSegment(character: character, text: text)
        segments.append(segment)
    }

    /// Compose the final scene string with "Character: line" formatting.
    public func buildScene() -> String {
        segments.map { "\($0.character): \($0.text)" }.joined(separator: "\n")
    }

    public func reset() {
        segments.removeAll()
    }
}

