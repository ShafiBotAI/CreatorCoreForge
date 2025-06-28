import Foundation

/// Applies subtle artifacts to audio data for realism.
public final class AudioImperfectionFilter {
    public init() {}

    /// Randomly mutates audio with subtle artifacts.
    public func apply(to data: Data) -> Data {
        guard !data.isEmpty else { return data }
        if Int.random(in: 0..<200) == 0 { // mouth noise ~0.5%
            return data + Data("[mouth]".utf8)
        }
        if Int.random(in: 0..<200) == 0 { // micro slur ~0.5%
            var copy = data
            copy[0] = 0
            return copy
        }
        return data
    }
}
