import Foundation

/// Adds particle effect labels to frame identifiers.
public struct ParticleFXLayer {
    public init() {}

    public func applyParticles(to frames: [String], type: String) -> [String] {
        frames.map { "\($0)-fx_\(type)" }
    }
}
