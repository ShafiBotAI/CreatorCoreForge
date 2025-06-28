import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

/// Wrapper for ElevenLabs API operations used across CreatorCoreForge apps.
public struct ElevenLabsClient {
    private let apiKey: String
    private let session: URLSession

    /// Options for advanced synthesis quality tuning.
    public struct Options {
        /// Voice stability between 0 and 1.0.
        public var stability: Double
        /// Similarity boost between 0 and 1.0.
        public var similarityBoost: Double
        /// Optional model identifier, e.g. `eleven_multilingual_v2`.
        public var modelID: String?

        public init(stability: Double = 0.75,
                    similarityBoost: Double = 0.75,
                    modelID: String? = nil) {
            self.stability = stability
            self.similarityBoost = similarityBoost
            self.modelID = modelID
        }
    }

    public init(apiKey: String = ProcessInfo.processInfo.environment["ELEVEN_API_KEY"] ?? "",
                session: URLSession = .shared) {
        self.apiKey = apiKey
        self.session = session
    }

    /// Fetch available voices.
    public func listVoices(completion: @escaping (Result<Data, Error>) -> Void) {
        request(endpoint: "voices", method: "GET", body: nil, completion: completion)
    }

    /// Retrieve detailed info for a specific voice.
    public func voiceInfo(id: String, completion: @escaping (Result<Data, Error>) -> Void) {
        request(endpoint: "voices/\(id)", method: "GET", body: nil, completion: completion)
    }

    /// Synthesize text to speech using a voice identifier.
    public func synthesize(text: String, voiceID: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let body = try? JSONSerialization.data(withJSONObject: ["text": text])
        request(endpoint: "text-to-speech/\(voiceID)", method: "POST", body: body, completion: completion)
    }

    /// Synthesize text with advanced quality options.
    public func synthesize(text: String,
                           voiceID: String,
                           options: Options,
                           completion: @escaping (Result<Data, Error>) -> Void) {
        var payload: [String: Any] = ["text": text,
                                      "voice_settings": ["stability": options.stability,
                                                         "similarity_boost": options.similarityBoost]]
        if let model = options.modelID { payload["model_id"] = model }
        let body = try? JSONSerialization.data(withJSONObject: payload)
        request(endpoint: "text-to-speech/\(voiceID)", method: "POST", body: body, completion: completion)
    }

    // MARK: - Private helper
    private func request(endpoint: String, method: String, body: Data?, completion: @escaping (Result<Data, Error>) -> Void) {
        guard !apiKey.isEmpty, let url = URL(string: "https://api.elevenlabs.io/v1/\(endpoint)") else {
            completion(.failure(NSError(domain: "ElevenLabs", code: -1)))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        if let body = body {
            request.httpBody = body
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
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

