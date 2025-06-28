import Foundation
#if canImport(AVFoundation)
import AVFoundation
#endif

/// Plays synthesized speech using the FusionVoiceController and AVAudioPlayer.
public final class EnhancedTTSPlayer {
    private let controller: FusionVoiceController
#if canImport(AVFoundation)
    private var player: AVAudioPlayer?
#endif
    public init(controller: FusionVoiceController = FusionVoiceController()) {
        self.controller = controller
    }

    /// Generate audio for the given text and play it immediately.
    /// Completion returns `true` on success.
    public func play(text: String, profile: VoiceProfile, completion: @escaping (Bool) -> Void) {
        controller.speak(text: text, using: profile) { [weak self] data in
#if canImport(AVFoundation)
            guard let self = self, let data = data else { completion(false); return }
            do {
                self.player = try AVAudioPlayer(data: data)
                self.player?.play()
                completion(true)
            } catch {
                completion(false)
            }
#else
            completion(false)
#endif
        }
    }

    /// Stop playback and clear the current player.
    public func stop() {
#if canImport(AVFoundation)
        player?.stop()
        player = nil
#endif
    }
}
