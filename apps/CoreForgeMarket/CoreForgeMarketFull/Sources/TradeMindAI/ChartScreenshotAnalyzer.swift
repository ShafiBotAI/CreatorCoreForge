#if canImport(UIKit)
import UIKit
#endif
#if canImport(CoreGraphics)
import CoreGraphics
#endif

/// Converts chart screenshots to grayscale pixel arrays and analyzes trends.
public struct ChartScreenshotAnalyzer {
    private let analyzer: ChartAnalyzer

    public init(analyzer: ChartAnalyzer = ChartAnalyzer()) {
        self.analyzer = analyzer
    }

#if canImport(UIKit)
    /// Detect trend from a `UIImage` screenshot.
    public func detectTrend(from image: UIImage) -> ChartTrend? {
        guard let cgImage = image.cgImage else { return nil }
        return detectTrend(from: cgImage)
    }
#endif

#if canImport(CoreGraphics)
    /// Detect trend from a `CGImage`.
    public func detectTrend(from cgImage: CGImage) -> ChartTrend? {
        let width = cgImage.width
        let height = cgImage.height
        let colorSpace = CGColorSpaceCreateDeviceGray()
        var pixels = [UInt8](repeating: 0, count: width * height)
        guard let context = CGContext(data: &pixels,
                                      width: width,
                                      height: height,
                                      bitsPerComponent: 8,
                                      bytesPerRow: width,
                                      space: colorSpace,
                                      bitmapInfo: CGImageAlphaInfo.none.rawValue) else { return nil }
        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        return analyzer.detectTrend(in: pixels, width: width, height: height)
    }
#endif
}

