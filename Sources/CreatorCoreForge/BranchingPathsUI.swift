import Foundation

/// Option for branching path selection.
public struct BranchOption: Equatable {
    public let id: String
    public init(id: String) { self.id = id }
}

/// Simple helper that produces numbered labels for branching path options.
public struct BranchingPathsUI {
    public init() {}

    /// Render options as numbered strings suitable for display in a menu.
    public func render(options: [BranchOption]) -> [String] {
        options.enumerated().map { index, opt in
            "\(index + 1). \(opt.id)"
        }
    }
}
