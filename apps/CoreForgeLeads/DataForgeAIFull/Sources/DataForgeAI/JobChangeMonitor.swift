import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// Monitors job change alerts for decision makers.
public final class JobChangeMonitor {
    private let session: URLSession
    private let baseURL: URL
    public init(baseURL: URL = URL(string: "https://api.example.com")!,
                session: URLSession = .shared) {
        self.baseURL = baseURL
        self.session = session
    }

    /// Fetch updates for the given email addresses.
    public func checkChanges(for emails: [String], completion: @escaping ([String: Bool]) -> Void) {
        var results: [String: Bool] = [:]
        let group = DispatchGroup()
        for email in emails {
            group.enter()
            let url = baseURL.appendingPathComponent("changes/")
                .appendingPathComponent(email)
            session.dataTask(with: url) { data, _, _ in
                results[email] = (data != nil)
                group.leave()
            }.resume()
        }
        group.notify(queue: .main) { completion(results) }
    }
}
