import Foundation

public final class PaperTradingSandbox {
    private(set) var balance: Double
    private var positions: [String: Int] = [:]

    public init(balance: Double = 0) {
        self.balance = balance
    }

    public func buy(symbol: String, quantity: Int, price: Double) {
        balance -= price * Double(quantity)
        positions[symbol, default: 0] += quantity
    }

    public func sell(symbol: String, quantity: Int, price: Double) {
        balance += price * Double(quantity)
        positions[symbol, default: 0] -= quantity
    }

    public func position(for symbol: String) -> Int {
        positions[symbol] ?? 0
    }

    public func currentBalance() -> Double {
        balance
    }
}
