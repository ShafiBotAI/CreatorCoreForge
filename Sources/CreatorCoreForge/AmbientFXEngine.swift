import Foundation
#if canImport(AVFoundation)
import AVFoundation
#endif

/// Handles ambient sound playback and transitions for scenes.
public final class AmbientFXEngine {
    private let manager: SoundEffectManager
    public private(set) var library: FXLibrary
    public var immersiveMode: Bool = true
    public var isMuted: Bool = false

    /// Tracks listener reactions per scene.
    private var reactions: [String: Int] = [:]

    public init(manager: SoundEffectManager = .shared, library: FXLibrary = FXLibrary()) {
        self.manager = manager
        self.library = library
    }

    /// Play ambience based on tone and location keywords.
    @discardableResult
    public func playAmbient(tone: String, location: String) -> String {
        guard immersiveMode, !isMuted else { return "" }
        let key = selectCategory(tone: tone, location: location)
        let fx = library.fx(for: key).first ?? ""
        manager.playAmbience(named: fx)
        return fx
    }

    /// Crossfade from current ambience to a new one.
    public func crossfade(to name: String, duration: TimeInterval = 1.0) {
        #if canImport(AVFoundation)
        manager.playAmbience(named: name)
        // Stub fade logic for placeholder
        #else
        manager.playAmbience(named: name)
        #endif
    }

    /// Volume level for a given intensity.
    public func volume(for intensity: String) -> Float {
        switch intensity.lowercased() {
        case "whisper": return 0.2
        case "battle": return 1.0
        default: return 0.5
        }
    }

    /// Record a reaction count for personalization.
    public func recordReaction(sceneID: String) {
        reactions[sceneID, default: 0] += 1
    }

    /// Generate a simple FX track listing for export.
    public func exportTrack() -> [String] {
        library.fx(for: .generic)
    }

    /// Update ambience during streaming playback.
    public func updateRealTime(to name: String) {
        if immersiveMode && !isMuted {
            manager.playAmbience(named: name)
        }
    }

    /// Detect ambient changes from narration and apply a new effect.
    @discardableResult
    public func detectAndApplyTransition(narrationLine: String) -> String? {
        let line = narrationLine.lowercased()
        let map: [String: FXLibrary.Category] = [
            "forest": .forest,
            "city": .city,
            "tavern": .tavern,
            "ship": .spaceship
        ]
        for (keyword, category) in map {
            if line.contains(keyword) {
                let fx = library.fx(for: category).first ?? ""
                crossfade(to: fx)
                return fx
            }
        }
        return nil
    }

    /// Sync ambient playback with narrator pauses.
    public func syncWithNarrationPause(_ paused: Bool) {
        isMuted = paused
    }

    private func selectCategory(tone: String, location: String) -> FXLibrary.Category {
        if location.lowercased().contains("forest") { return .forest }
        if location.lowercased().contains("city") { return .city }
        if location.lowercased().contains("tavern") { return .tavern }
        if location.lowercased().contains("ship") { return .spaceship }
        return .generic
    }
}
