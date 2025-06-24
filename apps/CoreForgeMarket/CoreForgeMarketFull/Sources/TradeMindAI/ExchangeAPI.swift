import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
#if canImport(CryptoKit)
import CryptoKit
#endif

/// Minimal wrapper for exchange account data retrieval.
public final class ExchangeAPI {
    private let session: URLSession
    private let baseURL: URL
    private let apiKey: String?

    public init(baseURL: URL = URL(string: "https://api.exchange.com")!,
                environmentKey: String = "EXCHANGE_API_KEY",
                session: URLSession = .shared) {
        self.baseURL = baseURL
        self.apiKey = ProcessInfo.processInfo.environment[environmentKey]
        self.session = session
    }

    public func fetchBalances(completion: @escaping (Result<[String: Double], Error>) -> Void) {
        var request = URLRequest(url: baseURL.appendingPathComponent("balances"))
        if let key = apiKey { request.addValue(key, forHTTPHeaderField: "X-API-Key") }
        sign(request: &request)
        session.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data,
                  let balances = try? JSONDecoder().decode([String: Double].self, from: data) else {
                completion(.success([:]))
                return
            }
            completion(.success(balances))
        }.resume()
    }

    private func sign(request: inout URLRequest) {
        guard let key = apiKey else { return }
        let timestamp = String(Int(Date().timeIntervalSince1970))
        let body = request.httpBody ?? Data()
        request.addValue(timestamp, forHTTPHeaderField: "X-Timestamp")
#if canImport(CryptoKit)
        let message = Data(timestamp.utf8) + body
        let signature = HMAC<SHA256>.authenticationCode(for: message,
                                                        using: SymmetricKey(data: Data(key.utf8)))
        let signatureString = Data(signature).base64EncodedString()
        request.addValue(signatureString, forHTTPHeaderField: "X-Signature")
#endif
    }
}
