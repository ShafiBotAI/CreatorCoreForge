import Foundation

/// In-memory community marketplace used for demos and tests. Items can
/// be published, removed and browsed. Persistence is intentionally
/// simple so the feature works without external storage.
public final class CommunityMarketplace {
    private var items: [String] = []

    public init() {}

    /// Publish an item to the marketplace. Returns `true` if it was added.
    @discardableResult
    public func publish(item: String) -> Bool {
        guard !item.isEmpty else { return false }
        items.append(item)
        return true
    }

    /// Remove an item from the marketplace.
    public func remove(item: String) {
        items.removeAll { $0 == item }
    }

    /// Retrieve all items currently published.
    public func browse() -> [String] { items }
}
