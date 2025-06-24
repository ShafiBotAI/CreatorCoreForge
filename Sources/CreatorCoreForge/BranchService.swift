import Foundation

/// Tracks alternate story branches.
public final class BranchService {
    private var branches: [String: String] = [:]
    public init() {}

    public func addBranch(id: String, text: String) {
        branches[id] = text
    }

    public func branch(for id: String) -> String? {
        branches[id]
    }
}
