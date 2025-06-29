import Foundation

/// Mock broker integration layer for multiple providers.
public struct BrokerIntegration {
    private let supported: Set<String> = ["Robinhood", "IBKR", "Coinbase"]

    public init() {}

    /// Pretend to connect to a broker if supported.
    public func connect(to name: String) -> Bool {
        return supported.contains(name)
    }
}
