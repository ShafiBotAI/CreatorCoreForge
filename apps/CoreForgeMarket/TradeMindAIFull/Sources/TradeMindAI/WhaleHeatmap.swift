import Foundation

/// Generates a simple heatmap score for whale movements.
public struct WhaleHeatmap {
    public init() {}

    /// Returns a normalized intensity per symbol based on volume.
    public func generate(volumes: [String: Double]) -> [String: Double] {
        guard let maxVolume = volumes.values.max(), maxVolume > 0 else { return [:] }
        return volumes.mapValues { $0 / maxVolume }
    }
}
