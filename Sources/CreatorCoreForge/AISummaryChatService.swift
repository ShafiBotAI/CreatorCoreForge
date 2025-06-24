import Foundation

/// Provides AI-powered summaries and chat responses for content.
public final class AISummaryChatService {
    private let service: OpenAIService

    public init(service: OpenAIService) {
        self.service = service
    }

    /// Return a short AI-generated summary for the given text.
    public func summarize(_ text: String, completion: @escaping (Result<String, Error>) -> Void) {
        service.summarize(text, completion: completion)
    }

    /// Send a chat prompt and receive a response string.
    public func chat(_ prompt: String, completion: @escaping (Result<String, Error>) -> Void) {
        service.sendPrompt(prompt, completion: completion)
    }
}
