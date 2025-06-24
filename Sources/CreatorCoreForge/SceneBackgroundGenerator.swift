import Foundation

/// Generates background identifiers for scenes based on genre keywords.
public struct SceneBackgroundGenerator {
    public init() {}

    public func generateBackground(for genre: String) -> String {
        "background-" + genre.lowercased().replacingOccurrences(of: " ", with: "_")
    }
}
