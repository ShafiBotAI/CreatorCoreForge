import Foundation

/// Simple engine that converts text snippets into executable plugins.
/// Only a limited mini-syntax is supported.
public final class CustomCodeInjector {
    public init() {}

    /// Parses a snippet and returns a plugin when possible.
    /// Currently supports "replace:token=value" rule.
    public func plugin(from snippet: String) -> FusionEnginePlugin? {
        guard snippet.hasPrefix("replace:") else { return nil }
        let remainder = snippet.dropFirst("replace:".count)
        let parts = remainder.split(separator: "=", maxSplits: 1).map(String.init)
        guard parts.count == 2 else { return nil }
        let token = parts[0]
        let value = parts[1]
        return CodePlugin(name: "replace-\(token)") { prompt in
            prompt.replacingOccurrences(of: token, with: value)
        } responseTransform: { $0 }
    }
}

/// Plugin backed by closures for prompt and response transformation.
public struct CodePlugin: FusionEnginePlugin {
    public var name: String
    let promptTransform: (String) -> String
    let responseTransform: (String) -> String

    public init(name: String,
                promptTransform: @escaping (String) -> String,
                responseTransform: @escaping (String) -> String) {
        self.name = name
        self.promptTransform = promptTransform
        self.responseTransform = responseTransform
    }

    public func processPrompt(_ prompt: String) -> String {
        promptTransform(prompt)
    }

    public func processResponse(_ response: String) -> String {
        responseTransform(response)
    }
}
