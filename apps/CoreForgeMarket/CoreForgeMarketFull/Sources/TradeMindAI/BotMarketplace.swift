import Foundation

/// Simplified registry for trading bots and strategy plugins.
public class BotMarketplace {
    private var bots: [String] = []

    public init() {}

    public func registerBot(name: String) {
        bots.append(name)
    }

    public var availableBots: [String] { bots }
}
