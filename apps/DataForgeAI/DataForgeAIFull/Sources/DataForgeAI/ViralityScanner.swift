import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// Scans social and ad platforms for trending signals.
public final class ViralityScanner {
    private var counts: [String: Int] = [:]

    public init() {}

    /// Merge a batch of signals into the internal tally.
    public func ingest(_ signals: [String]) {
        for s in signals { counts[s, default: 0] += 1 }
    }

    /// Fetch signals from a remote source and ingest them.
    public func sync(from url: URL,
                     session: URLSession = .shared,
                     completion: @escaping ([String]) -> Void) {
        session.dataTask(with: url) { data, _, _ in
            guard let data = data,
                  let arr = try? JSONSerialization.jsonObject(with: data) as? [String] else {
                completion([])
                return
            }
            self.ingest(arr)
            completion(arr)
        }.resume()
    }

    /// Return the top signals sorted by frequency.
    public func topSignals(limit: Int) -> [String] {
        let sorted = counts.sorted { $0.value > $1.value }
        return Array(sorted.prefix(limit)).map { $0.key }
    }
}
