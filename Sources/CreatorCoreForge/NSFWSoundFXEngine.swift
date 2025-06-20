import Foundation
#if canImport(AVFoundation)
import AVFoundation
#endif
#if canImport(Combine)
import Combine
#endif

/// Singleton engine for NSFW sound effects.
/// Plays a sequence of clips with adjustable intensity.
public final class NSFWSoundFXEngine: NSObject {
    public static let shared = NSFWSoundFXEngine()

    #if canImport(AVFoundation)
    private var audioPlayers: [String: AVAudioPlayer] = [:]
    private let queue = DispatchQueue(label: "nsfw.soundfx.queue")
    #endif

    public enum NSFWIntensity: String {
        case soft, sensual, dominant, rough, hardcore
    }

    /// Play a scene using the provided pattern and intensity.
    public func playNSFWScene(basePattern: [String], intensity: NSFWIntensity, loop: Bool = false) {
        #if canImport(AVFoundation)
        queue.async {
            self.stopAll()
            for (index, fx) in basePattern.enumerated() {
                guard let url = Bundle.main.url(forResource: fx, withExtension: "mp3") else {
                    print("[NSFWSoundFXEngine] Missing NSFW file: \(fx).mp3")
                    continue
                }
                do {
                    let player = try AVAudioPlayer(contentsOf: url)
                    player.volume = self.volume(for: intensity)
                    player.numberOfLoops = loop ? -1 : 0
                    player.prepareToPlay()
                    DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.5) {
                        player.play()
                    }
                    DispatchQueue.main.async { [weak self] in
                        self?.audioPlayers[fx] = player
                    }
                } catch {
                    print("[NSFWSoundFXEngine] Error: \(error.localizedDescription)")
                }
            }
        }
        #endif
    }

    #if canImport(AVFoundation)
    private func volume(for level: NSFWIntensity) -> Float {
        switch level {
        case .soft: return 0.5
        case .sensual: return 0.6
        case .dominant: return 0.7
        case .rough: return 0.8
        case .hardcore: return 1.0
        }
    }
    #endif

    /// Stop all currently playing NSFW clips.
    public func stopAll() {
        #if canImport(AVFoundation)
        for (_, player) in audioPlayers { player.stop() }
        audioPlayers.removeAll()
        #endif
    }

    /// Query whether any NSFW clip is playing.
    public func isNSFWPlaying() -> Bool {
        #if canImport(AVFoundation)
        return audioPlayers.values.contains { $0.isPlaying }
        #else
        return false
        #endif
    }
}
