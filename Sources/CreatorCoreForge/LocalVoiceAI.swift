import Foundation

/// Represents a lightweight local voice profile used for synthesis.
public struct VoiceProfile: Codable, Equatable {
    /// Unique identifier for the profile.
    public let id: String
    /// Display name of the voice.
    public var name: String
    /// Base emotion for synthesis (e.g. "neutral", "happy").
    public var emotion: String

    public init(id: String = UUID().uuidString, name: String, emotion: String = "neutral") {
        self.id = id
        self.name = name
        self.emotion = emotion
    }
}

/// Offline-first voice engine stub that supports cloning and emotion modulation.
public final class LocalVoiceAI {
    public init() {}

    /// Creates a new `VoiceProfile` from raw audio data.
    /// This mimics a cloning process locally by generating a new identifier.
    /// - Parameters:
    ///   - sample: Voice sample data.
    ///   - name: Desired display name for the voice.
    ///   - completion: Called with the created profile.
    public func cloneVoice(from sample: Data, name: String, completion: @escaping (VoiceProfile) -> Void) {
        // simulate processing delay
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.1) {
            let profile = VoiceProfile(name: name)
            completion(profile)
        }
    }

    /// Synthesizes speech for the provided text using the given profile.
    /// - Parameters:
    ///   - text: Input text to speak.
    ///   - profile: Voice profile to use during synthesis.
    ///   - emotionShift: Optional adjustment to the base emotion.
    ///   - completion: Returns synthesized audio data (mocked).
    public func synthesize(text: String, with profile: VoiceProfile, emotionShift: Double = 0.0, completion: @escaping (Result<Data, Error>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 0.1) {
            let marker = "\(profile.id)|\(profile.emotion)|\(emotionShift)|\(text)"
            completion(.success(Data(marker.utf8)))
        }
    }
}
