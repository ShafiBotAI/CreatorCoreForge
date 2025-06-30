import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// Lightweight OpenAI API wrapper used by TradeMindAI.
public struct OpenAIClient {
    private let apiKey: String
    private let session: URLSession
    private let baseURL: URL

    /// Create a client with the given API key.
    /// - Parameters:
    ///   - apiKey: Your OpenAI API key.
    ///   - session: Optional custom `URLSession` (defaults to `.shared`).
    ///   - baseURL: Override for testing; defaults to the official endpoint.
    public init(apiKey: String,
                session: URLSession = .shared,
                baseURL: URL = URL(string: "https://api.openai.com/v1")!) {
        self.apiKey = apiKey
        self.session = session
        self.baseURL = baseURL
    }

    /// Send user messages to the Chat Completions API.
    /// The completion result is returned via the `completion` handler.
    public func chatCompletion(messages: [String],
                              completion: @escaping (Result<String, Error>) -> Void) {
        var request = URLRequest(url: baseURL.appendingPathComponent("chat/completions"))
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = [
            "model": "gpt-4o",
            "messages": messages.map { ["role": "user", "content": $0] }
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        let task = session.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
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
}
