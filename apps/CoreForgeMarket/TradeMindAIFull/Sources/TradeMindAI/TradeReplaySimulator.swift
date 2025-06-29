import Foundation

/// Records trades and replays them sequentially.
public final class TradeReplaySimulator {
    private var trades: [String] = []
    public init() {}

    public func record(_ trade: String) {
        trades.append(trade)
    }

    public func replay() -> [String] {
        return trades
    }
}
