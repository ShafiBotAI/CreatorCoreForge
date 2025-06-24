import Foundation

/// Represents relationships between characters and events across books.
public final class CanonMemoryGraph {
    public struct Node: Codable, Hashable {
        public let id: String
        public init(id: String) { self.id = id }
    }

    private var edges: [Node: Set<Node>] = [:]
    private let fileURL: URL

    public init(fileURL: URL? = nil) {
        if let url = fileURL {
            self.fileURL = url
        } else {
            let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            self.fileURL = dir.appendingPathComponent("canon_graph.json")
        }
        load()
    }

    /// Add a connection between two nodes.
    public func link(_ a: Node, _ b: Node) {
        edges[a, default: []].insert(b)
        edges[b, default: []].insert(a)
        save()
    }

    /// Retrieve all linked nodes for the given node.
    public func links(for node: Node) -> [Node] {
        Array(edges[node] ?? [])
    }

    /// Remove all connections and nodes.
    public func clear() {
        edges.removeAll()
        save()
    }

    private func load() {
        if let data = try? Data(contentsOf: fileURL),
           let decoded = try? JSONDecoder().decode([String: [String]].self, from: data) {
            var result: [Node: Set<Node>] = [:]
            for (key, values) in decoded {
                let node = Node(id: key)
                result[node] = Set(values.map { Node(id: $0) })
            }
            edges = result
        }
    }

    private func save() {
        var encoded: [String: [String]] = [:]
        for (node, links) in edges {
            encoded[node.id] = links.map { $0.id }
        }
        if let data = try? JSONEncoder().encode(encoded) {
            try? data.write(to: fileURL)
        }
    }
}
