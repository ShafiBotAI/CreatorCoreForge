#if canImport(Combine)
import Foundation
#if canImport(AVFoundation)
import AVFoundation
#endif
import Combine

#if canImport(AVFoundation)
/// Manages ambient sound effects for immersive playback.
public final class SoundEffectManager: ObservableObject {
    /// Shared singleton instance.
    public static let shared = SoundEffectManager()

    /// Name of the currently playing ambience, or "None".
    @Published public private(set) var currentAmbience: String = "None"

    private var audioPlayers: [String: AVAudioPlayer] = [:]
    private let ambienceFiles: [String: String] = [
        "Rain": "rain_loop",
        "Wind": "wind_loop",
        "Fire": "fireplace",
        "Battlefield": "battle_ambience",
        "Cafe": "cafe_background"
    ]

    /// Play a looping ambience clip by name.
    public func playAmbience(named name: String) {
        stopAllAmbience()
        guard let fileName = ambienceFiles[name],
              let url = Bundle.main.url(forResource: fileName, withExtension: "mp3") else {
            print("[SoundEffectManager] Ambience file not found: \(name)")
            return
        }
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.numberOfLoops = -1
            player.volume = 0.4
            player.prepareToPlay()
            player.play()
            audioPlayers[name] = player
            currentAmbience = name
        } catch {
            print("[SoundEffectManager] Failed to play \(name): \(error.localizedDescription)")
        }
    }

    /// Stop all currently playing ambience tracks.
    public func stopAllAmbience() {
        for (_, player) in audioPlayers {
            player.stop()
        }
        audioPlayers.removeAll()
        currentAmbience = "None"
    }

    /// Preload ambience audio files into memory.
    public func preloadAmbiences() {
        for (_, file) in ambienceFiles {
            if let url = Bundle.main.url(forResource: file, withExtension: "mp3") {
                _ = try? AVAudioPlayer(contentsOf: url)
            }
        }
    }

    /// Create a configured reverb unit for the given preset.
    public func triggerReverbPreset(preset: ReverbStyle) -> AVAudioUnitReverb {
        let reverb = AVAudioUnitReverb()
        reverb.loadFactoryPreset(preset.avPreset)
        reverb.wetDryMix = 50.0
        return reverb
    }
}
#else
/// Minimal placeholder for platforms without AVFoundation.
public final class SoundEffectManager: ObservableObject {
    public static let shared = SoundEffectManager()
    @Published public private(set) var currentAmbience: String = "None"

    public func playAmbience(named name: String) { currentAmbience = name }
    public func stopAllAmbience() { currentAmbience = "None" }
    public func preloadAmbiences() {}
    public func triggerReverbPreset(preset: ReverbStyle) {}
}
#endif

#else
import Foundation
#if canImport(AVFoundation)
import AVFoundation
#endif

/// Minimal placeholder when Combine is unavailable.
public final class SoundEffectManager {
    public static let shared = SoundEffectManager()
    public private(set) var currentAmbience: String = "None"

    public func playAmbience(named name: String) { currentAmbience = name }
    public func stopAllAmbience() { currentAmbience = "None" }
    public func preloadAmbiences() {}
    public func triggerReverbPreset(preset: ReverbStyle) {}
}
#endif

/// Supported reverb styles for ambience effects.
public enum ReverbStyle: String, CaseIterable, Codable {
    case cathedral, cave, underwater, hall, dreamlike
#if canImport(AVFoundation)
    var avPreset: AVAudioUnitReverbPreset {
        switch self {
        case .cathedral: return .cathedral
        case .cave: return .largeRoom
        case .underwater: return .mediumRoom
        case .hall: return .largeHall
        case .dreamlike: return .plate
        }
    }
#endif
}

