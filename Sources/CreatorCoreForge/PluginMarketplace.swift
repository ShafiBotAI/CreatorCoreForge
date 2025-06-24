import Foundation

/// Basic in-memory plugin marketplace with ratings and version history.
public final class PluginMarketplace {
    private var plugins: [String: PluginManifest] = [:]
    private var ratings: [String: [Int]] = [:]
    private var history: [String: [PluginManifest]] = [:]
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

    public func averageRating(for name: String) -> Double {
        let values = ratings[name] ?? []
        guard !values.isEmpty else { return 0 }
        return Double(values.reduce(0, +)) / Double(values.count)
    }

    public func versionHistory(for name: String) -> [PluginManifest] {
        history[name] ?? []
    }
}
