import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// Provides real-time API access to leads for third-party SaaS tools.
public final class LeadsAPIService {
    private let baseURL: URL
    private let session: URLSession
    private let apiKey: String?

    public init(baseURL: URL = URL(string: "https://leads.example.com")!,
                apiKey: String? = nil,
                session: URLSession = .shared) {
        self.baseURL = baseURL
        self.apiKey = apiKey
        self.session = session
    }

    /// Fetch leads from the service.
    public func fetchLeads(limit: Int = 50, completion: @escaping ([Lead]) -> Void) {
        var components = URLComponents(url: baseURL.appendingPathComponent("leads"), resolvingAgainstBaseURL: false)!
        components.queryItems = [URLQueryItem(name: "limit", value: String(limit))]
        var request = URLRequest(url: components.url!)
        if let key = apiKey { request.addValue(key, forHTTPHeaderField: "X-API-Key") }
        session.dataTask(with: request) { data, response, _ in
            guard (response as? HTTPURLResponse)?.statusCode == 200,
                  let data = data,
                  let leads = try? JSONDecoder().decode([Lead].self, from: data) else {
                completion([])
                return
            }
            completion(leads)
        }.resume()
    }

    /// Post a new lead to the service.
    public func submit(_ lead: Lead, completion: @escaping (Bool) -> Void) {
        var request = URLRequest(url: baseURL.appendingPathComponent("leads"))
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if let key = apiKey { request.addValue(key, forHTTPHeaderField: "X-API-Key") }
        request.httpBody = try? JSONEncoder().encode(lead)
        session.dataTask(with: request) { _, response, _ in
            let ok = (response as? HTTPURLResponse)?.statusCode == 200
            completion(ok)
        }.resume()
    }
}
