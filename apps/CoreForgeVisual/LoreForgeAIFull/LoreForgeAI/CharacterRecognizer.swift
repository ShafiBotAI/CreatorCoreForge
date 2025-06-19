import Foundation

/// Attempts to detect if a character from the given text matches known franchises.
final class CharacterRecognizer {
    private let knownCharacters: [String]

    init(knownCharacters: [String] = ["Harry Potter", "Luke Skywalker", "Batman"]) {
        self.knownCharacters = knownCharacters
    }

    func recognize(in text: String) -> [String] {
        let lower = text.lowercased()
        return knownCharacters.filter { lower.contains($0.lowercased()) }
    }
}
