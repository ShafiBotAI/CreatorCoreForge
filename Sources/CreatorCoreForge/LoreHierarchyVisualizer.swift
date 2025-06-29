import Foundation

/// Creates a basic hierarchy representation for lore elements.
public struct LoreHierarchyNode: Codable, Equatable {
    public let name: String
    public var children: [LoreHierarchyNode]
    public init(name: String, children: [LoreHierarchyNode] = []) {
        self.name = name
        self.children = children
    }
}

public struct LoreHierarchyVisualizer {
    public init() {}

    public func buildHierarchy(race: String, kingdom: String, myth: String, artifact: String) -> LoreHierarchyNode {
        let artifactNode = LoreHierarchyNode(name: artifact)
        let mythNode = LoreHierarchyNode(name: myth, children: [artifactNode])
        let kingdomNode = LoreHierarchyNode(name: kingdom, children: [mythNode])
        let raceNode = LoreHierarchyNode(name: race, children: [kingdomNode])
        return raceNode
    }
}
