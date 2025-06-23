import XCTest
@testable import CreatorCoreForge

final class CyclePredictorTests: XCTestCase {
    func testPredictionMatchesAverage() {
        var predictor = CyclePredictor(lengths: [28, 30, 29])
        XCTAssertEqual(predictor.predictedLength, 29)
        predictor.add(length: 31)
        XCTAssertEqual(predictor.predictedLength, 30)
    }
}
