#if canImport(Combine)

import Combine

import Foundation
#if canImport(AVFoundation)
import AVFoundation
#endif



/// Manages short sound effects for the FusionEngine apps.
/// Provides async fade-out control when stopping effects.
/// Simple manager for playing short audio clips. ObservableObject is avoided
/// to keep the package cross-platform.
public final class SoundEffectManager {
    public static let shared = SoundEffectManager()

    private init() {}

    #if canImport(AVFoundation)
    private var audioPlayers: [String: AVAudioPlayer] = [:]
    private let environmentQueue = DispatchQueue(label: "sound.environment.queue")

    /// Play a sound effect using AVAudioPlayer on a background queue.
    public func playEffect(named name: String,
                           fileExtension: String = "mp3",
                           loop: Bool = false,
                           volume: Float = 1.0) {
        environmentQueue.async {
            guard let url = Bundle.main.url(forResource: name, withExtension: fileExtension) else {
                print("[SoundEffectManager] Missing file: \(name).\(fileExtension)")
                return
            }
            do {
                let player = try AVAudioPlayer(contentsOf: url)
                player.volume = volume
                player.numberOfLoops = loop ? -1 : 0
                player.prepareToPlay()
                player.play()

                DispatchQueue.main.async { [weak self] in
                    self?.audioPlayers[name] = player
                }
            } catch {
                print("[SoundEffectManager] Failed to play \(name): \(error.localizedDescription)")
            }
        }
    }

    /// Stop a specific sound effect, optionally fading out over a duration.
    public func stopEffect(named name: String, fadeOutDuration: TimeInterval = 0) {
        guard let player = audioPlayers[name] else { return }
        guard fadeOutDuration > 0 else {
            player.stop()
            audioPlayers.removeValue(forKey: name)
            return
        }

        Task.detached { [weak self, weak player] in
            guard let player = player else { return }
            let steps = 10
            let interval = fadeOutDuration / Double(steps)
            for step in stride(from: steps, through: 0, by: -1) {
                try? await Task.sleep(nanoseconds: UInt64(interval * 1_000_000_000))
                DispatchQueue.main.async {
                    player.volume = Float(step) / Float(steps)
                }
            }
            DispatchQueue.main.async { [weak self] in
                player.stop()
                self?.audioPlayers.removeValue(forKey: name)
            }
        }
    }

    /// Stop all currently playing sound effects.
    /// - Parameter fadeOutDuration: optional fade-out applied to each effect.
    public func stopAll(fadeOutDuration: TimeInterval = 0) {
        for key in audioPlayers.keys {
            stopEffect(named: key, fadeOutDuration: fadeOutDuration)
        }
    }

    /// Preload sound effects to reduce latency on first play.
    public func preloadEffects(names: [String], fileExtension: String = "mp3") {
        for name in names {
            guard let url = Bundle.main.url(forResource: name, withExtension: fileExtension) else { continue }
            do {
                let player = try AVAudioPlayer(contentsOf: url)
                player.prepareToPlay()
                audioPlayers[name] = player
            } catch {
                print("[SoundEffectManager] Preload failed for \(name)")
            }
        }
    }

    /// Adjust the volume for a currently loaded sound effect.
    public func setVolume(for name: String, volume: Float) {
        audioPlayers[name]?.volume = volume
    }

    /// Query whether a particular effect is playing.
    public func isEffectPlaying(_ name: String) -> Bool {
        audioPlayers[name]?.isPlaying ?? false
    }
    #else
    // Placeholder implementations for platforms without AVFoundation
    private var audioPlayers: [String: Int] = [:]

    public func playEffect(named name: String,
                           fileExtension: String = "mp3",
                           loop: Bool = false,
                           volume: Float = 1.0) {}

    public func stopEffect(named name: String, fadeOutDuration: TimeInterval = 0) {}

    public func stopAll(fadeOutDuration: TimeInterval = 0) {}

    public func preloadEffects(names: [String], fileExtension: String = "mp3") {}

    public func setVolume(for name: String, volume: Float) {}

    public func isEffectPlaying(_ name: String) -> Bool { false }
    #endif
}

// Example FX file names to be used:
// - "wind_gust", "rain_loop", "heartbeat_slow", "cave_echo", "footstep_gravel", "battle_distant", "crowd_chatter"
// These can be tied to tagged scenes or characters using the EnvironmentLayer engine.
=======

import Combine

#if canImport(AVFoundation)

/// Manages ambient sound effects for immersive playback.
public final class SoundEffectManager: ObservableObject {
    /// Shared singleton instance.
    public static let shared = SoundEffectManager()

    #if canImport(AVFoundation)
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
        for (_, player) in audioPlayers { player.stop() }
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
    #else
    @Published public private(set) var currentAmbience: String = "None"
    public func playAmbience(named name: String) { currentAmbience = name }
    public func stopAllAmbience() { currentAmbience = "None" }
    public func preloadAmbiences() {}
    public func triggerReverbPreset(preset: ReverbStyle) {}
    #endif
}
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
