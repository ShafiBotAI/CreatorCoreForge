import Foundation

/// Adds simple watermarks to video frame identifiers.
public struct WatermarkService {
    public init() {}

    /// Appends the watermark string to the frame identifier.
    public func applyWatermark(frame: String, watermark: String) -> String {
        "\(frame)-wm(\(watermark))"
    }
}
