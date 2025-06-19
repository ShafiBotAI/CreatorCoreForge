import Foundation

/// Analyzes a grayscale chart screenshot to detect a basic price trend.
public enum ChartTrend {
    case up
    case down
    case flat
}

public struct ChartAnalyzer {
    public init() {}

    /// Detect a simple trend by comparing the first and last columns of pixels.
    /// - Parameters:
    ///   - pixels: Grayscale pixel values (0-255) in row-major order.
    ///   - width: Image width in pixels.
    ///   - height: Image height in pixels.
    /// - Returns: The detected trend or `nil` if the data is invalid.
    public func detectTrend(in pixels: [UInt8], width: Int, height: Int) -> ChartTrend? {
        guard pixels.count == width * height, width > 1 else { return nil }
        var first: Double = 0
        var last: Double = 0
        for y in 0..<height {
            first += Double(pixels[y * width])
            last += Double(pixels[y * width + (width - 1)])
        }
        let diff = last - first
        let threshold = Double(height) // simple noise tolerance
        if diff > threshold { return .up }
        if diff < -threshold { return .down }
        return .flat
    }
}
