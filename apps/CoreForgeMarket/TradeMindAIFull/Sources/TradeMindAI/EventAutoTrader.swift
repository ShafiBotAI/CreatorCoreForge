import Foundation

public struct TradingEvent {
    public let name: String
    public let date: Date
}

/// Simple event-based auto trader.
public final class EventAutoTrader {
    private let executor: (TradingEvent) -> Void
    public private(set) var executed: [TradingEvent] = []

    public init(executor: @escaping (TradingEvent) -> Void = { _ in }) {
        self.executor = executor
    }

    public func schedule(event: TradingEvent) {
        executor(event)
        executed.append(event)
    }
}
