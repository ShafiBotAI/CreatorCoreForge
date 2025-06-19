import Foundation

/// Lightweight aggregator that selects the active AI engine for text and voice tasks.
public final class FusionEngine {
    public enum Mode {
        case local
        case remote
    }

    private let engine: AIEngine
    private let parallelEngines: [AIEngine]?

    public let memory: ContextualMemory
    public let emotionGraph: EmotionGraph
    public var sandboxEnabled: Bool = false
    
    /// Initializes the engine using `AIEngineFactory` based on the given mode.
    public init(mode: Mode = .remote,
                memory: ContextualMemory = ContextualMemory(),
                emotionGraph: EmotionGraph = EmotionGraph()) {
        self.memory = memory
        self.emotionGraph = emotionGraph
        self.parallelEngines = nil
        switch mode {
        case .local:
            self.engine = LocalAIEnginePro()
        case .remote:
            self.engine = OpenAIService()
        }
    }

    /// Initializes the engine with a custom list of engines for parallel execution.
    public init(parallelEngines: [AIEngine],
                memory: ContextualMemory = ContextualMemory(),
                emotionGraph: EmotionGraph = EmotionGraph()) {
        precondition(!parallelEngines.isEmpty, "parallelEngines must not be empty")
        self.engine = parallelEngines[0]
        self.parallelEngines = parallelEngines
        self.memory = memory
        self.emotionGraph = emotionGraph
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

    /// Combines memory context and optional sandbox prefix before sending.
    public func sendPromptWithMemory(_ prompt: String, completion: @escaping (Result<String, Error>) -> Void) {
        var finalPrompt = prompt
        let context = memory.contextString()
        if !context.isEmpty {
            finalPrompt = context + "\n" + finalPrompt
        }
        if sandboxEnabled {
            finalPrompt = "[Sandbox] " + finalPrompt
        }
        engine.sendPrompt(finalPrompt) { [weak self] result in
            if case .success(let response) = result {
                self?.memory.add(prompt: prompt, response: response)
            }
            completion(result)
        }
    }

    /// Executes the prompt on all parallel engines and returns all successful responses.
    public func sendPromptParallel(_ prompt: String, completion: @escaping ([String]) -> Void) {
        guard let engines = parallelEngines else {
            completion([])
            return
        }

        let group = DispatchGroup()
        var results: [String] = []
        let lock = NSLock()
        for engine in engines {
            group.enter()
            var p = prompt
            if sandboxEnabled { p = "[Sandbox] " + p }
            engine.sendPrompt(p) { result in
                if case .success(let text) = result {
                    lock.lock()
                    results.append(text)
                    lock.unlock()
                }
                group.leave()
            }
        }
        group.notify(queue: .main) {
            completion(results)
        }
    }

    /// Record an emotion intensity in the shared emotion graph.
    public func recordEmotion(_ emotion: String, intensity: Double) {
        emotionGraph.record(emotion: emotion, intensity: intensity)
    }
}

