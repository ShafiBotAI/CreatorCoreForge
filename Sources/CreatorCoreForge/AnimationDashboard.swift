import Foundation

/// Tracks animation previews and lock states for characters.
public final class AnimationDashboard {
    private var lockedCharacters: Set<String> = []

    public init() {}

    /// Preview a character animation and return a summary string.
    public func preview(animation: String) -> String {
        "Previewing " + animation
    }

    /// Lock animations for a character so they cannot change.
    public func lockAnimation(for character: String) {
        lockedCharacters.insert(character.lowercased())
    }

    /// Whether a character's animations are locked.
    public func isLocked(_ character: String) -> Bool {
        lockedCharacters.contains(character.lowercased())
    }
}
