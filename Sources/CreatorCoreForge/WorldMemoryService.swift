import Foundation

/// Stores and retrieves simple world lore key-values.
public final class WorldMemoryService {
    private var store: [String: String] = [:]
    public init() {}

    public func remember(key: String, value: String) {
        store[key] = value
    }

    public func recall(key: String) -> String? {
        store[key]
    }
}
