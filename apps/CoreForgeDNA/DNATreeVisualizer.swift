import Foundation

/// Basic data model for a character DNA tree node.
public class DNATreeNode {
    public var name: String
    public var children: [DNATreeNode]

    public init(name: String, children: [DNATreeNode] = []) {
        self.name = name
        self.children = children
    }
}

/// Renders a tree of DNA nodes using box-drawing characters.
public struct DNATreeVisualizer {
    public static func render(_ root: DNATreeNode) -> String {
        func helper(_ node: DNATreeNode, _ prefix: String, _ isLast: Bool) -> String {
            var line = prefix
            line += isLast ? "└─ " : "├─ "
            line += node.name + "\n"
            let nextPrefix = prefix + (isLast ? "   " : "│  ")
            for (idx, child) in node.children.enumerated() {
                line += helper(child, nextPrefix, idx == node.children.count - 1)
            }
            return line
        }
        return helper(root, "", true)
    }
}
