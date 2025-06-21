import Foundation
#if canImport(AVFoundation)
import AVFoundation
public typealias OptionalEngine = AVAudioEngine?
#else
public typealias OptionalEngine = Any?
#endif

/// Coordinates adaptive soundtrack and voice SFX for a scene.
public final class SceneSoundtrackCoordinator {
    public static let shared = SceneSoundtrackCoordinator()

    private let atmosphereBuilder: SceneAtmosphereBuilder
    private let effectManager: SoundEffectManager
    private let emotionEngine: AIEmotionEngine

    public init(atmosphereBuilder: SceneAtmosphereBuilder = .shared,
                effectManager: SoundEffectManager = .shared,
                emotionEngine: AIEmotionEngine = .shared) {
        self.atmosphereBuilder = atmosphereBuilder
        self.effectManager = effectManager
        self.emotionEngine = emotionEngine
    }

    /// Determine the appropriate atmosphere mood for the scene text.
    public func soundtrackMood(for sceneText: String) -> SceneAtmosphereBuilder.Mood {
        let emotion = emotionEngine.analyze(text: sceneText)
        let lowered = sceneText.lowercased()
        switch emotion {
        case .happy: return .peaceful
        case .sad: return .tragic
        case .tense, .angry, .fear: return .tense
        case .romantic: return .romantic
        case .euphoric: return .sciFi
        case .neutral:
            if lowered.contains("love") || lowered.contains("kiss") {
                return .romantic
            }
            return .fantasy
        }
    }

    /// Apply soundtrack and SFX to the scene using available audio frameworks.
    /// - Parameters:
    ///   - sceneText: Text of the scene used to derive mood.
    ///   - engine: Optional audio engine for live playback when AVFoundation is available.
    public func applySoundtrack(
        to sceneText: String,
        engine: OptionalEngine = nil
    ) {
        let mood = soundtrackMood(for: sceneText)
#if canImport(AVFoundation)
        if let engine = engine {
            let player = AVAudioPlayerNode()
            atmosphereBuilder.playAtmosphere(for: mood, in: engine, player: player)
        }
#endif
        #if canImport(Combine)
        effectManager.playEffect(named: mood.rawValue)
        #endif
    }
}
