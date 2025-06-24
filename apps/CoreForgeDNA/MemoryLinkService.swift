import Foundation

/// Service responsible for linking character DNA across apps.
/// This mock implementation only stores IDs for demonstration.
public class MemoryLinkService {
    private var linkedIDs: Set<String> = []

    public init() {}

    public func link(id: String) {
        linkedIDs.insert(id)
    }

    public func isLinked(id: String) -> Bool {
        return linkedIDs.contains(id)
    }
}
