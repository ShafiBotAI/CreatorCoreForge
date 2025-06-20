import Foundation

/// Simple plugin that performs token replacement on outgoing prompts.
public struct MacroPlugin: FusionEnginePlugin {
    public var macros: [String: String]

    public init(macros: [String: String]) {
        self.macros = macros
    }

    public func processPrompt(_ prompt: String) -> String {
        var result = prompt
        for (token, value) in macros {
            result = result.replacingOccurrences(of: token, with: value)
        }
        return result
    }

    public func processResponse(_ response: String) -> String {
        response
    }
}
