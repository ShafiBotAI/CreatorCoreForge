import Foundation

/// Handles editing operations across quantum branches.
public struct QuantumEditMode {
    public init() {}

    /// Returns a set of alternate edits for quantum timelines.
    public func branch(edits: [String]) -> [String] {
        edits.flatMap { [$0, $0] }
    }
}
