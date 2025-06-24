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

    public let memory: ContextualMemory
    public let emotionGraph: EmotionGraph
    public let voiceMemory: VoiceMemoryManager
    public let sceneGenerator: SceneGenerator
    public let studioMode: AIStudioMode
    public let genesisEngine: GenesisModeEngine
    public var sandboxEnabled: Bool = false

    public init(mode: Mode = .remote,
                memory: ContextualMemory = ContextualMemory(),
                emotionGraph: EmotionGraph = EmotionGraph(),
                voiceMemory: VoiceMemoryManager = .shared,
                sceneGenerator: SceneGenerator = SceneGenerator(),
                studioMode: AIStudioMode = AIStudioMode(),
                genesisEngine: GenesisModeEngine = GenesisModeEngine(),
                plugins: [FusionEnginePlugin] = []) {
        self.memory = memory
        self.emotionGraph = emotionGraph
        self.voiceMemory = voiceMemory
        self.sceneGenerator = sceneGenerator
        self.studioMode = studioMode
        self.genesisEngine = genesisEngine
        self.plugins = plugins
        self.parallelEngines = nil
        switch mode {
        case .local:
            self.engine = LocalAIEnginePro()
        case .remote:
            self.engine = OpenAIService()
        }
    }

    public init(parallelEngines: [AIEngine],
                memory: ContextualMemory = ContextualMemory(),
                emotionGraph: EmotionGraph = EmotionGraph(),
                voiceMemory: VoiceMemoryManager = .shared,
                sceneGenerator: SceneGenerator = SceneGenerator(),
                studioMode: AIStudioMode = AIStudioMode(),
                genesisEngine: GenesisModeEngine = GenesisModeEngine(),
                plugins: [FusionEnginePlugin] = []) {
        precondition(!parallelEngines.isEmpty, "parallelEngines must not be empty")
        self.engine = parallelEngines[0]
        self.parallelEngines = parallelEngines
        self.memory = memory
        self.emotionGraph = emotionGraph
        self.voiceMemory = voiceMemory
        self.sceneGenerator = sceneGenerator
        self.studioMode = studioMode
        self.genesisEngine = genesisEngine
        self.plugins = plugins
    }

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
        self.studioMode = AIStudioMode()
        self.genesisEngine = GenesisModeEngine()
        self.plugins = plugins
    }

    public convenience init() {
        if ProcessInfo.processInfo.environment["USE_LOCAL_AI"] != nil {
            self.init(mode: .local)
        } else {
            self.init(mode: .remote)
        }
    }

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

    @available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
    public func sendPrompt(_ prompt: String) async throws -> String {
        try await withCheckedThrowingContinuation { cont in
            sendPrompt(prompt) { result in
                cont.resume(with: result)
            }
        }
    }

    public func sendEmbedding(_ text: String, completion: @escaping (Result<[Double], Error>) -> Void) {
        engine.sendEmbeddingRequest(text: text, completion: completion)
    }

    @available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
    public func sendEmbedding(_ text: String) async throws -> [Double] {
        try await withCheckedThrowingContinuation { cont in
            sendEmbedding(text) { result in
                cont.resume(with: result)
            }
        }
    }

    public func summarize(_ text: String, completion: @escaping (Result<String, Error>) -> Void) {
        engine.summarize(text, completion: completion)
    }

    @available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
    public func summarize(_ text: String) async throws -> String {
        try await withCheckedThrowingContinuation { cont in
            summarize(text) { result in
                cont.resume(with: result)
            }
        }
    }

    public func sendPromptWithMemory(_ prompt: String, completion: @escaping (Result<String, Error>) -> Void) {
        var finalPrompt = studioMode.apply(to: prompt)
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

    @available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
    public func sendPromptWithMemory(_ prompt: String) async throws -> String {
        try await withCheckedThrowingContinuation { cont in
            sendPromptWithMemory(prompt) { result in
                cont.resume(with: result)
            }
        }
    }

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

    @available(macOS 10.15, iOS 13, tvOS 13, watchOS 6, *)
    public func sendPromptParallel(_ prompt: String) async -> [String] {
        await withCheckedContinuation { cont in
            sendPromptParallel(prompt) { results in
                cont.resume(returning: results)
            }
        }
    }

    public func recordEmotion(_ emotion: String, intensity: Double) {
        emotionGraph.record(emotion: emotion, intensity: intensity)
    }

    public func generateScenes(from text: String, maxScenes: Int = 3) -> [String] {
        sceneGenerator.generateScenes(from: text, maxScenes: maxScenes)
    }

    public func assignVoice(_ voiceID: String, to character: String, in series: String) {
        voiceMemory.assign(voiceID: voiceID, to: character, in: series)
    }

    public func voiceID(for character: String, in series: String) -> String? {
        voiceMemory.voiceID(for: character, in: series)
    }

    public func toggleStudioMode() {
        studioMode.toggle()
    }

    public func generateVariants(for idea: String, count: Int = 3) -> [String] {
        genesisEngine.generateVariants(for: idea, count: count)
    }

    public func registerPlugin(_ plugin: FusionEnginePlugin) {
        plugins.append(plugin)
    }

    public func removeAllPlugins() {
        plugins.removeAll()
    }
}
