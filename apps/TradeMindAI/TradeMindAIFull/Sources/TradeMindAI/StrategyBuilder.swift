import Foundation

/// Uses OpenAIService to generate trading strategies from plain text prompts.
public final class StrategyBuilder {
    private let service: OpenAIService
    private let template: String

    /// - Parameters:
    ///   - service: OpenAIService for network calls.
    ///   - template: Optional template. `{prompt}` will be replaced with the user prompt.
    init(service: OpenAIService, template: String = "Create a concise trading strategy for: {prompt}") {
        self.service = service
        self.template = template
    }

    /// Sends the prompt to OpenAI and returns a generated strategy string.
    public func generateStrategy(from prompt: String, completion: @escaping (Result<String, Error>) -> Void) {
        let merged = template.replacingOccurrences(of: "{prompt}", with: prompt)
        service.sendPrompt(merged, completion: completion)
    }
}
