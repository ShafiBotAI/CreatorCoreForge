import Foundation

/// Generates basic interview questions and responses for a character.
public struct CharacterInterviewEngine {
    public init() {}

    public func questions(for name: String) -> [String] {
        [
            "What drives \(name)?",
            "What is \(name)'s biggest fear?",
            "How does \(name) view their allies?"
        ]
    }

    public func respond(character: String, to question: String) -> String {
        "\(character) answers: \(question.lowercased())..."
    }
}
