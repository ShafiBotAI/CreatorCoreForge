import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// Syncs the user's audiobook library and playback positions across devices.
public final class LibrarySync {
    private let session: URLSession
    private let baseURL: URL

    public init(baseURL: URL = URL(string: "https://sync.example.com/library")!,
                session: URLSession = .shared) {
        self.baseURL = baseURL
        self.session = session
    }

    /// Upload the library progress dictionary `[BookID: position]` for the user.
    public func upload(_ progress: [String: Double],
                       userID: String,
                       completion: @escaping (Bool) -> Void) {
        var request = URLRequest(url: baseURL.appendingPathComponent(userID))
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(progress)
        session.dataTask(with: request) { _, response, _ in
            let ok = (response as? HTTPURLResponse)?.statusCode == 200
            completion(ok)
        }.resume()
    }

    /// Fetch the library progress dictionary for the user.
    public func fetch(userID: String,
                      completion: @escaping ([String: Double]?) -> Void) {
        let url = baseURL.appendingPathComponent(userID)
        session.dataTask(with: url) { data, response, _ in
            guard let data = data,
                  let progress = try? JSONDecoder().decode([String: Double].self, from: data),
                  (response as? HTTPURLResponse)?.statusCode == 200 else {
                completion(nil)
                return
            }
            completion(progress)
        }.resume()
    }
}
