import Foundation

/// Stores reusable logic block snippets.
public final class LogicBlockLibrary {
    private var blocks: [String: String] = [:]
    public init() {}

    public func addBlock(name: String, code: String) {
        blocks[name] = code
    }

    public func block(named name: String) -> String? {
        blocks[name]
    }
}
