import Foundation

/// Provides real-time improvisational narration for roleplay scenarios.
public final class RealTimeImproviserService {
    private let engine: FusionEngine
    private var sessionContext: String

    /// - Parameters:
    ///   - engine: Underlying `FusionEngine` used for text generation.
    ///   - context: Initial scene or character context to maintain.
    public init(engine: FusionEngine = FusionEngine(), context: String = "") {
        self.engine = engine
        self.sessionContext = context
    }

    /// Update the active improvisation context.
    public func updateContext(_ context: String) {
        sessionContext = context
    }

    /// Generate a single improvised line given user input.
    public func improvise(userInput: String, completion: @escaping (String) -> Void) {
        let prompt = [sessionContext, "User: \(userInput)", "AI:"].filter { !$0.isEmpty }.joined(separator: "\n")
        engine.sendPrompt(prompt) { result in
            switch result {
            case .success(let text):
                completion(text.trimmingCharacters(in: .whitespacesAndNewlines))
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
}
