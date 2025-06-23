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

/// Placeholder visualizer that converts the tree into a simple text diagram.
public struct DNATreeVisualizer {
    public static func render(_ root: DNATreeNode) -> String {
        func helper(_ node: DNATreeNode, _ prefix: String) -> String {
            var result = prefix + "- " + node.name + "\n"
            for child in node.children {
                result += helper(child, prefix + "  ")
            }
            return result
        }
        return helper(root, "")
    }
}
