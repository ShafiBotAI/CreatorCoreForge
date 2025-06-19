import Foundation

/// Shared protocol allowing modules to swap between local and remote AI engines.
public protocol AIEngine {
    func sendPrompt(_ prompt: String, completion: @escaping (Result<String, Error>) -> Void)
    func sendEmbeddingRequest(text: String, completion: @escaping (Result<[Double], Error>) -> Void)
}

extension OpenAIService: AIEngine {}
extension LocalAIEnginePro: AIEngine {}

/// Factory returning the preferred engine based on environment settings.
public enum AIEngineFactory {
    /// Returns a local engine when `USE_LOCAL_AI` is set, otherwise `OpenAIService`.
    public static func defaultEngine() -> AIEngine {
        if ProcessInfo.processInfo.environment["USE_LOCAL_AI"] != nil {
            return LocalAIEnginePro()
        }
        return OpenAIService()
    }
}
