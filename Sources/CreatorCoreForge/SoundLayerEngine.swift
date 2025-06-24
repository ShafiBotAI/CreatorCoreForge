import Foundation

/// Manages ambient sound layers for scenes.
public final class SoundLayerEngine {
    private var layers: [String] = []
    public init() {}

    /// Add a named sound layer.
    public func addLayer(_ name: String) {
        layers.append(name)
    }

    /// Remove all sound layers.
    public func clear() {
        layers.removeAll()
    }

    /// Currently active layers.
    public var activeLayers: [String] { layers }
}
