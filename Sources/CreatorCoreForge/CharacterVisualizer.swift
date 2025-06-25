import Foundation

/// Responsible for generating simple avatar identifiers with emotion layers.
public struct CharacterVisualizer {
    public init() {}

    /// Render an avatar string for the character with a base emotion.
    public func renderAvatar(for name: String, emotion: String) -> String {
        "\(name)_avatar_\(emotion)"
    }

    /// Apply an emotion overlay to an existing avatar identifier.
    public func layerEmotion(_ emotion: String, on avatar: String) -> String {
        avatar + "_" + emotion
    }
}
