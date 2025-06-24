import Foundation

/// Attempts to detect if a character name from the given text matches known franchises.
public final class CharacterRecognizer {
    private let knownCharacters: [String]

    public init(knownCharacters: [String] = ["Harry Potter", "Luke Skywalker", "Batman"]) {
        self.knownCharacters = knownCharacters
    }

    public func recognize(in text: String) -> [String] {
        let lower = text.lowercased()
        return knownCharacters.filter { lower.contains($0.lowercased()) }
    }
}
