import Foundation

/// Simple pronunciation editor that stores custom phoneme mappings.
public final class PronunciationEditor {
    private var custom: [String: [String]] = [:]

    public init() {}

    /// Add or update a custom phoneme mapping for a word.
    public func setPhonemes(_ phonemes: [String], for word: String) {
        custom[word.lowercased()] = phonemes
    }

    /// Remove a custom phoneme mapping.
    public func removeWord(_ word: String) {
        custom.removeValue(forKey: word.lowercased())
    }

    /// Return the phoneme array for the given word. If no custom mapping exists
    /// the word is split into characters.
    public func phonemes(for word: String) -> [String] {
        custom[word.lowercased()] ?? word.map { String($0) }
    }
}
