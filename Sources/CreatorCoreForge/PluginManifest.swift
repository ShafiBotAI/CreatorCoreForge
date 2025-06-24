import Foundation

/// Metadata describing a plugin's inputs and outputs.
public struct PluginManifest: Codable {
    public var name: String
    public var version: String
    public var inputs: [String]
    public var outputs: [String]
    public var permissions: [String]
}
