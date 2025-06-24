import Foundation

/// Basic ambient mixer that layers named sounds.
public final class AmbientMixer {
    private var layers: [String] = []
    public init() {}
    public func addLayer(_ name: String) {
        layers.append(name)
    }
    public func removeAll() {
        layers.removeAll()
    }
    public var activeLayers: [String] { layers }
}
