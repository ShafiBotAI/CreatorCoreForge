import Foundation

/// Offline-first local AI engine stub used during development.
public final class LocalAIEnginePro {
    public init() {}

    /// Generates a text response locally using a trivial transformation.
    /// - Parameters:
    ///   - prompt: Input prompt from the user.
    ///   - completion: Completion handler with reversed prompt as output.
    public func sendPrompt(_ prompt: String, completion: @escaping (Result<String, Error>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.1) {
            completion(.success(String(prompt.reversed())))
        }
    }

    /// Produces a deterministic embedding for the given text.
    /// - Parameters:
    ///   - text: Input text.
    ///   - completion: Completion handler with a simple numeric vector.
    public func sendEmbeddingRequest(text: String, completion: @escaping (Result<[Double], Error>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.1) {
            let vector = text.utf8.map { Double($0) / 255.0 }
            completion(.success(vector))
        }
    }
}
