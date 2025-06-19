import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

final class ElevenLabsService {
    private let apiKey: String
    private let session: URLSession

    init(apiKey: String = SecureStore.apiKey(named: "ELEVEN_API_KEY") ?? "", session: URLSession = .shared) {
        self.apiKey = apiKey
        self.session = session
    }

    func synthesize(text: String, voice: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: "https://api.elevenlabs.io/v1/text-to-speech/\(voice)") else {
            completion(.failure(NSError(domain: "ElevenLabs", code: -1)))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: ["text": text])
        let task = session.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(data ?? Data()))
            }
        }
        task.resume()
    }
}
