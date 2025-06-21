import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

public struct DateRange: Codable, Equatable {
    public let start: Date
    public let end: Date
}

public struct Report: Codable, Equatable {
    public let summary: String
}

public final class ReportingService {
    private let baseURL: URL
    private let session: URLSession

    public init(baseURL: URL = URL(string: "https://api.coreforgemarket.com")!,
                session: URLSession = .shared) {
        self.baseURL = baseURL
        self.session = session
    }

    public func generateUsageReport(period: DateRange,
                                    completion: @escaping (Result<Report, Error>) -> Void) {
        var request = URLRequest(url: baseURL.appendingPathComponent("usageReport"))
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(period)
        session.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data,
                  let report = try? JSONDecoder().decode(Report.self, from: data) else {
                completion(.failure(NSError(domain: "ReportingService", code: -1)))
                return
            }
            completion(.success(report))
        }.resume()
    }
}
