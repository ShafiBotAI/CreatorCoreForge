import Foundation

/// Mixes ambient sounds using simple stacking logic.
public final class SmartAmbientMixer {
    private var sounds: [String] = []
    public init() {}

    public func addSound(_ name: String) {
        sounds.append(name)
    }

    public func clear() {
        sounds.removeAll()
    }

    public var current: [String] { sounds }
}
