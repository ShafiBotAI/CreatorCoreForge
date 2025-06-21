import Foundation

/// Stores custom pronunciations for words.
public final class PronunciationDictionary {
    private var entries: [String: String] = [:]
    public init() {}

    public func add(word: String, phonemes: String) {
        entries[word] = phonemes
    }

    public func phonemes(for word: String) -> String? {
        entries[word]
    }
}
