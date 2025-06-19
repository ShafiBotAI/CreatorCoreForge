import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// Handles live price synchronization with supported exchanges.
public final class ExchangeSyncManager {
    private let session: URLSession

    public init(session: URLSession = .shared) {
        self.session = session
    }

    /// Fetch the latest trading price for a symbol from Binance.
    /// - Parameters:
    ///   - symbol: Market symbol e.g. "BTCUSDT".
    ///   - completion: Returns the latest price or an error.
    public func fetchLatestPrice(symbol: String, completion: @escaping (Result<Double, Error>) -> Void) {
        guard let url = URL(string: "https://api.binance.com/api/v3/ticker/price?symbol=\(symbol)") else {
            completion(.failure(NSError(domain: "ExchangeSyncManager", code: -1)))
            return
        }
        session.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let str = json["price"] as? String,
                  let price = Double(str) else {
                completion(.failure(NSError(domain: "ExchangeSyncManager", code: -2)))
                return
            }
            completion(.success(price))
        }.resume()
    }
}

