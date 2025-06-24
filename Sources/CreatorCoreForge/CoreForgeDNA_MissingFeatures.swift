import Foundation

public struct DNATreeNode {
    public var name: String
    public var children: [DNATreeNode]
    public init(name: String, children: [DNATreeNode] = []) {
        self.name = name
        self.children = children
    }
}

public struct CoreForgeDNAFeatures {
    public init() {}

    public func visualize(_ root: DNATreeNode) -> [String] {
        var result: [String] = []
        func walk(_ node: DNATreeNode) {
            result.append(node.name)
            node.children.forEach { walk($0) }
        }
        walk(root)
        return result
    }

    public func export(profile: [String: String]) -> Data {
        (try? JSONSerialization.data(withJSONObject: profile)) ?? Data()
    }

    public func importProfile(data: Data) -> [String: String] {
        (try? JSONSerialization.jsonObject(with: data)) as? [String: String] ?? [:]
    }

    public func merge(timelineA: [String], timelineB: [String]) -> [String] {
        Array(Set(timelineA + timelineB)).sorted()
    }
}
