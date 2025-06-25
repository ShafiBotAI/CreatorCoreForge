import Foundation

/// Trains a simple user style model from code samples.
public final class StyleModelTrainer {
    private var models: [String: [String]] = [:]
    public init() {}

    /// Store code samples for a user.
    public func train(userID: String, codeSamples: [String]) {
        models[userID, default: []].append(contentsOf: codeSamples)
    }

    /// Retrieve a sample style summary.
    public func styleSummary(for userID: String) -> String {
        let samples = models[userID] ?? []
        return "Samples: \(samples.count)"
    }
}
