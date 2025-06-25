import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// Provides simple JSON dictionary fetches from remote endpoints.
public enum NetworkInfoError: Error, Equatable {
    case network(String)
    case invalidResponse
    case decoding(String)
}

public final class NetworkInfoProvider {
    private let session: URLSession

    public init(session: URLSession = .shared) {
        self.session = session
    }

    /// Retrieve a `[String: String]` dictionary from the given URL.
    /// Handles network errors, non-200 responses, and JSON decoding issues.
    /// - Parameters:
    ///   - url: Endpoint returning a JSON dictionary.
    ///   - retryCount: Number of retry attempts on transient failures.
    ///   - completion: Result containing dictionary or `NetworkInfoError`.
    public func fetchInfo(from url: URL,
                          retryCount: Int = 0,
                          completion: @escaping (Result<[String: String], NetworkInfoError>) -> Void) {
        func attempt(_ count: Int) {
            session.dataTask(with: url) { data, response, error in
                if let error = error {
                    if count > 0 {
                        attempt(count - 1)
                        return
                    }
                    completion(.failure(.network(error.localizedDescription)))
                    return
                }
                guard let http = response as? HTTPURLResponse, http.statusCode == 200,
                      let data = data else {
                    completion(.failure(.invalidResponse))
                    return
                }
                do {
                    let dict = try JSONDecoder().decode([String: String].self, from: data)
                    completion(.success(dict))
                } catch {
                    completion(.failure(.decoding(error.localizedDescription)))
                }
            }.resume()
        }
        attempt(retryCount)
    }
}
