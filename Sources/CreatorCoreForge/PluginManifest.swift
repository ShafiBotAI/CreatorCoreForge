import Foundation

/// Metadata describing a plugin's inputs and outputs.
public struct PluginManifest: Codable {
    public var name: String
    public var version: String
    public var inputs: [String]
    public var outputs: [String]
    public var permissions: [String]
    /// Whether the plugin requires payment.
    public var premium: Bool
    /// Optional price in USD if premium is enabled.
    public var price: Double?

    public init(name: String,
                version: String,
                inputs: [String],
                outputs: [String],
                permissions: [String],
                premium: Bool = false,
                price: Double? = nil) {
        self.name = name
        self.version = version
        self.inputs = inputs
        self.outputs = outputs
        self.permissions = permissions
        self.premium = premium
        self.price = price
    }
}
