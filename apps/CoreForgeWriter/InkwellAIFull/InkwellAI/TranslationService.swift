import Foundation

/// Lightweight translation helper using the MyMemory API. Results are cached
/// for the lifetime of the service to avoid duplicate network calls.
final class TranslationService {
    private let session: URLSession
    private var cache: [String: String] = [:]

    init(session: URLSession = .shared) {
        self.session = session
    }

    func translate(_ text: String, to language: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let encoded = text.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            completion(.failure(NSError(domain: "TranslationService", code: -1)))
            return
        }
        let urlStr = "https://api.mymemory.translated.net/get?q=\(encoded)&langpair=en|\(language)"
        guard let url = URL(string: urlStr) else {
            completion(.failure(NSError(domain: "TranslationService", code: -1)))
            return
        }
        if let cached = cache["\(text)-\(language)"] {
            completion(.success(cached))
            return
        }
        session.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data,
                  let obj = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let resp = obj["responseData"] as? [String: Any],
                  let translated = resp["translatedText"] as? String else {
                completion(.failure(NSError(domain: "TranslationService", code: -1)))
                return
            }
            self.cache["\(text)-\(language)"] = translated
            completion(.success(translated))
        }.resume()
    }
}
