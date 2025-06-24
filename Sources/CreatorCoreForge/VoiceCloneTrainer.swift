import Foundation

/// Manages the training process for new voice clones using local data.
public final class VoiceCloneTrainer {
    private let voiceAI = LocalVoiceAI()

    public init() {}

    public func train(from sample: Data, name: String, completion: @escaping (VoiceProfile) -> Void) {
        voiceAI.cloneVoice(from: sample, name: name) { profile in
            completion(profile)
        }
    }
}
