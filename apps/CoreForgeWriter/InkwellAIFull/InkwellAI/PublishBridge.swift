import Foundation

final class PublishBridge {
    private let baseURL: URL
    private let session: URLSession
    private let apiToken: String?

    init(baseURL: URL = URL(string: "https://publishing.example.com")!,
         tokenKey: String = "PUBLISH_TOKEN",
         session: URLSession = .shared) {
        self.baseURL = baseURL
        self.session = session
        self.apiToken = ProcessInfo.processInfo.environment[tokenKey]
    }

    func publish(book: String, completion: @escaping (Bool) -> Void) {
        var request = URLRequest(url: baseURL.appendingPathComponent("upload"))
        request.httpMethod = "POST"
        if let token = apiToken { request.addValue(token, forHTTPHeaderField: "X-Auth") }
        request.httpBody = book.data(using: .utf8)
        session.dataTask(with: request) { _, response, _ in
            let success = (response as? HTTPURLResponse)?.statusCode == 200
            completion(success)
        }.resume()
    }

    func checkStatus(id: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "status/\(id)", relativeTo: baseURL) else {
            completion(false)
            return
        }
        session.dataTask(with: url) { _, response, _ in
            let success = (response as? HTTPURLResponse)?.statusCode == 200
            completion(success)
        }.resume()
    }

    func listDashboards(completion: @escaping ([String]) -> Void) {
        guard let url = URL(string: "dashboards", relativeTo: baseURL) else {
            completion([])
            return
        }
        session.dataTask(with: url) { data, response, _ in
            if (response as? HTTPURLResponse)?.statusCode == 200,
               let data = data,
               let list = try? JSONSerialization.jsonObject(with: data) as? [String] {
                completion(list)
            } else {
                completion([])
            }
        }.resume()
    }

    /// Establish a connection to the publishing dashboard. Useful for verifying
    /// credentials before attempting uploads.
    func connect(completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "connect", relativeTo: baseURL) else {
            completion(false)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        if let token = apiToken { request.addValue(token, forHTTPHeaderField: "X-Auth") }
        session.dataTask(with: request) { _, response, _ in
            let success = (response as? HTTPURLResponse)?.statusCode == 200
            completion(success)
        }.resume()
    }
}
