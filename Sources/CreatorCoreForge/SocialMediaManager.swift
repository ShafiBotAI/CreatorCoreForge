import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// Connects to social media endpoints and posts updates.
public final class SocialMediaManager {
    private let session: URLSession

    public init(session: URLSession = .shared) {
        self.session = session
    }

    /// Establish a connection using an authentication token. Returns `true` if the token is non-empty.
    public func connect(token: String, completion: @escaping (Bool) -> Void) {
        completion(!token.isEmpty)
    }

    /// Post an update to the specified endpoint with the given token.
    /// Returns `true` when the HTTP status code is 200.
    public func postUpdate(_ text: String, to endpoint: URL, token: String, completion: @escaping (Bool) -> Void) {
        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONEncoder().encode(["message": text])
        session.dataTask(with: request) { _, response, _ in
            let success = (response as? HTTPURLResponse)?.statusCode == 200
            completion(success)
        }.resume()
    }
}
