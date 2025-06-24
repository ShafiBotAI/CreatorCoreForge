import Foundation

/// Basic in-memory plugin marketplace with ratings and version history.
public final class PluginMarketplace {
    private var plugins: [String: PluginManifest] = [:]
    private var ratings: [String: [Int]] = [:]
    private var history: [String: [PluginManifest]] = [:]
    private var reviews: [String: [String]] = [:]
    private var usage: [String: Int] = [:]
    public init() {}

    public func publish(_ manifest: PluginManifest) {
        plugins[manifest.name] = manifest
        history[manifest.name, default: []].append(manifest)
    }

    public func manifest(named name: String) -> PluginManifest? {
        plugins[name]
    }

    public func addRating(for name: String, rating: Int) {
        ratings[name, default: []].append(max(1, min(5, rating)))
    }

    public func addReview(for name: String, review: String) {
        reviews[name, default: []].append(review)
    }

    public func reviews(for name: String) -> [String] {
        reviews[name] ?? []
    }

    public func recordUsage(for name: String) {
        usage[name, default: 0] += 1
    }

    public func usageCount(for name: String) -> Int {
        usage[name] ?? 0
    }

    public func averageRating(for name: String) -> Double {
        let values = ratings[name] ?? []
        guard !values.isEmpty else { return 0 }
        return Double(values.reduce(0, +)) / Double(values.count)
    }

    public func versionHistory(for name: String) -> [PluginManifest] {
        history[name] ?? []
    }

    /// Rollback the currently published plugin to a previous version index.
    @discardableResult
    public func rollback(name: String, toVersion index: Int) -> Bool {
        guard var versions = history[name], index >= 0, index < versions.count else { return false }
        let manifest = versions[index]
        plugins[name] = manifest
        // Truncate history to index
        versions = Array(versions.prefix(index + 1))
        history[name] = versions
        return true
    }
}
