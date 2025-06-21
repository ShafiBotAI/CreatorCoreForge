import Foundation

/// Provides real-time improvisational narration for roleplay scenarios.
public final class RealTimeImproviserService {
    private let engine: FusionEngine
    private var sessionContext: String
    private let memory: ContextualMemory

    /// - Parameters:
    ///   - engine: Underlying `FusionEngine` used for text generation.
    ///   - context: Initial scene or character context to maintain.
    ///   - memoryLimit: Number of recent exchanges to keep in context.
    public init(engine: FusionEngine = FusionEngine(),
                context: String = "",
                memoryLimit: Int = 10) {
        self.engine = engine
        self.sessionContext = context
        self.memory = ContextualMemory(limit: memoryLimit)
    }

    /// Update the active improvisation context.
    public func updateContext(_ context: String) {
        sessionContext = context
    }

    /// Generate a single improvised line given user input.
    public func improvise(userInput: String, completion: @escaping (String) -> Void) {
        var parts: [String] = []
        if !sessionContext.isEmpty { parts.append(sessionContext) }
        let context = memory.contextString()
        if !context.isEmpty { parts.append(context) }
        parts.append("User: \(userInput)")
        parts.append("AI:")
        let prompt = parts.joined(separator: "\n")
        engine.sendPrompt(prompt) { [memory] result in
            switch result {
            case .success(let text):
                let reply = text.trimmingCharacters(in: .whitespacesAndNewlines)
                memory.add(prompt: userInput, response: reply)
                completion(reply)
            case .failure:
                completion("")
            }
        }
    }

    /// Continue an improvisation session with multiple user prompts.
    public func runSession(with inputs: [String], completion: @escaping ([String]) -> Void) {
        var replies: [String] = []
        let group = DispatchGroup()
        for input in inputs {
            group.enter()
            improvise(userInput: input) { line in
                replies.append(line)
                group.leave()
            }
        }
        group.notify(queue: .main) { completion(replies) }
    }

    /// Clear the conversation memory.
    public func clearHistory() {
        memory.clear()
    }
}
