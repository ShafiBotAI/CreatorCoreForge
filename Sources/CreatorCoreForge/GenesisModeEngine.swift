import Foundation

/// Generates variant ideas for new apps or features.
public struct GenesisModeEngine {
    public init() {}

    /// Produce a list of variant strings for the given seed idea.
    /// - Parameters:
    ///   - idea: Base idea text.
    ///   - count: Number of variants to create.
    public func generateVariants(for idea: String, count: Int = 3) -> [String] {
        guard count > 0 else { return [] }
        return (1...count).map { "\(idea) Variant \($0)" }
    }
}
