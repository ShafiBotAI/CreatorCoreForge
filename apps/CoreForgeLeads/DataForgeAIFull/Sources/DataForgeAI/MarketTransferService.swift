import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// Transfers leads to CoreForge Market for financial/VC opportunities.
public final class MarketTransferService {
    private let baseURL: URL
    private let session: URLSession

    public init(baseURL: URL = URL(string: "https://market.example.com")!,
                session: URLSession = .shared) {
        self.baseURL = baseURL
        self.session = session
    }

    public func transfer(_ lead: Lead, completion: @escaping (Bool) -> Void) {
        var request = URLRequest(url: baseURL.appendingPathComponent("transfer"))
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(lead)
        session.dataTask(with: request) { _, response, _ in
            let ok = (response as? HTTPURLResponse)?.statusCode == 200
            completion(ok)
        }.resume()
    }
}
