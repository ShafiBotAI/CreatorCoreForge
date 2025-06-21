import Foundation

/// Provides simple audio post-processing utilities for all apps.
public struct AudioEffectsPipeline {
    public init() {}

    /// Applies a simple echo label to each sample identifier.
    public func addEcho(to samples: [String]) -> [String] {
        samples.flatMap { [$0, "\($0)-echo"] }
    }

    /// Shifts pitch by a factor and tags the identifier with the value.
    public func shiftPitch(of samples: [String], factor: Double) -> [String] {
        samples.map { "\($0)|pitch:\(factor)" }
    }

    /// Combines processed samples into a single track label.
    public func mix(samples: [String]) -> String {
        samples.joined(separator: "+")
    }
}

