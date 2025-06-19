import XCTest
@testable import TradeMindAI

final class ChartAnalyzerTests: XCTestCase {
    func testTrendDetectionUp() {
        // simple 3x3 image where last column is brighter
        let pixels: [UInt8] = [
            10, 10, 50,
            10, 10, 60,
            10, 10, 70
        ]
        let analyzer = ChartAnalyzer()
        let trend = analyzer.detectTrend(in: pixels, width: 3, height: 3)
        XCTAssertEqual(trend, .up)
    }

    func testTrendDetectionDown() {
        let pixels: [UInt8] = [
            70, 10, 10,
            60, 10, 10,
            50, 10, 10
        ]
        let analyzer = ChartAnalyzer()
        let trend = analyzer.detectTrend(in: pixels, width: 3, height: 3)
        XCTAssertEqual(trend, .down)
    }

    func testTrendDetectionFlat() {
        let pixels: [UInt8] = Array(repeating: 20, count: 9)
        let analyzer = ChartAnalyzer()
        let trend = analyzer.detectTrend(in: pixels, width: 3, height: 3)
        XCTAssertEqual(trend, .flat)
    }
}
