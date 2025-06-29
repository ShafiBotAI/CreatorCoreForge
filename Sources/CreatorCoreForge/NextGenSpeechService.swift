import Foundation

/// Provides lightweight speech synthesis and recognition without network access.
public final class NextGenSpeechService {
    private let controller: FusionVoiceController

    public init(controller: FusionVoiceController = FusionVoiceController()) {
        self.controller = controller
    }

    /// Generate speech audio for the given text and profile.
    public func generate(text: String,
                         profile: VoiceProfile,
                         completion: @escaping (Data?) -> Void) {
        controller.speak(text: text, using: profile, completion: completion)
    }

    /// Naively recognize speech from raw data. If the data is valid UTF-8, the
    /// decoded string is returned. Otherwise a simple loud/soft label is used.
    public func recognize(_ data: Data) -> String {
        if let text = String(data: data, encoding: .utf8),
           text.rangeOfCharacter(from: .controlCharacters.inverted) != nil {
            return text
        }
        let avg = data.reduce(0) { $0 + Int($1) } / max(data.count, 1)
        return avg > 127 ? "LOUD" : "SOFT"
    }
}
