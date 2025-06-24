import Foundation

/// Loads plugin manifests from disk and validates required fields.
public final class PluginLoader {
    public init() {}

    public func loadManifest(at url: URL) -> PluginManifest? {
        guard let data = try? Data(contentsOf: url) else { return nil }
        return try? JSONDecoder().decode(PluginManifest.self, from: data)
    }

    /// Load all manifest JSON files inside a directory.
    public func loadPlugins(in directory: URL) -> [PluginManifest] {
        guard let files = try? FileManager.default.contentsOfDirectory(at: directory, includingPropertiesForKeys: nil) else { return [] }
        return files.compactMap { file in
            guard file.pathExtension == "json" else { return nil }
            return loadManifest(at: file)
        }
    }

    public func validate(manifest: PluginManifest) -> Bool {
        guard !manifest.name.isEmpty, !manifest.version.isEmpty else { return false }
        if manifest.premium { return manifest.price != nil }
        return true
    }

    /// Import a plugin from a GitHub repository using the pull_plugins.py script.
    /// - Parameters:
    ///   - repo: Repository in owner/name form.
    ///   - branch: Optional branch, defaults to master.
    ///   - dest: Destination directory for downloaded content.
    public func importFromGitHub(repo: String, branch: String = "master", dest: URL) throws {
        let scriptURL = URL(fileURLWithPath: #file)
            .deletingLastPathComponent().deletingLastPathComponent()
            .appendingPathComponent("scripts/pull_plugins.py")
        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/usr/bin/python3")
        process.arguments = [scriptURL.path, repo, dest.path, branch]
        try process.run()
        process.waitUntilExit()
    }
}
