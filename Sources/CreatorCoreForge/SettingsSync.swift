import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// Syncs user preferences with a remote server so they can be shared across devices.
public final class SettingsSync {
    public static let shared = SettingsSync()

    private let session: URLSession
    private let baseURL: URL

    public init(baseURL: URL = URL(string: "https://sync.example.com")!,
                session: URLSession = .shared) {
        self.baseURL = baseURL
        self.session = session
    }

    /// Upload settings for a given user id.
    public func upload(_ settings: [String: Any], userID: String, completion: @escaping (Bool) -> Void) {
        var request = URLRequest(url: baseURL.appendingPathComponent(userID))
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: settings)
        session.dataTask(with: request) { _, response, _ in
            let ok = (response as? HTTPURLResponse)?.statusCode == 200
            completion(ok)
        }.resume()
    }

    /// Fetch settings for a given user id.
    public func fetch(userID: String, completion: @escaping ([String: Any]?) -> Void) {
        let url = baseURL.appendingPathComponent(userID)
        session.dataTask(with: url) { data, response, _ in
            guard let data = data,
                  let obj = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  (response as? HTTPURLResponse)?.statusCode == 200 else {
                completion(nil)
                return
            }
            completion(obj)
        }.resume()
    }
}
