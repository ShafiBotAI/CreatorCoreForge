import Foundation

/// Suggests color palette and lighting based on timeline branch.
public struct TimelineBranchAdvisor {
    private let suggestions: [String: (palette: String, lighting: String)] = [
        "A": ("Warm", "Bright"),
        "B": ("Cool", "Dim"),
        "Prime": ("Neutral", "Balanced")
    ]

    public init() {}

    public func recommendation(for branch: String) -> (palette: String, lighting: String) {
        suggestions[branch] ?? ("Default", "Standard")
    }
}
