import Foundation

/// Tracks how often each voice is used to enable personalization.
final class VoiceHistory {
    static let shared = VoiceHistory()
    private let key = "VV_VoiceHistory"
    private var usage: [String: Int] = [:]

    private init() {
        if let data = UserDefaults.standard.data(forKey: key),
           let saved = try? JSONDecoder().decode([String: Int].self, from: data) {
            usage = saved
        }
    }

    func record(voice: String) {
        usage[voice, default: 0] += 1
        persist()
    }

    func usageScore(for voice: String) -> Int {
        usage[voice, default: 0]
    }

    func topVoices(limit: Int) -> [String] {
        usage.sorted { $0.value > $1.value }.prefix(limit).map { $0.key }
    }

    private func persist() {
        if let data = try? JSONEncoder().encode(usage) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
}
