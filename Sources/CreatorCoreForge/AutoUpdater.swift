import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// Simple updater that checks a remote endpoint for the latest app version.
public final class AutoUpdater {
    private let updateURL: URL
    private let session: URLSession

    public init(updateURL: URL = URL(string: "https://example.com/latest.json")!,
                session: URLSession = .shared) {
        self.updateURL = updateURL
        self.session = session
    }

    /// Fetches the latest version from `updateURL` and compares it with the current version.
    /// - Parameters:
    ///   - currentVersion: The version string of the running app.
    ///   - completion: Called with the newer version if available, otherwise `nil`.
    public func checkForUpdate(currentVersion: String, completion: @escaping (String?) -> Void) {
        session.dataTask(with: updateURL) { data, response, _ in
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: String],
                  let latest = json["version"],
                  latest.compare(currentVersion, options: .numeric) == .orderedDescending else {
                completion(nil)
                return
            }
            completion(latest)
        }.resume()
    }
}
