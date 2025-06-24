import Foundation

/// Generates a basic plugin template for Creator Dashboard extensions.
public struct PluginBuilder {
    public init() {}

    /// Creates a human readable template string for a plugin.
    /// - Parameters:
    ///   - name: Plugin name.
    ///   - features: Feature list to include in the template.
    /// - Returns: Multi-line template text.
    public func createTemplate(name: String, features: [String]) -> String {
        let header = "/// Generated Plugin Template"
        let featureList = features.map { "- \($0)" }.joined(separator: "\n")
        return [header, "Plugin: \(name)", "Features:", featureList].joined(separator: "\n")
    }

    /// Create a plugin template with co-pilot documentation attached.
    public func createIntegratedPlugin(name: String, features: [String], copilot: AICoPilot = AICoPilot()) -> String {
        let base = createTemplate(name: name, features: features)
        let docs = copilot.generateDocs(for: name)
        return base + "\n" + docs
    }
}
