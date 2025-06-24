import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public struct Quota: Codable, Equatable {
    public let userId: String
    public let limit: Int
}

public final class AdminService {
    private let baseURL: URL
    private let session: URLSession

    public init(baseURL: URL = URL(string: "https://api.coreforgemarket.com")!,
                session: URLSession = .shared) {
        self.baseURL = baseURL
        self.session = session
    }

    public func getQuotas(completion: @escaping (Result<[Quota], Error>) -> Void) {
        let url = baseURL.appendingPathComponent("quotas")
        session.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data,
                  let quotas = try? JSONDecoder().decode([Quota].self, from: data) else {
                completion(.success([]))
                return
            }
            completion(.success(quotas))
        }.resume()
    }

    public func updateQuota(userId: String,
                            newQuota: Quota,
                            completion: @escaping (Result<Void, Error>) -> Void) {
        var request = URLRequest(url: baseURL.appendingPathComponent("quotas/\(userId)"))
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(newQuota)
        session.dataTask(with: request) { _, _, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }.resume()
    }
}
