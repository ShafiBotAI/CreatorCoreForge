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
    public let voiceMemory: VoiceMemoryManager
    public let sceneGenerator: SceneGenerator
    public let studioMode: AIStudioMode
    public let genesisEngine: GenesisModeEngine
    public var sandboxEnabled: Bool = false
    
    /// Initializes the engine using `AIEngineFactory` based on the given mode.
    public init(mode: Mode = .remote,
                memory: ContextualMemory = ContextualMemory(),
                emotionGraph: EmotionGraph = EmotionGraph(),
                voiceMemory: VoiceMemoryManager = .shared,
                sceneGenerator: SceneGenerator = SceneGenerator(),
                studioMode: AIStudioMode = AIStudioMode(),
                genesisEngine: GenesisModeEngine = GenesisModeEngine()) {
        self.memory = memory
        self.emotionGraph = emotionGraph
        self.voiceMemory = voiceMemory
        self.sceneGenerator = sceneGenerator
        self.studioMode = studioMode
        self.genesisEngine = genesisEngine
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
                studioMode: AIStudioMode = AIStudioMode(),
                genesisEngine: GenesisModeEngine = GenesisModeEngine()) {
        precondition(!parallelEngines.isEmpty, "parallelEngines must not be empty")
        self.engine = parallelEngines[0]
        self.parallelEngines = parallelEngines
        self.memory = memory
        self.emotionGraph = emotionGraph
        self.voiceMemory = voiceMemory
        self.sceneGenerator = sceneGenerator
        self.studioMode = studioMode
        self.genesisEngine = genesisEngine
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
        var finalPrompt = studioMode.apply(to: prompt)
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

    /// Generate scene outlines from text using the shared scene generator.
    public func generateScenes(from text: String, maxScenes: Int = 3) -> [String] {
        sceneGenerator.generateScenes(from: text, maxScenes: maxScenes)
    }

    /// Manage voice assignments across series via the voice memory manager.
    public func assignVoice(_ voiceID: String, to character: String, in series: String) {
        voiceMemory.assign(voiceID: voiceID, to: character, in: series)
    }

    /// Retrieve the assigned voice ID for a character in a series.
    public func voiceID(for character: String, in series: String) -> String? {
        voiceMemory.voiceID(for: character, in: series)
    }

    /// Toggle studio mode for applying the [Studio] prefix to prompts.
    public func toggleStudioMode() {
        studioMode.toggle()
    }

    /// Generate variant ideas using the genesis engine helper.
    public func generateVariants(for idea: String, count: Int = 3) -> [String] {
        genesisEngine.generateVariants(for: idea, count: count)
    }
}

