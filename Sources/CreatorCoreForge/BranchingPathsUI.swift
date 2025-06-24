import Foundation

/// Option for branching path selection.
public struct BranchOption: Equatable {
    public let id: String
    public init(id: String) { self.id = id }
}

/// Stub UI helper that returns the option identifiers for display.
public struct BranchingPathsUI {
    public init() {}
    public func render(options: [BranchOption]) -> [String] {
        options.map { $0.id }
    }
}
