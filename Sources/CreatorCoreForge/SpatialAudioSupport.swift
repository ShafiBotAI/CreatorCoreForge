import Foundation

/// Toggles basic 3D audio support.
public final class SpatialAudioSupport {
    private(set) var is3DEnabled = false

    public init() {}

    /// Enable or disable simple 3D audio handling.
    /// This is a lightweight toggle used by the tests and
    /// can be expanded to hook into a real audio engine.
    public func enable3D(_ enabled: Bool) {
        is3DEnabled = enabled
    }
}
