import Foundation

/// Tracks character arcs with dynamic weighting for context relevance.
final class AdaptiveCharacterMemory {
    private var entries: [String: [String]] = [:]

    func record(character: String, line: String) {
        entries[character, default: []].append(line)
    }

    func recentLines(for character: String, limit: Int = 5) -> [String] {
        let lines = entries[character] ?? []
        return Array(lines.suffix(limit))
    }

    func relevanceScore(for character: String, in text: String) -> Double {
        let lines = entries[character] ?? []
        guard !lines.isEmpty else { return 0 }
        let lower = text.lowercased()
        let hits = lines.filter { lower.contains($0.lowercased()) }
        return Double(hits.count) / Double(lines.count)
    }
}
