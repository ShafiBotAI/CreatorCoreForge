import Foundation

/// Analyzes outreach messages and returns a simple performance score.
public struct OutreachAuditTool {
    public init() {}

    /// Compute a score for each message based on length and keyword usage.
    public func audit(messages: [String]) -> [String: Double] {
        var results: [String: Double] = [:]
        for message in messages {
            let words = message.split(separator: " ")
            let keywordBonus = words.contains { $0.lowercased().contains("offer") } ? 0.2 : 0.0
            let lengthPenalty = Double(max(0, words.count - 50)) * 0.01
            let score = max(0, 1.0 + keywordBonus - lengthPenalty)
            results[message] = score
        }
        return results
    }
}
