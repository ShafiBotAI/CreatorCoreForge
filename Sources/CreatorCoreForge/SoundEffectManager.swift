import Foundation
#if canImport(AVFoundation)
import AVFoundation
#endif


// SoundEffectManager.swift
// CoreForge Audio


#if canImport(Combine)
import Combine
#endif

// SoundEffectManager.swift
// CoreForge Audio

/// Cross-platform manager for short sound effects and ambience.
public final class SoundEffectManager {
#if canImport(Combine)
    @Published public private(set) var currentAmbience: String = "None"
#else
    public private(set) var currentAmbience: String = "None"
#endif
    public static let shared = SoundEffectManager()
    private init() {}

#if canImport(AVFoundation)
    private var audioPlayers: [String: AVAudioPlayer] = [:]
    private var panValues: [String: Float] = [:]
    private let environmentQueue = DispatchQueue(label: "sound.environment.queue")
    private let ambienceFiles: [String: String] = [
        "Rain": "rain_loop",
        "Wind": "wind_loop",
        "Fire": "fireplace",
        "Battlefield": "battle_ambience",
        "Cafe": "cafe_background"
    ]
#else
    private var audioPlayers: [String: Int] = [:]
    private var panValues: [String: Float] = [:]
    private let ambienceFiles: [String: String] = [:]
#endif

    // MARK: - Effects
    public func playEffect(named name: String,
                           fileExtension: String = "mp3",
                           loop: Bool = false,
                           volume: Float = 1.0,
                           pan: Float = 0.0) {
#if canImport(AVFoundation)
        environmentQueue.async { [self] in
            guard let url = Bundle.main.url(forResource: name, withExtension: fileExtension) else {
                print("[SoundEffectManager] Missing file: \(name).\(fileExtension)")
                return
            }
            do {
                let player = try AVAudioPlayer(contentsOf: url)
                player.volume = volume
                player.pan = max(-1.0, min(pan, 1.0))
                player.numberOfLoops = loop ? -1 : 0
                player.prepareToPlay()
                player.play()
                DispatchQueue.main.async {
                    self.audioPlayers[name] = player
                    self.panValues[name] = pan
                }
            } catch {
                print("[SoundEffectManager] Failed to play \(name): \(error.localizedDescription)")
            }
        }
#else
        panValues[name] = pan
#endif
    }

    public func stopEffect(named name: String, fadeOutDuration: TimeInterval = 0) {
#if canImport(AVFoundation)
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
            DispatchQueue.main.async {
                player.stop()
                self?.audioPlayers.removeValue(forKey: name)
            }
        }
#endif
    }

    public func stopAll(fadeOutDuration: TimeInterval = 0) {
#if canImport(AVFoundation)
        for key in audioPlayers.keys {
            stopEffect(named: key, fadeOutDuration: fadeOutDuration)
        }
        panValues.removeAll()
#else
        panValues.removeAll()
#endif
    }

    public func preloadEffects(names: [String], fileExtension: String = "mp3") {
#if canImport(AVFoundation)
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
#endif
    }

    public func setVolume(for name: String, volume: Float) {
#if canImport(AVFoundation)
        audioPlayers[name]?.volume = volume
#endif
    }

    public func isEffectPlaying(_ name: String) -> Bool {
#if canImport(AVFoundation)
        return audioPlayers[name]?.isPlaying ?? false
#else
        return false
#endif
    }

    public func currentPan(for name: String) -> Float? {
        panValues[name]
    }

    // MARK: - Ambience
    public func playAmbience(named name: String) {
#if canImport(AVFoundation)
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
#else
        currentAmbience = name
#endif
    }

    public func stopAllAmbience() {
#if canImport(AVFoundation)
        for (_, player) in audioPlayers { player.stop() }
        audioPlayers.removeAll()
#endif
        currentAmbience = "None"
    }

    public func preloadAmbiences() {
#if canImport(AVFoundation)
        for (_, file) in ambienceFiles {
            if let url = Bundle.main.url(forResource: file, withExtension: "mp3") {
                _ = try? AVAudioPlayer(contentsOf: url)
            }
        }
#endif
    }

#if canImport(AVFoundation)
    public func triggerReverbPreset(preset: ReverbStyle) -> AVAudioUnitReverb {
        let reverb = AVAudioUnitReverb()
        reverb.loadFactoryPreset(preset.avPreset)
        reverb.wetDryMix = 50.0
        return reverb
    }
#else
    public func triggerReverbPreset(preset: ReverbStyle) -> StubReverb {
        print("[SoundEffectManager] Reverb preset \(preset.rawValue) not supported on this platform")
        return StubReverb()
    }
#endif
}

#if canImport(AVFoundation)
public enum ReverbStyle: String, CaseIterable, Codable {
    case cathedral, cave, underwater, hall, dreamlike
    var avPreset: AVAudioUnitReverbPreset {
        switch self {
        case .cathedral: return .cathedral
        case .cave: return .largeRoom
        case .underwater: return .mediumRoom
        case .hall: return .largeHall
        case .dreamlike: return .plate
        }
    }
}
#else
public enum ReverbStyle: String, CaseIterable, Codable {
    case cathedral, cave, underwater, hall, dreamlike
}

/// Minimal stand-in for `AVAudioUnitReverb` when AVFoundation is unavailable.
public struct StubReverb {
    public var wetDryMix: Float = 0.0
    public init() {}
}
#endif

#if canImport(Combine)
extension SoundEffectManager: ObservableObject {}
#endif
