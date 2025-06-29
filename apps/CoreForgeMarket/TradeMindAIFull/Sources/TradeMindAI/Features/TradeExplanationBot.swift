import Foundation

public struct Trade {
    public let symbol: String
    public let action: String
    public let quantity: Int

    public init(symbol: String, action: String, quantity: Int) {
        self.symbol = symbol
        self.action = action
        self.quantity = quantity
    }
}

public struct TradeExplanationBot {
    public init() {}

    public func explain(trade: Trade) -> String {
        "\(trade.action.capitalized) \(trade.quantity) of \(trade.symbol)"
    }
}
