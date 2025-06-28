import Foundation

/// Determines a basic pitch curve for sentences.
public final class ProsodyCurveManager {
    public init() {}

    /// Returns a label describing the pitch curve for a sentence.
    public func curveType(for sentence: String) -> String {
        let trimmed = sentence.trimmingCharacters(in: .whitespaces)
        if trimmed.hasSuffix("?") { return "rise" }
        if trimmed.hasSuffix("!") { return "burst" }
        return "fall"
    }
}
