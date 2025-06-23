import Foundation

/// Represents an audio clip on a timeline.
public struct AudioClip: Codable, Equatable {
    public let start: TimeInterval
    public let duration: TimeInterval
    public init(start: TimeInterval, duration: TimeInterval) {
        self.start = start
        self.duration = duration
    }
}

/// Coordinates voice, ambient, and FX clips for a scene.
public final class SceneTimeline {
    private var voiceTracks: [String: [AudioClip]] = [:]
    private var ambientClips: [AudioClip] = []
    private var fxClips: [AudioClip] = []

    public init() {}

    public func addVoiceClip(for character: String, clip: AudioClip) {
        voiceTracks[character, default: []].append(clip)
    }

    public func addAmbientClip(_ clip: AudioClip) {
        ambientClips.append(clip)
    }

    public func addFXClip(_ clip: AudioClip) {
        fxClips.append(clip)
    }

    public func timeline() -> (voices: [String: [AudioClip]], ambient: [AudioClip], fx: [AudioClip]) {
        (voiceTracks, ambientClips, fxClips)
    }
}
