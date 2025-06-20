import Foundation

/// Protocol describing a FusionEngine plugin that can process prompts and responses.
public protocol FusionEnginePlugin {
    /// Allows the plugin to transform an outgoing prompt before it is sent.
    func processPrompt(_ prompt: String) -> String
    /// Allows the plugin to transform an incoming response before it is returned.
    func processResponse(_ response: String) -> String
}
