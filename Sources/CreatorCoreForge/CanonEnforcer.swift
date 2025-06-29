import Foundation

/// Enforces basic canon rules by checking continuity with previous text.
public struct CanonEnforcer {
    public init() {}

    /// Returns true if the text contains any of the given canon facts.
    public func validate(text: String, canonFacts: [String]) -> Bool {
        let lower = text.lowercased()
        for fact in canonFacts.map({ $0.lowercased() }) {
            if lower.contains(fact) { return true }
        }
        return false
    }
}
