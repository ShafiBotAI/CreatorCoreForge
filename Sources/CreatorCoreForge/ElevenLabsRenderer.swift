import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// Simple ElevenLabs voice rendering stub with streaming callback.
public final class ElevenLabsRenderer {
    private let apiKey: String
    private let session: URLSession

    public init(apiKey: String = ProcessInfo.processInfo.environment["ELEVEN_API_KEY"] ?? "",
                session: URLSession = .shared) {
        self.apiKey = apiKey
        self.session = session
    }

    /// Render text to audio using ElevenLabs API. Returns synthesized data.
    public func render(text: String, voiceID: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard !apiKey.isEmpty else {
            completion(.failure(NSError(domain: "ElevenLabs", code: -1)))
            return
        }
        var request = URLRequest(url: URL(string: "https://api.elevenlabs.io/v1/text-to-speech/\(voiceID)")!)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONSerialization.data(withJSONObject: ["text": text])
        let task = session.dataTask(with: request) { data, _, error in
            if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(error ?? NSError(domain: "ElevenLabs", code: -1)))
            }
        }
        task.resume()
    }
}
