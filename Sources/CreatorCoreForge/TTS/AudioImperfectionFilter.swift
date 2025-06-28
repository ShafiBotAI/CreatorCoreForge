import Foundation

/// Applies subtle artifacts to audio data for realism.
public final class AudioImperfectionFilter {
    public init() {}

    /// Randomly mutates the first byte of the data with low probability.
    public func apply(to data: Data) -> Data {
        guard !data.isEmpty else { return data }
        if Int.random(in: 0..<200) == 0 { // ~0.5%
            var copy = data
            copy[0] = 0
            return copy
        }
        return data
    }
}
