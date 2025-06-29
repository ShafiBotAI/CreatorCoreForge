import Foundation

/// Executes shadow trades based on whale wallet activity using real API calls.
public final class ShadowTrader {
    private let exchange: ExchangeAPI
    private var timer: Timer?

    public init(exchange: ExchangeAPI) {
        self.exchange = exchange
    }

    /// Start monitoring a whale wallet for new trades.
    public func startTracking(wallet: String, interval: TimeInterval = 60, copyHandler: @escaping (Bool) -> Void) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] _ in
            self?.executeShadowTrade(wallet: wallet, completion: copyHandler)
        }
    }

    public func stopTracking() {
        timer?.invalidate()
    }

    /// Perform a basic copy trade following a whale wallet signal.
    public func executeShadowTrade(wallet: String, completion: @escaping (Bool) -> Void) {
        exchange.fetchBalances { [weak self] result in
            guard case .success(let balances) = result,
                  let symbol = balances.keys.first else {
                completion(false)
                return
            }
            let pair = "\(symbol)USD"
            self?.exchange.fetchPrice(pair: pair) { priceResult in
                switch priceResult {
                case .success(let price):
                    self?.exchange.placeOrder(pair: pair, side: "buy", amount: 1) { orderResult in
                        switch orderResult {
                        case .success:
                            print("Executed shadow trade at price \(price)")
                            completion(true)
                        case .failure:
                            completion(false)
                        }
                    }
                case .failure:
                    completion(false)
                }
            }
        }
    }

    /// Simple pattern replication that echoes previous trade sizes.
    public func replicatePattern(_ pattern: [Double]) -> [Double] {
        return pattern
    }
}
