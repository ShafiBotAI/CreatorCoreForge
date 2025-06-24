#if canImport(Combine)
import Foundation
import Combine

/// Supports assigning multiple voices to a single character.
public final class MultivoiceCharacterMode: ObservableObject {
    /// Shared singleton instance.
    public static let shared = MultivoiceCharacterMode()

    @Published private(set) var voiceMap: [String: [String]] = [:]

    public func assignVoice(_ id: String, to character: String) {
        var voices = voiceMap[character] ?? []
        if !voices.contains(id) {
            voices.append(id)
            voiceMap[character] = voices
        }
    }

    public func voices(for character: String) -> [String] {
        voiceMap[character] ?? []
    }

    public func removeVoice(_ id: String, from character: String) {
        guard var voices = voiceMap[character] else { return }
        voices.removeAll { $0 == id }
        voiceMap[character] = voices
    }

    public func clearVoices(for character: String) {
        voiceMap[character] = []
    }
}
#else
import Foundation

/// Supports assigning multiple voices to a single character.
public final class MultivoiceCharacterMode {
    public static let shared = MultivoiceCharacterMode()
    private var voiceMap: [String: [String]] = [:]

    public func assignVoice(_ id: String, to character: String) {
        var voices = voiceMap[character] ?? []
        if !voices.contains(id) {
            voices.append(id)
            voiceMap[character] = voices
        }
    }

    public func voices(for character: String) -> [String] {
        voiceMap[character] ?? []
    }

    public func removeVoice(_ id: String, from character: String) {
        guard var voices = voiceMap[character] else { return }
        voices.removeAll { $0 == id }
        voiceMap[character] = voices
    }

    public func clearVoices(for character: String) {
        voiceMap[character] = []
    }
}
#endif
