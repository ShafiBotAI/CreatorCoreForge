import Foundation

/// Generates simple accent tags for a phrase.
public struct AccentGenerator {
    public enum Accent: String, CaseIterable {
        case american, british, australian
    }
    public init() {}

    /// Prefix the phrase with the accent label.
    public func applyAccent(_ accent: Accent, to phrase: String) -> String {
        "[\(accent.rawValue.capitalized)] " + phrase
    }
}
