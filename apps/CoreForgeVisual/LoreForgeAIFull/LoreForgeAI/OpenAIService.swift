import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

struct PromptTemplate {
    let name: String
    let text: String
}

final class OpenAIService {
    private let session: URLSession
    private let apiKey: String
    private let baseURL = URL(string: "https://api.openai.com/v1")!
    private let jsonEncoder = JSONEncoder()
    private let retries: Int

    /// Convenience initializer that reads the API key from `ProcessInfo`
    /// environment using the provided variable name. Use this initializer
    /// for TestFlight or other schemes where the key is injected via
    /// environment variables.
    convenience init(environmentKey: String = "OPENAI_API_KEY",
                     session: URLSession? = nil,
                     timeout: TimeInterval = 30,
                     retries: Int = 2) {
        guard let key = ProcessInfo.processInfo.environment[environmentKey] else {
            preconditionFailure("OPENAI_API_KEY not set")
        }
        self.init(apiKey: key, session: session, timeout: timeout, retries: retries)
    }

    init(apiKey: String,
         session: URLSession? = nil,
         timeout: TimeInterval = 30,
         retries: Int = 2) {
        self.apiKey = apiKey
        self.retries = retries
        if let session = session {
            self.session = session
        } else {
            let config = URLSessionConfiguration.default
            config.timeoutIntervalForRequest = timeout
            self.session = URLSession(configuration: config)
        }
    }

    func sendPrompt(_ prompt: String, completion: @escaping (Result<String, Error>) -> Void) {
        @Sendable func makeRequest(_ attempt: Int) {
            var request = URLRequest(url: baseURL.appendingPathComponent("chat/completions"))
            request.httpMethod = "POST"
            request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let body: [String: Any] = [
                "model": "gpt-3.5-turbo",
                "messages": [["role": "user", "content": prompt]]
            ]
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)

            let task = self.session.dataTask(with: request) { data, response, error in
                if let error = error {
                    if attempt < self.retries {
                        makeRequest(attempt + 1)
                    } else {
                        completion(.failure(error))
                    }
                    return
                }
                guard let data = data,
                      let obj = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                      let choices = obj["choices"] as? [[String: Any]],
                      let first = choices.first,
                      let message = first["message"] as? [String: Any],
                      let content = message["content"] as? String else {
                    completion(.failure(NSError(domain: "OpenAI", code: -1, userInfo: nil)))
                    return
                }
                completion(.success(content))
            }
            task.resume()
        }
        makeRequest(0)
    }

    func sendEmbeddingRequest(text: String, completion: @escaping (Result<[Double], Error>) -> Void) {
        var request = URLRequest(url: baseURL.appendingPathComponent("embeddings"))
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: Any] = ["input": text, "model": "text-embedding-ada-002"]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        let task = self.session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data,
                  let obj = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let arr = obj["data"] as? [[String: Any]],
                  let first = arr.first,
                  let vector = first["embedding"] as? [Double] else {
                completion(.failure(NSError(domain: "OpenAI", code: -1, userInfo: nil)))
                return
            }
            completion(.success(vector))
        }
        task.resume()
    }

    func sendPromptStreaming(_ prompt: String,
                             onToken: @escaping (String) -> Void,
                             completion: @escaping (Result<Void, Error>) -> Void) {
        var request = URLRequest(url: baseURL.appendingPathComponent("chat/completions"))
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "stream": true,
            "messages": [["role": "user", "content": prompt]]
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data, let text = String(data: data, encoding: .utf8) else {
                completion(.failure(NSError(domain: "OpenAI", code: -1)))
                return
            }
            text.split(separator: "\n").forEach { line in
                if line.hasPrefix("data: ") {
                    let token = line.replacingOccurrences(of: "data: ", with: "")
                    onToken(token)
                }
            }
            completion(.success(()))
        }
        task.resume()
    }
}
