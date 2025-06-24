import Foundation

/// FusionEngine plugin that logs prompts and responses for debugging.
public struct LoggingPlugin: FusionEnginePlugin {
    private let logger: AnalyticsLogger

    public init(logger: AnalyticsLogger = AnalyticsLogger()) {
        self.logger = logger
    }

    public func processPrompt(_ prompt: String) -> String {
        logger.log(event: "Prompt: \(prompt)")
        return prompt
    }

    public func processResponse(_ response: String) -> String {
        logger.log(event: "Response: \(response)")
        return response
    }
}
