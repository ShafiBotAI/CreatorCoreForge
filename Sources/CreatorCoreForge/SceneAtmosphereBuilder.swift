// SceneAtmosphereBuilder.swift
// CoreForge Audio – Phase 7 Module

import Foundation
#if canImport(AVFoundation)
import AVFoundation
#endif

/// Generates and plays ambient atmosphere tracks for scenes.
public final class SceneAtmosphereBuilder {
    /// Shared singleton instance.
    public static let shared = SceneAtmosphereBuilder()

    /// Supported moods for atmosphere generation.
    public enum Mood: String, Codable {
        case tense, romantic, suspenseful, peaceful, erotic, tragic, sciFi, fantasy
    }

    #if canImport(AVFoundation)
    /// Load the atmosphere audio file for the given mood.
    /// - Parameters:
    ///   - mood: desired atmosphere mood.
    ///   - duration: expected playback duration.
    /// - Returns: `AVAudioFile` if found.
    public func generateAtmosphere(for mood: Mood, duration: TimeInterval) -> AVAudioFile? {
        let filename = "atmo_\(mood.rawValue).caf"
        guard let url = Bundle.main.url(forResource: filename, withExtension: nil) else {
            print("\u{26A0}\u{FE0F} Atmosphere file not found: \(filename)")
            return nil
        }

        do {
            let file = try AVAudioFile(forReading: url)
            return file
        } catch {
            print("\u{26A0}\u{FE0F} Error loading atmosphere audio: \(error.localizedDescription)")
            return nil
        }
    }

    /// Play an atmosphere track using the provided engine and player.
    /// - Parameters:
    ///   - mood: mood to play.
    ///   - engine: `AVAudioEngine` instance.
    ///   - player: `AVAudioPlayerNode` attached to the engine.
    public func playAtmosphere(for mood: Mood, in engine: AVAudioEngine, player: AVAudioPlayerNode) {
        guard let atmosphereFile = generateAtmosphere(for: mood, duration: 60.0) else { return }

        engine.attach(player)
        engine.connect(player, to: engine.mainMixerNode, format: atmosphereFile.processingFormat)

        player.scheduleFile(atmosphereFile, at: nil)
        do {
            try engine.start()
            player.play()
        } catch {
            print("\u{26A0}\u{FE0F} Error starting audio engine: \(error.localizedDescription)")
        }
    }
    #else
    // Fallback implementation when AVFoundation is unavailable. A simple file
    // containing the mood name is generated so downstream code can still
    // operate on a URL.
    public func generateAtmosphere(for mood: Mood, duration: TimeInterval) -> Any? {
        // Without AVFoundation we cannot generate audio, so just log and return nil
        print("Atmosphere generation skipped for \(mood.rawValue) — AVFoundation unavailable")
        return nil
    }

    public func playAtmosphere(for mood: Mood, in engine: Any, player: Any) {
        // Simply log the call since playback isn't supported without AVFoundation
        _ = generateAtmosphere(for: mood, duration: 0)
        print("Atmosphere playback skipped — AVFoundation unavailable")
    }
    #endif
}

// Example usage:
// SceneAtmosphereBuilder.shared.playAtmosphere(for: .suspenseful, in: engine, player: player)
