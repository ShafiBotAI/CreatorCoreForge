import Foundation

/// Loads plugin manifests from disk and validates required fields.
public final class PluginLoader {
    public init() {}

    public func loadManifest(at url: URL) -> PluginManifest? {
        guard let data = try? Data(contentsOf: url) else { return nil }
        return try? JSONDecoder().decode(PluginManifest.self, from: data)
    }

    public func validate(manifest: PluginManifest) -> Bool {
        !manifest.name.isEmpty && !manifest.version.isEmpty
    }
}
