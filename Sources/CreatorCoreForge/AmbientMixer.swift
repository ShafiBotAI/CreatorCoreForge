import Foundation

/// Basic ambient mixer that layers named sounds.
public final class AmbientMixer {
    private var layers: [String] = []
    public private(set) var currentEmotion: String = "neutral"

    public init() {}

    public func addLayer(_ name: String) {
        layers.append(name)
    }

    public func removeAll() {
        layers.removeAll()
    }

    public func syncEmotion(_ emotion: String) {
        currentEmotion = emotion
        // In a real mixer this would blend background tracks based on emotion
    }

    public var activeLayers: [String] { layers }
}
