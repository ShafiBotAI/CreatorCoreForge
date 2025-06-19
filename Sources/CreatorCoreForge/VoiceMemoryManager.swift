import Foundation

/// Stores voice assignments for characters across different series.
public final class VoiceMemoryManager {
    public static let shared = VoiceMemoryManager()
    private let key = "VoiceMemoryAssignments"
    private var assignments: [String: String] = [:] // series|character -> voiceID

    private init() {
        if let saved = UserDefaults.standard.dictionary(forKey: key) as? [String: String] {
            assignments = saved
        }
    }

    public func assign(voiceID: String, to character: String, in series: String) {
        let mapKey = Self.mapKey(series: series, character: character)
        assignments[mapKey] = voiceID
        persist()
    }

    public func voiceID(for character: String, in series: String) -> String? {
        let mapKey = Self.mapKey(series: series, character: character)
        return assignments[mapKey]
    }

    public func clear(series: String) {
        assignments.keys.filter { $0.hasPrefix(series.lowercased() + "|") }.forEach { assignments.removeValue(forKey: $0) }
        persist()
    }

    /// Exports all voice assignments as JSON data for cross-app sharing.
    public func exportAssignments() -> Data? {
        return try? JSONSerialization.data(withJSONObject: assignments, options: [])
    }

    /// Imports voice assignments from JSON data. Existing entries are merged.
    /// - Parameter data: JSON data produced by `exportAssignments()`.
    public func importAssignments(_ data: Data) {
        guard let obj = try? JSONSerialization.jsonObject(with: data) as? [String: String] else {
            return
        }
        for (key, value) in obj {
            assignments[key] = value
        }
        persist()
    }

    private func persist() {
        UserDefaults.standard.set(assignments, forKey: key)
    }

    private static func mapKey(series: String, character: String) -> String {
        return series.lowercased() + "|" + character.lowercased()
    }
}
