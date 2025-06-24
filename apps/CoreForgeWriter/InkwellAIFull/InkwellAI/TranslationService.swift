import Foundation

/// Very small translation helper using the MyMemory API for demo purposes.
final class TranslationService {
    private let session: URLSession

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
            completion(.success(translated))
        }.resume()
    }
}
