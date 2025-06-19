import Foundation

/// Lightweight aggregator that selects the active AI engine for text and voice tasks.
public final class FusionEngine {
    public enum Mode {
        case local
        case remote
    }

    private let engine: AIEngine

    /// Initializes the engine using `AIEngineFactory` based on the given mode.
    public init(mode: Mode = .remote) {
        switch mode {
        case .local:
            self.engine = LocalAIEnginePro()
        case .remote:
            self.engine = OpenAIService()
        }
    }

    /// Convenience initializer that checks the `USE_LOCAL_AI` environment variable.
    public convenience init() {
        if ProcessInfo.processInfo.environment["USE_LOCAL_AI"] != nil {
            self.init(mode: .local)
        } else {
            self.init(mode: .remote)
        }
    }

    /// Passes a prompt to the underlying AI engine.
    public func sendPrompt(_ prompt: String, completion: @escaping (Result<String, Error>) -> Void) {
        engine.sendPrompt(prompt, completion: completion)
    }

    /// Retrieves an embedding vector using the underlying engine.
    public func sendEmbedding(_ text: String, completion: @escaping (Result<[Double], Error>) -> Void) {
        engine.sendEmbeddingRequest(text: text, completion: completion)
    }
}

