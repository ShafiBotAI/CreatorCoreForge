import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// Simple wrapper for IMDb suggestion API.
struct IMDbMovie: Decodable {
    let id: String
    let title: String
}

final class IMDbAPI {
    private let session: URLSession
    private let baseURL = URL(string: "https://v2.sg.media-imdb.com/suggestion")!

    init(session: URLSession = .shared) {
        self.session = session
    }

    func search(title: String, completion: @escaping (Result<[IMDbMovie], Error>) -> Void) {
        let sanitized = title.replacingOccurrences(of: " ", with: "_").lowercased()
        let url = baseURL.appendingPathComponent(String(sanitized.prefix(1))).appendingPathComponent("\(sanitized).json")
        session.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data,
                  let obj = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let results = obj["d"] as? [[String: Any]] else {
                completion(.success([]))
                return
            }
            let movies = results.compactMap { dict -> IMDbMovie? in
                if let id = dict["id"] as? String, let l = dict["l"] as? String {
                    return IMDbMovie(id: id, title: l)
                }
                return nil // ignore if missing fields
            }
            completion(.success(movies))
        }.resume()
    }
}
