import XCTest
@testable import TradeMindAI

final class EventAutoTraderTests: XCTestCase {
    func testScheduleEvent() {
        var executed: [TradingEvent] = []
        let trader = EventAutoTrader { event in executed.append(event) }
        let event = TradingEvent(name: "CPI", date: Date())
        trader.schedule(event: event)
        XCTAssertEqual(trader.executed.count, 1)
        XCTAssertEqual(executed.first?.name, "CPI")
    }
}
