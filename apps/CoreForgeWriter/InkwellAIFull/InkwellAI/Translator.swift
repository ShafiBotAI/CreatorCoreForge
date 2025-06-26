import Foundation

/// Convenience wrapper around `TranslationService`.
struct Translator {
    private static let service = TranslationService()

    static func translate(_ text: String,
                          to language: String,
                          completion: @escaping (Result<String, Error>) -> Void) {
        guard language.lowercased() != "english" else {
            completion(.success(text))
            return
        }
        service.translate(text, to: language, completion: completion)
    }
}
