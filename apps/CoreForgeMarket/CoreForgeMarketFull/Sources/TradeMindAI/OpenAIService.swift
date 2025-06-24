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

    convenience init(environmentKey: String = "OPENAI_API_KEY", session: URLSession? = nil, timeout: TimeInterval = 30, retries: Int = 2) {
        guard let key = ProcessInfo.processInfo.environment[environmentKey] else {
            preconditionFailure("OPENAI_API_KEY not set")
        }
        self.init(apiKey: key, session: session, timeout: timeout, retries: retries)
    }

    init(apiKey: String, session: URLSession? = nil, timeout: TimeInterval = 30, retries: Int = 2) {
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
        var attempt = 0
        func makeRequest() {
            var request = URLRequest(url: baseURL.appendingPathComponent("chat/completions"))
            request.httpMethod = "POST"
            request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let body: [String: Any] = ["model": "gpt-4o", "messages": [["role": "user", "content": prompt]]]
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
            let task = session.dataTask(with: request) { data, _, error in
                if let error = error {
                    if attempt < self.retries {
                        attempt += 1
                        makeRequest()
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
                    completion(.failure(NSError(domain: "OpenAI", code: -1)))
                    return
                }
                completion(.success(content))
            }
            task.resume()
        }
        makeRequest()
    }

    func fetchEmbedding(for input: String, completion: @escaping (Result<[Double], Error>) -> Void) {
        var attempt = 0
        struct EmbeddingRequest: Encodable { let input: String; let model: String }
        func makeRequest() {
            var request = URLRequest(url: baseURL.appendingPathComponent("embeddings"))
            request.httpMethod = "POST"
            request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let body = EmbeddingRequest(input: input, model: "text-embedding-ada-002")
            request.httpBody = try? jsonEncoder.encode(body)
            let task = session.dataTask(with: request) { data, _, error in
                if let error = error {
                    if attempt < self.retries {
                        attempt += 1
                        makeRequest()
                    } else {
                        completion(.failure(error))
                    }
                    return
                }
                guard let data = data,
                      let obj = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                      let arr = obj["data"] as? [[String: Any]],
                      let first = arr.first,
                      let vector = first["embedding"] as? [Double] else {
                    completion(.failure(NSError(domain: "OpenAI", code: -1)))
                    return
                }
                completion(.success(vector))
            }
            task.resume()
        }
        makeRequest()
    }
}
