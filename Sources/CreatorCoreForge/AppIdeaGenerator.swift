import Foundation

/// Generates basic app ideas based on a list of trending topics.
public struct AppIdeaGenerator {
    /// Topics used for idea generation.
    public let topics: [String]

    /// Default initializer with built-in trending topics.
    public init(topics: [String] = AppIdeaGenerator.defaultTopics) {
        self.topics = topics
    }

    /// Returns a simple app idea string such as "Fitness Helper".
    public func generateIdea() -> String {
        guard let topic = topics.randomElement() else { return "Generic App" }
        return "\(topic) Helper"
    }

    /// Basic trending topics used when none are provided.
    public static let defaultTopics = [
        "Fitness",
        "Budget",
        "Recipe",
        "Study",
        "Travel"
    ]
}
