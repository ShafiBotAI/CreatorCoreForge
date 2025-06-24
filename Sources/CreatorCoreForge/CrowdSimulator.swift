import Foundation

/// Represents a member of a simulated crowd.
public struct CrowdMember: Equatable {
    public let id: Int
    public init(id: Int) { self.id = id }
}

/// Simple crowd simulator returning members with incremental ids.
public final class CrowdSimulator {
    public init() {}
    public func simulate(count: Int) -> [CrowdMember] {
        guard count > 0 else { return [] }
        return (0..<count).map { CrowdMember(id: $0) }
    }
}
