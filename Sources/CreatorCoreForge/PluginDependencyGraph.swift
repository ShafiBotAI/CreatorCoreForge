import Foundation

/// Tracks plugin dependencies for visualizing logic flow.
public struct PluginDependencyGraph {
    private var edges: [String: [String]] = [:]
    public init() {}

    /// Register a plugin and its dependencies.
    public mutating func addPlugin(_ name: String, dependencies: [String]) {
        edges[name] = dependencies
    }

    /// Retrieve dependencies for a given plugin.
    public func dependencies(for name: String) -> [String] {
        edges[name] ?? []
    }

    /// Generate a simple textual representation of the graph.
    public func description() -> String {
        edges.map { "\($0.key) -> \($0.value.joined(separator: ","))" }
            .joined(separator: "\n")
    }
}
