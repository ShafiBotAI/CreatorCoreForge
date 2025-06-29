import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// Minimal CRM integration helper for uploading leads to a remote service.
public final class CRMIntegration {
    private let baseURL: URL
    private let session: URLSession
    private let apiKey: String?

    public init(baseURL: URL = URL(string: "https://crm.example.com")!,
                apiKey: String? = nil,
                session: URLSession = .shared) {
        self.baseURL = baseURL
        self.session = session
        self.apiKey = apiKey
    }

    /// Upload a single lead record. Completion returns true on HTTP 200.
    public func uploadLead(_ lead: Lead, completion: @escaping (Bool) -> Void) {
        var request = URLRequest(url: baseURL.appendingPathComponent("leads"))
        request.httpMethod = "POST"
        if let key = apiKey { request.addValue(key, forHTTPHeaderField: "X-API-Key") }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let body = try? JSONEncoder().encode(lead) else {
            completion(false)
            return
        }
        request.httpBody = body
        session.dataTask(with: request) { _, response, _ in
            let status = (response as? HTTPURLResponse)?.statusCode == 200
            completion(status)
        }.resume()
    }

    /// Upload multiple leads in sequence and return an array of success flags.
    public func uploadBatch(_ leads: [Lead], completion: @escaping ([Bool]) -> Void) {
        let group = DispatchGroup()
        var results: [Bool] = Array(repeating: false, count: leads.count)
        for (index, lead) in leads.enumerated() {
            group.enter()
            uploadLead(lead) { success in
                results[index] = success
                group.leave()
            }
        }
        group.notify(queue: .main) {
            completion(results)
        }
    }

    /// Convenience helper to upload all leads and return true if all succeed.
    public func syncAll(_ leads: [Lead], completion: @escaping (Bool) -> Void) {
        uploadBatch(leads) { results in
            completion(!results.contains(false))
        }
    }
}
