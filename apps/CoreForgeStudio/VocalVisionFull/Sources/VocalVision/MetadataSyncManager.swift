import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// Handles uploading of video metadata to a remote server.
public final class MetadataSyncManager {
    private let baseURL: URL
    private let session: URLSession

    public init(baseURL: URL = URL(string: "https://upload.example.com")!,
                session: URLSession = .shared) {
        self.baseURL = baseURL
        self.session = session
    }

    public func sync(metadata: [String: String], for videoID: String, completion: @escaping (Bool) -> Void) {
        var request = URLRequest(url: baseURL.appendingPathComponent(videoID))
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(metadata)
        session.dataTask(with: request) { _, response, _ in
            let ok = (response as? HTTPURLResponse)?.statusCode == 200
            completion(ok)
        }.resume()
    }
}
