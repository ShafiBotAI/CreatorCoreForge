import Foundation

/// Simulates a sandbox environment for plugin testing.
public final class PluginSandbox {
    public init() {}
    public func run(_ manifest: PluginManifest) -> Bool {
        // In a real system this would load and execute the plugin.
        // Here we simply validate the manifest and return success.
        return !manifest.name.isEmpty
    }
}
