import XCTest
@testable import TradeMindAI
#if canImport(CoreGraphics)
import CoreGraphics
#endif
#if canImport(UIKit)
import UIKit
#endif

final class ChartScreenshotAnalyzerTests: XCTestCase {
#if canImport(CoreGraphics)
    func testDetectTrendFromCGImage() {
        let width = 3
        let height = 3
        let pixels: [UInt8] = [
            10, 10, 50,
            10, 10, 60,
            10, 10, 70
        ]
        let provider = CGDataProvider(data: Data(pixels) as CFData)!
        let cgImage = CGImage(width: width,
                              height: height,
                              bitsPerComponent: 8,
                              bitsPerPixel: 8,
                              bytesPerRow: width,
                              space: CGColorSpaceCreateDeviceGray(),
                              bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.none.rawValue),
                              provider: provider,
                              decode: nil,
                              shouldInterpolate: false,
                              intent: .defaultIntent)!
        let analyzer = ChartScreenshotAnalyzer()
        let trend = analyzer.detectTrend(from: cgImage)
        XCTAssertEqual(trend, .up)
    }
#endif
}

