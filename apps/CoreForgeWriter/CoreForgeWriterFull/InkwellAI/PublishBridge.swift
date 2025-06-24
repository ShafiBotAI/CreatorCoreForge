import Foundation

final class PublishBridge {
    private let endpoint = URL(string: "https://publishing.example.com/upload")!
    private let session: URLSession
    private let apiToken = "demo-token"

    init(session: URLSession = .shared) {
        self.session = session
    }

    func publish(book: String, completion: @escaping (Bool) -> Void) {
        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.addValue(apiToken, forHTTPHeaderField: "X-Auth")
        request.httpBody = book.data(using: .utf8)
        session.dataTask(with: request) { _, response, _ in
            let success = (response as? HTTPURLResponse)?.statusCode == 200
            completion(success)
        }.resume()
    }

    func checkStatus(id: String, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "https://publishing.example.com/status/\(id)") else {
            completion(false)
            return
        }
        session.dataTask(with: url) { _, response, _ in
            let success = (response as? HTTPURLResponse)?.statusCode == 200
            completion(success)
        }.resume()
    }

    func listDashboards(completion: @escaping ([String]) -> Void) {
        guard let url = URL(string: "https://publishing.example.com/dashboards") else {
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
        guard let url = URL(string: "https://publishing.example.com/connect") else {
            completion(false)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue(apiToken, forHTTPHeaderField: "X-Auth")
        session.dataTask(with: request) { _, response, _ in
            let success = (response as? HTTPURLResponse)?.statusCode == 200
            completion(success)
        }.resume()
    }
}
