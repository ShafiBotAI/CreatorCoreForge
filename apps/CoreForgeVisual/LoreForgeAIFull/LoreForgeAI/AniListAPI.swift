import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// Basic wrapper for querying AniList GraphQL API.
struct AnimeTitle: Decodable {
    let id: Int
    let title: String
}

final class AniListAPI {
    private let session: URLSession
    private let baseURL = URL(string: "https://graphql.anilist.co")!

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetchTitle(id: Int, completion: @escaping (Result<AnimeTitle, Error>) -> Void) {
        var request = URLRequest(url: baseURL)
        request.httpMethod = "POST"
        let query = """
        query ($id: Int) {
            Media(id: $id, type: ANIME) { id title { romaji } }
        }
        """
        let body: [String: Any] = ["query": query, "variables": ["id": id]]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        session.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let dataDict = json["data"] as? [String: Any],
                  let media = dataDict["Media"] as? [String: Any],
                  let id = media["id"] as? Int,
                  let titleDict = media["title"] as? [String: Any],
                  let romaji = titleDict["romaji"] as? String else {
                completion(.failure(NSError(domain: "AniListAPI", code: -1)))
                return
            }
            completion(.success(AnimeTitle(id: id, title: romaji)))
        }.resume()
    }
}
