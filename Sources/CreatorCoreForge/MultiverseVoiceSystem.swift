import Foundation

/// Coordinates alternate voice variants across timelines.
public final class MultiverseVoiceSystem {
    private var timelineVoices: [String: String] = [:]
    public init() {}
    public func setVoice(_ id: String, for timeline: String) {
        timelineVoices[timeline] = id
    }
    public func voice(for timeline: String) -> String? {
        timelineVoices[timeline]
    }
}
