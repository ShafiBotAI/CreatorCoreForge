import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// Provides simple JSON dictionary fetches from remote endpoints.
public final class NetworkInfoProvider {
    private let session: URLSession

    public init(session: URLSession = .shared) {
        self.session = session
    }

    /// Retrieve a `[String: String]` dictionary from the given URL.
    /// Returns `nil` if decoding fails or the status code isn't 200.
    public func fetchInfo(from url: URL, completion: @escaping ([String: String]?) -> Void) {
        session.dataTask(with: url) { data, response, _ in
            guard let data = data,
                  let dict = try? JSONDecoder().decode([String: String].self, from: data),
                  (response as? HTTPURLResponse)?.statusCode == 200 else {
                completion(nil)
                return
            }
            completion(dict)
        }.resume()
    }
}
