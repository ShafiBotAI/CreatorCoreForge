import Foundation

/// Stores version checkpoints and allows restore/compare operations.
public final class VersionHistory {
    private var versions: [String: Date] = [:]

    public init() {}

    /// Save a named version tag.
    public func saveVersion(tag: String) {
        versions[tag] = Date()
    }

    /// List available versions.
    public func allVersions() -> [String] {
        versions.keys.sorted()
    }

    /// Compare two versions and generate a simple diff summary.
    public func diff(from: String, to: String) -> String {
        guard versions[from] != nil, versions[to] != nil else { return "" }
        return "Diff between \(from) and \(to)"
    }
}
