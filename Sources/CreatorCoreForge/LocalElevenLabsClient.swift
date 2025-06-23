import Foundation

/// Offline replacement for `ElevenLabsClient` using `LocalVoiceAI`.
/// Provides a minimal subset of ElevenLabs-style APIs without any
/// network access. Voices can be added at runtime and synthesis is
/// performed locally via `LocalVoiceAI`.
public struct LocalElevenLabsClient {
    private var voices: [String: VoiceProfile]
    private let engine = LocalVoiceAI()

    /// Creates the client with an optional array of voices.
    public init(voices: [VoiceProfile] = [VoiceProfile(name: "Default")]) {
        self.voices = Dictionary(uniqueKeysWithValues: voices.map { ($0.id, $0) })
    }

    /// Returns all available voices.
    public func listVoices() -> [VoiceProfile] {
        Array(voices.values)
    }

    /// Fetches info for a specific voice id if present.
    public func voiceInfo(id: String) -> VoiceProfile? {
        voices[id]
    }

    /// Synthesizes the provided text using the stored voice profile.
    public func synthesize(text: String,
                           voiceID: String,
                           sampleRate: Int = 44100,
                           completion: @escaping (Result<Data, Error>) -> Void) {
        guard let profile = voices[voiceID] else {
            completion(.failure(NSError(domain: "LocalElevenLabs", code: -1)))
            return
        }
        engine.synthesize(text: text,
                          with: profile,
                          sampleRate: sampleRate,
                          completion: completion)
    }

    /// Adds a new voice to the local catalog.
    public mutating func addVoice(_ profile: VoiceProfile) {
        voices[profile.id] = profile
    }
}
