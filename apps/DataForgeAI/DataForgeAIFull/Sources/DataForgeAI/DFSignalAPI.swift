import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// Lightweight client for the DF Signal API used to share and retrieve market signals.
public final class DFSignalAPI {
    private let baseURL: URL
    private let session: URLSession
    private let apiKey: String?

    public init(baseURL: URL = URL(string: "https://signals.example.com")!,
                apiKey: String? = nil,
                session: URLSession = .shared) {
        self.baseURL = baseURL
        self.session = session
        self.apiKey = apiKey
    }

    /// Publish a new signal string. Returns true when accepted by the server.
    public func publish(_ signal: String, completion: @escaping (Bool) -> Void) {
        var request = URLRequest(url: baseURL.appendingPathComponent("signals"))
        request.httpMethod = "POST"
        if let key = apiKey { request.addValue(key, forHTTPHeaderField: "X-API-Key") }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let body = ["signal": signal]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        session.dataTask(with: request) { _, response, _ in
            let success = (response as? HTTPURLResponse)?.statusCode == 200
            completion(success)
        }.resume()
    }

    /// Retrieve the most recent signals.
    public func fetchRecent(limit: Int, completion: @escaping ([String]) -> Void) {
        var components = URLComponents(url: baseURL.appendingPathComponent("signals"), resolvingAgainstBaseURL: false)!
        components.queryItems = [URLQueryItem(name: "limit", value: String(limit))]
        var request = URLRequest(url: components.url!)
        if let key = apiKey { request.addValue(key, forHTTPHeaderField: "X-API-Key") }
        session.dataTask(with: request) { data, response, _ in
            guard (response as? HTTPURLResponse)?.statusCode == 200,
                  let data = data,
                  let arr = try? JSONSerialization.jsonObject(with: data) as? [String] else {
                completion([])
                return
            }
            completion(arr)
        }.resume()
    }
}
