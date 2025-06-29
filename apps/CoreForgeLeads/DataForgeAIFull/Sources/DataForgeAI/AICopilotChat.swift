import Foundation

/// Provides quick AI chat suggestions for SDRs.
public final class AICopilotChat {
    private let service: OpenAIService

    public init(service: OpenAIService) {
        self.service = service
    }

    public func suggestReply(for text: String, completion: @escaping (String) -> Void) {
        let prompt = "Suggest a short reply: \(text)"
        service.sendPrompt(prompt) { result in
            completion((try? result.get()) ?? "")
        }
    }
}
