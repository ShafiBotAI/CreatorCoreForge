import Foundation

/// Lightweight aggregator that selects the active AI engine for text and voice tasks.
public final class FusionEngine {
    public enum Mode {
        case local
        case remote
    }

    private let engine: AIEngine
    private let parallelEngines: [AIEngine]?
    private var plugins: [FusionEnginePlugin]

    public let voiceMemory: VoiceMemoryManager
    public let sceneGenerator: SceneGenerator

    public let memory: ContextualMemory
    public let emotionGraph: EmotionGraph
    public var sandboxEnabled: Bool = false
    
    /// Initializes the engine using `AIEngineFactory` based on the given mode.
    public init(mode: Mode = .remote,
                memory: ContextualMemory = ContextualMemory(),
                emotionGraph: EmotionGraph = EmotionGraph(),
                voiceMemory: VoiceMemoryManager = .shared,
                sceneGenerator: SceneGenerator = SceneGenerator(),
                plugins: [FusionEnginePlugin] = []) {
        self.memory = memory
        self.emotionGraph = emotionGraph
        self.voiceMemory = voiceMemory
        self.sceneGenerator = sceneGenerator
        self.plugins = plugins
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
                emotionGraph: EmotionGraph = EmotionGraph(),
                voiceMemory: VoiceMemoryManager = .shared,
                sceneGenerator: SceneGenerator = SceneGenerator(),
                plugins: [FusionEnginePlugin] = []) {
        precondition(!parallelEngines.isEmpty, "parallelEngines must not be empty")
        self.engine = parallelEngines[0]
        self.parallelEngines = parallelEngines
        self.memory = memory
        self.emotionGraph = emotionGraph
        self.voiceMemory = voiceMemory
        self.sceneGenerator = sceneGenerator
        self.plugins = plugins
    }

    /// Initializes the engine with a fully custom AI engine implementation.
    public init(engine: AIEngine,
                memory: ContextualMemory = ContextualMemory(),
                emotionGraph: EmotionGraph = EmotionGraph(),
                voiceMemory: VoiceMemoryManager = .shared,
                sceneGenerator: SceneGenerator = SceneGenerator(),
                plugins: [FusionEnginePlugin] = []) {
        self.engine = engine
        self.parallelEngines = nil
        self.memory = memory
        self.emotionGraph = emotionGraph
        self.voiceMemory = voiceMemory
        self.sceneGenerator = sceneGenerator
        self.plugins = plugins
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
        let processed = plugins.reduce(prompt) { $1.processPrompt($0) }
        engine.sendPrompt(processed) { [plugins = self.plugins] result in
            switch result {
            case .success(let text):
                let output = plugins.reduce(text) { $1.processResponse($0) }
                completion(.success(output))
            case .failure:
                completion(result)
            }
        }
    }

    /// Retrieves an embedding vector using the underlying engine.
    public func sendEmbedding(_ text: String, completion: @escaping (Result<[Double], Error>) -> Void) {
        engine.sendEmbeddingRequest(text: text, completion: completion)
    }

    /// Generate a short summary using the active engine.
    public func summarize(_ text: String, completion: @escaping (Result<String, Error>) -> Void) {
        engine.summarize(text, completion: completion)
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
        let processed = plugins.reduce(finalPrompt) { $1.processPrompt($0) }
        engine.sendPrompt(processed) { [weak self, plugins = self.plugins] result in
            switch result {
            case .success(let response):
                self?.memory.add(prompt: prompt, response: response)
                let output = plugins.reduce(response) { $1.processResponse($0) }
                completion(.success(output))
            case .failure:
                completion(result)
            }
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
            p = plugins.reduce(p) { $1.processPrompt($0) }
            engine.sendPrompt(p) { [plugins = self.plugins] result in
                if case .success(let text) = result {
                    let output = plugins.reduce(text) { $1.processResponse($0) }
                    lock.lock()
                    results.append(output)
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

    /// Assign a voice ID to a character in a series for cross-app reuse.
    public func assignVoice(_ voiceID: String, to character: String, in series: String) {
        voiceMemory.assign(voiceID: voiceID, to: character, in: series)
    }

    /// Retrieve the assigned voice ID for a character if available.
    public func voiceID(for character: String, in series: String) -> String? {
        voiceMemory.voiceID(for: character, in: series)
    }

    /// Generate simple storyboard scenes from a text block.
    public func generateScenes(from text: String, limit: Int = 3) -> [String] {
        sceneGenerator.generateScenes(from: text, maxScenes: limit)
    }

    /// Registers a new plugin that will process prompts and responses.
    public func registerPlugin(_ plugin: FusionEnginePlugin) {
        plugins.append(plugin)
    }

    /// Removes all registered plugins.
    public func removeAllPlugins() {
        plugins.removeAll()
    }
}

