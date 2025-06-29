import Foundation

/// Enforces lore references across books.
public struct LoreReferenceEnforcer {
    public init() {}

    /// Returns a list of required references not found in the text.
    public func missingReferences(in text: String, required: [String]) -> [String] {
        let lower = text.lowercased()
        return required.filter { !lower.contains($0.lowercased()) }
    }
}
