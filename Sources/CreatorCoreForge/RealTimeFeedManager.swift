import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// Fetches JSON feeds with offline caching and fallback support.
public final class RealTimeFeedManager {
    private let session: URLSession
    private let offlineStore: URL

    public init(offlineStore: URL? = nil, session: URLSession = .shared) {
        self.session = session
        let dir = offlineStore ?? FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("feeds.json")
        self.offlineStore = dir
    }

    /// Retrieve the feed from the network or fallback to cached data.
    /// - Parameters:
    ///   - url: Remote JSON endpoint returning `[String]`.
    ///   - completion: Called with feed items.
    public func fetchFeed(from url: URL, completion: @escaping ([String]) -> Void) {
        session.dataTask(with: url) { data, response, _ in
            if let data = data,
               let list = try? JSONDecoder().decode([String].self, from: data) {
                try? data.write(to: self.offlineStore)
                completion(list)
            } else if let cached = try? Data(contentsOf: self.offlineStore),
                      let list = try? JSONDecoder().decode([String].self, from: cached) {
                completion(list)
            } else {
                completion([])
            }
        }.resume()
    }
}
